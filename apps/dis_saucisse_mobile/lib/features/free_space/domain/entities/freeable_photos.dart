import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';

@immutable
final class FreeablePhotos {
  const FreeablePhotos({
    required this.kept,
    required this.keptBytes,
    required this.discarded,
    required this.discardedBytes,
    required this.sizes,
  });

  final List<PhotoId> kept;
  final int keptBytes;
  final List<PhotoId> discarded;
  final int discardedBytes;
  final Map<PhotoId, int> sizes;

  bool get isEmpty => kept.isEmpty && discarded.isEmpty;

  int bytesOf(Iterable<PhotoId> photos) => photos.fold(0, (int total, PhotoId id) => total + (sizes[id] ?? 0));
}
