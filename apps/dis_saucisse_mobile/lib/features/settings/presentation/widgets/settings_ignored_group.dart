import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_switch.dart';
import 'package:flutter/material.dart';

class SettingsIgnoredGroup extends StatelessWidget {
  const SettingsIgnoredGroup({super.key, required this.ignoredOrigins, required this.onIgnoredChanged});

  final Set<PhotoOrigin> ignoredOrigins;
  final void Function(PhotoOrigin origin, {required bool ignored}) onIgnoredChanged;

  @override
  Widget build(BuildContext context) => DsSettingsGroup(
    title: "Ce que l'app ignore",
    children: <Widget>[
      DsSettingsTile(
        icon: Icons.screenshot_outlined,
        iconBackground: DsColors.lavenderSoft,
        title: "Captures d'écran",
        trailing: SettingsSwitch(
          value: ignoredOrigins.contains(PhotoOrigin.screenshot),
          onChanged: (bool ignored) => onIgnoredChanged(PhotoOrigin.screenshot, ignored: ignored),
        ),
      ),
      DsSettingsTile(
        icon: Icons.chat_bubble_outline_rounded,
        iconBackground: DsColors.successSoft,
        title: 'Images WhatsApp',
        subtitle: 'Et des autres messageries',
        trailing: SettingsSwitch(
          value: ignoredOrigins.contains(PhotoOrigin.messagingApp),
          onChanged: (bool ignored) => onIgnoredChanged(PhotoOrigin.messagingApp, ignored: ignored),
        ),
      ),
      const DsSettingsTile(
        icon: Icons.videocam_outlined,
        iconBackground: DsColors.blushSoft,
        title: 'Vidéos',
        subtitle: 'Toujours ignorées pour le moment',
        trailing: SettingsSwitch(value: true),
      ),
    ],
  );
}
