import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/month_events.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:fpdart/fpdart.dart';

const Duration burstMaxGap = Duration(seconds: 10);
const Duration eventMaxGap = Duration(hours: 3);

List<List<LibraryPhoto>> _splitWhen(
  List<LibraryPhoto> chronologicalPhotos,
  bool Function(LibraryPhoto previous, LibraryPhoto photo) startsNewGroup,
) {
  final List<List<LibraryPhoto>> groups = <List<LibraryPhoto>>[];
  for (final LibraryPhoto photo in chronologicalPhotos) {
    if (groups.isEmpty || startsNewGroup(groups.last.last, photo)) {
      groups.add(<LibraryPhoto>[photo]);
    } else {
      groups.last.add(photo);
    }
  }
  return groups;
}

bool _gapExceeds(LibraryPhoto previous, LibraryPhoto photo, Duration maxGap) =>
    photo.takenAt.difference(previous.takenAt) > maxGap;

List<LibraryPhoto> _chronological(List<LibraryPhoto> photos) =>
    <LibraryPhoto>[...photos]..sort((LibraryPhoto a, LibraryPhoto b) => a.takenAt.compareTo(b.takenAt));

List<PhotoBurst> groupIntoBursts(List<LibraryPhoto> photos) => _splitWhen(
  _chronological(photos),
  (LibraryPhoto previous, LibraryPhoto photo) => _gapExceeds(previous, photo, burstMaxGap),
).map((List<LibraryPhoto> burst) => PhotoBurst(photos: burst)).toList();

List<PhotoEvent> groupIntoEvents(
  List<LibraryPhoto> photos,
  Map<EventId, String> names, [
  EventBoundaries boundaries = const EventBoundaries.none(),
]) =>
    _splitWhen(
      _chronological(photos),
      (LibraryPhoto previous, LibraryPhoto photo) =>
          boundaries.splitAt.contains(photo.id) ||
          (_gapExceeds(previous, photo, eventMaxGap) && !boundaries.joinedAt.contains(photo.id)),
    ).map((List<LibraryPhoto> eventPhotos) {
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

Option<PhotoEvent> eventBefore(List<PhotoEvent> chronologicalEvents, EventId id) {
  final int index = chronologicalEvents.indexWhere((PhotoEvent event) => event.id == id);
  return index > 0 ? some(chronologicalEvents[index - 1]) : none();
}

Option<PhotoEvent> eventAfter(List<PhotoEvent> chronologicalEvents, EventId id) {
  final int index = chronologicalEvents.indexWhere((PhotoEvent event) => event.id == id);
  return index >= 0 && index < chronologicalEvents.length - 1 ? some(chronologicalEvents[index + 1]) : none();
}
