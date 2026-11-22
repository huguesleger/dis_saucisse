import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/storage_preview.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class StorageMonthFormatSelector extends StatelessWidget {
  const StorageMonthFormatSelector({
    super.key,
    required this.year,
    required this.selected,
    required this.onSelected,
  });

  final int year;

  final Option<MonthFolderFormat> selected;
  final ValueChanged<MonthFolderFormat> onSelected;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: DsColors.pageBackground, borderRadius: DsRadius.pillAll),
    child: Padding(
      padding: const EdgeInsets.all(DsSpacing.xxs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final MonthFolderFormat format in MonthFolderFormat.values)
            Semantics(
              button: true,
              selected: selected == some(format),
              child: GestureDetector(
                onTap: () => onSelected(format),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: DsSpacing.s, vertical: DsSpacing.xs),
                  decoration: BoxDecoration(
                    color: selected == some(format) ? DsColors.background : DsColors.pageBackground,
                    borderRadius: DsRadius.pillAll,
                    boxShadow: selected == some(format) ? DsShadows.card : null,
                  ),
                  child: Text(
                    monthFolderName(DateTime(year, previewMonth), format),
                    style: DsTextStyles.bodyBold.copyWith(
                      fontSize: 13,
                      color: selected == some(format) ? DsColors.text : DsColors.textSoft,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
