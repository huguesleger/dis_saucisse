import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/widgets/cards/ds_event_photo_card.dart';
import 'package:core_ui/src/widgets/cards/ds_stat_tile.dart';
import 'package:core_ui/src/widgets/chips/ds_filter_chip.dart';
import 'package:core_ui/src/widgets/layout/ds_section_header.dart';
import 'package:flutter/material.dart';

class DsGalleryHomePieces extends StatelessWidget {
  const DsGalleryHomePieces({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsSpacing.m,
    children: <Widget>[
      Wrap(
        spacing: DsSpacing.xs,
        children: <Widget>[
          DsFilterChip(label: 'Tout', selected: true, onSelected: () {}),
          DsFilterChip(label: 'Novembre', selected: false, onSelected: () {}),
          DsFilterChip(label: 'Octobre', selected: false, onSelected: () {}),
        ],
      ),
      Row(
        spacing: DsSpacing.s,
        children: <Widget>[
          Expanded(
            child: DsStatTile(value: '31', label: 'doublons', icon: Icons.copy_all_rounded, onTap: () {}),
          ),
          Expanded(
            child: DsStatTile(value: '12', label: 'photos floues', icon: Icons.blur_on_rounded, onTap: () {}),
          ),
        ],
      ),
      const DsSectionHeader(title: 'Novembre 2026', trailing: '3 événements'),
      DsEventPhotoCard(
        title: 'Anniversaire de mamie',
        subtitle: 'Sam. 8 nov. · 112 photos',
        badge: '9 rafales à trier',
        thumbnails: const <ImageProvider?>[null, null, null],
        extraCount: 4,
        onTap: () {},
      ),
    ],
  );
}
