import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class StorageFolderRow extends StatelessWidget {
  const StorageFolderRow({super.key, required this.folderPath, required this.onBrowse});

  final Option<String> folderPath;
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) => Row(
    spacing: DsSpacing.s,
    children: <Widget>[
      const DsIconSquare(icon: Icons.folder_outlined, background: DsColors.surfaceStrong, size: 52),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(t.storage.folderRow.label, style: DsTextStyles.caption),
            Text(
              folderPath.match(() => t.storage.folderRow.defaultPath, (String path) => path),
              style: DsTextStyles.titleM.copyWith(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              folderPath.match(() => t.storage.folderRow.defaultFolder, (String _) => t.storage.folderRow.chosenFolder),
              style: DsTextStyles.caption,
            ),
          ],
        ),
      ),
      DsButton(label: t.storage.folderRow.browse, variant: DsButtonVariant.dark, expanded: false, onPressed: onBrowse),
    ],
  );
}
