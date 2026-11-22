import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_photo_status.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_decision_toggle.dart';
import 'package:flutter/material.dart';

class QualityPhotoViewerPanel extends StatelessWidget {
  const QualityPhotoViewerPanel({
    super.key,
    required this.issue,
    required this.position,
    required this.status,
    required this.onDecision,
  });

  final QualityIssue issue;
  final int position;
  final QualityPhotoStatus status;
  final ValueChanged<bool> onDecision;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(DsSpacing.l, 0, DsSpacing.l, DsSpacing.m),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: DsSpacing.m,
      children: <Widget>[
        Text(
          t.quality.viewer.photo(position: position + 1),
          style: DsTextStyles.display.copyWith(color: DsColors.background),
        ),
        DsGlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: DsSpacing.m,
            children: <Widget>[
              Text(
                switch ((status, issue)) {
                  (QualityPhotoStatus.best, _) => t.quality.viewer.message.best,
                  (_, QualityIssue.duplicates) => t.quality.viewer.message.duplicate,
                  (_, QualityIssue.blurry) => t.quality.viewer.message.blurry,
                },
                style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
              ),
              switch (status) {
                QualityPhotoStatus.best => Align(
                  alignment: Alignment.centerLeft,
                  child: DsStatusBadge(
                    label: t.quality.viewer.best,
                    tone: DsStatusTone.highlight,
                    icon: Icons.star_rounded,
                  ),
                ),
                QualityPhotoStatus.kept || QualityPhotoStatus.toDiscard => QualityDecisionToggle(
                  toDiscard: status == QualityPhotoStatus.toDiscard,
                  onChanged: onDecision,
                ),
              },
            ],
          ),
        ),
      ],
    ),
  );
}
