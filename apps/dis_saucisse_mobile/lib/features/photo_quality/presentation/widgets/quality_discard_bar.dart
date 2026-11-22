import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_texts.dart';
import 'package:flutter/widgets.dart';

class QualityDiscardBar extends StatelessWidget {
  const QualityDiscardBar({super.key, required this.selectedCount, required this.onDiscard});

  final int selectedCount;
  final VoidCallback onDiscard;

  @override
  Widget build(BuildContext context) => AnimatedSize(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOut,
    child: selectedCount == 0
        ? const SizedBox(width: double.infinity)
        : Padding(
            padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.s, DsSpacing.l, DsSpacing.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: DsSpacing.xs,
              children: <Widget>[
                DsButton(
                  label: t.quality.review.discard(photos: photoCountLabel(selectedCount)),
                  variant: DsButtonVariant.dark,
                  onPressed: onDiscard,
                ),
                Text(t.quality.review.nothingDeleted, style: DsTextStyles.caption, textAlign: TextAlign.center),
              ],
            ),
          ),
  );
}
