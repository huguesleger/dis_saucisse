import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/widgets/pairing_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class PairingQrCard extends StatelessWidget {
  const PairingQrCard({super.key, required this.invitation, required this.pairedPhoneName});

  final PairingPayload invitation;
  final String? pairedPhoneName;

  @override
  Widget build(BuildContext context) => DsCard(
    padding: const EdgeInsets.all(DsSpacing.xl),
    child: Column(
      spacing: DsSpacing.m,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(DsSpacing.s),
          decoration: BoxDecoration(
            color: DsColors.background,
            borderRadius: DsRadius.largeAll,
            border: Border.all(color: DsColors.mustardLight, width: 3),
          ),
          child: QrImageView(
            data: invitation.encode(),
            size: 232,
            eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: DsColors.text),
            dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: DsColors.text),
          ),
        ),
        Text('Scanne avec Dis Saucisse !', style: DsTextStyles.titleM),
        Text(
          'Dans l’app, touche le bouton ordinateur en haut de l’accueil.',
          style: DsTextStyles.caption,
          textAlign: TextAlign.center,
        ),
        PairingStatusPill(pairedPhoneName: pairedPhoneName),
      ],
    ),
  );
}
