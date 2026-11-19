import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:core_ui/src/gallery/ds_gallery_buttons.dart';
import 'package:core_ui/src/gallery/ds_gallery_colors.dart';
import 'package:core_ui/src/gallery/ds_gallery_home_pieces.dart';
import 'package:core_ui/src/gallery/ds_gallery_section.dart';
import 'package:core_ui/src/gallery/ds_gallery_settings_pieces.dart';
import 'package:core_ui/src/gallery/ds_gallery_sorting_pieces.dart';
import 'package:core_ui/src/gallery/ds_gallery_top_bar.dart';
import 'package:core_ui/src/gallery/ds_gallery_typography.dart';
import 'package:core_ui/src/widgets/layout/ds_mesh_background.dart';
import 'package:core_ui/src/widgets/navigation/ds_floating_nav_bar.dart';
import 'package:core_ui/src/widgets/navigation/ds_nav_destination.dart';
import 'package:flutter/material.dart';

/// Every token and component of the design system on one screen.
class DsGalleryScreen extends StatelessWidget {
  const DsGalleryScreen({super.key});

  static const List<DsNavDestination> _destinations = <DsNavDestination>[
    DsNavDestination(icon: Icons.photo_outlined, label: 'Photos à trier'),
    DsNavDestination(icon: Icons.favorite_border_rounded, label: 'Souvenirs'),
    DsNavDestination(icon: Icons.tune_rounded, label: 'Réglages'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DsMeshBackground(
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.m, DsSpacing.l, 120),
          children: <Widget>[
            const DsGalleryTopBar(),
            const SizedBox(height: DsSpacing.xl),
            Text('Coucou ! Prête pour le tri ?', style: DsTextStyles.caption),
            Text('Design system', style: DsTextStyles.display),
            const SizedBox(height: DsSpacing.xl),
            const DsGallerySection(title: 'Couleurs', child: DsGalleryColors()),
            const DsGallerySection(title: 'Accueil', child: DsGalleryHomePieces()),
            const DsGallerySection(title: 'Boutons', child: DsGalleryButtons()),
            const DsGallerySection(title: 'Tri et transfert', child: DsGallerySortingPieces()),
            const DsGallerySection(title: 'Réglages et ordinateur', child: DsGallerySettingsPieces()),
            const DsGallerySection(title: 'Typographie', child: DsGalleryTypography()),
          ],
        ),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: DsFloatingNavBar(
      destinations: _destinations,
      selectedIndex: 0,
      onDestinationSelected: (_) {},
    ),
  );
}
