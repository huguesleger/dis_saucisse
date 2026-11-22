import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

void main() {
  Future<void> pumpLoader(WidgetTester tester, DsLoader loader) =>
      tester.pumpWidget(MaterialApp(home: Scaffold(body: Center(child: loader))));

  testWidgets('plays the sausage animation', (WidgetTester tester) async {
    await pumpLoader(tester, const DsLoader());

    expect(find.byType(Lottie), findsOneWidget);
    expect(find.bySemanticsLabel('Chargement'), findsOneWidget);
  });

  testWidgets('keeps a 2:1 ratio for the given width', (WidgetTester tester) async {
    await pumpLoader(tester, const DsLoader(width: 120));

    expect(tester.getSize(find.byType(DsLoader)), const Size(120, 60));
  });

  testWidgets('loads a valid animation that loops forever', (WidgetTester tester) async {
    final LottieComposition composition = (await tester.runAsync(
      () => AssetLottie('assets/animations/ds_loader.json', package: 'core_ui').load(),
    ))!;

    expect(composition.durationFrames, greaterThan(0));
    expect((composition.bounds.width, composition.bounds.height), (120, 60));
  });
}
