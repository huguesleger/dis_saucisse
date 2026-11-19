import 'package:core_ui/gallery.dart';
import 'package:dis_saucisse_mobile/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the design system gallery', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(DsGalleryScreen), findsOneWidget);
  });
}
