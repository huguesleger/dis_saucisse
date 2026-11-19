import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/data/data_sources/thumbnail_analysis.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoAnalysisDataSource {
  static const int _thumbnailSize = 256;

  TaskEither<AppFailure, ThumbnailAnalysis> analyze(String photoId) =>
      TaskEither<AppFailure, ThumbnailAnalysis>.tryCatch(
        () async {
          final AssetEntity? asset = await AssetEntity.fromId(photoId);
          final Uint8List bytes =
              await asset?.thumbnailDataWithOption(
                Platform.isIOS
                    ? ThumbnailOption.ios(
                        size: const ThumbnailSize.square(_thumbnailSize),
                        quality: 90,
                        deliveryMode: DeliveryMode.highQualityFormat,
                        resizeMode: ResizeMode.exact,
                      )
                    : const ThumbnailOption(size: ThumbnailSize.square(_thumbnailSize), quality: 90),
              ) ??
              (throw const UnreadableThumbnailException());
          return Isolate.run(() => analyzeThumbnail(bytes));
        },
        (Object error, StackTrace stackTrace) {
          log('Photo analysis failed', error: error, stackTrace: stackTrace, name: 'photo_quality');
          return const PhotoAnalysisFailure();
        },
      );
}
