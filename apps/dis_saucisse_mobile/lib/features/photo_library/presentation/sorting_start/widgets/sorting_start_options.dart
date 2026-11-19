import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/sorting_start_preset.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/sorting_start_choice.dart';
import 'package:flutter/material.dart';

class SortingStartOptions extends StatelessWidget {
  const SortingStartOptions({super.key, required this.choice, required this.today, required this.onChoose});

  final SortingStartChoice choice;
  final DateTime today;
  final ValueChanged<SortingStartChoice> onChoose;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: choice.startDate(today),
      firstDate: DateTime(2000),
      lastDate: today,
      helpText: 'Trier les photos depuis le',
    );
    if (picked != null) onChoose(CustomSortingStart(picked));
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsSpacing.s,
    children: <Widget>[
      Wrap(
        spacing: DsSpacing.xs,
        runSpacing: DsSpacing.xs,
        children: <Widget>[
          for (final SortingStartPreset preset in SortingStartPreset.values)
            DsFilterChip(
              label: switch (preset) {
                SortingStartPreset.oneMonth => '1 mois',
                SortingStartPreset.threeMonths => '3 mois',
                SortingStartPreset.sixMonths => '6 mois',
                SortingStartPreset.oneYear => '1 an',
              },
              selected: switch (choice) {
                PresetSortingStart(preset: final SortingStartPreset selected) => selected == preset,
                CustomSortingStart() => false,
              },
              onSelected: () => onChoose(PresetSortingStart(preset)),
            ),
          DsFilterChip(
            label: 'Autre date',
            selected: switch (choice) {
              PresetSortingStart() => false,
              CustomSortingStart() => true,
            },
            onSelected: () => _pickDate(context),
          ),
        ],
      ),
      Text('À partir du ${frenchLongDate(choice.startDate(today))}', style: DsTextStyles.bodyBold),
    ],
  );
}
