import 'package:core_ui/core_ui.dart';
import 'package:flutter/widgets.dart';

class HomeEventsSection extends StatelessWidget {
  const HomeEventsSection({super.key});

  @override
  Widget build(BuildContext context) => Column(
    spacing: DsSpacing.s,
    children: <Widget>[
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
