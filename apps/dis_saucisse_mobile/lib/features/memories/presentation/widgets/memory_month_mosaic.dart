import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memory_mosaic_tile.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

class MemoryMonthMosaic extends StatelessWidget {
  const MemoryMonthMosaic({super.key, required this.photoCount, required this.photosOnPhone});

  static const int _columns = 4;
  static const int _maxTiles = 8;

  final int photoCount;
  final List<PhotoId> photosOnPhone;

  @override
  Widget build(BuildContext context) {
    final int tileCount = min(photoCount, _maxTiles);
    return GridView.count(
      crossAxisCount: _columns,
      mainAxisSpacing: DsSpacing.xxs + 2,
      crossAxisSpacing: DsSpacing.xxs + 2,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        for (int index = 0; index < tileCount; index++)
          MemoryMosaicTile(
            photo: index < photosOnPhone.length ? some(photosOnPhone[index]) : none(),
            placeholderIndex: index,
            hiddenCount: index == tileCount - 1 ? photoCount - tileCount : 0,
          ),
      ],
    );
  }
}
