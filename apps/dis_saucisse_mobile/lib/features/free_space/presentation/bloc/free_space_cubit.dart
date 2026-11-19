import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/entities/freeable_photos.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/free_space_repository.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/rules/freeable_photos_rule.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'free_space_state.dart';

class FreeSpaceCubit extends SafeCubit<FreeSpaceState> {
  FreeSpaceCubit({FreeSpaceRepository? freeSpaceRepository, LoadEventLibrary? loadEventLibrary})
    : _freeSpaceRepository = freeSpaceRepository ?? getIt.get<FreeSpaceRepository>(),
      _loadEventLibrary = loadEventLibrary ?? LoadEventLibrary(),
      super(const FreeSpaceLoading());

  final FreeSpaceRepository _freeSpaceRepository;
  final LoadEventLibrary _loadEventLibrary;

  Future<void> load() {
    emit(const FreeSpaceLoading());
    return _loadEventLibrary()
        .flatMap(
          (EventLibraryLoad load) => switch (load) {
            EventLibraryLoaded(:final EventLibrary library) => _freeSpaceRepository.loadSentPhotoBytes().map(
              (Map<PhotoId, int> sent) => freeablePhotos(library, sent),
            ),
            EventLibraryNeedsSortingStart() ||
            EventLibraryAccessDenied() => TaskEither<AppFailure, FreeablePhotos>.right(
              const FreeablePhotos(
                kept: <PhotoId>[],
                keptBytes: 0,
                discarded: <PhotoId>[],
                discardedBytes: 0,
                sizes: <PhotoId, int>{},
              ),
            ),
          },
        )
        .match(
          (AppFailure _) => const FreeSpaceFailed(),
          (FreeablePhotos photos) =>
              photos.isEmpty ? const FreeSpaceNothingToFree() : FreeSpaceReady(photos: photos, includeDiscarded: false),
        )
        .map(emit)
        .run();
  }

  void includeDiscarded(bool include) => switch (state) {
    FreeSpaceReady(:final FreeablePhotos photos) => emit(FreeSpaceReady(photos: photos, includeDiscarded: include)),
    FreeSpaceLoading() ||
    FreeSpaceNothingToFree() ||
    FreeSpaceDeleting() ||
    FreeSpaceDone() ||
    FreeSpaceFailed() => null,
  };

  Future<void> freeSpace() => switch (state) {
    final FreeSpaceReady ready => _delete(ready),
    FreeSpaceLoading() ||
    FreeSpaceNothingToFree() ||
    FreeSpaceDeleting() ||
    FreeSpaceDone() ||
    FreeSpaceFailed() => Future<void>.value(),
  };

  Future<void> _delete(FreeSpaceReady ready) {
    emit(const FreeSpaceDeleting());
    return _freeSpaceRepository
        .movePhotosToTrash(ready.selected)
        .match(
          (AppFailure _) => const FreeSpaceFailed(),
          (Set<PhotoId> deleted) =>
              FreeSpaceDone(deletedCount: deleted.length, freedBytes: ready.photos.bytesOf(deleted)),
        )
        .map(emit)
        .run();
  }
}
