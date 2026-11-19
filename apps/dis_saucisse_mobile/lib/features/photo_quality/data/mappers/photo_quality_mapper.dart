import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/data/data_sources/thumbnail_analysis.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';

PhotoQuality photoQualityRowToPhotoQuality(PhotoQualityRow row) =>
    PhotoQuality(photoId: PhotoId(row.photoId), sharpness: row.sharpness, fingerprint: row.fingerprint);

PhotoQualityRow photoQualityToRow(PhotoQuality quality, DateTime analyzedAt) => PhotoQualityRow(
  photoId: quality.photoId.value,
  sharpness: quality.sharpness,
  fingerprint: quality.fingerprint,
  algorithm: thumbnailAnalysisAlgorithm,
  analyzedAt: analyzedAt,
);
