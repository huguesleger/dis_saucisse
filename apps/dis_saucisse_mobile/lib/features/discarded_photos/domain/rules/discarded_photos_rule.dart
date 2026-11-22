import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/domain/entities/discarded_photos.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';

DiscardedPhotos discardedPhotos(EventLibrary library, Set<PhotoId> sentPhotos) {
  final List<LibraryPhoto> discarded =
      library.photos.where((LibraryPhoto photo) => library.decisions[photo.id] == PhotoDecision.discarded).toList()
        ..sort((LibraryPhoto a, LibraryPhoto b) => b.takenAt.compareTo(a.takenAt));
  return DiscardedPhotos(
    onPhoneOnly: discarded.where((LibraryPhoto photo) => !sentPhotos.contains(photo.id)).toList(),
    alreadySent: discarded.where((LibraryPhoto photo) => sentPhotos.contains(photo.id)).toList(),
  );
}
