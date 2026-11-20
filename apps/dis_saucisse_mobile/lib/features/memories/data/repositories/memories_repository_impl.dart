import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/memories/data/data_sources/sent_photo_history_data_source.dart';
import 'package:dis_saucisse_mobile/features/memories/data/mappers/sent_photo_record_mapper.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/sent_photo_record.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/memories_repository.dart';
import 'package:fpdart/fpdart.dart';

class MemoriesRepositoryImpl implements MemoriesRepository {
  MemoriesRepositoryImpl(this._history);

  final SentPhotoHistoryDataSource _history;

  @override
  TaskEither<AppFailure, List<SentPhotoRecord>> loadSentPhotos() => _history.loadSentPhotos().map(
    (List<PhotoTransferRow> rows) => rows.map(photoTransferRowToSentPhotoRecord).toList(),
  );
}
