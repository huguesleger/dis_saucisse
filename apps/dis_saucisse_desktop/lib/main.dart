import 'package:dis_saucisse_desktop/app/app.dart';
import 'package:dis_saucisse_desktop/config/setup_get_it.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/desktop_background_runner.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopBackgroundRunner.prepare();
  configureDependencies();
  runApp(const DesktopBackgroundRunner(child: App()));
}
