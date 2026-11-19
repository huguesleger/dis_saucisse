import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router = buildAppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Dis Saucisse !',
    debugShowCheckedModeBanner: false,
    theme: DsTheme.light(),
    locale: const Locale('fr'),
    supportedLocales: const <Locale>[Locale('fr')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    routerConfig: _router,
  );
}
