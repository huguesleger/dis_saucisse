import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/widgets/event_split_option.dart';
import 'package:flutter/material.dart';

class EventSplitSheet extends StatelessWidget {
  const EventSplitSheet({super.key, required this.event});

  final PhotoEvent event;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(DsSpacing.l, 0, DsSpacing.l, DsSpacing.xxs),
            child: Text('Où commence le nouvel événement\u00a0?', style: DsTextStyles.titleL),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsSpacing.l),
            child: Text(
              'Tout ce qui suit la rafale choisie part dans le nouvel événement.',
              style: DsTextStyles.caption,
            ),
          ),
          const SizedBox(height: DsSpacing.s),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(DsSpacing.l, 0, DsSpacing.l, DsSpacing.m),
              children: <Widget>[
                for (final PhotoBurst burst in event.bursts.skip(1))
                  EventSplitOption(burst: burst, onTap: () => Navigator.of(context).pop(burst)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
