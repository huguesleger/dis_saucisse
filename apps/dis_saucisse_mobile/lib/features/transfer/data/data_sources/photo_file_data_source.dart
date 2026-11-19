import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/heic_converter_data_source.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/photo_file.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/rules/photo_format.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoFileDataSource {
  PhotoFileDataSource(this._converter);

  final HeicConverterDataSource _converter;

  TaskEither<AppFailure, PhotoFile> loadPhotoFile(String photoId, {required bool convertHeicToJpeg}) =>
      TaskEither<AppFailure, Option<PhotoFile>>.tryCatch(() async {
        final AssetEntity? asset = await AssetEntity.fromId(photoId);
        if (asset == null) return none();
        final String title = await asset.titleAsync;
        final String fileName = title.isEmpty ? '$photoId.jpg' : title;
        final Uint8List? original = await asset.originBytes;
        if (original == null) return none();
        if (!convertHeicToJpeg || !isHeic(fileName)) return some(PhotoFile(fileName: fileName, bytes: original));
        final Uint8List? jpeg = await _converter
            .toJpeg(original)
            .then<Uint8List?>(
              (Uint8List converted) => converted,
              onError: (Object error) => _renderedJpeg(asset, error),
            );
        return Option<Uint8List>.fromNullable(
          jpeg,
        ).map((Uint8List content) => PhotoFile(fileName: jpegFileName(fileName), bytes: content));
      }, _failure).flatMap(
        (Option<PhotoFile> file) => TaskEither<AppFailure, PhotoFile>.fromOption(file, PhotoFileUnavailableFailure.new),
      );

  Future<Uint8List?> _renderedJpeg(AssetEntity asset, Object error) {
    log('HEIC conversion failed, sending a rendered JPEG without metadata', error: error, name: 'transfer');
    return asset.thumbnailDataWithSize(ThumbnailSize(asset.width, asset.height), quality: 92);
  }

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Photo file unavailable', error: error, stackTrace: stackTrace, name: 'transfer');
    return const PhotoFileUnavailableFailure();
  }
}
