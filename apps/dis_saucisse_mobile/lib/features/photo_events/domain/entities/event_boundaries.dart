import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';

@immutable
final class EventBoundaries {
  const EventBoundaries({required this.joinedAt, required this.splitAt});

  const EventBoundaries.none() : joinedAt = const <PhotoId>{}, splitAt = const <PhotoId>{};

  final Set<PhotoId> joinedAt;
  final Set<PhotoId> splitAt;

  EventBoundaries joining(PhotoId photo) =>
      EventBoundaries(joinedAt: <PhotoId>{...joinedAt, photo}, splitAt: <PhotoId>{...splitAt}..remove(photo));

  EventBoundaries splitting(PhotoId photo) =>
      EventBoundaries(joinedAt: <PhotoId>{...joinedAt}..remove(photo), splitAt: <PhotoId>{...splitAt, photo});
}
