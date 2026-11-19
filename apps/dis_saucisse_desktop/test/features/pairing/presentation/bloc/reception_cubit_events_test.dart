import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_repository.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/received_event.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class _MockPairingRepository extends Mock implements PairingRepository {}

class _MockReceptionRepository extends Mock implements ReceptionRepository {}

class _MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  late _MockPairingRepository pairingRepository;
  late _MockReceptionRepository receptionRepository;
  late _MockHistoryRepository historyRepository;
  late StreamController<ReceptionEvent> events;
  const PairingPayload invitation = PairingPayload(
    computerId: ComputerId('computer-1'),
    computerName: 'Mac',
    platform: ComputerPlatform.macos,
    host: '192.168.1.11',
    port: 47820,
    token: PairingToken('secret'),
  );

  setUpAll(
    () => registerFallbackValue(
      TransferRecord(
        receivedAt: DateTime(2026),
        phoneName: '',
        photoCount: 0,
        rejectedCount: 0,
        byteCount: 0,
        eventCount: 0,
      ),
    ),
  );

  setUp(() {
    pairingRepository = _MockPairingRepository();
    receptionRepository = _MockReceptionRepository();
    historyRepository = _MockHistoryRepository();
    when(() => historyRepository.saveTransfer(any())).thenReturn(TaskEither.right(unit));
    events = StreamController<ReceptionEvent>();
    when(() => pairingRepository.pairedPhones).thenAnswer((_) => const Stream<PairedPhone>.empty());
    when(() => pairingRepository.stopReception()).thenReturn(TaskEither.right(unit));
    when(() => receptionRepository.events).thenAnswer((_) => events.stream);
  });

  tearDown(() => events.close());

  blocTest<ReceptionCubit, ReceptionState>(
    'follows a transfer from the first photo to the summary',
    build: () => ReceptionCubit(
      pairingRepository: pairingRepository,
      receptionRepository: receptionRepository,
      historyRepository: historyRepository,
      clock: () => DateTime(2026, 11, 19, 21),
    ),
    seed: () => const ReceptionReady(invitation: invitation, phones: <PairedPhone>[], activity: ReceptionIdle()),
    act: (ReceptionCubit cubit) async {
      events
        ..add(const TransferStarted(phoneName: 'iPhone', photoCount: 2))
        ..add(
          const PhotoReceived(
            folder: '2026/2026-11 Novembre/2026-11-08',
            filePath: '/photos/IMG_1.jpg',
            eventKey: '2026-11-08T14:00:00.000 ',
            eventLabel: '8 novembre 2026',
            byteCount: 1000,
            decision: PhotoDecisionKind.kept,
          ),
        )
        ..add(const PhotoRejected())
        ..add(const TransferFinished(photoCount: 1));
      await Future<void>.delayed(Duration.zero);
    },
    expect: () => <Matcher>[
      isA<ReceptionReady>().having((ReceptionReady s) => s.activity, 'activity', isA<ReceptionInProgress>()),
      isA<ReceptionReady>().having(
        (ReceptionReady s) => (s.activity as ReceptionInProgress).received,
        'received',
        1,
      ),
      isA<ReceptionReady>().having(
        (ReceptionReady s) => (s.activity as ReceptionInProgress).rejected,
        'rejected',
        1,
      ),
      isA<ReceptionReady>().having(
        (ReceptionReady s) => s.activity,
        'activity',
        isA<ReceptionDone>().having((ReceptionDone d) => d.rejected, 'rejected', 1).having(
          (ReceptionDone d) => d.events,
          'events',
          <ReceivedEvent>[(label: '8 novembre 2026', count: 1)],
        ),
      ),
    ],
    verify: (_) {
      final TransferRecord record =
          verify(() => historyRepository.saveTransfer(captureAny())).captured.single as TransferRecord;
      expect(record.receivedAt, DateTime(2026, 11, 19, 21));
      expect(record.phoneName, 'iPhone');
      expect(record.photoCount, 1);
      expect(record.rejectedCount, 1);
      expect(record.byteCount, 1000);
      expect(record.eventCount, 1);
    },
  );
}
