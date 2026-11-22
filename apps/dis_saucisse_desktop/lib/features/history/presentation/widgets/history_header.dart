import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key, required this.years, required this.selectedYear, required this.onSelectYear});

  final List<int> years;
  final int selectedYear;
  final ValueChanged<int> onSelectYear;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(t.history.header.subtitle, style: DsTextStyles.caption.copyWith(fontSize: 13)),
            Text(t.history.header.title, style: DsTextStyles.display),
          ],
        ),
      ),
      Wrap(
        spacing: DsSpacing.xs,
        children: <Widget>[
          for (final int year in years)
            DsFilterChip(label: '$year', selected: year == selectedYear, onSelected: () => onSelectYear(year)),
        ],
      ),
    ],
  );
}
