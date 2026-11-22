import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/storage_preview.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/widgets/storage_preview_folder.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class StoragePreviewCard extends StatelessWidget {
  const StoragePreviewCard({super.key, required this.folderPath, required this.folders});

  final Option<String> folderPath;
  final List<PreviewFolder> folders;

  @override
  Widget build(BuildContext context) => DsCard(
    padding: const EdgeInsets.all(DsSpacing.l),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          spacing: DsSpacing.xs,
          children: <Widget>[
            Text(t.storage.preview.title, style: DsTextStyles.titleM.copyWith(fontWeight: FontWeight.w600)),
            Expanded(child: Text(t.storage.preview.subtitle, style: DsTextStyles.caption)),
          ],
        ),
        const SizedBox(height: DsSpacing.s),
        Expanded(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: DsColors.pageBackground, borderRadius: DsRadius.largeAll),
            child: ListView(
              padding: const EdgeInsets.all(DsSpacing.s),
              children: <Widget>[
                StoragePreviewFolder(
                  name: folderPath.match(() => 'Dis Saucisse', (String path) => path.split(RegExp(r'[\\/]')).last),
                  depth: 0,
                  emphasized: true,
                  muted: false,
                ),
                for (final PreviewFolder folder in folders)
                  StoragePreviewFolder(
                    name: folder.name,
                    depth: folder.depth + 1,
                    emphasized: folder.depth < 2 && !folder.isContext,
                    muted: folder.isContext || folder.name == discardedFolderName,
                  ),
                if (folders.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: DsSpacing.l, top: DsSpacing.xxs),
                    child: Text(t.storage.preview.allInOnePlace, style: DsTextStyles.caption),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: DsSpacing.s),
        Text(t.storage.preview.noOverwrite, style: DsTextStyles.caption),
      ],
    ),
  );
}
