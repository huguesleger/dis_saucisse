import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/core/presentation/desktop_section.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/desktop_connection_cards.dart';
import 'package:flutter/material.dart';

class DesktopSidebar extends StatelessWidget {
  const DesktopSidebar({super.key, required this.section, required this.onSelected});

  final DesktopSection section;
  final ValueChanged<DesktopSection> onSelected;

  @override
  Widget build(BuildContext context) => Container(
    width: 248,
    color: DsColors.background,
    padding: const EdgeInsets.all(DsSpacing.m),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: DsSpacing.xxs,
      children: <Widget>[
        const Align(alignment: Alignment.centerLeft, child: DsLogoPill(elevated: false)),
        const SizedBox(height: DsSpacing.l),
        for (final DesktopSection destination in DesktopSection.values)
          DsSidebarItem(
            destination: switch (destination) {
              DesktopSection.reception => DsNavDestination(
                icon: Icons.image_outlined,
                label: t.shell.navigation.reception,
              ),
              DesktopSection.storage => DsNavDestination(
                icon: Icons.folder_outlined,
                label: t.shell.navigation.storage,
              ),
              DesktopSection.history => DsNavDestination(
                icon: Icons.history_rounded,
                label: t.shell.navigation.history,
              ),
            },
            selected: destination == section,
            onTap: () => onSelected(destination),
          ),
        const Spacer(),
        const DesktopConnectionCards(),
      ],
    ),
  );
}
