import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/sorting_start_preset.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/sorting_start_presets.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class SortingStartChoice {
  const SortingStartChoice();

  DateTime startDate(DateTime today);
}

final class PresetSortingStart extends SortingStartChoice {
  const PresetSortingStart(this.preset);

  final SortingStartPreset preset;

  @override
  DateTime startDate(DateTime today) => sortingStartFrom(preset, today);
}

final class CustomSortingStart extends SortingStartChoice {
  const CustomSortingStart(this.date);

  final DateTime date;

  @override
  DateTime startDate(DateTime today) => date;
}
