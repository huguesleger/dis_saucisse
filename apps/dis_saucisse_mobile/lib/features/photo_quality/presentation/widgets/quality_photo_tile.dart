import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';

class QualityPhotoTile extends StatelessWidget {
  const QualityPhotoTile({
    super.key,
    required this.photoId,
    required this.isBest,
    required this.isSelected,
    required this.onTap,
  });

  static const double size = 96;

  final PhotoId photoId;
  final bool isBest;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: onTap != null,
    selected: isSelected,
    label: isBest ? t.quality.photoTile.kept : (isSelected ? t.quality.photoTile.toDiscard : t.quality.photoTile.kept),
    child: GestureDetector(
      onTap: onTap,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: isSelected ? 0.55 : 1,
              child: DsPhoto(image: PhotoThumbnailImage(photoId, size: 240), borderRadius: DsRadius.smallAll),
            ),
            Positioned(
              top: DsSpacing.xxs,
              right: DsSpacing.xxs,
              child: Icon(
                isBest ? Icons.star_rounded : (isSelected ? Icons.remove_circle_rounded : Icons.check_circle_rounded),
                color: isBest ? DsColors.mustard : (isSelected ? DsColors.sausage : DsColors.success),
                size: 26,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
