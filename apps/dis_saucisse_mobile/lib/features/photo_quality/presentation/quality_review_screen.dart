import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/quality_review_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_texts.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_review_message_view.dart';
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
        QualityReviewLoading() => const Center(child: CircularProgressIndicator(color: DsColors.mustard)),
        QualityReviewFailed() => const QualityReviewMessageView(
          title: 'Oups !',
          message: 'Je n’ai pas réussi à relire tes photos.',
        ),
        QualityReviewDone(:final int discardedCount) => QualityReviewMessageView(
          title: '${photoCountLabel(discardedCount)} écartée${discardedCount > 1 ? 's' : ''}',
          message:
              '${discardedCount > 1 ? 'Elles iront' : 'Elle ira'} dans « Écartées » sur l’ordinateur. Rien n’est supprimé du téléphone.',
        ),
        QualityReviewReady(groups: final groups) when groups.isEmpty => QualityReviewMessageView(
          title: 'Tout est propre !',
          message: qualityReviewEmpty(issue),
        ),
        final QualityReviewReady ready => QualityReviewReadyView(issue: issue, state: ready),
      },
    ),
  );
}
