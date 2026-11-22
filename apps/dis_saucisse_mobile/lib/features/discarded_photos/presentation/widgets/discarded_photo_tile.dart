import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoTile extends StatelessWidget {
  const DiscardedPhotoTile({super.key, required this.photoId, required this.isSelected, required this.onTap});

  final PhotoId photoId;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: onTap != null,
    selected: isSelected,
    label: onTap == null
        ? t.discarded.tile.alreadySent
        : (isSelected ? t.discarded.tile.selected : t.discarded.tile.discarded),
    child: GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: onTap == null ? 0.5 : 1,
            child: DsPhoto(image: PhotoThumbnailImage(photoId, size: 240), borderRadius: DsRadius.smallAll),
          ),
          if (isSelected)
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: DsRadius.smallAll,
                border: Border.all(color: DsColors.mustard, width: 3),
              ),
            ),
          Positioned(
            top: DsSpacing.xxs,
            right: DsSpacing.xxs,
            child: Icon(
              onTap == null
                  ? Icons.computer_rounded
                  : (isSelected ? Icons.replay_circle_filled_rounded : Icons.radio_button_unchecked_rounded),
              color: isSelected ? DsColors.mustard : DsColors.background,
              size: 24,
            ),
          ),
        ],
      ),
    ),
  );
}
