import 'package:bloc_test/bloc_test.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/bloc/pair_computer_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class _MockPairingRepository extends Mock implements PairingRepository {}

void main() {
  late _MockPairingRepository repository;
  const PairingPayload invitation = PairingPayload(
    computerId: ComputerId('computer-1'),
    computerName: 'PC du salon',
    platform: ComputerPlatform.macos,
    host: '192.168.1.24',
    port: 47820,
    token: PairingToken('secret'),
  );
  const PairedComputer computer = PairedComputer(
    id: ComputerId('computer-1'),
    name: 'PC du salon',
    platform: ComputerPlatform.macos,
    host: '192.168.1.24',
    port: 47820,
    token: PairingToken('secret'),
  );

  setUpAll(() => registerFallbackValue(invitation));

  setUp(() => repository = _MockPairingRepository());

  blocTest<PairComputerCubit, PairComputerState>(
    'pairs with the computer of a valid QR code',
    setUp: () => when(() => repository.pairWith(any())).thenReturn(TaskEither.right(computer)),
    build: () => PairComputerCubit(pairingRepository: repository, minimalLoading: Duration.zero),
    act: (PairComputerCubit cubit) => cubit.codeScanned(invitation.encode()),
    expect: () => <Matcher>[
      isA<PairComputerPairing>().having((PairComputerPairing s) => s.computerName, 'name', 'PC du salon'),
      isA<PairComputerPaired>(),
    ],
  );

  blocTest<PairComputerCubit, PairComputerState>(
    'rejects a QR code that is not a pairing code',
    build: () => PairComputerCubit(pairingRepository: repository, minimalLoading: Duration.zero),
    act: (PairComputerCubit cubit) => cubit.codeScanned('https://example.com'),
    expect: () => <Matcher>[
      isA<PairComputerFailed>().having((PairComputerFailed s) => s.problem, 'problem', PairingProblem.invalidCode),
    ],
    verify: (_) => verifyNever(() => repository.pairWith(any())),
  );

  blocTest<PairComputerCubit, PairComputerState>(
    'explains that the computer cannot be reached',
    setUp: () => when(() => repository.pairWith(any())).thenReturn(TaskEither.left(const ComputerUnreachableFailure())),
    build: () => PairComputerCubit(pairingRepository: repository, minimalLoading: Duration.zero),
    act: (PairComputerCubit cubit) => cubit.codeScanned(invitation.encode()),
    expect: () => <Matcher>[
      isA<PairComputerPairing>(),
      isA<PairComputerFailed>().having((PairComputerFailed s) => s.problem, 'problem', PairingProblem.unreachable),
    ],
  );

  blocTest<PairComputerCubit, PairComputerState>(
    'ignores the codes detected while a pairing is in progress',
    build: () => PairComputerCubit(pairingRepository: repository, minimalLoading: Duration.zero),
    seed: () => const PairComputerPairing('PC du salon'),
    act: (PairComputerCubit cubit) => cubit.codeScanned(invitation.encode()),
    expect: () => <Matcher>[],
  );

  blocTest<PairComputerCubit, PairComputerState>(
    'goes back to scanning on retry',
    build: () => PairComputerCubit(pairingRepository: repository, minimalLoading: Duration.zero),
    seed: () => const PairComputerFailed(PairingProblem.refused),
    act: (PairComputerCubit cubit) => cubit.retry(),
    expect: () => <Matcher>[isA<PairComputerScanning>()],
  );

  blocTest<PairComputerCubit, PairComputerState>(
    'pairs with the QR code read from an imported image',
    setUp: () {
      when(() => repository.readQrCodeFromImage('/tmp/qr.png')).thenReturn(TaskEither.right(some(invitation.encode())));
      when(() => repository.pairWith(any())).thenReturn(TaskEither.right(computer));
    },
    build: () => PairComputerCubit(pairingRepository: repository, minimalLoading: Duration.zero),
    act: (PairComputerCubit cubit) => cubit.qrImagePicked('/tmp/qr.png'),
    expect: () => <Matcher>[isA<PairComputerPairing>(), isA<PairComputerPaired>()],
  );

  blocTest<PairComputerCubit, PairComputerState>(
    'explains that the imported image has no QR code',
    setUp: () => when(() => repository.readQrCodeFromImage(any())).thenReturn(TaskEither.right(none())),
    build: () => PairComputerCubit(pairingRepository: repository, minimalLoading: Duration.zero),
    act: (PairComputerCubit cubit) => cubit.qrImagePicked('/tmp/photo.jpg'),
    expect: () => <Matcher>[
      isA<PairComputerFailed>().having((PairComputerFailed s) => s.problem, 'problem', PairingProblem.invalidCode),
    ],
  );
}
