import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

class MemoriesYearFilters extends StatelessWidget {
  const MemoriesYearFilters({super.key, required this.years, required this.selectedYear, required this.onSelected});

  final List<int> years;
  final Option<int> selectedYear;
  final ValueChanged<Option<int>> onSelected;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: DsSpacing.l),
    child: Row(
      spacing: DsSpacing.xs,
      children: <Widget>[
        DsFilterChip(label: 'Tout', selected: selectedYear.isNone(), onSelected: () => onSelected(none())),
        for (final int year in years)
          DsFilterChip(label: '$year', selected: selectedYear == some(year), onSelected: () => onSelected(some(year))),
      ],
    ),
  );
}
