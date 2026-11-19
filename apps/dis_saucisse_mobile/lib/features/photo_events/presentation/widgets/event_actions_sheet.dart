import 'package:core_ui/core_ui.dart';
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
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(DsSpacing.l, 0, DsSpacing.l, DsSpacing.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsSpacing.m,
        children: <Widget>[
          Text(eventTitle(event), style: DsTextStyles.titleL),
          DsSettingsGroup(
            children: <Widget>[
              DsSettingsTile(
                icon: Icons.edit_outlined,
                title: 'Renommer',
                onTap: () => Navigator.of(context).pop(EventAction.rename),
              ),
              ...previous.match(
                () => <Widget>[],
                (PhotoEvent before) => <Widget>[
                  DsSettingsTile(
                    icon: Icons.vertical_align_top_rounded,
                    title: "Fusionner avec l'événement d'avant",
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
                    title: "Fusionner avec l'événement d'après",
                    subtitle: eventTitle(after),
                    onTap: () => Navigator.of(context).pop(EventAction.mergeWithNext),
                  ),
                ],
              ),
              if (event.bursts.length > 1)
                DsSettingsTile(
                  icon: Icons.call_split_rounded,
                  title: 'Séparer en deux',
                  subtitle: 'Choisis la rafale qui commence le nouvel événement',
                  onTap: () => Navigator.of(context).pop(EventAction.split),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
