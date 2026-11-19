import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/data/data_sources/photo_analysis_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/data/data_sources/photo_quality_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/data/data_sources/thumbnail_analysis.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/data/mappers/photo_quality_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_repository.dart';
import 'package:fpdart/fpdart.dart';

class PhotoQualityRepositoryImpl implements PhotoQualityRepository {
  PhotoQualityRepositoryImpl({
    required PhotoQualityDataSource storage,
    required PhotoAnalysisDataSource analysis,
    DateTime Function()? clock,
  }) : _storage = storage,
       _analysis = analysis,
       _clock = clock ?? DateTime.now;

  final PhotoQualityDataSource _storage;
  final PhotoAnalysisDataSource _analysis;
  final DateTime Function() _clock;

  @override
  TaskEither<AppFailure, Map<PhotoId, PhotoQuality>> loadQualities() => _storage.loadQualities().map(
    (List<PhotoQualityRow> rows) => <PhotoId, PhotoQuality>{
      for (final PhotoQualityRow row in rows)
        if (row.algorithm == thumbnailAnalysisAlgorithm) PhotoId(row.photoId): photoQualityRowToPhotoQuality(row),
    },
  );

  @override
  TaskEither<AppFailure, PhotoQuality> analyzePhoto(PhotoId photo) => _analysis
      .analyze(photo.value)
      .map(
        (ThumbnailAnalysis result) =>
            PhotoQuality(photoId: photo, sharpness: result.sharpness, fingerprint: result.fingerprint),
      )
      .flatMap(
        (PhotoQuality quality) => _storage.saveQuality(photoQualityToRow(quality, _clock())).map((Unit _) => quality),
      );
}
