import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:flutter/material.dart';

class HomeQualityTiles extends StatelessWidget {
  const HomeQualityTiles({
    super.key,
    required this.duplicateCount,
    required this.blurryCount,
    required this.photosLeftToAnalyze,
    required this.onOpen,
  });

  final int duplicateCount;
  final int blurryCount;
  final int photosLeftToAnalyze;
  final ValueChanged<QualityIssue> onOpen;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsSpacing.xs,
    children: <Widget>[
      Row(
        spacing: DsSpacing.s,
        children: <Widget>[
          Expanded(
            child: DsStatTile(
              value: '$duplicateCount',
              label: 'doublons',
              icon: Icons.filter_none_rounded,
              iconBackground: DsColors.mustardLight,
              onTap: () => onOpen(QualityIssue.duplicates),
            ),
          ),
          Expanded(
            child: DsStatTile(
              value: '$blurryCount',
              label: 'photos floues',
              icon: Icons.remove_circle_outline_rounded,
              iconBackground: DsColors.surfaceStrong,
              onTap: () => onOpen(QualityIssue.blurry),
            ),
          ),
        ],
      ),
      if (photosLeftToAnalyze > 0)
        Text(
          'Analyse en cours… encore $photosLeftToAnalyze photo${photosLeftToAnalyze > 1 ? 's' : ''}',
          style: DsTextStyles.caption,
        ),
    ],
  );
}
