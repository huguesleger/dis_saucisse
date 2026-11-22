import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_settings.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/storage_settings_repository.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/bloc/storage_settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockStorageSettingsRepository extends Mock implements StorageSettingsRepository {}

void main() {
  late _MockStorageSettingsRepository repository;
  final StorageLayout withoutEvents = StorageLayout.defaults.copyWith(byEvent: false);
  const StorageSettingsLoaded loaded = StorageSettingsLoaded(
    folderPath: None(),
    layout: StorageLayout.defaults,
    currentYear: 2026,
  );

  setUp(() => repository = _MockStorageSettingsRepository());

  StorageSettingsCubit buildCubit() => StorageSettingsCubit(repository: repository, clock: () => DateTime(2026, 5, 3));

  blocTest<StorageSettingsCubit, StorageSettingsState>(
    'loads the saved folder and layout',
    setUp: () => when(() => repository.loadSettings()).thenReturn(
      TaskEither.right(StorageSettings(folderPath: some('/Photos'), layout: withoutEvents)),
    ),
    build: buildCubit,
    act: (StorageSettingsCubit cubit) => cubit.load(),
    expect: () => <StorageSettingsState>[
      StorageSettingsLoaded(folderPath: some('/Photos'), layout: withoutEvents, currentYear: 2026),
    ],
  );

  blocTest<StorageSettingsCubit, StorageSettingsState>(
    'reports unreadable settings',
    setUp: () => when(() => repository.loadSettings()).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    act: (StorageSettingsCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<StorageSettingsFailed>().having((StorageSettingsFailed s) => s.failure, 'failure', const UnknownFailure()),
    ],
  );

  blocTest<StorageSettingsCubit, StorageSettingsState>(
    'saves and shows a new layout',
    setUp: () => when(() => repository.saveLayout(withoutEvents)).thenReturn(TaskEither.right(unit)),
    build: buildCubit,
    seed: () => loaded,
    act: (StorageSettingsCubit cubit) => cubit.updateLayout(withoutEvents),
    expect: () => <StorageSettingsState>[loaded.copyWith(layout: withoutEvents)],
  );

  blocTest<StorageSettingsCubit, StorageSettingsState>(
    'keeps the layout when it cannot be saved',
    setUp: () => when(() => repository.saveLayout(withoutEvents)).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    seed: () => loaded,
    act: (StorageSettingsCubit cubit) => cubit.updateLayout(withoutEvents),
    expect: () => <StorageSettingsState>[],
  );

  blocTest<StorageSettingsCubit, StorageSettingsState>(
    'shows the chosen folder',
    setUp: () => when(() => repository.chooseFolder()).thenReturn(TaskEither.right(some('/Volumes/Photos'))),
    build: buildCubit,
    seed: () => loaded,
    act: (StorageSettingsCubit cubit) => cubit.chooseFolder(),
    expect: () => <StorageSettingsState>[loaded.copyWith(folderPath: some('/Volumes/Photos'))],
  );

  blocTest<StorageSettingsCubit, StorageSettingsState>(
    'keeps the folder when the choice is cancelled',
    setUp: () => when(() => repository.chooseFolder()).thenReturn(TaskEither.right(none())),
    build: buildCubit,
    seed: () => loaded,
    act: (StorageSettingsCubit cubit) => cubit.chooseFolder(),
    expect: () => <StorageSettingsState>[],
  );
}
