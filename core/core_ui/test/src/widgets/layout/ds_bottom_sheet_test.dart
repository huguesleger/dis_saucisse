import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Future<String?> result;

  Future<void> openSheet(WidgetTester tester, WidgetBuilder builder) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DsTheme.light(),
        home: Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => result = DsBottomSheet.show<String>(context, builder: builder),
            child: const Text('Ouvrir'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Ouvrir'));
    await tester.pumpAndSettle();
  }

  testWidgets('shows the title, the subtitle and the content', (WidgetTester tester) async {
    await openSheet(
      tester,
      (_) => const DsBottomSheet(title: 'Nomme l’événement', subtitle: 'Visible sur le PC', child: Text('Contenu')),
    );

    expect(find.text('Nomme l’événement'), findsOneWidget);
    expect(find.text('Visible sur le PC'), findsOneWidget);
    expect(find.text('Contenu'), findsOneWidget);
  });

  testWidgets('returns the value popped by the sheet', (WidgetTester tester) async {
    await openSheet(
      tester,
      (BuildContext context) => DsBottomSheet(
        title: 'Choisis',
        child: TextButton(onPressed: () => Navigator.of(context).pop('Plage'), child: const Text('Plage')),
      ),
    );

    await tester.tap(find.text('Plage'));
    await tester.pumpAndSettle();

    expect(await result, 'Plage');
  });

  testWidgets('never grows past 85% of the screen', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 800));
    await openSheet(
      tester,
      (_) => DsBottomSheet(
        title: 'Longue liste',
        child: ListView(shrinkWrap: true, children: <Widget>[for (int i = 0; i < 50; i++) Text('Rafale $i')]),
      ),
    );

    expect(tester.getSize(find.byType(DsBottomSheet)).height, lessThanOrEqualTo(800 * 0.85));
  });
}
