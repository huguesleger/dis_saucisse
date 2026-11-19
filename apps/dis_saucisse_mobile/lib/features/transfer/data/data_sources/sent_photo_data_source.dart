import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_failure.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

class SentPhotoDataSource {
  SentPhotoDataSource(this._database);

  final AppDatabase _database;

  TaskEither<AppFailure, Set<String>> loadSentPhotoIds(String computerId) =>
      TaskEither<AppFailure, Set<String>>.tryCatch(
        () async =>
            (await (_database.select(
                  _database.photoTransfers,
                )..where(($PhotoTransfersTable row) => row.computerId.equals(computerId))).get())
                .map((PhotoTransferRow row) => row.photoId)
                .toSet(),
        _failure,
      );

  TaskEither<AppFailure, Unit> markSent(String computerId, List<String> photoIds, DateTime sentAt) =>
      TaskEither<AppFailure, Unit>.tryCatch(() async {
        await _database.batch(
          (Batch batch) => batch.insertAllOnConflictUpdate(_database.photoTransfers, <PhotoTransferRow>[
            for (final String photoId in photoIds)
              PhotoTransferRow(photoId: photoId, computerId: computerId, sentAt: sentAt),
          ]),
        );
        return unit;
      }, _failure);

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Sent photo storage failed', error: error, stackTrace: stackTrace, name: 'transfer');
    return const SentPhotoStorageFailure();
  }
}
