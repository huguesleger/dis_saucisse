import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/stored_event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/mappers/event_boundaries_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('round-trips the boundaries through their stored form and JSON', () {
    const EventBoundaries boundaries = EventBoundaries(
      joinedAt: <PhotoId>{PhotoId('walk')},
      splitAt: <PhotoId>{PhotoId('candles')},
    );

    final EventBoundaries restored = storedToEventBoundaries(
      StoredEventBoundaries.fromJson(eventBoundariesToStored(boundaries).toJson()),
    );

    expect(restored.joinedAt, boundaries.joinedAt);
    expect(restored.splitAt, boundaries.splitAt);
  });

  test('reads an empty stored value', () {
    final EventBoundaries restored = storedToEventBoundaries(StoredEventBoundaries.fromJson(<String, dynamic>{}));

    expect(restored.joinedAt, isEmpty);
    expect(restored.splitAt, isEmpty);
  });
}
