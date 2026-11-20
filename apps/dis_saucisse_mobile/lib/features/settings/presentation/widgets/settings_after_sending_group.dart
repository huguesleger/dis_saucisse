import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SettingsAfterSendingGroup extends StatelessWidget {
  const SettingsAfterSendingGroup({super.key, required this.onFreeSpace});

  final VoidCallback onFreeSpace;

  @override
  Widget build(BuildContext context) => DsSettingsGroup(
    title: "Après l'envoi",
    children: <Widget>[
      DsSettingsTile(
        icon: Icons.cleaning_services_outlined,
        title: 'Libérer de la place',
        subtitle: 'Les photos déjà sur le PC passent par la corbeille, récupérables 30 jours',
        trailing: const Icon(Icons.chevron_right_rounded, color: DsColors.text),
        onTap: onFreeSpace,
      ),
    ],
  );
}
