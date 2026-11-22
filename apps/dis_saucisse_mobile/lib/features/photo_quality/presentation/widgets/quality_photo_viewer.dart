import 'package:dis_saucisse_mobile/core/presentation/widgets/photo_viewer/photo_viewer.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/quality_review_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_photo_status.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_groups.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_photo_viewer_panel.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QualityPhotoViewer extends StatelessWidget {
  const QualityPhotoViewer({super.key, required this.issue, required this.group, required this.initialIndex});

  final QualityIssue issue;
  final QualityGroup group;
  final int initialIndex;

  @override
  Widget build(BuildContext context) => PhotoViewer(
    photos: group.photos.map((LibraryPhoto photo) => photo.id).toList(),
    initialIndex: initialIndex,
    title: qualityGroupTitle(issue, group),
    panelBuilder: (BuildContext context, int index) => BlocBuilder<QualityReviewCubit, QualityReviewState>(
      builder: (BuildContext context, QualityReviewState state) {
        final Set<PhotoId> toDiscard = switch (state) {
          QualityReviewReady(:final Set<PhotoId> selected) => selected,
          QualityReviewLoading() || QualityReviewFailed() || QualityReviewDone() => const <PhotoId>{},
        };
        final QualityPhotoStatus status = qualityPhotoStatus(group, group.photos[index], toDiscard);
        return QualityPhotoViewerPanel(
          issue: issue,
          position: index,
          status: status,
          onDecision: (bool discard) {
            if ((status == QualityPhotoStatus.toDiscard) != discard) {
              context.read<QualityReviewCubit>().toggle(group.photos[index].id);
            }
          },
        );
      },
    ),
  );
}
