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
  const HomeFailed();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required this.photos, required this.events, required this.selectedMonth});

  final List<LibraryPhoto> photos;
  final List<PhotoEvent> events;
  final Option<PhotoMonth> selectedMonth;

  List<PhotoMonth> get months => photoMonthsNewestFirst(photos);

  int get visiblePhotoCount =>
      selectedMonth.match(() => photos.length, (PhotoMonth month) => countPhotosIn(photos, month));

  List<MonthEvents> get visibleEventsByMonth => eventsByMonthNewestFirst(
    selectedMonth.match(
      () => events,
      (PhotoMonth month) => events.where((PhotoEvent event) => event.month == month).toList(),
    ),
  );

  HomeLoaded copyWith({List<PhotoEvent>? events, Option<PhotoMonth>? selectedMonth}) => HomeLoaded(
    photos: photos,
    events: events ?? this.events,
    selectedMonth: selectedMonth ?? this.selectedMonth,
  );
}
