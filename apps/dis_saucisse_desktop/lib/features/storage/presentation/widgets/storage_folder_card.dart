import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class StorageFolderCard extends StatelessWidget {
  const StorageFolderCard({super.key, required this.folderPath, required this.onBrowse});

  final Option<String> folderPath;
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) => DsCard(
    child: Row(
      children: <Widget>[
        const DsIconSquare(icon: Icons.folder_rounded, background: DsColors.surfaceStrong),
        const SizedBox(width: DsSpacing.s),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Les photos arrivent dans', style: DsTextStyles.caption),
              Text(
                folderPath.match(() => 'Images / Dis Saucisse', (String path) => path),
                style: DsTextStyles.bodyBold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: DsSpacing.s),
        DsButton(label: 'Parcourir…', variant: DsButtonVariant.secondary, onPressed: onBrowse),
      ],
    ),
  );
}
