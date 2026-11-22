import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/event_action.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/event_labels.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class EventActionsSheet extends StatelessWidget {
  const EventActionsSheet({super.key, required this.event, required this.previous, required this.next});

  final PhotoEvent event;
  final Option<PhotoEvent> previous;
  final Option<PhotoEvent> next;

  @override
  Widget build(BuildContext context) => DsBottomSheet(
    title: eventTitle(event),
    child: DsSettingsGroup(
      children: <Widget>[
        DsSettingsTile(
          icon: Icons.edit_outlined,
          title: t.events.actions.rename,
          onTap: () => Navigator.of(context).pop(EventAction.rename),
        ),
        ...previous.match(
          () => <Widget>[],
          (PhotoEvent before) => <Widget>[
            DsSettingsTile(
              icon: Icons.vertical_align_top_rounded,
              title: t.events.actions.mergeWithPrevious,
              subtitle: eventTitle(before),
              onTap: () => Navigator.of(context).pop(EventAction.mergeWithPrevious),
            ),
          ],
        ),
        ...next.match(
          () => <Widget>[],
          (PhotoEvent after) => <Widget>[
            DsSettingsTile(
              icon: Icons.vertical_align_bottom_rounded,
              title: t.events.actions.mergeWithNext,
              subtitle: eventTitle(after),
              onTap: () => Navigator.of(context).pop(EventAction.mergeWithNext),
            ),
          ],
        ),
        if (event.bursts.length > 1)
          DsSettingsTile(
            icon: Icons.call_split_rounded,
            title: t.events.actions.split,
            subtitle: t.events.actions.splitHint,
            onTap: () => Navigator.of(context).pop(EventAction.split),
          ),
      ],
    ),
  );
}
