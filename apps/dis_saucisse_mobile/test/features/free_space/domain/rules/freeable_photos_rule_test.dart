import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/entities/freeable_photos.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/rules/freeable_photos_rule.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/photo_fixtures.dart';

void main() {
  test('frees only the photos sent to a computer and still on the phone', () {
    final FreeablePhotos photos = freeablePhotos(
      EventLibrary(
        photos: saturdayPhotos,
        names: const <EventId, String>{},
        boundaries: const EventBoundaries.none(),
        decisions: const <PhotoId, PhotoDecision>{
          PhotoId('cake-1'): PhotoDecision.kept,
          PhotoId('cake-2'): PhotoDecision.discarded,
          PhotoId('candles'): PhotoDecision.kept,
        },
      ),
      const <PhotoId, int>{PhotoId('cake-1'): 3000, PhotoId('cake-2'): 1000, PhotoId('deleted-already'): 9000},
    );

    expect(photos.kept, const <PhotoId>[PhotoId('cake-1')]);
    expect(photos.keptBytes, 3000);
    expect(photos.discarded, const <PhotoId>[PhotoId('cake-2')]);
    expect(photos.discardedBytes, 1000);
  });
}
