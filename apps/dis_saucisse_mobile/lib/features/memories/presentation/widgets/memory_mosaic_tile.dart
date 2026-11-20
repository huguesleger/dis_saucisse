import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

class MemoryMosaicTile extends StatelessWidget {
  const MemoryMosaicTile({super.key, required this.photo, required this.placeholderIndex, required this.hiddenCount});

  final Option<PhotoId> photo;
  final int placeholderIndex;
  final int hiddenCount;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: <Widget>[
      DsPhoto(
        image: photo.map((PhotoId id) => PhotoThumbnailImage(id, size: 200)).toNullable(),
        placeholderIndex: placeholderIndex,
        borderRadius: DsRadius.smallAll,
      ),
      if (hiddenCount > 0)
        DecoratedBox(
          decoration: const BoxDecoration(color: Color(0x993A1520), borderRadius: DsRadius.smallAll),
          child: Center(
            child: Text('+$hiddenCount', style: DsTextStyles.titleM.copyWith(color: DsColors.background)),
          ),
        ),
    ],
  );
}
