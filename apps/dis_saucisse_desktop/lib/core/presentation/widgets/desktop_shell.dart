import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/desktop_sidebar.dart';
import 'package:flutter/material.dart';

class DesktopShell extends StatelessWidget {
  const DesktopShell({super.key, required this.sidebar, required this.child});

  final DesktopSidebar sidebar;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        sidebar,
        Expanded(child: DsMeshBackground(meshHeight: 420, child: child)),
      ],
    ),
  );
}
