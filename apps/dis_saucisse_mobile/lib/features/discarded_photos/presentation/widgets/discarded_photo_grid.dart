import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_tile.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/widgets.dart';

class DiscardedPhotoGrid extends StatelessWidget {
  const DiscardedPhotoGrid({
    super.key,
    required this.photos,
    required this.selected,
    required this.onOpen,
    required this.onToggle,
  });

  final List<LibraryPhoto> photos;
  final Set<PhotoId> selected;
  final ValueChanged<int> onOpen;
  final ValueChanged<PhotoId>? onToggle;

  @override
  Widget build(BuildContext context) {
    final ValueChanged<PhotoId>? toggle = onToggle;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: DsSpacing.xs,
        crossAxisSpacing: DsSpacing.xs,
        childAspectRatio: 3 / 4,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int index) {
        final PhotoId id = photos[index].id;
        return DiscardedPhotoTile(
          photoId: id,
          isSelected: selected.contains(id),
          onOpen: () => onOpen(index),
          onToggle: toggle == null ? null : () => toggle(id),
        );
      },
    );
  }
}
