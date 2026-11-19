import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_photo_tile.dart';
import 'package:flutter/material.dart';

class QualityGroupCard extends StatelessWidget {
  const QualityGroupCard({super.key, required this.group, required this.selected, required this.onToggle});

  final QualityGroup group;
  final Set<PhotoId> selected;
  final ValueChanged<PhotoId> onToggle;

  @override
  Widget build(BuildContext context) => DsCard(
    padding: const EdgeInsets.all(DsSpacing.s),
    child: Wrap(
      spacing: DsSpacing.xs,
      runSpacing: DsSpacing.xs,
      children: <Widget>[
        for (final LibraryPhoto photo in group.photos)
          group.best.match(
            () => QualityPhotoTile(
              photoId: photo.id,
              isBest: false,
              isSelected: selected.contains(photo.id),
              onTap: () => onToggle(photo.id),
            ),
            (LibraryPhoto best) => QualityPhotoTile(
              photoId: photo.id,
              isBest: best.id == photo.id,
              isSelected: selected.contains(photo.id),
              onTap: best.id == photo.id ? null : () => onToggle(photo.id),
            ),
          ),
      ],
    ),
  );
}
