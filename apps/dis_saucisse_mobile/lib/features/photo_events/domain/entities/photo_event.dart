import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
final class PhotoEvent {
  const PhotoEvent({required this.id, required this.name, required this.bursts});

  final EventId id;
  final Option<String> name;
  final List<PhotoBurst> bursts;

  List<LibraryPhoto> get photos => bursts.expand((PhotoBurst burst) => burst.photos).toList();

  int get photoCount => bursts.fold(0, (int count, PhotoBurst burst) => count + burst.photos.length);

  DateTime get startedAt => bursts.first.photos.first.takenAt;

  DateTime get endedAt => bursts.last.photos.last.takenAt;

  PhotoMonth get month => PhotoMonth(year: startedAt.year, month: startedAt.month);

  PhotoEvent copyWith({Option<String>? name}) => PhotoEvent(id: id, name: name ?? this.name, bursts: bursts);
}
