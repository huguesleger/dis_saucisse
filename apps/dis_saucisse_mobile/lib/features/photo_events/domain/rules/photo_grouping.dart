import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/month_events.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:fpdart/fpdart.dart';

const Duration burstMaxGap = Duration(seconds: 10);
const Duration eventMaxGap = Duration(hours: 3);

List<List<LibraryPhoto>> _splitWhenGapExceeds(List<LibraryPhoto> chronologicalPhotos, Duration maxGap) {
  final List<List<LibraryPhoto>> groups = <List<LibraryPhoto>>[];
  for (final LibraryPhoto photo in chronologicalPhotos) {
    if (groups.isNotEmpty && photo.takenAt.difference(groups.last.last.takenAt) <= maxGap) {
      groups.last.add(photo);
    } else {
      groups.add(<LibraryPhoto>[photo]);
    }
  }
  return groups;
}

List<LibraryPhoto> _chronological(List<LibraryPhoto> photos) =>
    <LibraryPhoto>[...photos]..sort((LibraryPhoto a, LibraryPhoto b) => a.takenAt.compareTo(b.takenAt));

List<PhotoBurst> groupIntoBursts(List<LibraryPhoto> photos) => _splitWhenGapExceeds(
  _chronological(photos),
  burstMaxGap,
).map((List<LibraryPhoto> burst) => PhotoBurst(photos: burst)).toList();

List<PhotoEvent> groupIntoEvents(List<LibraryPhoto> photos, Map<EventId, String> names) =>
    _splitWhenGapExceeds(_chronological(photos), eventMaxGap).map((List<LibraryPhoto> eventPhotos) {
      final EventId id = EventId(eventPhotos.first.id.value);
      return PhotoEvent(id: id, name: Option<String>.fromNullable(names[id]), bursts: groupIntoBursts(eventPhotos));
    }).toList();

List<MonthEvents> eventsByMonthNewestFirst(List<PhotoEvent> events) {
  final List<PhotoMonth> months = events.map((PhotoEvent event) => event.month).toSet().toList()
    ..sort((PhotoMonth a, PhotoMonth b) => b.compareTo(a));
  return months
      .map(
        (PhotoMonth month) => (
          month: month,
          events: events.where((PhotoEvent event) => event.month == month).toList()
            ..sort((PhotoEvent a, PhotoEvent b) => b.startedAt.compareTo(a.startedAt)),
        ),
      )
      .toList();
}
