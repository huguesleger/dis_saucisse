import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/photo_file.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoFileDataSource {
  static final RegExp _heic = RegExp(r'\.(heic|heif)$', caseSensitive: false);

  TaskEither<AppFailure, PhotoFile> loadPhotoFile(String photoId, {required bool convertHeicToJpeg}) =>
      TaskEither<AppFailure, Option<PhotoFile>>.tryCatch(() async {
        final AssetEntity? asset = await AssetEntity.fromId(photoId);
        if (asset == null) return none();
        final String title = await asset.titleAsync;
        final String fileName = title.isEmpty ? '$photoId.jpg' : title;
        final bool convert = convertHeicToJpeg && _heic.hasMatch(fileName);
        final Uint8List? bytes = convert
            ? await asset.thumbnailDataWithSize(ThumbnailSize(asset.width, asset.height), quality: 92)
            : await asset.originBytes;
        return Option<Uint8List>.fromNullable(bytes).map(
          (Uint8List content) =>
              PhotoFile(fileName: convert ? fileName.replaceFirst(_heic, '.jpg') : fileName, bytes: content),
        );
      }, _failure).flatMap(
        (Option<PhotoFile> file) => TaskEither<AppFailure, PhotoFile>.fromOption(file, PhotoFileUnavailableFailure.new),
      );

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Photo file unavailable', error: error, stackTrace: stackTrace, name: 'transfer');
    return const PhotoFileUnavailableFailure();
  }
}
