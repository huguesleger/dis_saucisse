import 'package:core_ui/src/foundation/ds_colors.dart';
import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/widgets/navigation/ds_connection_card.dart';
import 'package:core_ui/src/widgets/navigation/ds_nav_destination.dart';
import 'package:core_ui/src/widgets/navigation/ds_sidebar_item.dart';
import 'package:core_ui/src/widgets/settings/ds_settings_group.dart';
import 'package:core_ui/src/widgets/settings/ds_settings_tile.dart';
import 'package:flutter/material.dart';

class DsGallerySettingsPieces extends StatelessWidget {
  const DsGallerySettingsPieces({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsSpacing.m,
    children: <Widget>[
      DsSettingsGroup(
        title: "Ce que l'app ignore",
        children: <Widget>[
          DsSettingsTile(
            icon: Icons.screenshot_outlined,
            iconBackground: const Color(0xFFE3EEFB),
            title: "Captures d'écran",
            subtitle: 'Jamais triées ni envoyées',
            trailing: Switch(value: true, onChanged: (_) {}),
          ),
          DsSettingsTile(
            icon: Icons.videocam_outlined,
            iconBackground: const Color(0xFFFBE3E6),
            title: 'Vidéos',
            subtitle: 'Pas encore prises en charge',
            trailing: Switch(value: false, onChanged: (_) {}),
          ),
        ],
      ),
      SizedBox(
        width: 240,
        child: Column(
          spacing: DsSpacing.xxs,
          children: <Widget>[
            DsSidebarItem(
              destination: const DsNavDestination(icon: Icons.image_outlined, label: 'Réception'),
              selected: false,
              onTap: () {},
            ),
            DsSidebarItem(
              destination: const DsNavDestination(icon: Icons.history_rounded, label: 'Historique'),
              selected: true,
              onTap: () {},
            ),
            const SizedBox(height: DsSpacing.xs),
            const DsConnectionCard(
              icon: Icons.smartphone_rounded,
              title: 'Téléphone Android',
              status: 'Associé · connecté',
            ),
          ],
        ),
      ),
      const ColoredBox(color: DsColors.pageBackground, child: SizedBox(height: 80)),
    ],
  );
}
