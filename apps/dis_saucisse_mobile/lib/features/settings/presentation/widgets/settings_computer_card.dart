import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class SettingsComputerCard extends StatelessWidget {
  const SettingsComputerCard({super.key, required this.computer, required this.onChange});

  final Option<PairedComputer> computer;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) => DsCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: DsSpacing.s,
      children: <Widget>[
        Row(
          children: <Widget>[
            const DsIconSquare(
              icon: Icons.desktop_windows_outlined,
              background: DsColors.text,
              foreground: DsColors.mustardLight,
              size: 44,
            ),
            const SizedBox(width: DsSpacing.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    computer.match(() => t.settings.computer.noComputer, (PairedComputer paired) => paired.name),
                    style: DsTextStyles.titleM,
                  ),
                  Text(
                    computer.match(
                      () => t.settings.computer.pairHint,
                      (PairedComputer paired) => t.settings.computer.paired(platform: _platformLabel(paired.platform)),
                    ),
                    style: DsTextStyles.caption,
                  ),
                ],
              ),
            ),
            DsButton(
              label: computer.isSome() ? t.settings.computer.change : t.settings.computer.pair,
              variant: DsButtonVariant.secondary,
              expanded: false,
              onPressed: onChange,
            ),
          ],
        ),
        Text(
          t.settings.computer.folderHint,
          style: DsTextStyles.caption,
        ),
      ],
    ),
  );

  String _platformLabel(ComputerPlatform platform) => switch (platform) {
    ComputerPlatform.macos => t.settings.computer.macos,
    ComputerPlatform.windows => t.settings.computer.windows,
  };
}
