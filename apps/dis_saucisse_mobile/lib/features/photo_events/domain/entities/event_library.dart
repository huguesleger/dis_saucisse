import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';

@immutable
final class EventLibrary {
  const EventLibrary({required this.photos, required this.names, required this.boundaries, required this.decisions});

  final List<LibraryPhoto> photos;
  final Map<EventId, String> names;
  final EventBoundaries boundaries;
  final Map<PhotoId, PhotoDecision> decisions;

  List<PhotoEvent> get events => groupIntoEvents(photos, names, boundaries);

  EventLibrary copyWith({
    Map<EventId, String>? names,
    EventBoundaries? boundaries,
    Map<PhotoId, PhotoDecision>? decisions,
  }) => EventLibrary(
    photos: photos,
    names: names ?? this.names,
    boundaries: boundaries ?? this.boundaries,
    decisions: decisions ?? this.decisions,
  );
}
