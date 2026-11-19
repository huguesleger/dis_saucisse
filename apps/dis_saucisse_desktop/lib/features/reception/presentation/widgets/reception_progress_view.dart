import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/byte_size_label.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_current_folder_card.dart';
import 'package:flutter/material.dart';

class ReceptionProgressView extends StatelessWidget {
  const ReceptionProgressView({super.key, required this.progress});

  final ReceptionInProgress progress;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(DsSpacing.xxl),
    children: <Widget>[
      Text('${progress.phoneName} envoie ses photos', style: DsTextStyles.caption.copyWith(fontSize: 13)),
      Text('Réception en cours', style: DsTextStyles.display),
      const SizedBox(height: DsSpacing.xl),
      Wrap(
        spacing: DsSpacing.xl,
        runSpacing: DsSpacing.xl,
        children: <Widget>[
          SizedBox(
            width: 380,
            child: DsCard(
              padding: const EdgeInsets.all(DsSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DsSpacing.m,
                children: <Widget>[
                  Row(
                    spacing: DsSpacing.m,
                    children: <Widget>[
                      const DsMascot(width: 96),
                      Text('${progress.received} / ${progress.expected}', style: DsTextStyles.number),
                    ],
                  ),
                  Text('photos reçues', style: DsTextStyles.caption),
                  DsProgressBar(value: progress.expected == 0 ? 0 : progress.received / progress.expected),
                  Row(
                    spacing: DsSpacing.s,
                    children: <Widget>[
                      Expanded(
                        child: DsStatTile(value: '${progress.received}', label: 'vérifiées'),
                      ),
                      Expanded(
                        child: DsStatTile(value: '${progress.rejected}', label: 'erreurs'),
                      ),
                      Expanded(
                        child: DsStatTile(value: byteSizeLabel(progress.byteCount), label: 'reçus'),
                      ),
                    ],
                  ),
                  const DsSettingsTile(
                    icon: Icons.lock_outline_rounded,
                    iconBackground: DsColors.successSoft,
                    title: 'Chaque photo est vérifiée',
                    subtitle: 'Rien n’est supprimé du téléphone sans son accord.',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 380, child: ReceptionCurrentFolderCard(currentFolder: progress.currentFolder)),
        ],
      ),
    ],
  );
}
