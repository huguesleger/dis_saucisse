import 'package:core_ui/core_ui.dart';
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
    required this.onBrowse,
    required this.onLayoutChanged,
  });

  final Option<String> folderPath;
  final StorageLayout layout;
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
            title: 'Dossier par année',
            subtitle: '2026',
            trailing: StorageSwitch(
              value: layout.byYear,
              onChanged: (bool on) => onLayoutChanged(layout.copyWith(byYear: on)),
            ),
          ),
          const Divider(height: DsSpacing.s),
          StorageOptionRow(
            icon: Icons.schedule_rounded,
            iconBackground: DsColors.surfaceStrong,
            title: 'Dossier par mois',
            subtitle: 'Choisis le format du nom',
            trailing: StorageMonthFormatSelector(
              selected: layout.byMonth ? some(layout.monthFormat) : none(),
              onSelected: (MonthFolderFormat format) =>
                  onLayoutChanged(layout.copyWith(byMonth: true, monthFormat: format)),
            ),
          ),
          const Divider(height: DsSpacing.s),
          StorageOptionRow(
            icon: Icons.image_outlined,
            iconBackground: DsColors.blushSoft,
            title: 'Dossier par événement',
            subtitle: 'Daté et nommé : 2026-11-08 Anniversaire de mamie',
            trailing: StorageSwitch(
              value: layout.byEvent,
              onChanged: (bool on) => onLayoutChanged(layout.copyWith(byEvent: on)),
            ),
          ),
          const Divider(height: DsSpacing.s),
          StorageOptionRow(
            icon: Icons.close_rounded,
            iconBackground: DsColors.skySoft,
            title: 'Photos écartées',
            subtitle: layout.discardedSubfolder
                ? 'Rangées dans un sous-dossier « $discardedFolderName »'
                : 'Rangées avec les autres photos',
            trailing: StorageSwitch(
              value: layout.discardedSubfolder,
              onChanged: (bool on) => onLayoutChanged(layout.copyWith(discardedSubfolder: on)),
            ),
          ),
          const Divider(height: DsSpacing.s),
          StorageOptionRow(
            icon: Icons.check_rounded,
            iconBackground: DsColors.successSoft,
            title: 'Renommer les fichiers',
            subtitle: layout.renameFiles
                ? 'Avec la date de prise de vue (2026-11-08 14.30.12.jpg)'
                : 'Garder les noms d’origine (IMG_2034.jpg)',
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
