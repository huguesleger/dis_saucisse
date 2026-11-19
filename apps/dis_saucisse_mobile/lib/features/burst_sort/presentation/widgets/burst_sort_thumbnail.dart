import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class BurstSortThumbnail extends StatelessWidget {
  const BurstSortThumbnail({
    super.key,
    required this.photoId,
    required this.decision,
    required this.selected,
    required this.onTap,
  });

  final PhotoId photoId;
  final Option<PhotoDecision> decision;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: DsRadius.mediumAll,
        border: Border.all(color: selected ? DsColors.mustard : Colors.transparent, width: 2.5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DsPhoto(image: PhotoThumbnailImage(photoId, size: 160), borderRadius: DsRadius.smallAll),
          ...decision.match(
            () => <Widget>[],
            (PhotoDecision value) => <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: DsRadius.smallAll,
                  color: switch (value) {
                    PhotoDecision.kept => DsColors.success.withValues(alpha: 0.35),
                    PhotoDecision.discarded => DsColors.text.withValues(alpha: 0.55),
                  },
                ),
                child: Icon(
                  switch (value) {
                    PhotoDecision.kept => Icons.check_rounded,
                    PhotoDecision.discarded => Icons.close_rounded,
                  },
                  color: DsColors.background,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
