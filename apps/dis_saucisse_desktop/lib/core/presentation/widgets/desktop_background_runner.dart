import 'dart:io';

import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:flutter/widgets.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class DesktopBackgroundRunner extends StatefulWidget {
  const DesktopBackgroundRunner({super.key, required this.child});

  final Widget child;

  static Future<void> prepare() async {
    await windowManager.ensureInitialized();
    await windowManager.setPreventClose(true);
    await windowManager.setMinimumSize(const Size(980, 640));
  }

  @override
  State<DesktopBackgroundRunner> createState() => _DesktopBackgroundRunnerState();
}

class _DesktopBackgroundRunnerState extends State<DesktopBackgroundRunner> with TrayListener, WindowListener {
  static const String _showKey = 'show';
  static const String _quitKey = 'quit';

  @override
  void initState() {
    super.initState();
    trayManager.addListener(this);
    windowManager.addListener(this);
    _setUpTray();
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<void> _setUpTray() async {
    await trayManager.setIcon(
      Platform.isWindows ? 'assets/tray/tray_icon.ico' : 'assets/tray/tray_icon.png',
      isTemplate: true,
    );
    await trayManager.setToolTip(t.shell.tray.tooltip);
    await trayManager.setContextMenu(
      Menu(
        items: <MenuItem>[
          MenuItem(key: _showKey, label: t.shell.tray.open),
          MenuItem.separator(),
          MenuItem(key: _quitKey, label: t.shell.tray.quit),
        ],
      ),
    );
  }

  Future<void> _showWindow() async {
    await windowManager.show();
    await windowManager.focus();
  }

  @override
  void onWindowClose() => windowManager.hide();

  @override
  void onTrayIconMouseDown() => Platform.isWindows ? _showWindow() : trayManager.popUpContextMenu();

  @override
  void onTrayIconRightMouseDown() => trayManager.popUpContextMenu();

  @override
  void onTrayMenuItemClick(MenuItem menuItem) => switch (menuItem.key) {
    _showKey => _showWindow(),
    _quitKey => windowManager.destroy(),
    _ => null,
  };

  @override
  Widget build(BuildContext context) => widget.child;
}
