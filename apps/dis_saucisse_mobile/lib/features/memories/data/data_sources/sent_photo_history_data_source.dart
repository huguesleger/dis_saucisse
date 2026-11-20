import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/memories_failure.dart';
import 'package:fpdart/fpdart.dart';

class SentPhotoHistoryDataSource {
  SentPhotoHistoryDataSource(this._database);

  final AppDatabase _database;

  TaskEither<AppFailure, List<PhotoTransferRow>> loadSentPhotos() =>
      TaskEither<AppFailure, List<PhotoTransferRow>>.tryCatch(
        () => _database.select(_database.photoTransfers).get(),
        (Object error, StackTrace stackTrace) {
          log('Sent photo history failed', error: error, stackTrace: stackTrace, name: 'memories');
          return const SentPhotoHistoryFailure();
        },
      );
}
