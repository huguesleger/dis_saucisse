import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_boundary_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/ignored_origins_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photos_to_sort.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoadEventLibrary {
  LoadEventLibrary({
    PhotoLibraryRepository? photoLibraryRepository,
    SortingStartRepository? sortingStartRepository,
    EventNameRepository? eventNameRepository,
    EventBoundaryRepository? eventBoundaryRepository,
    PhotoDecisionRepository? photoDecisionRepository,
    IgnoredOriginsRepository? ignoredOriginsRepository,
  }) : _photoLibraryRepository = photoLibraryRepository ?? getIt.get<PhotoLibraryRepository>(),
       _sortingStartRepository = sortingStartRepository ?? getIt.get<SortingStartRepository>(),
       _eventNameRepository = eventNameRepository ?? getIt.get<EventNameRepository>(),
       _eventBoundaryRepository = eventBoundaryRepository ?? getIt.get<EventBoundaryRepository>(),
       _photoDecisionRepository = photoDecisionRepository ?? getIt.get<PhotoDecisionRepository>(),
       _ignoredOriginsRepository = ignoredOriginsRepository ?? getIt.get<IgnoredOriginsRepository>();

  final PhotoLibraryRepository _photoLibraryRepository;
  final SortingStartRepository _sortingStartRepository;
  final EventNameRepository _eventNameRepository;
  final EventBoundaryRepository _eventBoundaryRepository;
  final PhotoDecisionRepository _photoDecisionRepository;
  final IgnoredOriginsRepository _ignoredOriginsRepository;

  TaskEither<AppFailure, EventLibraryLoad> call() => _sortingStartRepository.loadStartDate().flatMap(
    (Option<DateTime> start) => start.match(
      () => TaskEither<AppFailure, EventLibraryLoad>.right(const EventLibraryNeedsSortingStart()),
      _loadWhenAccessGranted,
    ),
  );

  TaskEither<AppFailure, EventLibraryLoad> _loadWhenAccessGranted(DateTime start) =>
      _photoLibraryRepository.checkAccess().flatMap(
        (PhotoAccess access) => switch (access) {
          PhotoAccess.granted || PhotoAccess.limited => _loadLibrary(start),
          PhotoAccess.denied => TaskEither<AppFailure, EventLibraryLoad>.right(const EventLibraryAccessDenied()),
        },
      );

  TaskEither<AppFailure, EventLibraryLoad> _loadLibrary(DateTime start) =>
      TaskEither<AppFailure, EventLibraryLoad>.Do(($) async {
        final Set<PhotoOrigin> ignored = await $(_ignoredOriginsRepository.loadIgnoredOrigins());
        final List<LibraryPhoto> photos = photosToSort(
          await $(_photoLibraryRepository.loadPhotosTakenSince(start)),
          ignored: ignored,
        );
        final Map<EventId, String> names = await $(_eventNameRepository.loadNames());
        final EventBoundaries boundaries = await $(_eventBoundaryRepository.loadBoundaries());
        final Map<PhotoId, PhotoDecision> decisions = await $(_photoDecisionRepository.loadDecisions());
        return EventLibraryLoaded(
          EventLibrary(photos: photos, names: names, boundaries: boundaries, decisions: decisions),
        );
      });
}
