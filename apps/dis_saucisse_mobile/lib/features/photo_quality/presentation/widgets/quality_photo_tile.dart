import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_photo_status.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_status_dot.dart';
import 'package:flutter/material.dart';

class QualityPhotoTile extends StatelessWidget {
  const QualityPhotoTile({
    super.key,
    required this.photoId,
    required this.status,
    required this.onOpen,
    required this.onToggle,
  });

  final PhotoId photoId;
  final QualityPhotoStatus status;
  final VoidCallback onOpen;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: switch (status) {
      QualityPhotoStatus.best => t.quality.tile.best,
      QualityPhotoStatus.kept => t.quality.tile.kept,
      QualityPhotoStatus.toDiscard => t.quality.tile.toDiscard,
    },
    child: GestureDetector(
      onTap: onOpen,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: status == QualityPhotoStatus.toDiscard ? 0.55 : 1,
            child: DsPhoto(image: PhotoThumbnailImage(photoId, size: 360), borderRadius: DsRadius.mediumAll),
          ),
          if (status == QualityPhotoStatus.toDiscard)
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: DsRadius.mediumAll,
                border: Border.all(color: DsColors.sausage, width: 3),
              ),
            ),
          Positioned(
            top: 0,
            right: 0,
            child: QualityStatusDot(
              status: status,
              onTap: status == QualityPhotoStatus.best ? null : onToggle,
            ),
          ),
        ],
      ),
    ),
  );
}
