import 'package:dis_saucisse_desktop/features/reception/domain/rules/remaining_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  final DateTime start = DateTime(2026, 11, 19, 20);

  test('projects the pace of the photos already received', () {
    expect(
      remainingTime(
        startedAt: start,
        lastReceivedAt: start.add(const Duration(minutes: 2)),
        received: 100,
        expected: 150,
      ),
      some(const Duration(minutes: 1)),
    );
  });

  test('gives no estimate before the first photo or once everything arrived', () {
    expect(remainingTime(startedAt: start, lastReceivedAt: start, received: 0, expected: 10), none<Duration>());
    expect(remainingTime(startedAt: start, lastReceivedAt: start, received: 10, expected: 10), none<Duration>());
  });
}
