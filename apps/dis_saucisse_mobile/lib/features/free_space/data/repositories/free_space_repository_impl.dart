import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/free_space/data/data_sources/photo_deletion_data_source.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/free_space_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/sent_photo_data_source.dart';
import 'package:fpdart/fpdart.dart';

class FreeSpaceRepositoryImpl implements FreeSpaceRepository {
  FreeSpaceRepositoryImpl({required SentPhotoDataSource sentPhotos, required PhotoDeletionDataSource deletion})
    : _sentPhotos = sentPhotos,
      _deletion = deletion;

  final SentPhotoDataSource _sentPhotos;
  final PhotoDeletionDataSource _deletion;

  @override
  TaskEither<AppFailure, Map<PhotoId, int>> loadSentPhotoBytes() => _sentPhotos.loadSentPhotoBytes().map(
    (Map<String, int> bytes) => bytes.map((String id, int count) => MapEntry<PhotoId, int>(PhotoId(id), count)),
  );

  @override
  TaskEither<AppFailure, Set<PhotoId>> movePhotosToTrash(List<PhotoId> photos) => _deletion
      .moveToTrash(photos.map((PhotoId id) => id.value).toList())
      .map((List<String> deleted) => deleted.map(PhotoId.new).toSet());
}
