import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_groups.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_photo_tile.dart';
import 'package:flutter/material.dart';

class QualityGroupCard extends StatelessWidget {
  const QualityGroupCard({
    super.key,
    required this.issue,
    required this.group,
    required this.selected,
    required this.onOpen,
    required this.onToggle,
  });

  final QualityIssue issue;
  final QualityGroup group;
  final Set<PhotoId> selected;
  final ValueChanged<int> onOpen;
  final ValueChanged<PhotoId> onToggle;

  @override
  Widget build(BuildContext context) => DsCard(
    padding: const EdgeInsets.all(DsSpacing.s),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(qualityGroupTitle(issue, group), style: DsTextStyles.titleM),
        ...qualityGroupSubtitle(issue, group).match(
          () => <Widget>[],
          (String subtitle) => <Widget>[Text(subtitle, style: DsTextStyles.caption)],
        ),
        const SizedBox(height: DsSpacing.s),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: DsSpacing.xs,
            crossAxisSpacing: DsSpacing.xs,
            childAspectRatio: 3 / 4,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: group.photos.length,
          itemBuilder: (BuildContext context, int index) => QualityPhotoTile(
            photoId: group.photos[index].id,
            status: qualityPhotoStatus(group, group.photos[index], selected),
            onOpen: () => onOpen(index),
            onToggle: () => onToggle(group.photos[index].id),
          ),
        ),
      ],
    ),
  );
}
