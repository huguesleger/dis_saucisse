import 'dart:io';
import 'dart:ui' as ui;

import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:photo_manager/photo_manager.dart';

@immutable
class PhotoPreviewImage extends ImageProvider<PhotoPreviewImage> {
  const PhotoPreviewImage(this.photoId, {this.maxSide = 2048});

  final PhotoId photoId;
  final int maxSide;

  @override
  Future<PhotoPreviewImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture<PhotoPreviewImage>(this);

  @override
  ImageStreamCompleter loadImage(PhotoPreviewImage key, ImageDecoderCallback decode) =>
      MultiFrameImageStreamCompleter(codec: _loadCodec(decode), scale: 1);

  ThumbnailOption get _option {
    final ThumbnailSize size = ThumbnailSize.square(maxSide);
    return Platform.isIOS
        ? ThumbnailOption.ios(
            size: size,
            deliveryMode: DeliveryMode.highQualityFormat,
            resizeContentMode: ResizeContentMode.fit,
          )
        : ThumbnailOption(size: size);
  }

  Future<ui.Codec> _loadCodec(ImageDecoderCallback decode) async {
    final AssetEntity? asset = await AssetEntity.fromId(photoId.value);
    final Uint8List? bytes = await asset?.thumbnailDataWithOption(_option);
    return bytes == null
        ? Future<ui.Codec>.error(StateError('No preview for photo ${photoId.value}'))
        : decode(await ui.ImmutableBuffer.fromUint8List(bytes));
  }

  @override
  bool operator ==(Object other) => other is PhotoPreviewImage && other.photoId == photoId && other.maxSide == maxSide;

  @override
  int get hashCode => Object.hash(photoId, maxSide);
}
