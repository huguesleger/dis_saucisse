import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_progress.dart';
import 'package:flutter/material.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class TransferDetails extends StatelessWidget {
  const TransferDetails({
    super.key,
    required this.progress,
    required this.paused,
    required this.waitingForComputer,
    required this.onPause,
    required this.onResume,
  });

  final TransferProgress progress;
  final bool paused;
  final bool waitingForComputer;
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
            subtitle: paused
                ? t.transfer.details.paused
                : (waitingForComputer ? t.transfer.details.computerPaused : t.transfer.details.connected),
            trailing: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: paused || waitingForComputer ? DsColors.textSoft : DsColors.success,
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
            child: DsStatTile(value: '${progress.sent}', label: t.transfer.details.checked),
          ),
          Expanded(
            child: DsStatTile(value: '${progress.discardedSent}', label: t.transfer.details.discarded),
          ),
        ],
      ),
      DsSettingsGroup(
        children: <Widget>[
          DsSettingsTile(
            icon: Icons.folder_open_rounded,
            title: progress.currentFolder.match(
              () => t.transfer.details.preparing,
              (String folder) => folder.replaceAll('/', ' / '),
            ),
            subtitle: t.transfer.details.sortingInto,
          ),
        ],
      ),
      DsButton(
        label: paused ? t.transfer.details.resume : t.transfer.details.pause,
        variant: paused ? DsButtonVariant.primary : DsButtonVariant.light,
        onPressed: paused ? onResume : onPause,
      ),
    ],
  );
}
