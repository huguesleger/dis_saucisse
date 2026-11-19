import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/pairing/presentation/widgets/pair_step.dart';
import 'package:flutter/material.dart';

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
                      Text('C’est rapide !', style: DsTextStyles.titleM),
                      Text('Une seule fois, ensuite tout est automatique', style: DsTextStyles.caption),
                    ],
                  ),
                ),
              ],
            ),
            const PairStep(number: 1, text: 'Ouvre Dis Saucisse ! sur le PC'),
            const PairStep(number: 2, text: 'Vérifie que les deux sont sur le même Wi-Fi'),
            const PairStep(number: 3, text: 'Vise le QR code, c’est tout'),
            DsButton(
              label: 'Importer une image du QR code',
              variant: DsButtonVariant.secondary,
              icon: Icons.image_outlined,
              onPressed: onImportImage,
            ),
            Row(
              spacing: DsSpacing.xs,
              children: <Widget>[
                const Icon(Icons.lock_outline_rounded, size: 14, color: DsColors.textSoft),
                Expanded(
                  child: Text('Les photos restent chez vous, sans passer par internet', style: DsTextStyles.caption),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
