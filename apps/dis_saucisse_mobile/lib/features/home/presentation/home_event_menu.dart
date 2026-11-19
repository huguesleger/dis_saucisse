import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/event_action.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/event_labels.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/widgets/event_actions_sheet.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/widgets/event_name_sheet.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/widgets/event_split_sheet.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

Future<void> openEventMenu(BuildContext context, {required HomeCubit cubit, required PhotoEvent event}) async {
  final List<PhotoEvent> events = switch (cubit.state) {
    final HomeLoaded loaded => loaded.events,
    HomeLoading() || HomeNeedsSortingStart() || HomeAccessDenied() || HomeFailed() => <PhotoEvent>[],
  };
  final Option<PhotoEvent> next = eventAfter(events, event.id);
  final EventAction? action = await showModalBottomSheet<EventAction>(
    context: context,
    builder: (BuildContext context) =>
        EventActionsSheet(event: event, previous: eventBefore(events, event.id), next: next),
  );
  if (!context.mounted) return;
  await switch (action) {
    EventAction.rename => _renameEvent(context, cubit, event),
    EventAction.mergeWithPrevious => cubit.mergeWithPreviousEvent(event),
    EventAction.mergeWithNext => next.match(() => Future<void>.value(), cubit.mergeWithPreviousEvent),
    EventAction.split => _splitEvent(context, cubit, event),
    null => Future<void>.value(),
  };
}

Future<void> _renameEvent(BuildContext context, HomeCubit cubit, PhotoEvent event) async {
  final String? name = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) =>
        EventNameSheet(initialName: event.name.match(() => '', identity), placeholder: eventTitle(event)),
  );
  if (name != null) {
    await cubit.renameEvent(event.id, Option<String>.fromPredicate(name.trim(), (String n) => n.isNotEmpty));
  }
}

Future<void> _splitEvent(BuildContext context, HomeCubit cubit, PhotoEvent event) async {
  final PhotoBurst? burst = await showModalBottomSheet<PhotoBurst>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => EventSplitSheet(event: event),
  );
  if (burst != null) await cubit.splitEventBefore(burst);
}
