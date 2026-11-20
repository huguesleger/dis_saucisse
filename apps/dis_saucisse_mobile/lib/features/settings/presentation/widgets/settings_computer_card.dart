import 'package:core_ui/core_ui.dart';
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
                    computer.match(() => 'Aucun ordinateur', (PairedComputer paired) => paired.name),
                    style: DsTextStyles.titleM,
                  ),
                  Text(
                    computer.match(
                      () => 'Associe ton PC pour y envoyer tes photos',
                      (PairedComputer paired) => '${_platformLabel(paired.platform)} · associé',
                    ),
                    style: DsTextStyles.caption,
                  ),
                ],
              ),
            ),
            DsButton(
              label: computer.isSome() ? 'Changer' : 'Associer',
              variant: DsButtonVariant.secondary,
              expanded: false,
              onPressed: onChange,
            ),
          ],
        ),
        Text(
          'Le dossier de rangement et son format se choisissent dans l’app du PC.',
          style: DsTextStyles.caption,
        ),
      ],
    ),
  );

  String _platformLabel(ComputerPlatform platform) => switch (platform) {
    ComputerPlatform.macos => 'Mac',
    ComputerPlatform.windows => 'PC Windows',
  };
}
