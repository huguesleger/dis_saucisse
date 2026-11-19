import 'package:core_ui/core_ui.dart';
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
            Text('Dossier principal', style: DsTextStyles.caption),
            Text(
              folderPath.match(() => 'Images / Dis Saucisse', (String path) => path),
              style: DsTextStyles.titleM.copyWith(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              folderPath.match(() => 'Dossier proposé par défaut', (String _) => 'Choisi par toi'),
              style: DsTextStyles.caption,
            ),
          ],
        ),
      ),
      DsButton(label: 'Parcourir…', variant: DsButtonVariant.dark, expanded: false, onPressed: onBrowse),
    ],
  );
}
