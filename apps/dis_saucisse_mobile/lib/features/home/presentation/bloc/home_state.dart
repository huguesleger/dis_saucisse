part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeNeedsSortingStart extends HomeState {
  const HomeNeedsSortingStart();
}

final class HomeAccessDenied extends HomeState {
  const HomeAccessDenied();
}

final class HomeFailed extends HomeState {
  const HomeFailed(this.failure);

  final AppFailure failure;
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required this.library, required this.selectedMonth});

  final EventLibrary library;
  final Option<PhotoMonth> selectedMonth;

  List<PhotoEvent> get events => library.events;

  List<LibraryPhoto> get photosLeftToSort => undecidedPhotos(library.photos, library.decisions);

  List<PhotoMonth> get months => photoMonthsNewestFirst(photosLeftToSort);

  int get visiblePhotoCount => selectedMonth.match(
    () => photosLeftToSort.length,
    (PhotoMonth month) => countPhotosIn(photosLeftToSort, month),
  );

  List<MonthEvents> get visibleEventsByMonth {
    final List<PhotoEvent> toSort = eventsToSort(events, library.decisions);
    return eventsByMonthNewestFirst(
      selectedMonth.match(
        () => toSort,
        (PhotoMonth month) => toSort.where((PhotoEvent event) => event.month == month).toList(),
      ),
    );
  }

  HomeLoaded copyWith({EventLibrary? library, Option<PhotoMonth>? selectedMonth}) =>
      HomeLoaded(library: library ?? this.library, selectedMonth: selectedMonth ?? this.selectedMonth);
}
