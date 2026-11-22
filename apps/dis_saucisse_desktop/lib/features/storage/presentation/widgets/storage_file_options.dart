import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_option_row.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_switch.dart';
import 'package:flutter/material.dart';

class StorageFileOptions extends StatelessWidget {
  const StorageFileOptions({super.key, required this.layout, required this.onLayoutChanged});

  final StorageLayout layout;
  final ValueChanged<StorageLayout> onLayoutChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
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
  );
}
