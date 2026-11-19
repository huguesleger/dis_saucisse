import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_item.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/rules/photos_to_send.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../helpers/photo_fixtures.dart';

void main() {
  final EventLibrary library = EventLibrary(
    photos: saturdayPhotos,
    names: const <EventId, String>{EventId('cake-1'): 'Anniversaire'},
    boundaries: const EventBoundaries.none(),
    decisions: const <PhotoId, PhotoDecision>{
      PhotoId('cake-1'): PhotoDecision.kept,
      PhotoId('cake-2'): PhotoDecision.discarded,
      PhotoId('walk'): PhotoDecision.kept,
    },
  );

  test('sends the decided photos that were not sent yet, with their event', () {
    final List<TransferItem> items = photosToSend(library, <PhotoId>{const PhotoId('walk')});

    expect(items.map((TransferItem item) => item.photo.id.value), <String>['cake-1', 'cake-2']);
    expect(items.first.eventName, some('Anniversaire'));
    expect(items.last.decision, PhotoDecision.discarded);
    expect(items.first.eventDate, DateTime(2026, 11, 7, 14));
  });

  test('counts the events of the photos to send', () {
    expect(eventCount(photosToSend(library, <PhotoId>{})), 2);
  });
}
