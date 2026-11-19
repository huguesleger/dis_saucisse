import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/storage_preview.dart';
import 'package:flutter/material.dart';

class StoragePreviewCard extends StatelessWidget {
  const StoragePreviewCard({super.key, required this.folders});

  final List<PreviewFolder> folders;

  @override
  Widget build(BuildContext context) => DsCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Aperçu', style: DsTextStyles.bodyBold),
        const SizedBox(height: DsSpacing.s),
        Row(
          children: <Widget>[
            const Icon(Icons.folder_rounded, size: 18, color: DsColors.mustard),
            const SizedBox(width: DsSpacing.xs),
            Text('Dis Saucisse', style: DsTextStyles.body),
          ],
        ),
        for (final PreviewFolder folder in folders)
          Padding(
            padding: EdgeInsets.only(left: DsSpacing.l * (folder.depth + 1), top: DsSpacing.xxs),
            child: Row(
              children: <Widget>[
                const Icon(Icons.folder_outlined, size: 18, color: DsColors.textSoft),
                const SizedBox(width: DsSpacing.xs),
                Flexible(
                  child: Text(folder.name, style: DsTextStyles.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        if (folders.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: DsSpacing.l, top: DsSpacing.xxs),
            child: Text('Toutes les photos à la racine', style: DsTextStyles.caption),
          ),
      ],
    ),
  );
}
