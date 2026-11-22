import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/config/setup_get_it.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_settings.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/storage_settings_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'storage_settings_state.dart';

class StorageSettingsCubit extends SafeCubit<StorageSettingsState> {
  StorageSettingsCubit({StorageSettingsRepository? repository, DateTime Function()? clock, Duration? minimalLoading})
    : _repository = repository ?? getIt.get<StorageSettingsRepository>(),
      _clock = clock ?? DateTime.now,
      _minimalLoading = minimalLoading ?? DsSkeletonizer.minDuration,
      super(const StorageSettingsLoading());

  final StorageSettingsRepository _repository;
  final DateTime Function() _clock;
  final Duration _minimalLoading;

  Future<void> load() {
    if (state is StorageSettingsFailed) emit(const StorageSettingsLoading());
    return _repository
        .loadSettings()
        .withMinimalDelay(_minimalLoading)
        .match(
          StorageSettingsFailed.new,
          (StorageSettings settings) => StorageSettingsLoaded(
            folderPath: settings.folderPath,
            layout: settings.layout,
            currentYear: _clock().year,
          ),
        )
        .map(emit)
        .run();
  }

  Future<void> updateLayout(StorageLayout layout) async => switch (state) {
    final StorageSettingsLoaded loaded =>
      await _repository
          .saveLayout(layout)
          .match((AppFailure _) => loaded, (Unit _) => loaded.copyWith(layout: layout))
          .map(emit)
          .run(),
    StorageSettingsLoading() || StorageSettingsFailed() => null,
  };

  Future<void> chooseFolder() async => switch (state) {
    final StorageSettingsLoaded loaded =>
      await _repository
          .chooseFolder()
          .match(
            (AppFailure _) => loaded,
            (Option<String> chosen) =>
                chosen.match(() => loaded, (String path) => loaded.copyWith(folderPath: some(path))),
          )
          .map(emit)
          .run(),
    StorageSettingsLoading() || StorageSettingsFailed() => null,
  };
}
