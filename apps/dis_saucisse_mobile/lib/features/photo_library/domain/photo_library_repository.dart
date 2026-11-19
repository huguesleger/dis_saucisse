import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PhotoLibraryRepository {
  TaskEither<AppFailure, PhotoAccess> checkAccess();

  TaskEither<AppFailure, PhotoAccess> requestAccess();

  TaskEither<AppFailure, Unit> openAccessSettings();

  TaskEither<AppFailure, List<LibraryPhoto>> loadPhotosTakenSince(DateTime start);
}
