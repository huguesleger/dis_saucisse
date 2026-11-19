import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('calls onSelected when tapped', (WidgetTester tester) async {
    int selections = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DsFilterChip(label: 'Novembre', selected: false, onSelected: () => selections++),
        ),
      ),
    );

    await tester.tap(find.text('Novembre'));

    expect(selections, 1);
  });

  testWidgets('uses the dark pill when selected', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DsFilterChip(label: 'Tout', selected: true, onSelected: () {}),
        ),
      ),
    );

    final Material pill = tester.widget<Material>(
      find.descendant(of: find.byType(DsFilterChip), matching: find.byType(Material)).first,
    );
    expect(pill.color, DsColors.text);
  });
}
