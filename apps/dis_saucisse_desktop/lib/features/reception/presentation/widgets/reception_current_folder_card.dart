import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class ReceptionCurrentFolderCard extends StatelessWidget {
  const ReceptionCurrentFolderCard({super.key, required this.currentFolder});

  final Option<String> currentFolder;

  @override
  Widget build(BuildContext context) => DsCard(
    padding: const EdgeInsets.all(DsSpacing.xl),
    child: Row(
      spacing: DsSpacing.m,
      children: <Widget>[
        const DsIconSquare(icon: Icons.folder_open_rounded, size: 44),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('En train de ranger dans', style: DsTextStyles.caption),
              Text(
                currentFolder.match(
                  () => 'En attente de la première photo…',
                  (String folder) => folder.replaceAll('/', ' / '),
                ),
                style: DsTextStyles.titleM,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
