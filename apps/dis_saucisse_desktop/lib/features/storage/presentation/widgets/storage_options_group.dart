import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:flutter/material.dart';

class StorageOptionsGroup extends StatelessWidget {
  const StorageOptionsGroup({super.key, required this.layout, required this.onChanged});

  final StorageLayout layout;
  final ValueChanged<StorageLayout> onChanged;

  @override
  Widget build(BuildContext context) => DsSettingsGroup(
    title: 'Classement',
    children: <Widget>[
      for (final (IconData icon, String title, String subtitle, bool value, StorageLayout Function(bool) apply)
          in <(IconData, String, String, bool, StorageLayout Function(bool))>[
            (
              Icons.calendar_today_rounded,
              'Un dossier par année',
              '2026, 2025…',
              layout.byYear,
              (bool on) => layout.copyWith(byYear: on),
            ),
            (
              Icons.calendar_view_month_rounded,
              'Un dossier par mois',
              'Dans l’année, un dossier pour chaque mois',
              layout.byMonth,
              (bool on) => layout.copyWith(byMonth: on),
            ),
            (
              Icons.celebration_rounded,
              'Un dossier par événement',
              'Date et nom donné sur le téléphone',
              layout.byEvent,
              (bool on) => layout.copyWith(byEvent: on),
            ),
            (
              Icons.delete_outline_rounded,
              'Sous-dossier « Écartées »',
              'Les photos écartées restent à part, à toi de les supprimer',
              layout.discardedSubfolder,
              (bool on) => layout.copyWith(discardedSubfolder: on),
            ),
            (
              Icons.drive_file_rename_outline_rounded,
              'Renommer avec la date',
              '2026-11-08 14.30.12.jpg au lieu de IMG_2034.jpg',
              layout.renameFiles,
              (bool on) => layout.copyWith(renameFiles: on),
            ),
          ])
        DsSettingsTile(
          icon: icon,
          title: title,
          subtitle: subtitle,
          trailing: Switch(
            value: value,
            activeTrackColor: DsColors.mustard,
            onChanged: (bool on) => onChanged(apply(on)),
          ),
          onTap: () => onChanged(apply(!value)),
        ),
    ],
  );
}
