import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/widgets/pair_step.dart';
import 'package:flutter/material.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class PairHelpSheet extends StatelessWidget {
  const PairHelpSheet({super.key, required this.onImportImage});

  final VoidCallback onImportImage;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsColors.pageBackground, borderRadius: DsRadius.sheetTop),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.l, DsSpacing.l, DsSpacing.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: DsSpacing.s,
          children: <Widget>[
            Row(
              spacing: DsSpacing.s,
              children: <Widget>[
                const DsMascot(width: 64),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(t.pairing.help.title, style: DsTextStyles.titleM),
                      Text(t.pairing.help.subtitle, style: DsTextStyles.caption),
                    ],
                  ),
                ),
              ],
            ),
            PairStep(number: 1, text: t.pairing.help.step1),
            PairStep(number: 2, text: t.pairing.help.step2),
            PairStep(number: 3, text: t.pairing.help.step3),
            DsButton(
              label: t.pairing.help.importImage,
              variant: DsButtonVariant.secondary,
              icon: Icons.image_outlined,
              onPressed: onImportImage,
            ),
            Row(
              spacing: DsSpacing.xs,
              children: <Widget>[
                const Icon(Icons.lock_outline_rounded, size: 14, color: DsColors.textSoft),
                Expanded(
                  child: Text(t.pairing.help.privacy, style: DsTextStyles.caption),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
