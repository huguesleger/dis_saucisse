import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FreeSpaceRepository {
  TaskEither<AppFailure, Map<PhotoId, int>> loadSentPhotoBytes();

  TaskEither<AppFailure, Set<PhotoId>> movePhotosToTrash(List<PhotoId> photos);
}
