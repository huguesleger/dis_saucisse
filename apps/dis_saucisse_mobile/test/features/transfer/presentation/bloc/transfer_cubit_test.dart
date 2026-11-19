import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_item.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_repository.dart';
import 'package:dis_saucisse_mobile/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockPairingRepository extends Mock implements PairingRepository {}

class _MockTransferRepository extends Mock implements TransferRepository {}

class _MockLoadEventLibrary extends Mock implements LoadEventLibrary {}

void main() {
  late _MockPairingRepository pairingRepository;
  late _MockTransferRepository transferRepository;
  late _MockLoadEventLibrary loadEventLibrary;
  late Completer<Either<AppFailure, String>> pendingFirstSend;
  const PairedComputer computer = PairedComputer(
    id: ComputerId('mac'),
    name: 'Mac',
    platform: ComputerPlatform.macos,
    host: '192.168.1.11',
    port: 47820,
    token: PairingToken('secret'),
  );
  final EventLibrary library = EventLibrary(
    photos: saturdayPhotos,
    names: const <EventId, String>{},
    boundaries: const EventBoundaries.none(),
    decisions: const <PhotoId, PhotoDecision>{
      PhotoId('cake-1'): PhotoDecision.kept,
      PhotoId('cake-2'): PhotoDecision.discarded,
      PhotoId('walk'): PhotoDecision.kept,
    },
  );

  setUpAll(() {
    registerFallbackValue(computer);
    registerFallbackValue(<PhotoId>[]);
    registerFallbackValue(
      TransferItem(
        photo: saturdayPhotos.first,
        decision: PhotoDecision.kept,
        eventName: none(),
        eventDate: DateTime(2026),
      ),
    );
  });

  setUp(() {
    pairingRepository = _MockPairingRepository();
    transferRepository = _MockTransferRepository();
    loadEventLibrary = _MockLoadEventLibrary();
    when(() => pairingRepository.loadPairedComputer()).thenReturn(TaskEither.right(some(computer)));
    when(() => loadEventLibrary()).thenReturn(TaskEither.right(EventLibraryLoaded(library)));
    when(() => transferRepository.loadSentPhotoIds(any())).thenReturn(TaskEither.right(<PhotoId>{}));
    when(() => transferRepository.markAlreadyReceived(any(), any())).thenReturn(TaskEither.right(unit));
    when(() => transferRepository.sendPhoto(any(), any())).thenReturn(TaskEither.right('2026/2026-11 Novembre'));
    when(() => transferRepository.finishTransfer(any(), any())).thenReturn(TaskEither.right(unit));
  });

  TransferCubit buildCubit() => TransferCubit(
    pairingRepository: pairingRepository,
    transferRepository: transferRepository,
    loadEventLibrary: loadEventLibrary,
    clock: () => DateTime(2026, 11, 19, 21),
  );

  blocTest<TransferCubit, TransferState>(
    'sends only the photos the computer is missing, then shows the summary',
    setUp: () => when(() => transferRepository.startTransfer(any(), any())).thenReturn(
      TaskEither.right(<PhotoId>{const PhotoId('cake-2'), const PhotoId('walk')}),
    ),
    build: buildCubit,
    act: (TransferCubit cubit) => cubit.start(),
    expect: () => <Matcher>[
      isA<TransferPreparing>(),
      isA<TransferSending>().having((TransferSending s) => s.progress.total, 'total', 2),
      isA<TransferSending>().having((TransferSending s) => s.progress.discardedSent, 'discarded', 1),
      isA<TransferSending>().having((TransferSending s) => s.progress.sent, 'sent', 2),
      isA<TransferFinished>()
          .having((TransferFinished s) => s.sentCount, 'sent', 2)
          .having((TransferFinished s) => s.eventCount, 'events', 2),
    ],
    verify: (_) {
      verify(() => transferRepository.markAlreadyReceived(computer, <PhotoId>[const PhotoId('cake-1')])).called(1);
      verify(() => transferRepository.finishTransfer(computer, 2)).called(1);
    },
  );

  blocTest<TransferCubit, TransferState>(
    'asks to pair a computer first',
    setUp: () => when(() => pairingRepository.loadPairedComputer()).thenReturn(TaskEither.right(none())),
    build: buildCubit,
    act: (TransferCubit cubit) => cubit.start(),
    expect: () => <Matcher>[isA<TransferPreparing>(), isA<TransferNeedsPairing>()],
  );

  blocTest<TransferCubit, TransferState>(
    'has nothing to send when every decided photo was sent',
    setUp: () => when(() => transferRepository.loadSentPhotoIds(any())).thenReturn(
      TaskEither.right(<PhotoId>{const PhotoId('cake-1'), const PhotoId('cake-2'), const PhotoId('walk')}),
    ),
    build: buildCubit,
    act: (TransferCubit cubit) => cubit.start(),
    expect: () => <Matcher>[isA<TransferPreparing>(), isA<TransferNothingToSend>()],
    verify: (_) => verifyNever(() => transferRepository.startTransfer(any(), any())),
  );

  blocTest<TransferCubit, TransferState>(
    'explains that the computer cannot be reached',
    setUp: () => when(
      () => transferRepository.startTransfer(any(), any()),
    ).thenReturn(TaskEither.left(const ComputerUnreachableFailure())),
    build: buildCubit,
    act: (TransferCubit cubit) => cubit.start(),
    expect: () => <Matcher>[
      isA<TransferPreparing>(),
      isA<TransferFailed>().having((TransferFailed s) => s.problem, 'problem', TransferProblem.unreachable),
    ],
  );

  blocTest<TransferCubit, TransferState>(
    'stops after the current photo when paused, and goes on when resumed',
    setUp: () {
      final Completer<Either<AppFailure, String>> firstSend = Completer<Either<AppFailure, String>>();
      int sendCount = 0;
      when(
        () => transferRepository.startTransfer(any(), any()),
      ).thenReturn(TaskEither.right(<PhotoId>{const PhotoId('cake-1'), const PhotoId('cake-2')}));
      when(() => transferRepository.sendPhoto(any(), any())).thenAnswer(
        (_) => sendCount++ == 0
            ? TaskEither<AppFailure, String>(() => firstSend.future)
            : TaskEither<AppFailure, String>.right('2026/2026-11 Novembre'),
      );
      pendingFirstSend = firstSend;
    },
    build: buildCubit,
    act: (TransferCubit cubit) async {
      final Future<void> started = cubit.start();
      await Future<void>.delayed(const Duration(milliseconds: 10));
      cubit.pause();
      pendingFirstSend.complete(right('2026/2026-11 Novembre'));
      await started;
      await cubit.resume();
    },
    expect: () => <Matcher>[
      isA<TransferPreparing>(),
      isA<TransferSending>().having((TransferSending s) => s.progress.sent, 'sent', 0),
      isA<TransferPaused>().having((TransferPaused s) => s.progress.sent, 'sent', 0),
      isA<TransferPaused>().having((TransferPaused s) => s.progress.sent, 'sent', 1),
      isA<TransferSending>().having((TransferSending s) => s.progress.sent, 'sent', 1),
      isA<TransferSending>().having((TransferSending s) => s.progress.sent, 'sent', 2),
      isA<TransferFinished>(),
    ],
  );
}
