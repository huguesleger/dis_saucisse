import 'package:dis_saucisse_mobile/app/app.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

const Duration _splashDuration = Duration(seconds: 2);

void main() {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  configureDependencies();
  runApp(const App());
  Future<void>.delayed(_splashDuration, FlutterNativeSplash.remove);
}
