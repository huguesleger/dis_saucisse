import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

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
                tooltip: t.pairing.topBar.close,
                variant: DsRoundIconButtonVariant.glass,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const Spacer(),
              DsGlassPill(label: t.pairing.topBar.pill),
              const Spacer(),
              const SizedBox(width: 44),
            ],
          ),
          Text(
            t.pairing.topBar.scan,
            style: DsTextStyles.titleL.copyWith(color: DsColors.background),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
