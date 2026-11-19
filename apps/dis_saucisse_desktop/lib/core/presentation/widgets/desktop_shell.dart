import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/presentation/desktop_section.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/desktop_sidebar.dart';
import 'package:flutter/material.dart';

class DesktopShell extends StatelessWidget {
  const DesktopShell({super.key, required this.section, required this.onSelected, required this.child});

  final DesktopSection section;
  final ValueChanged<DesktopSection> onSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DesktopSidebar(section: section, onSelected: onSelected),
        Expanded(child: DsMeshBackground(meshHeight: 420, child: child)),
      ],
    ),
  );
}
