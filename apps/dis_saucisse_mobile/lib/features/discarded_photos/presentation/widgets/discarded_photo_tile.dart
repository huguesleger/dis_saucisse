import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_select_dot.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoTile extends StatelessWidget {
  const DiscardedPhotoTile({
    super.key,
    required this.photoId,
    required this.isSelected,
    required this.onOpen,
    required this.onToggle,
  });

  final PhotoId photoId;
  final bool isSelected;
  final VoidCallback onOpen;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? toggle = onToggle;
    return Semantics(
      button: true,
      selected: isSelected,
      label: toggle == null
          ? t.discarded.tile.alreadySent
          : (isSelected ? t.discarded.tile.selected : t.discarded.tile.discarded),
      child: GestureDetector(
        onTap: onOpen,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: toggle == null ? 0.55 : 1,
              child: DsPhoto(image: PhotoThumbnailImage(photoId, size: 360), borderRadius: DsRadius.mediumAll),
            ),
            if (isSelected)
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: DsRadius.mediumAll,
                  border: Border.all(color: DsColors.mustard, width: 3),
                ),
              ),
            Positioned(
              top: 0,
              right: 0,
              child: toggle == null
                  ? const Padding(
                      padding: EdgeInsets.all(DsSpacing.xs),
                      child: Icon(Icons.computer_rounded, color: DsColors.background, size: 20),
                    )
                  : DiscardedPhotoSelectDot(isSelected: isSelected, onTap: toggle),
            ),
          ],
        ),
      ),
    );
  }
}
