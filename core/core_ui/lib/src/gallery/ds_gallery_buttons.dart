import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/widgets/buttons/ds_button.dart';
import 'package:core_ui/src/widgets/buttons/ds_button_variant.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button.dart';
import 'package:core_ui/src/widgets/buttons/ds_round_icon_button_variant.dart';
import 'package:flutter/material.dart';

class DsGalleryButtons extends StatelessWidget {
  const DsGalleryButtons({super.key});

  @override
  Widget build(BuildContext context) => Column(
    spacing: DsSpacing.s,
    children: <Widget>[
      DsButton(label: 'Lancer le tri', variant: DsButtonVariant.dark, onPressed: () {}),
      DsButton(label: 'Trier mes photos', onPressed: () {}),
      DsButton(label: 'Plus tard', variant: DsButtonVariant.secondary, onPressed: () {}),
      Row(
        spacing: DsSpacing.s,
        children: <Widget>[
          Expanded(
            child: DsButton(label: 'Écarter', variant: DsButtonVariant.light, onPressed: () {}),
          ),
          Expanded(
            child: DsButton(label: 'Garder', onPressed: () {}),
          ),
        ],
      ),
      Row(
        spacing: DsSpacing.s,
        children: <Widget>[
          DsRoundIconButton(icon: Icons.calendar_today_outlined, tooltip: 'Calendrier', onPressed: () {}),
          DsRoundIconButton(
            icon: Icons.desktop_windows_outlined,
            tooltip: 'Envoyer au PC',
            variant: DsRoundIconButtonVariant.dark,
            onPressed: () {},
          ),
          DsButton(label: 'Mettre en pause', variant: DsButtonVariant.light, expanded: false, onPressed: () {}),
        ],
      ),
    ],
  );
}
