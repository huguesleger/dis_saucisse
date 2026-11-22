import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/memory_month.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/sent_photo_record.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/memories_repository.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/rules/memory_months.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'memories_state.dart';

class MemoriesCubit extends SafeCubit<MemoriesState> {
  MemoriesCubit({MemoriesRepository? memoriesRepository, LoadEventLibrary? loadEventLibrary, Duration? minimalLoading})
    : _memoriesRepository = memoriesRepository ?? getIt.get<MemoriesRepository>(),
      _loadEventLibrary = loadEventLibrary ?? LoadEventLibrary(),
      _minimalLoading = minimalLoading ?? DsSkeletonizer.minDuration,
      super(const MemoriesLoading());

  final MemoriesRepository _memoriesRepository;
  final LoadEventLibrary _loadEventLibrary;
  final Duration _minimalLoading;

  Future<void> load() {
    final Option<int> selectedYear = switch (state) {
      MemoriesLoaded(:final Option<int> selectedYear) => selectedYear,
      MemoriesLoading() || MemoriesFailed() => none(),
    };
    final Duration minimalDelay = switch (state) {
      MemoriesLoaded() => Duration.zero,
      MemoriesLoading() || MemoriesFailed() => _minimalLoading,
    };
    if (state is MemoriesFailed) emit(const MemoriesLoading());
    return TaskEither<AppFailure, List<MemoryMonth>>.Do(($) async {
          final List<SentPhotoRecord> sent = await $(_memoriesRepository.loadSentPhotos());
          final List<PhotoEvent> events = await $(_loadEventLibrary().map(_eventsOf));
          return memoryMonthsNewestFirst(sent, events);
        })
        .withMinimalDelay(minimalDelay)
        .match(
          MemoriesFailed.new,
          (List<MemoryMonth> months) => MemoriesLoaded(months: months, selectedYear: _keptYear(months, selectedYear)),
        )
        .map(emit)
        .run();
  }

  void selectYear(Option<int> year) => switch (state) {
    final MemoriesLoaded loaded => emit(MemoriesLoaded(months: loaded.months, selectedYear: year)),
    MemoriesLoading() || MemoriesFailed() => null,
  };

  List<PhotoEvent> _eventsOf(EventLibraryLoad load) => switch (load) {
    EventLibraryLoaded(:final EventLibrary library) => library.events,
    EventLibraryNeedsSortingStart() || EventLibraryAccessDenied() => <PhotoEvent>[],
  };

  Option<int> _keptYear(List<MemoryMonth> months, Option<int> year) =>
      year.filter((int selected) => memoryYearsNewestFirst(months).contains(selected));
}
