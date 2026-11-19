import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/entities/freeable_photos.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';

FreeablePhotos freeablePhotos(EventLibrary library, Map<PhotoId, int> sentBytes) {
  List<PhotoId> sentWith(PhotoDecision decision) => library.photos
      .where((LibraryPhoto photo) => sentBytes.containsKey(photo.id) && library.decisions[photo.id] == decision)
      .map((LibraryPhoto photo) => photo.id)
      .toList();
  final List<PhotoId> kept = sentWith(PhotoDecision.kept);
  final List<PhotoId> discarded = sentWith(PhotoDecision.discarded);
  final Map<PhotoId, int> sizes = <PhotoId, int>{
    for (final PhotoId id in <PhotoId>[...kept, ...discarded]) id: sentBytes[id] ?? 0,
  };
  int bytesOf(List<PhotoId> photos) => photos.fold(0, (int total, PhotoId id) => total + sizes[id]!);
  return FreeablePhotos(
    kept: kept,
    keptBytes: bytesOf(kept),
    discarded: discarded,
    discardedBytes: bytesOf(discarded),
    sizes: sizes,
  );
}
