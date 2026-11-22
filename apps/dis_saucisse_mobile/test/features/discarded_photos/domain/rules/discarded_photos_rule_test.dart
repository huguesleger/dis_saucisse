import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/domain/entities/discarded_photos.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/domain/rules/discarded_photos_rule.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/photo_fixtures.dart';

void main() {
  EventLibrary libraryWith(Map<PhotoId, PhotoDecision> decisions) => EventLibrary(
    photos: saturdayPhotos,
    names: const {},
    boundaries: const EventBoundaries.none(),
    decisions: decisions,
  );

  List<String> idsOf(List<LibraryPhoto> photos) => photos.map((LibraryPhoto photo) => photo.id.value).toList();

  test('keeps only the discarded photos, newest first', () {
    final DiscardedPhotos photos = discardedPhotos(
      libraryWith(const <PhotoId, PhotoDecision>{
        PhotoId('cake-1'): PhotoDecision.discarded,
        PhotoId('cake-2'): PhotoDecision.kept,
        PhotoId('walk'): PhotoDecision.discarded,
      }),
      const <PhotoId>{},
    );

    expect(idsOf(photos.onPhoneOnly), <String>['walk', 'cake-1']);
    expect(photos.alreadySent, isEmpty);
  });

  test('sets apart the discarded photos already sent to the computer', () {
    final DiscardedPhotos photos = discardedPhotos(
      libraryWith(const <PhotoId, PhotoDecision>{
        PhotoId('cake-1'): PhotoDecision.discarded,
        PhotoId('walk'): PhotoDecision.discarded,
      }),
      const <PhotoId>{PhotoId('cake-1')},
    );

    expect(idsOf(photos.onPhoneOnly), <String>['walk']);
    expect(idsOf(photos.alreadySent), <String>['cake-1']);
  });

  test('is empty when nothing was discarded', () {
    expect(
      discardedPhotos(
        libraryWith(const <PhotoId, PhotoDecision>{PhotoId('cake-1'): PhotoDecision.kept}),
        const {},
      ).isEmpty,
      isTrue,
    );
  });
}
