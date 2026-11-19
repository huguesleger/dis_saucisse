import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class _MockPairingRepository extends Mock implements PairingRepository {}

class _MockReceptionRepository extends Mock implements ReceptionRepository {}

void main() {
  late _MockPairingRepository pairingRepository;
  late _MockReceptionRepository receptionRepository;
  late StreamController<ReceptionEvent> events;
  const PairingPayload invitation = PairingPayload(
    computerId: ComputerId('computer-1'),
    computerName: 'Mac',
    platform: ComputerPlatform.macos,
    host: '192.168.1.11',
    port: 47820,
    token: PairingToken('secret'),
  );

  setUp(() {
    pairingRepository = _MockPairingRepository();
    receptionRepository = _MockReceptionRepository();
    events = StreamController<ReceptionEvent>();
    when(() => pairingRepository.pairedPhones).thenAnswer((_) => const Stream<PairedPhone>.empty());
    when(() => pairingRepository.stopReception()).thenReturn(TaskEither.right(unit));
    when(() => receptionRepository.events).thenAnswer((_) => events.stream);
  });

  tearDown(() => events.close());

  blocTest<ReceptionCubit, ReceptionState>(
    'follows a transfer from the first photo to the summary',
    build: () => ReceptionCubit(pairingRepository: pairingRepository, receptionRepository: receptionRepository),
    seed: () => const ReceptionReady(invitation: invitation, phones: <PairedPhone>[], activity: ReceptionIdle()),
    act: (ReceptionCubit cubit) async {
      events
        ..add(const TransferStarted(phoneName: 'iPhone', photoCount: 2))
        ..add(
          const PhotoReceived(
            folder: '2026/2026-11 Novembre/2026-11-08',
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
      isA<ReceptionReady>().having((ReceptionReady s) => s.activity, 'activity', isA<ReceptionDone>()),
    ],
  );
}
