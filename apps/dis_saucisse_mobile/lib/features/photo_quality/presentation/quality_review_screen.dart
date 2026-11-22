import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/failure_view.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/quality_review_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_texts.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_review_ready_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QualityReviewScreen extends StatelessWidget {
  const QualityReviewScreen({super.key, required this.issue});

  final QualityIssue issue;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder<QualityReviewCubit, QualityReviewState>(
      builder: (BuildContext context, QualityReviewState state) => switch (state) {
        QualityReviewLoading() => const Center(child: DsLoader()),
        QualityReviewFailed(:final failure) => FailureView(
          failure: failure,
          onRetry: context.read<QualityReviewCubit>().load,
          showBackButton: true,
        ),
        QualityReviewDone(:final int discardedCount) => DsMessageView(
          title: discardedCount > 1
              ? t.quality.done.titleSeveral(count: discardedCount)
              : t.quality.done.titleSingle(count: discardedCount),
          message: discardedCount > 1 ? t.quality.done.messageSeveral : t.quality.done.messageSingle,
          showBackButton: true,
        ),
        QualityReviewReady(groups: final groups) when groups.isEmpty => DsMessageView(
          title: t.quality.empty.title,
          message: qualityReviewEmpty(issue),
          showBackButton: true,
        ),
        final QualityReviewReady ready => QualityReviewReadyView(issue: issue, state: ready),
      },
    ),
  );
}
