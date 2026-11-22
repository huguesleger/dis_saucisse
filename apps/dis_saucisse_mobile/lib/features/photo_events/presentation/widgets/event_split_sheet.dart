import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/widgets/event_split_option.dart';
import 'package:flutter/material.dart';

class EventSplitSheet extends StatelessWidget {
  const EventSplitSheet({super.key, required this.event});

  final PhotoEvent event;

  @override
  Widget build(BuildContext context) => DsBottomSheet(
    title: t.events.splitSheet.title,
    subtitle: t.events.splitSheet.subtitle,
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
