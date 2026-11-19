import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class _MockPairingRepository extends Mock implements PairingRepository {}

void main() {
  late _MockPairingRepository repository;
  late StreamController<PairedPhone> pairings;
  const PairingPayload invitation = PairingPayload(
    computerId: ComputerId('computer-1'),
    computerName: 'PC du salon',
    platform: ComputerPlatform.macos,
    host: '192.168.1.24',
    port: 47820,
    token: PairingToken('secret'),
  );
  final PairedPhone iphone = PairedPhone(
    id: const PhoneId('phone-1'),
    name: 'iPhone',
    pairedAt: DateTime(2026, 11, 19),
  );

  setUpAll(() => registerFallbackValue(iphone));

  setUp(() {
    repository = _MockPairingRepository();
    pairings = StreamController<PairedPhone>();
    when(() => repository.pairedPhones).thenAnswer((_) => pairings.stream);
    when(() => repository.stopReception()).thenReturn(TaskEither.right(unit));
  });

  tearDown(() => pairings.close());

  blocTest<ReceptionCubit, ReceptionState>(
    'shows the QR code invitation and the phones already paired',
    setUp: () {
      when(() => repository.startReception()).thenReturn(TaskEither.right(invitation));
      when(() => repository.loadPairedPhones()).thenReturn(TaskEither.right(<PairedPhone>[]));
    },
    build: () => ReceptionCubit(pairingRepository: repository),
    act: (ReceptionCubit cubit) => cubit.start(),
    expect: () => <Matcher>[
      isA<ReceptionStarting>(),
      isA<ReceptionReady>().having((ReceptionReady s) => s.invitation.host, 'host', '192.168.1.24'),
    ],
  );

  blocTest<ReceptionCubit, ReceptionState>(
    'saves and shows a phone that pairs',
    setUp: () {
      when(() => repository.startReception()).thenReturn(TaskEither.right(invitation));
      when(() => repository.loadPairedPhones()).thenReturn(TaskEither.right(<PairedPhone>[]));
      when(() => repository.savePairedPhone(any())).thenReturn(TaskEither.right(unit));
    },
    build: () => ReceptionCubit(pairingRepository: repository),
    act: (ReceptionCubit cubit) async {
      await cubit.start();
      pairings.add(iphone);
      await Future<void>.delayed(Duration.zero);
    },
    skip: 2,
    expect: () => <Matcher>[
      isA<ReceptionReady>().having((ReceptionReady s) => s.phones.map((PairedPhone p) => p.name), 'phones', <String>[
        'iPhone',
      ]),
    ],
    verify: (_) => verify(() => repository.savePairedPhone(iphone)).called(1),
  );

  blocTest<ReceptionCubit, ReceptionState>(
    'explains that the computer has no network',
    setUp: () => when(() => repository.startReception()).thenReturn(TaskEither.left(const NoLocalNetworkFailure())),
    build: () => ReceptionCubit(pairingRepository: repository),
    act: (ReceptionCubit cubit) => cubit.start(),
    expect: () => <Matcher>[
      isA<ReceptionStarting>(),
      isA<ReceptionFailed>().having((ReceptionFailed s) => s.problem, 'problem', ReceptionProblem.noNetwork),
    ],
  );
}
