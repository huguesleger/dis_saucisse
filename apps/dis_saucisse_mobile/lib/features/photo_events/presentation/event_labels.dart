import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:fpdart/fpdart.dart';

bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

String eventTitle(PhotoEvent event) => event.name.match(
  () => _sameDay(event.startedAt, event.endedAt)
      ? frenchWeekdayAndDay(event.startedAt)
      : 'Du ${event.startedAt.day} au ${frenchShortDay(event.endedAt)}',
  identity,
);

String eventDates(PhotoEvent event) => _sameDay(event.startedAt, event.endedAt)
    ? frenchShortWeekdayAndDay(event.startedAt)
    : '${frenchShortDay(event.startedAt)} – ${frenchShortDay(event.endedAt)}';

String eventSubtitle(PhotoEvent event) =>
    '${eventDates(event)} · ${event.photoCount} ${event.photoCount == 1 ? 'photo' : 'photos'}';

String burstsToSortLabel(PhotoEvent event) => switch (event.bursts.length) {
  1 => '1 rafale à trier',
  final int count => '$count rafales à trier',
};

String monthEventCountLabel(int count) => count == 1 ? '1 événement' : '$count événements';
