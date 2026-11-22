import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class SettingsAfterSendingGroup extends StatelessWidget {
  const SettingsAfterSendingGroup({super.key, required this.onFreeSpace});

  final VoidCallback onFreeSpace;

  @override
  Widget build(BuildContext context) => DsSettingsGroup(
    title: t.settings.afterSending.title,
    children: <Widget>[
      DsSettingsTile(
        icon: Icons.cleaning_services_outlined,
        title: t.settings.afterSending.freeSpace,
        subtitle: t.settings.afterSending.freeSpaceSubtitle,
        trailing: const Icon(Icons.chevron_right_rounded, color: DsColors.text),
        onTap: onFreeSpace,
      ),
    ],
  );
}
