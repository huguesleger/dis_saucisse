import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  Future<void> pumpSkeleton(WidgetTester tester, {required bool enabled, VoidCallback? onPressed}) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DsSkeletonizer(
          enabled: enabled,
          child: DsButton(label: 'Lancer le tri', onPressed: onPressed ?? () {}),
        ),
      ),
    ),
  );

  testWidgets('skeletonizes its child while enabled', (WidgetTester tester) async {
    await pumpSkeleton(tester, enabled: true);

    expect(
      tester.widget<Skeletonizer>(find.byWidgetPredicate((Widget widget) => widget is Skeletonizer)).enabled,
      isTrue,
    );
  });

  testWidgets('ignores taps while enabled', (WidgetTester tester) async {
    int taps = 0;
    await pumpSkeleton(tester, enabled: true, onPressed: () => taps++);

    await tester.tap(find.byType(DsButton), warnIfMissed: false);

    expect(taps, 0);
  });

  testWidgets('shows its child normally once disabled', (WidgetTester tester) async {
    int taps = 0;
    await pumpSkeleton(tester, enabled: false, onPressed: () => taps++);

    await tester.tap(find.text('Lancer le tri'));

    expect(taps, 1);
  });
}
