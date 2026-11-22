import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/domain/entities/discarded_photos.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/domain/rules/discarded_photos_rule.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/free_space_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'discarded_photos_state.dart';

class DiscardedPhotosCubit extends SafeCubit<DiscardedPhotosState> {
  DiscardedPhotosCubit({
    LoadEventLibrary? loadEventLibrary,
    FreeSpaceRepository? freeSpaceRepository,
    PhotoDecisionRepository? decisionRepository,
    Duration? minimalLoading,
  }) : _loadEventLibrary = loadEventLibrary ?? LoadEventLibrary(),
       _freeSpaceRepository = freeSpaceRepository ?? getIt.get<FreeSpaceRepository>(),
       _decisionRepository = decisionRepository ?? getIt.get<PhotoDecisionRepository>(),
       _minimalLoading = minimalLoading ?? DsSkeletonizer.minDuration,
       super(const DiscardedPhotosLoading());

  final LoadEventLibrary _loadEventLibrary;
  final FreeSpaceRepository _freeSpaceRepository;
  final PhotoDecisionRepository _decisionRepository;
  final Duration _minimalLoading;

  Future<void> load() {
    emit(const DiscardedPhotosLoading());
    return TaskEither<AppFailure, DiscardedPhotosState>.Do(($) async {
      final EventLibraryLoad load = await $(_loadEventLibrary());
      final Map<PhotoId, int> sent = await $(_freeSpaceRepository.loadSentPhotoBytes());
      return switch (load) {
        EventLibraryLoaded(:final EventLibrary library) => DiscardedPhotosReady(
          photos: discardedPhotos(library, sent.keys.toSet()),
          selected: const <PhotoId>{},
        ),
        EventLibraryNeedsSortingStart() => const DiscardedPhotosReady(
          photos: DiscardedPhotos(onPhoneOnly: <LibraryPhoto>[], alreadySent: <LibraryPhoto>[]),
          selected: <PhotoId>{},
        ),
        EventLibraryAccessDenied() => const DiscardedPhotosFailed(PhotoAccessDeniedFailure()),
      };
    }).withMinimalDelay(_minimalLoading).match(DiscardedPhotosFailed.new, identity).map(emit).run();
  }

  void toggle(PhotoId photo) => switch (state) {
    final DiscardedPhotosReady ready => emit(
      ready.copyWith(
        selected: ready.selected.contains(photo)
            ? (Set<PhotoId>.of(ready.selected)..remove(photo))
            : <PhotoId>{...ready.selected, photo},
      ),
    ),
    DiscardedPhotosLoading() || DiscardedPhotosFailed() || DiscardedPhotosRestored() => null,
  };

  Future<void> restoreSelected() => switch (state) {
    final DiscardedPhotosReady ready =>
      _decisionRepository
          .removeDecisions(ready.selected)
          .match(DiscardedPhotosFailed.new, (_) => DiscardedPhotosRestored(restoredCount: ready.selected.length))
          .map(emit)
          .run(),
    DiscardedPhotosLoading() || DiscardedPhotosFailed() || DiscardedPhotosRestored() => Future<void>.value(),
  };
}
