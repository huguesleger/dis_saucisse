import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class PairingStatusPill extends StatelessWidget {
  const PairingStatusPill({super.key, required this.pairedPhoneName});

  final String? pairedPhoneName;

  @override
  Widget build(BuildContext context) {
    final String? name = pairedPhoneName;
    return name == null
        ? DsStatusBadge(label: t.pairing.statusPill.waiting, tone: DsStatusTone.neutral, icon: Icons.wifi_rounded)
        : DsStatusBadge(
            label: t.pairing.statusPill.paired(name: name),
            icon: Icons.check_rounded,
          );
  }
}
