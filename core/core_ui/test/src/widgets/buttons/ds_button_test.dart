import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpButton(WidgetTester tester, DsButton button) =>
      tester.pumpWidget(MaterialApp(home: Scaffold(body: button)));

  testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
    int taps = 0;
    await pumpButton(tester, DsButton(label: 'Garder', onPressed: () => taps++));

    await tester.tap(find.text('Garder'));

    expect(taps, 1);
  });

  testWidgets('is disabled without onPressed', (WidgetTester tester) async {
    await pumpButton(tester, const DsButton(label: 'Garder', onPressed: null));

    expect(tester.widget<FilledButton>(find.byType(FilledButton)).enabled, isFalse);
  });

  testWidgets('shows the dark variant with the yellow text', (WidgetTester tester) async {
    await pumpButton(tester, DsButton(label: 'Lancer le tri', variant: DsButtonVariant.dark, onPressed: () {}));

    final ButtonStyle style = tester.widget<FilledButton>(find.byType(FilledButton)).style!;
    expect(style.backgroundColor?.resolve(<WidgetState>{}), DsColors.text);
    expect(style.foregroundColor?.resolve(<WidgetState>{}), DsColors.mustardLight);
  });
}
