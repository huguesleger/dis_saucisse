import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class BurstSortTopBar extends StatelessWidget {
  const BurstSortTopBar({super.key, required this.burstPosition, required this.burstCount, required this.onBack});

  final int burstPosition;
  final int burstCount;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.m, vertical: DsSpacing.xs),
      child: Row(
        children: <Widget>[
          DsRoundIconButton(
            icon: Icons.arrow_back_rounded,
            tooltip: t.burstSort.backHome,
            variant: DsRoundIconButtonVariant.glass,
            onPressed: onBack,
          ),
          const Spacer(),
          DsGlassPill(
            label: t.burstSort.burstPosition(position: burstPosition, count: burstCount),
          ),
          const Spacer(),
          const SizedBox(width: 44),
        ],
      ),
    ),
  );
}
