import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/sort_cursor.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/rules/sorting_progress.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'burst_sort_state.dart';

class BurstSortCubit extends SafeCubit<BurstSortState> {
  BurstSortCubit({
    required Option<EventId> eventId,
    LoadEventLibrary? loadEventLibrary,
    PhotoDecisionRepository? photoDecisionRepository,
    Duration? minimalLoading,
  }) : _eventId = eventId,
       _loadEventLibrary = loadEventLibrary ?? LoadEventLibrary(),
       _photoDecisionRepository = photoDecisionRepository ?? getIt.get<PhotoDecisionRepository>(),
       _minimalLoading = minimalLoading ?? DsLoader.minDuration,
       super(const BurstSortLoading());

  final Option<EventId> _eventId;
  final LoadEventLibrary _loadEventLibrary;
  final PhotoDecisionRepository _photoDecisionRepository;
  final Duration _minimalLoading;

  Future<void> load() => _loadEventLibrary()
      .withMinimalDelay(_minimalLoading)
      .match(
        BurstSortFailed.new,
        (EventLibraryLoad load) => switch (load) {
          EventLibraryLoaded(:final EventLibrary library) => _start(library),
          EventLibraryNeedsSortingStart() => const BurstSortFailed(UnknownFailure()),
          EventLibraryAccessDenied() => const BurstSortFailed(PhotoAccessDeniedFailure()),
        },
      )
      .map(emit)
      .run();

  Future<void> keep() => _decide(PhotoDecision.kept);

  Future<void> discard() => _decide(PhotoDecision.discarded);

  void showPhoto(PhotoId photo) => switch (state) {
    final BurstSortInProgress sorting => emit(
      sorting.copyWith(
        cursor: SortCursor(
          eventIndex: sorting.cursor.eventIndex,
          burstIndex: sorting.cursor.burstIndex,
          photoId: photo,
        ),
      ),
    ),
    BurstSortLoading() || BurstSortFailed() || BurstSortFinished() => null,
  };

  BurstSortState _start(EventLibrary library) {
    final List<PhotoEvent> events = _eventId.match(
      () =>
          eventsToSort(library.events, library.decisions)
            ..sort((PhotoEvent a, PhotoEvent b) => b.startedAt.compareTo(a.startedAt)),
      (EventId id) => library.events.where((PhotoEvent event) => event.id == id).toList(),
    );
    return _sortingFrom(library, events, nextUndecided(events, library.decisions));
  }

  Future<void> _decide(PhotoDecision decision) => switch (state) {
    final BurstSortInProgress sorting =>
      _photoDecisionRepository
          .saveDecision(sorting.cursor.photoId, decision)
          .map((_) => _afterDecision(sorting, decision))
          .match((AppFailure _) => sorting, identity)
          .map(emit)
          .run(),
    BurstSortLoading() || BurstSortFailed() || BurstSortFinished() => Future<void>.value(),
  };

  BurstSortState _afterDecision(BurstSortInProgress sorting, PhotoDecision decision) {
    final EventLibrary library = sorting.library.copyWith(
      decisions: <PhotoId, PhotoDecision>{...sorting.library.decisions, sorting.cursor.photoId: decision},
    );
    return _sortingFrom(
      library,
      sorting.events,
      nextUndecided(
        sorting.events,
        library.decisions,
        fromEvent: sorting.cursor.eventIndex,
        fromBurst: sorting.cursor.burstIndex,
      ),
    );
  }

  BurstSortState _sortingFrom(EventLibrary library, List<PhotoEvent> events, Option<SortCursor> cursor) => cursor.match(
    () => const BurstSortFinished(),
    (SortCursor next) => BurstSortInProgress(library: library, events: events, cursor: next),
  );
}
