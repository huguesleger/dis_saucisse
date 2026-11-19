import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Dis Saucisse !',
    debugShowCheckedModeBanner: false,
    theme: DsTheme.light(),
    locale: const Locale('fr'),
    supportedLocales: const <Locale>[Locale('fr')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    routerConfig: appRouter,
  );
}
