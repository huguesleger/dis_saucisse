import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/month_events.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photo_months.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photos_to_sort.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'home_state.dart';

class HomeCubit extends SafeCubit<HomeState> {
  HomeCubit({
    PhotoLibraryRepository? photoLibraryRepository,
    SortingStartRepository? sortingStartRepository,
    EventNameRepository? eventNameRepository,
  }) : _photoLibraryRepository = photoLibraryRepository ?? getIt.get<PhotoLibraryRepository>(),
       _sortingStartRepository = sortingStartRepository ?? getIt.get<SortingStartRepository>(),
       _eventNameRepository = eventNameRepository ?? getIt.get<EventNameRepository>(),
       super(const HomeLoading());

  final PhotoLibraryRepository _photoLibraryRepository;
  final SortingStartRepository _sortingStartRepository;
  final EventNameRepository _eventNameRepository;

  Future<void> load() {
    emit(const HomeLoading());
    return _sortingStartRepository
        .loadStartDate()
        .flatMap(
          (Option<DateTime> start) => start.match(
            () => TaskEither<AppFailure, HomeState>.right(const HomeNeedsSortingStart()),
            _loadWhenAccessGranted,
          ),
        )
        .match((AppFailure _) => const HomeFailed(), identity)
        .map(emit)
        .run();
  }

  void selectMonth(Option<PhotoMonth> month) => switch (state) {
    final HomeLoaded loaded => emit(loaded.copyWith(selectedMonth: month)),
    HomeLoading() || HomeNeedsSortingStart() || HomeAccessDenied() || HomeFailed() => null,
  };

  Future<void> renameEvent(EventId id, Option<String> name) => switch (state) {
    final HomeLoaded loaded =>
      _eventNameRepository
          .saveName(id, name)
          .match(
            (AppFailure _) => loaded,
            (_) => loaded.copyWith(
              events: loaded.events
                  .map((PhotoEvent event) => event.id == id ? event.copyWith(name: name) : event)
                  .toList(),
            ),
          )
          .map(emit)
          .run(),
    HomeLoading() || HomeNeedsSortingStart() || HomeAccessDenied() || HomeFailed() => Future<void>.value(),
  };

  Future<void> openAccessSettings() => _photoLibraryRepository.openAccessSettings().run();

  TaskEither<AppFailure, HomeState> _loadWhenAccessGranted(DateTime start) =>
      _photoLibraryRepository.checkAccess().flatMap(
        (PhotoAccess access) => switch (access) {
          PhotoAccess.granted || PhotoAccess.limited => _loadPhotosAndEvents(start),
          PhotoAccess.denied => TaskEither<AppFailure, HomeState>.right(const HomeAccessDenied()),
        },
      );

  TaskEither<AppFailure, HomeState> _loadPhotosAndEvents(DateTime start) =>
      TaskEither<AppFailure, HomeState>.Do(($) async {
        final List<LibraryPhoto> photos = photosToSort(
          await $(_photoLibraryRepository.loadPhotosTakenSince(start)),
        );
        final Map<EventId, String> names = await $(_eventNameRepository.loadNames());
        return HomeLoaded(photos: photos, events: groupIntoEvents(photos, names), selectedMonth: none());
      });
}
