import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('refreshes a fixed layout pulled down', (WidgetTester tester) async {
    int refreshes = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DsRefresh(
            onRefresh: () async => refreshes++,
            child: const DsRefreshFillView(child: Center(child: Text('Pas encore de souvenirs'))),
          ),
        ),
      ),
    );

    await tester.fling(find.text('Pas encore de souvenirs'), const Offset(0, 400), 1000);
    await tester.pumpAndSettle();

    expect(refreshes, 1);
  });
}
