import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/sorting_start_preset.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/sorting_start_presets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DateTime today = DateTime(2026, 11, 19, 16, 42);

  test('starts at midnight, one month earlier', () {
    expect(sortingStartFrom(SortingStartPreset.oneMonth, today), DateTime(2026, 10, 19));
  });

  test('crosses the year for six months', () {
    expect(sortingStartFrom(SortingStartPreset.sixMonths, DateTime(2026, 3, 10)), DateTime(2025, 9, 10));
  });

  test('goes back one year', () {
    expect(sortingStartFrom(SortingStartPreset.oneYear, today), DateTime(2025, 11, 19));
  });
}
