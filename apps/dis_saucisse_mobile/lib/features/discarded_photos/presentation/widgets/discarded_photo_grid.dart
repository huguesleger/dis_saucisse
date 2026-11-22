import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_tile.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/widgets.dart';

class DiscardedPhotoGrid extends StatelessWidget {
  const DiscardedPhotoGrid({super.key, required this.photos, required this.selected, required this.onToggle});

  final List<LibraryPhoto> photos;
  final Set<PhotoId> selected;
  final ValueChanged<PhotoId>? onToggle;

  @override
  Widget build(BuildContext context) {
    final ValueChanged<PhotoId>? toggle = onToggle;
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: DsSpacing.xs,
      crossAxisSpacing: DsSpacing.xs,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: <Widget>[
        for (final LibraryPhoto photo in photos)
          DiscardedPhotoTile(
            photoId: photo.id,
            isSelected: selected.contains(photo.id),
            onTap: toggle == null ? null : () => toggle(photo.id),
          ),
      ],
    );
  }
}
