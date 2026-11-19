import 'package:core_ui/core_ui.dart';
import 'package:core_ui/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Dis Saucisse !',
    debugShowCheckedModeBanner: false,
    theme: DsTheme.light(),
    locale: const Locale('fr'),
    supportedLocales: const <Locale>[Locale('fr')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: const DsGalleryScreen(),
  );
}
