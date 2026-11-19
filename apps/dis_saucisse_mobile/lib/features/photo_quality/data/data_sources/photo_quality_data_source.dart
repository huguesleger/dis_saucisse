import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_failure.dart';
import 'package:fpdart/fpdart.dart';

class PhotoQualityDataSource {
  PhotoQualityDataSource(this._database);

  final AppDatabase _database;

  TaskEither<AppFailure, List<PhotoQualityRow>> loadQualities() =>
      TaskEither<AppFailure, List<PhotoQualityRow>>.tryCatch(
        () => _database.select(_database.photoQualities).get(),
        _failure,
      );

  TaskEither<AppFailure, Unit> saveQuality(PhotoQualityRow row) => TaskEither<AppFailure, Unit>.tryCatch(() async {
    await _database.into(_database.photoQualities).insertOnConflictUpdate(row);
    return unit;
  }, _failure);

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Photo quality storage failed', error: error, stackTrace: stackTrace, name: 'photo_quality');
    return const PhotoQualityStorageFailure();
  }
}
