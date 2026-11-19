import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

class HomeMonthFilters extends StatelessWidget {
  const HomeMonthFilters({super.key, required this.months, required this.selectedMonth, required this.onSelected});

  final List<PhotoMonth> months;
  final Option<PhotoMonth> selectedMonth;
  final ValueChanged<Option<PhotoMonth>> onSelected;

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: DsSpacing.l),
      child: Row(
        spacing: DsSpacing.xs,
        children: <Widget>[
          DsFilterChip(label: 'Tout', selected: selectedMonth.isNone(), onSelected: () => onSelected(none())),
          for (final PhotoMonth month in months)
            DsFilterChip(
              label: month.year == currentYear
                  ? capitalizedFrenchMonthName(month.month)
                  : '${capitalizedFrenchMonthName(month.month)} ${month.year}',
              selected: selectedMonth == some(month),
              onSelected: () => onSelected(some(month)),
            ),
        ],
      ),
    );
  }
}
