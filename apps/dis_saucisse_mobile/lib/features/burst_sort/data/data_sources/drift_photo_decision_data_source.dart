import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/data/data_sources/photo_decision_data_source.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/burst_sort_failure.dart';
import 'package:fpdart/fpdart.dart';

class DriftPhotoDecisionDataSource implements PhotoDecisionDataSource {
  DriftPhotoDecisionDataSource(this._database);

  final AppDatabase _database;

  @override
  TaskEither<AppFailure, List<PhotoDecisionRow>> loadDecisions() =>
      TaskEither<AppFailure, List<PhotoDecisionRow>>.tryCatch(
        () => _database.select(_database.photoDecisions).get(),
        _failure,
      );

  @override
  TaskEither<AppFailure, Unit> saveDecision(PhotoDecisionRow decision) => TaskEither<AppFailure, Unit>.tryCatch(
    () async {
      await _database.into(_database.photoDecisions).insertOnConflictUpdate(decision);
      return unit;
    },
    _failure,
  );

  @override
  TaskEither<AppFailure, Unit> deleteDecisions(List<String> photoIds) => TaskEither<AppFailure, Unit>.tryCatch(
    () async {
      await (_database.delete(
        _database.photoDecisions,
      )..where(($PhotoDecisionsTable row) => row.photoId.isIn(photoIds))).go();
      return unit;
    },
    _failure,
  );

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Photo decision storage failed', error: error, stackTrace: stackTrace, name: 'burst_sort');
    return const PhotoDecisionStorageFailure();
  }
}
