import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class HomeMonthFilters extends StatelessWidget {
  const HomeMonthFilters({super.key, required this.labels, required this.selectedIndex});

  final List<String> labels;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: DsSpacing.l),
    child: Row(
      spacing: DsSpacing.xs,
      children: <Widget>[
        for (final (int index, String label) in labels.indexed)
          DsFilterChip(label: label, selected: index == selectedIndex, onSelected: () {}),
      ],
    ),
  );
}
