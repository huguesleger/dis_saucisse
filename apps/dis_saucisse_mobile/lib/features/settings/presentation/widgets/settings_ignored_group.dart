import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/settings/presentation/widgets/settings_switch.dart';
import 'package:flutter/material.dart';

class SettingsIgnoredGroup extends StatelessWidget {
  const SettingsIgnoredGroup({super.key, required this.ignoredOrigins, required this.onIgnoredChanged});

  final Set<PhotoOrigin> ignoredOrigins;
  final void Function(PhotoOrigin origin, {required bool ignored}) onIgnoredChanged;

  @override
  Widget build(BuildContext context) => DsSettingsGroup(
    title: t.settings.ignored.title,
    children: <Widget>[
      DsSettingsTile(
        icon: Icons.screenshot_outlined,
        iconBackground: DsColors.lavenderSoft,
        title: t.settings.ignored.screenshots,
        trailing: SettingsSwitch(
          value: ignoredOrigins.contains(PhotoOrigin.screenshot),
          onChanged: (bool ignored) => onIgnoredChanged(PhotoOrigin.screenshot, ignored: ignored),
        ),
      ),
      DsSettingsTile(
        icon: Icons.chat_bubble_outline_rounded,
        iconBackground: DsColors.successSoft,
        title: t.settings.ignored.whatsapp,
        subtitle: t.settings.ignored.whatsappSubtitle,
        trailing: SettingsSwitch(
          value: ignoredOrigins.contains(PhotoOrigin.messagingApp),
          onChanged: (bool ignored) => onIgnoredChanged(PhotoOrigin.messagingApp, ignored: ignored),
        ),
      ),
    ],
  );
}
