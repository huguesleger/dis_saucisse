import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_folder_row.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_month_format_selector.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_option_row.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_switch.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class StorageOptionsCard extends StatelessWidget {
  const StorageOptionsCard({
    super.key,
    required this.folderPath,
    required this.layout,
    required this.currentYear,
    required this.onBrowse,
    required this.onLayoutChanged,
  });

  final Option<String> folderPath;
  final StorageLayout layout;
  final int currentYear;
  final VoidCallback onBrowse;
  final ValueChanged<StorageLayout> onLayoutChanged;

  @override
  Widget build(BuildContext context) => DsCard(
    padding: const EdgeInsets.all(DsSpacing.l),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StorageFolderRow(folderPath: folderPath, onBrowse: onBrowse),
          const Divider(height: DsSpacing.l),
          StorageOptionRow(
            icon: Icons.schedule_rounded,
            iconBackground: DsColors.lavenderSoft,
            title: t.storage.options.byYear,
            subtitle: '$currentYear',
            trailing: StorageSwitch(
              value: layout.byYear,
              onChanged: (bool on) => onLayoutChanged(layout.copyWith(byYear: on)),
            ),
          ),
          const Divider(height: DsSpacing.s),
          StorageOptionRow(
            icon: Icons.schedule_rounded,
            iconBackground: DsColors.surfaceStrong,
            title: t.storage.options.byMonth.title,
            subtitle: t.storage.options.byMonth.subtitle,
            trailing: StorageMonthFormatSelector(
              year: currentYear,
              selected: layout.byMonth ? some(layout.monthFormat) : none(),
              onSelected: (MonthFolderFormat format) =>
                  onLayoutChanged(layout.copyWith(byMonth: true, monthFormat: format)),
            ),
          ),
          const Divider(height: DsSpacing.s),
          StorageOptionRow(
            icon: Icons.image_outlined,
            iconBackground: DsColors.blushSoft,
            title: t.storage.options.byEvent.title,
            subtitle: t.storage.options.byEvent.subtitle,
            trailing: StorageSwitch(
              value: layout.byEvent,
              onChanged: (bool on) => onLayoutChanged(layout.copyWith(byEvent: on)),
            ),
          ),
          const Divider(height: DsSpacing.s),
          StorageOptionRow(
            icon: Icons.close_rounded,
            iconBackground: DsColors.skySoft,
            title: t.storage.options.discarded.title,
            subtitle: layout.discardedSubfolder
                ? t.storage.options.discarded.inSubfolder(folderName: discardedFolderName)
                : t.storage.options.discarded.withOthers,
            trailing: StorageSwitch(
              value: layout.discardedSubfolder,
              onChanged: (bool on) => onLayoutChanged(layout.copyWith(discardedSubfolder: on)),
            ),
          ),
          const Divider(height: DsSpacing.s),
          StorageOptionRow(
            icon: Icons.check_rounded,
            iconBackground: DsColors.successSoft,
            title: t.storage.options.renameFiles.title,
            subtitle: layout.renameFiles
                ? t.storage.options.renameFiles.withDate
                : t.storage.options.renameFiles.keepOriginal,
            trailing: StorageSwitch(
              value: layout.renameFiles,
              onChanged: (bool on) => onLayoutChanged(layout.copyWith(renameFiles: on)),
            ),
          ),
          const Divider(height: DsSpacing.s),
        ],
      ),
    ),
  );
}
