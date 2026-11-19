import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_radius.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/material.dart';

/// Pill filter ("Tout", "Novembre", "2026"): the selected one is dark.
class DsFilterChip extends StatelessWidget {
  const DsFilterChip({super.key, required this.label, required this.selected, required this.onSelected});

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    child: Material(
      color: selected ? DsColors.text : DsColors.background,
      shape: const RoundedRectangleBorder(borderRadius: DsRadius.pillAll),
      child: InkWell(
        onTap: onSelected,
        customBorder: const RoundedRectangleBorder(borderRadius: DsRadius.pillAll),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DsSpacing.m, vertical: DsSpacing.xs),
          child: Text(
            label,
            style: DsTextStyles.bodyBold.copyWith(color: selected ? DsColors.mustardLight : DsColors.text),
          ),
        ),
      ),
    ),
  );
}
