import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the logo', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(DsLogoPill), findsOneWidget);
  });
}
