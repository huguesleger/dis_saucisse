import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';

class BurstSortPhoto extends StatelessWidget {
  const BurstSortPhoto({super.key, required this.photoId, required this.onKeep, required this.onDiscard});

  static const double _swipeVelocity = 300;

  final PhotoId photoId;
  final VoidCallback onKeep;
  final VoidCallback onDiscard;

  void _onSwipe(DragEndDetails details) {
    final double velocity = details.primaryVelocity ?? 0;
    if (velocity < -_swipeVelocity) onKeep();
    if (velocity > _swipeVelocity) onDiscard();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onVerticalDragEnd: _onSwipe,
    child: ColoredBox(
      color: DsColors.pageBackground,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: DsImage(key: ValueKey<PhotoId>(photoId), image: PhotoThumbnailImage(photoId, size: 1600)),
      ),
    ),
  );
}
