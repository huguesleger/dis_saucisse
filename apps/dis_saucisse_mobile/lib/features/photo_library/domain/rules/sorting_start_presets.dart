import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/sorting_start_preset.dart';

DateTime sortingStartFrom(SortingStartPreset preset, DateTime today) {
  final DateTime midnight = DateTime(today.year, today.month, today.day);
  return switch (preset) {
    SortingStartPreset.oneMonth => DateTime(midnight.year, midnight.month - 1, midnight.day),
    SortingStartPreset.threeMonths => DateTime(midnight.year, midnight.month - 3, midnight.day),
    SortingStartPreset.sixMonths => DateTime(midnight.year, midnight.month - 6, midnight.day),
    SortingStartPreset.oneYear => DateTime(midnight.year - 1, midnight.month, midnight.day),
  };
}
