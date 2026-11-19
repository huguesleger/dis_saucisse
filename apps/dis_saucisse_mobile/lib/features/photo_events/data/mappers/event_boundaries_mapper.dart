import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/stored_event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';

EventBoundaries storedToEventBoundaries(StoredEventBoundaries stored) => EventBoundaries(
  joinedAt: stored.joinedAt.map(PhotoId.new).toSet(),
  splitAt: stored.splitAt.map(PhotoId.new).toSet(),
);

StoredEventBoundaries eventBoundariesToStored(EventBoundaries boundaries) => StoredEventBoundaries(
  joinedAt: boundaries.joinedAt.map((PhotoId id) => id.value).toList(),
  splitAt: boundaries.splitAt.map((PhotoId id) => id.value).toList(),
);
