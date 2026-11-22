import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/app/app.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

const Duration _splashDuration = Duration(seconds: 2);

const SystemUiOverlayStyle _systemNavigationBarStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: DsColors.pageBackground,
  systemNavigationBarDividerColor: DsColors.pageBackground,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarContrastEnforced: false,
);

void main() {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(_systemNavigationBarStyle);
  configureDependencies();
  runApp(const App());
  Future<void>.delayed(_splashDuration, FlutterNativeSplash.remove);
}
