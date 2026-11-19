import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      const DsLogoPill(),
      const Spacer(),
      DsRoundIconButton(icon: Icons.calendar_today_outlined, tooltip: 'Calendrier', onPressed: () {}),
      const SizedBox(width: DsSpacing.xs),
      DsRoundIconButton(
        icon: Icons.desktop_windows_outlined,
        tooltip: 'Envoyer vers le PC',
        variant: DsRoundIconButtonVariant.dark,
        onPressed: () {},
      ),
    ],
  );
}
