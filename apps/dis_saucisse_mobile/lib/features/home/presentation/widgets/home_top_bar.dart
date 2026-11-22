import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, required this.onComputerTap});

  final VoidCallback onComputerTap;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      const DsLogoPill(),
      const Spacer(),
      DsRoundIconButton(icon: Icons.calendar_today_outlined, tooltip: t.home.topBar.calendar, onPressed: () {}),
      const SizedBox(width: DsSpacing.xs),
      DsRoundIconButton(
        icon: Icons.desktop_windows_outlined,
        tooltip: t.home.topBar.computer,
        variant: DsRoundIconButtonVariant.dark,
        onPressed: onComputerTap,
      ),
    ],
  );
}
