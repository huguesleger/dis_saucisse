import 'package:dis_saucisse_mobile/app/app.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}
