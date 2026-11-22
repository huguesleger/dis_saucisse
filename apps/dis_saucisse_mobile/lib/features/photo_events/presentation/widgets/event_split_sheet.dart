import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/widgets/event_split_option.dart';
import 'package:flutter/material.dart';

class EventSplitSheet extends StatelessWidget {
  const EventSplitSheet({super.key, required this.event});

  final PhotoEvent event;

  @override
  Widget build(BuildContext context) => DsBottomSheet(
    title: 'Où commence le nouvel événement\u00a0?',
    subtitle: 'Tout ce qui suit la rafale choisie part dans le nouvel événement.',
    child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: <Widget>[
        for (final PhotoBurst burst in event.bursts.skip(1))
          EventSplitOption(burst: burst, onTap: () => Navigator.of(context).pop(burst)),
      ],
    ),
  );
}
