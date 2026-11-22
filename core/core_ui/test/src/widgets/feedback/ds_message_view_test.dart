import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpMessage(WidgetTester tester, DsMessageView view) =>
      tester.pumpWidget(MaterialApp(home: Scaffold(body: view)));

  testWidgets('shows the title and the message without buttons', (WidgetTester tester) async {
    await pumpMessage(tester, const DsMessageView(title: 'Tout est propre !', message: 'Aucune photo floue.'));

    expect(find.text('Tout est propre !'), findsOneWidget);
    expect(find.text('Aucune photo floue.'), findsOneWidget);
    expect(find.byType(DsButton), findsNothing);
    expect(find.byType(DsRoundIconButton), findsNothing);
  });

  testWidgets('calls the primary and secondary actions', (WidgetTester tester) async {
    final List<String> pressed = <String>[];
    await pumpMessage(
      tester,
      DsMessageView(
        title: 'PC introuvable',
        message: 'Vérifie le Wi-Fi.',
        primaryAction: DsMessageAction(label: 'Réessayer', onPressed: () => pressed.add('retry')),
        secondaryAction: DsMessageAction(label: 'Retour à l’accueil', onPressed: () => pressed.add('home')),
      ),
    );

    await tester.tap(find.text('Réessayer'));
    await tester.tap(find.text('Retour à l’accueil'));

    expect(pressed, <String>['retry', 'home']);
  });

  testWidgets('pops the page with the back arrow', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const Scaffold(
                  body: DsMessageView(title: 'Oups !', message: 'Erreur.', showBackButton: true),
                ),
              ),
            ),
            child: const Text('Ouvrir'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Ouvrir'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();

    expect(find.text('Oups !'), findsNothing);
  });

  testWidgets('paints the mesh background only as a page', (WidgetTester tester) async {
    await pumpMessage(tester, const DsMessageView(title: 'Oups !', message: 'Erreur.'));
    expect(find.byType(DsMeshBackground), findsOneWidget);

    await pumpMessage(
      tester,
      const DsMessageView(title: 'Oups !', message: 'Erreur.', placement: DsMessagePlacement.tab),
    );
    expect(find.byType(DsMeshBackground), findsNothing);
  });
}
