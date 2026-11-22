import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/ignored_origins_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photos_to_sort.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class _MockPairingRepository extends Mock implements PairingRepository {}

class _MockSortingStartRepository extends Mock implements SortingStartRepository {}

class _MockIgnoredOriginsRepository extends Mock implements IgnoredOriginsRepository {}

void main() {
  late _MockPairingRepository pairingRepository;
  late _MockSortingStartRepository sortingStartRepository;
  late _MockIgnoredOriginsRepository ignoredOriginsRepository;
  final DateTime start = DateTime(2026, 8, 19);
  const PairedComputer computer = PairedComputer(
    id: ComputerId('mac'),
    name: 'MacBook',
    platform: ComputerPlatform.macos,
    host: '192.168.1.20',
    port: 47820,
    token: PairingToken('token'),
  );

  setUpAll(() {
    registerFallbackValue(<PhotoOrigin>{});
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    pairingRepository = _MockPairingRepository();
    sortingStartRepository = _MockSortingStartRepository();
    ignoredOriginsRepository = _MockIgnoredOriginsRepository();
    when(() => pairingRepository.loadPairedComputer()).thenReturn(TaskEither.right(some(computer)));
    when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(some(start)));
    when(() => ignoredOriginsRepository.loadIgnoredOrigins()).thenReturn(TaskEither.right(defaultIgnoredOrigins));
    when(() => ignoredOriginsRepository.saveIgnoredOrigins(any())).thenReturn(TaskEither.right(unit));
    when(() => sortingStartRepository.saveStartDate(any())).thenReturn(TaskEither.right(unit));
  });

  SettingsCubit buildCubit() => SettingsCubit(
    pairingRepository: pairingRepository,
    sortingStartRepository: sortingStartRepository,
    ignoredOriginsRepository: ignoredOriginsRepository,
  );

  blocTest<SettingsCubit, SettingsState>(
    'loads the paired computer, the sorting start and what the app ignores',
    build: buildCubit,
    act: (SettingsCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<SettingsLoaded>()
          .having((SettingsLoaded s) => s.computer, 'computer', some(computer))
          .having((SettingsLoaded s) => s.startDate, 'start', some(start))
          .having((SettingsLoaded s) => s.ignoredOrigins, 'ignored', defaultIgnoredOrigins),
    ],
  );

  blocTest<SettingsCubit, SettingsState>(
    'stops ignoring the screenshots and saves it',
    build: buildCubit,
    act: (SettingsCubit cubit) async {
      await cubit.load();
      await cubit.ignoreOrigin(PhotoOrigin.screenshot, ignored: false);
    },
    skip: 1,
    expect: () => <Matcher>[
      isA<SettingsLoaded>().having((SettingsLoaded s) => s.ignoredOrigins, 'ignored', <PhotoOrigin>{
        PhotoOrigin.messagingApp,
      }),
    ],
    verify: (_) => verify(
      () => ignoredOriginsRepository.saveIgnoredOrigins(<PhotoOrigin>{PhotoOrigin.messagingApp}),
    ).called(1),
  );

  blocTest<SettingsCubit, SettingsState>(
    'keeps the previous choice when it cannot be saved',
    setUp: () => when(
      () => ignoredOriginsRepository.saveIgnoredOrigins(any()),
    ).thenReturn(TaskEither<AppFailure, Unit>.left(const IgnoredOriginsStorageFailure())),
    build: buildCubit,
    act: (SettingsCubit cubit) async {
      await cubit.load();
      await cubit.ignoreOrigin(PhotoOrigin.screenshot, ignored: false);
    },
    skip: 1,
    expect: () => <Matcher>[],
    verify: (SettingsCubit cubit) => expect(
      cubit.state,
      isA<SettingsLoaded>().having((SettingsLoaded s) => s.ignoredOrigins, 'ignored', defaultIgnoredOrigins),
    ),
  );

  blocTest<SettingsCubit, SettingsState>(
    'saves a new sorting start',
    build: buildCubit,
    act: (SettingsCubit cubit) async {
      await cubit.load();
      await cubit.changeStartDate(DateTime(2026, 1, 1));
    },
    skip: 1,
    expect: () => <Matcher>[
      isA<SettingsLoaded>().having((SettingsLoaded s) => s.startDate, 'start', some(DateTime(2026, 1, 1))),
    ],
    verify: (_) => verify(() => sortingStartRepository.saveStartDate(DateTime(2026, 1, 1))).called(1),
  );

  blocTest<SettingsCubit, SettingsState>(
    'fails when the settings cannot be read',
    setUp: () => when(
      () => sortingStartRepository.loadStartDate(),
    ).thenReturn(TaskEither<AppFailure, Option<DateTime>>.left(const SortingStartStorageFailure())),
    build: buildCubit,
    act: (SettingsCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<SettingsFailed>().having((SettingsFailed s) => s.failure, 'failure', const SortingStartStorageFailure()),
    ],
  );
}
