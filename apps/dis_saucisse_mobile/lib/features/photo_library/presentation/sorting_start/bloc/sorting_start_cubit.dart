import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/sorting_start_preset.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/sorting_start_choice.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'sorting_start_state.dart';

class SortingStartCubit extends SafeCubit<SortingStartState> {
  SortingStartCubit({
    PhotoLibraryRepository? photoLibraryRepository,
    SortingStartRepository? sortingStartRepository,
    DateTime Function()? clock,
  }) : _photoLibraryRepository = photoLibraryRepository ?? getIt.get<PhotoLibraryRepository>(),
       _sortingStartRepository = sortingStartRepository ?? getIt.get<SortingStartRepository>(),
       _clock = clock ?? DateTime.now,
       super(const SortingStartEditing(choice: PresetSortingStart(SortingStartPreset.threeMonths)));

  final PhotoLibraryRepository _photoLibraryRepository;
  final SortingStartRepository _sortingStartRepository;
  final DateTime Function() _clock;

  DateTime get today => _clock();

  void choose(SortingStartChoice choice) => emit(SortingStartEditing(choice: choice));

  Future<void> confirm() {
    final SortingStartChoice choice = state.choice;
    emit(SortingStartRequestingAccess(choice: choice));
    return _photoLibraryRepository
        .requestAccess()
        .flatMap(
          (PhotoAccess access) => switch (access) {
            PhotoAccess.granted || PhotoAccess.limited =>
              _sortingStartRepository
                  .saveStartDate(choice.startDate(_clock()))
                  .map<SortingStartState>((_) => SortingStartCompleted(choice: choice)),
            PhotoAccess.denied => TaskEither<AppFailure, SortingStartState>.right(
              SortingStartAccessDenied(choice: choice),
            ),
          },
        )
        .match((AppFailure _) => SortingStartFailed(choice: choice), identity)
        .map(emit)
        .run();
  }

  Future<void> openAccessSettings() => _photoLibraryRepository.openAccessSettings().run();
}
