import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/quality_review_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_texts.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QualityReviewReadyView extends StatelessWidget {
  const QualityReviewReadyView({super.key, required this.issue, required this.state});

  final QualityIssue issue;
  final QualityReviewReady state;

  @override
  Widget build(BuildContext context) => DsMeshBackground(
    child: SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(DsSpacing.l),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: DsRoundIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: t.quality.review.back,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
                const SizedBox(height: DsSpacing.m),
                Text(qualityReviewTitle(issue), style: DsTextStyles.display),
                const SizedBox(height: DsSpacing.xs),
                Text(qualityReviewIntro(issue), style: DsTextStyles.body.copyWith(color: DsColors.textSoft)),
                const SizedBox(height: DsSpacing.l),
                for (final QualityGroup group in state.groups) ...<Widget>[
                  QualityGroupCard(
                    group: group,
                    selected: state.selected,
                    onToggle: context.read<QualityReviewCubit>().toggle,
                  ),
                  const SizedBox(height: DsSpacing.s),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.s, DsSpacing.l, DsSpacing.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: DsSpacing.xs,
              children: <Widget>[
                DsButton(
                  label: t.quality.review.discard(photos: photoCountLabel(state.selected.length)),
                  variant: DsButtonVariant.dark,
                  onPressed: state.selected.isEmpty ? null : context.read<QualityReviewCubit>().discardSelected,
                ),
                Text(
                  t.quality.review.nothingDeleted,
                  style: DsTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
