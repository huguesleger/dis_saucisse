import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class PairTopBar extends StatelessWidget {
  const PairTopBar({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.m, vertical: DsSpacing.xs),
      child: Column(
        spacing: DsSpacing.l,
        children: <Widget>[
          Row(
            children: <Widget>[
              DsRoundIconButton(
                icon: Icons.close_rounded,
                tooltip: 'Fermer',
                variant: DsRoundIconButtonVariant.glass,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const Spacer(),
              const DsGlassPill(label: 'Associer le PC'),
              const Spacer(),
              const SizedBox(width: 44),
            ],
          ),
          Text(
            'Scanne le QR code\naffiché sur ton PC',
            style: DsTextStyles.titleL.copyWith(color: DsColors.background),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
