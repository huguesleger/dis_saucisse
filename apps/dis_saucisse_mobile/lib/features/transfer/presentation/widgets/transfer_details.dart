import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_progress.dart';
import 'package:flutter/material.dart';

class TransferDetails extends StatelessWidget {
  const TransferDetails({
    super.key,
    required this.progress,
    required this.paused,
    required this.onPause,
    required this.onResume,
  });

  final TransferProgress progress;
  final bool paused;
  final VoidCallback onPause;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsSpacing.s,
    children: <Widget>[
      DsSettingsGroup(
        children: <Widget>[
          DsSettingsTile(
            icon: Icons.desktop_windows_outlined,
            iconBackground: DsColors.mustardLight,
            title: progress.computer.name,
            subtitle: paused ? 'En pause' : 'Connecté en Wi-Fi',
            trailing: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: paused ? DsColors.textSoft : DsColors.success,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: DsSpacing.s,
        children: <Widget>[
          Expanded(
            child: DsStatTile(value: '${progress.sent}', label: 'vérifiées'),
          ),
          Expanded(
            child: DsStatTile(value: '${progress.discardedSent}', label: 'écartées'),
          ),
        ],
      ),
      DsSettingsGroup(
        children: <Widget>[
          DsSettingsTile(
            icon: Icons.folder_open_rounded,
            title: progress.currentFolder.match(() => 'Préparation…', (String folder) => folder.replaceAll('/', ' / ')),
            subtitle: 'En train de ranger dans',
          ),
        ],
      ),
      DsButton(
        label: paused ? 'Reprendre' : 'Mettre en pause',
        variant: paused ? DsButtonVariant.primary : DsButtonVariant.light,
        onPressed: paused ? onResume : onPause,
      ),
    ],
  );
}
