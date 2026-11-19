import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:flutter/material.dart';

class PairedPhonesCard extends StatelessWidget {
  const PairedPhonesCard({super.key, required this.phones});

  final List<PairedPhone> phones;

  @override
  Widget build(BuildContext context) => DsSettingsGroup(
    title: 'Téléphones associés',
    children: phones.isEmpty
        ? <Widget>[
            Padding(
              padding: const EdgeInsets.all(DsSpacing.m),
              child: Text('Aucun téléphone pour l’instant.', style: DsTextStyles.caption),
            ),
          ]
        : <Widget>[
            for (final PairedPhone phone in phones)
              DsSettingsTile(
                icon: Icons.smartphone_rounded,
                title: phone.name,
                subtitle: 'Associé',
                trailing: const DsStatusBadge(label: 'Prêt'),
              ),
          ],
  );
}
