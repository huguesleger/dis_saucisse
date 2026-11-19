import 'package:dis_saucisse_mobile/app/app.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens on the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('248 photos\nà trier'), findsOneWidget);
    expect(find.text('Lancer le tri'), findsOneWidget);
  });
}
