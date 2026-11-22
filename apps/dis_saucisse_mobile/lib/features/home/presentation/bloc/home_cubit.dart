import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/rules/sorting_progress.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/month_events.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_boundary_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photo_months.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'home_state.dart';

class HomeCubit extends SafeCubit<HomeState> {
  HomeCubit({
    LoadEventLibrary? loadEventLibrary,
    PhotoLibraryRepository? photoLibraryRepository,
    EventNameRepository? eventNameRepository,
    EventBoundaryRepository? eventBoundaryRepository,
    Duration? minimalLoading,
  }) : _loadEventLibrary = loadEventLibrary ?? LoadEventLibrary(),
       _photoLibraryRepository = photoLibraryRepository ?? getIt.get<PhotoLibraryRepository>(),
       _eventNameRepository = eventNameRepository ?? getIt.get<EventNameRepository>(),
       _eventBoundaryRepository = eventBoundaryRepository ?? getIt.get<EventBoundaryRepository>(),
       _minimalLoading = minimalLoading ?? DsSkeletonizer.minDuration,
       super(const HomeLoading());

  final LoadEventLibrary _loadEventLibrary;
  final PhotoLibraryRepository _photoLibraryRepository;
  final EventNameRepository _eventNameRepository;
  final EventBoundaryRepository _eventBoundaryRepository;
  final Duration _minimalLoading;

  Future<void> load() {
    emit(const HomeLoading());
    return _loadLibrary(_minimalLoading);
  }

  Future<void> refresh() => _loadLibrary(Duration.zero);

  Future<void> _loadLibrary(Duration minimalDelay) => _loadEventLibrary()
      .withMinimalDelay(minimalDelay)
      .match(
        HomeFailed.new,
        (EventLibraryLoad load) => switch (load) {
          EventLibraryNeedsSortingStart() => const HomeNeedsSortingStart(),
          EventLibraryAccessDenied() => const HomeAccessDenied(),
          EventLibraryLoaded(:final EventLibrary library) => HomeLoaded(
            library: library,
            selectedMonth: switch (state) {
              HomeLoaded(:final Option<PhotoMonth> selectedMonth) => selectedMonth,
              HomeLoading() || HomeNeedsSortingStart() || HomeAccessDenied() || HomeFailed() => none(),
            },
          ),
        },
      )
      .map(emit)
      .run();

  void selectMonth(Option<PhotoMonth> month) => switch (state) {
    final HomeLoaded loaded => emit(loaded.copyWith(selectedMonth: month)),
    HomeLoading() || HomeNeedsSortingStart() || HomeAccessDenied() || HomeFailed() => null,
  };

  Future<void> renameEvent(EventId id, Option<String> name) => _updateLibrary(
    (EventLibrary library) => _eventNameRepository
        .saveName(id, name)
        .map(
          (_) => library.copyWith(
            names: name.match(
              () => <EventId, String>{...library.names}..remove(id),
              (String value) => <EventId, String>{...library.names, id: value},
            ),
          ),
        ),
  );

  Future<void> mergeWithPreviousEvent(PhotoEvent event) =>
      _updateBoundaries((EventBoundaries boundaries) => boundaries.joining(event.photos.first.id));

  Future<void> splitEventBefore(PhotoBurst burst) =>
      _updateBoundaries((EventBoundaries boundaries) => boundaries.splitting(burst.photos.first.id));

  Future<void> openAccessSettings() => _photoLibraryRepository.openAccessSettings().run();

  Future<void> _updateBoundaries(EventBoundaries Function(EventBoundaries boundaries) update) => _updateLibrary(
    (EventLibrary library) => _eventBoundaryRepository
        .saveBoundaries(update(library.boundaries))
        .map((_) => library.copyWith(boundaries: update(library.boundaries))),
  );

  Future<void> _updateLibrary(TaskEither<AppFailure, EventLibrary> Function(EventLibrary library) update) =>
      switch (state) {
        final HomeLoaded loaded => update(
          loaded.library,
        ).match((AppFailure _) => loaded, (EventLibrary library) => loaded.copyWith(library: library)).map(emit).run(),
        HomeLoading() || HomeNeedsSortingStart() || HomeAccessDenied() || HomeFailed() => Future<void>.value(),
      };
}
