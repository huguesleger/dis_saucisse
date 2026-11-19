import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/storage/data/data_sources/storage_settings_data_source.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_settings.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/storage_failure.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/storage_settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class StorageSettingsRepositoryImpl implements StorageSettingsRepository {
  StorageSettingsRepositoryImpl(this._dataSource);

  final StorageSettingsDataSource _dataSource;

  @override
  TaskEither<AppFailure, StorageSettings> loadSettings() => TaskEither<AppFailure, StorageSettings>.tryCatch(
    () async => StorageSettings(
      folderPath: Option<String>.fromNullable(await _dataSource.loadFolderPath()),
      layout: await _dataSource.loadLayout(),
    ),
    _failure,
  );

  @override
  TaskEither<AppFailure, Unit> saveLayout(StorageLayout layout) => TaskEither<AppFailure, Unit>.tryCatch(() async {
    await _dataSource.saveLayout(layout);
    return unit;
  }, _failure);

  @override
  TaskEither<AppFailure, Option<String>> chooseFolder() => TaskEither<AppFailure, Option<String>>.tryCatch(
    () async => Option<String>.fromNullable(await _dataSource.pickAndSaveFolder()),
    _failure,
  );

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Storage settings failed', error: error, stackTrace: stackTrace, name: 'storage');
    return const StorageSettingsFailure();
  }
}
