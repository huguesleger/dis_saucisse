import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:fpdart/fpdart.dart';

bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

String eventTitle(PhotoEvent event) => event.name.match(
  () => _sameDay(event.startedAt, event.endedAt)
      ? frenchWeekdayAndDay(event.startedAt)
      : t.events.dateRangeTitle(startDay: event.startedAt.day, endDate: frenchShortDay(event.endedAt)),
  identity,
);

String eventDates(PhotoEvent event) => _sameDay(event.startedAt, event.endedAt)
    ? frenchShortWeekdayAndDay(event.startedAt)
    : '${frenchShortDay(event.startedAt)} – ${frenchShortDay(event.endedAt)}';

String eventSubtitle(PhotoEvent event) => event.photoCount == 1
    ? t.events.subtitle.single(dates: eventDates(event), count: event.photoCount)
    : t.events.subtitle.several(dates: eventDates(event), count: event.photoCount);

String burstsToSortLabel(int count) =>
    count == 1 ? t.events.burstsToSort.single : t.events.burstsToSort.several(count: count);

String monthEventCountLabel(int count) =>
    count == 1 ? t.events.monthEventCount.single : t.events.monthEventCount.several(count: count);
