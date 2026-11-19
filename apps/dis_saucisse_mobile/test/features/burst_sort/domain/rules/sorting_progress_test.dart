import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/sort_cursor.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/rules/sorting_progress.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../helpers/photo_fixtures.dart';

void main() {
  final List<PhotoEvent> events = groupIntoEvents(saturdayPhotos, <EventId, String>{});

  String? cursorPhoto(Option<SortCursor> cursor) => cursor.map((SortCursor c) => c.photoId.value).toNullable();

  test('starts with the first photo of the first burst', () {
    final Option<SortCursor> cursor = nextUndecided(events, <PhotoId, PhotoDecision>{});

    expect(cursorPhoto(cursor), 'cake-1');
  });

  test('moves to the next undecided photo of the burst, then to the next burst and event', () {
    expect(
      cursorPhoto(nextUndecided(events, <PhotoId, PhotoDecision>{const PhotoId('cake-1'): PhotoDecision.kept})),
      'cake-2',
    );
    expect(
      cursorPhoto(
        nextUndecided(events, <PhotoId, PhotoDecision>{
          const PhotoId('cake-1'): PhotoDecision.kept,
          const PhotoId('cake-2'): PhotoDecision.discarded,
          const PhotoId('candles'): PhotoDecision.kept,
        }),
      ),
      'walk',
    );
  });

  test('finishes when every photo is decided', () {
    final Map<PhotoId, PhotoDecision> all = <PhotoId, PhotoDecision>{
      for (final PhotoEvent event in events)
        for (final photo in event.photos) photo.id: PhotoDecision.kept,
    };

    expect(nextUndecided(events, all), none<SortCursor>());
  });

  test('counts what is left to sort', () {
    final Map<PhotoId, PhotoDecision> decisions = <PhotoId, PhotoDecision>{
      const PhotoId('cake-1'): PhotoDecision.kept,
      const PhotoId('cake-2'): PhotoDecision.kept,
      const PhotoId('walk'): PhotoDecision.discarded,
    };

    expect(undecidedPhotos(saturdayPhotos, decisions).map((photo) => photo.id.value), <String>['candles']);
    expect(burstsToSort(events.first, decisions).length, 1);
    expect(eventsToSort(events, decisions).map((PhotoEvent event) => event.id), const <EventId>[EventId('cake-1')]);
  });
}
