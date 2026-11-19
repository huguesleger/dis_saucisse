import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PhotoQualityRepository {
  TaskEither<AppFailure, Map<PhotoId, PhotoQuality>> loadQualities();

  TaskEither<AppFailure, PhotoQuality> analyzePhoto(PhotoId photo);
}
