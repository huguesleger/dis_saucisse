import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
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
  HomeCubit({PhotoLibraryRepository? photoLibraryRepository, SortingStartRepository? sortingStartRepository})
    : _photoLibraryRepository = photoLibraryRepository ?? getIt.get<PhotoLibraryRepository>(),
      _sortingStartRepository = sortingStartRepository ?? getIt.get<SortingStartRepository>(),
      super(const HomeLoading());

  final PhotoLibraryRepository _photoLibraryRepository;
  final SortingStartRepository _sortingStartRepository;

  Future<void> load() {
    emit(const HomeLoading());
    return _sortingStartRepository
        .loadStartDate()
        .flatMap(
          (Option<DateTime> start) => start.match(
            () => TaskEither<AppFailure, HomeState>.right(const HomeNeedsSortingStart()),
            _loadPhotosTakenSince,
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

  Future<void> openAccessSettings() => _photoLibraryRepository.openAccessSettings().run();

  TaskEither<AppFailure, HomeState> _loadPhotosTakenSince(DateTime start) =>
      _photoLibraryRepository.checkAccess().flatMap(
        (PhotoAccess access) => switch (access) {
          PhotoAccess.granted || PhotoAccess.limited =>
            _photoLibraryRepository
                .loadPhotosTakenSince(start)
                .map<HomeState>(
                  (List<LibraryPhoto> photos) => HomeLoaded(photos: photosToSort(photos), selectedMonth: none()),
                ),
          PhotoAccess.denied => TaskEither<AppFailure, HomeState>.right(const HomeAccessDenied()),
        },
      );
}
