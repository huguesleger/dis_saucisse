import 'package:dis_saucisse_desktop/app/app.dart';
import 'package:dis_saucisse_desktop/config/setup_get_it.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}
