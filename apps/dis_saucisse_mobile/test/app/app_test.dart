import 'package:dis_saucisse_mobile/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the app name', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Dis Saucisse !'), findsOneWidget);
  });
}
