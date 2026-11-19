import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const List<DsNavDestination> destinations = <DsNavDestination>[
    DsNavDestination(icon: Icons.photo_outlined, label: 'Photos à trier'),
    DsNavDestination(icon: Icons.favorite_border_rounded, label: 'Souvenirs'),
    DsNavDestination(icon: Icons.tune_rounded, label: 'Réglages'),
  ];

  Future<List<int>> pumpBar(WidgetTester tester) async {
    final List<int> selected = <int>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: DsFloatingNavBar(destinations: destinations, selectedIndex: 0, onDestinationSelected: selected.add),
          ),
        ),
      ),
    );
    return selected;
  }

  testWidgets('reports the index of the tapped destination', (WidgetTester tester) async {
    final List<int> selected = await pumpBar(tester);

    await tester.tap(find.byIcon(Icons.tune_rounded));

    expect(selected, <int>[2]);
  });

  testWidgets('labels every destination for screen readers', (WidgetTester tester) async {
    final SemanticsHandle semantics = tester.ensureSemantics();
    await pumpBar(tester);

    for (final DsNavDestination destination in destinations) {
      expect(find.bySemanticsLabel(destination.label), findsOneWidget);
    }
    semantics.dispose();
  });
}
