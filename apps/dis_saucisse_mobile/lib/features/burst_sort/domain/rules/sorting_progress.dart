import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/sort_cursor.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:fpdart/fpdart.dart';

bool _isUndecided(LibraryPhoto photo, Map<PhotoId, PhotoDecision> decisions) => !decisions.containsKey(photo.id);

List<LibraryPhoto> undecidedPhotos(List<LibraryPhoto> photos, Map<PhotoId, PhotoDecision> decisions) =>
    photos.where((LibraryPhoto photo) => _isUndecided(photo, decisions)).toList();

List<PhotoBurst> burstsToSort(PhotoEvent event, Map<PhotoId, PhotoDecision> decisions) => event.bursts
    .where((PhotoBurst burst) => burst.photos.any((LibraryPhoto photo) => _isUndecided(photo, decisions)))
    .toList();

List<PhotoEvent> eventsToSort(List<PhotoEvent> events, Map<PhotoId, PhotoDecision> decisions) =>
    events.where((PhotoEvent event) => burstsToSort(event, decisions).isNotEmpty).toList();

Option<SortCursor> nextUndecided(
  List<PhotoEvent> events,
  Map<PhotoId, PhotoDecision> decisions, {
  int fromEvent = 0,
  int fromBurst = 0,
}) {
  for (int eventIndex = fromEvent; eventIndex < events.length; eventIndex++) {
    final List<PhotoBurst> bursts = events[eventIndex].bursts;
    for (int burstIndex = eventIndex == fromEvent ? fromBurst : 0; burstIndex < bursts.length; burstIndex++) {
      final Option<LibraryPhoto> photo = Option<LibraryPhoto>.fromNullable(
        bursts[burstIndex].photos.where((LibraryPhoto photo) => _isUndecided(photo, decisions)).firstOrNull,
      );
      if (photo case Some<LibraryPhoto>(value: final LibraryPhoto undecided)) {
        return some(SortCursor(eventIndex: eventIndex, burstIndex: burstIndex, photoId: undecided.id));
      }
    }
  }
  return none();
}
