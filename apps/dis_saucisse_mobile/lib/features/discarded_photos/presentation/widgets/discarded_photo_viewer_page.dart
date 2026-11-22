import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_preview_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoViewerPage extends StatelessWidget {
  const DiscardedPhotoViewerPage({super.key, required this.photoId, required this.onTap});

  final PhotoId photoId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: InteractiveViewer(
      maxScale: 4,
      child: SizedBox.expand(
        child: Image(
          image: PhotoPreviewImage(photoId),
          fit: BoxFit.cover,
          gaplessPlayback: true,
          frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) =>
              frame == null && !wasSynchronouslyLoaded
              ? Image(
                  image: PhotoThumbnailImage(photoId, size: 360),
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) =>
                      const DsPhoto(borderRadius: BorderRadius.zero),
                )
              : child,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) =>
              const DsPhoto(borderRadius: BorderRadius.zero),
        ),
      ),
    ),
  );
}
