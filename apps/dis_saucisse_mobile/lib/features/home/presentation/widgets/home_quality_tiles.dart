import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HomeQualityTiles extends StatelessWidget {
  const HomeQualityTiles({super.key, required this.duplicateCount, required this.blurryCount});

  final int duplicateCount;
  final int blurryCount;

  @override
  Widget build(BuildContext context) => Row(
    spacing: DsSpacing.s,
    children: <Widget>[
      Expanded(
        child: DsStatTile(
          value: '$duplicateCount',
          label: 'doublons',
          icon: Icons.filter_none_rounded,
          iconBackground: DsColors.mustardLight,
          onTap: () {},
        ),
      ),
      Expanded(
        child: DsStatTile(
          value: '$blurryCount',
          label: 'photos floues',
          icon: Icons.remove_circle_outline_rounded,
          iconBackground: DsColors.surfaceStrong,
          onTap: () {},
        ),
      ),
    ],
  );
}
