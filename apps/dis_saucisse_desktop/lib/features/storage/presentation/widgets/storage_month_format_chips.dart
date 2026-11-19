import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:flutter/material.dart';

class StorageMonthFormatChips extends StatelessWidget {
  const StorageMonthFormatChips({super.key, required this.selected, required this.onSelected});

  final MonthFolderFormat selected;
  final ValueChanged<MonthFolderFormat> onSelected;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Nom des dossiers de mois', style: DsTextStyles.caption),
      const SizedBox(height: DsSpacing.xs),
      Wrap(
        spacing: DsSpacing.xs,
        runSpacing: DsSpacing.xs,
        children: <Widget>[
          for (final MonthFolderFormat format in MonthFolderFormat.values)
            DsFilterChip(
              label: monthFolderName(DateTime(2026, 11), format),
              selected: format == selected,
              onSelected: () => onSelected(format),
            ),
        ],
      ),
    ],
  );
}
