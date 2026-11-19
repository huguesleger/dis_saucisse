import 'dart:ui' as ui;

import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:photo_manager/photo_manager.dart';

@immutable
class PhotoThumbnailImage extends ImageProvider<PhotoThumbnailImage> {
  const PhotoThumbnailImage(this.photoId, {this.size = 480});

  final PhotoId photoId;
  final int size;

  @override
  Future<PhotoThumbnailImage> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<PhotoThumbnailImage>(this);

  @override
  ImageStreamCompleter loadImage(PhotoThumbnailImage key, ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(codec: _loadCodec(decode), scale: 1);

  Future<ui.Codec> _loadCodec(ImageDecoderCallback decode) async {
    final AssetEntity? asset = await AssetEntity.fromId(photoId.value);
    final Uint8List? bytes = await asset?.thumbnailDataWithSize(ThumbnailSize.square(size));
    return bytes == null
        ? Future<ui.Codec>.error(StateError('No thumbnail for photo ${photoId.value}'))
        : decode(await ui.ImmutableBuffer.fromUint8List(bytes));
  }

  @override
  bool operator ==(Object other) => other is PhotoThumbnailImage && other.photoId == photoId && other.size == size;

  @override
  int get hashCode => Object.hash(photoId, size);
}
