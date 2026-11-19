import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    title: 'Dis Saucisse !',
    debugShowCheckedModeBanner: false,
    locale: Locale('fr'),
    supportedLocales: <Locale>[Locale('fr')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: Scaffold(body: Center(child: Text('Dis Saucisse !'))),
  );
}
