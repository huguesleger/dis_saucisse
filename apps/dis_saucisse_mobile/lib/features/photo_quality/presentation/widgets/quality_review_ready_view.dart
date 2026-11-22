import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/quality_review_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_groups.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_navigation.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_texts.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/widgets/quality_discard_bar.dart';
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
                for (final QualityGroup group in displayedQualityGroups(issue, state.groups)) ...<Widget>[
                  QualityGroupCard(
                    issue: issue,
                    group: group,
                    selected: state.selected,
                    onOpen: (int index) => openQualityPhoto(
                      context,
                      cubit: context.read<QualityReviewCubit>(),
                      issue: issue,
                      group: group,
                      index: index,
                    ),
                    onToggle: context.read<QualityReviewCubit>().toggle,
                  ),
                  const SizedBox(height: DsSpacing.s),
                ],
              ],
            ),
          ),
          QualityDiscardBar(
            selectedCount: state.selected.length,
            onDiscard: context.read<QualityReviewCubit>().discardSelected,
          ),
        ],
      ),
    ),
  );
}
