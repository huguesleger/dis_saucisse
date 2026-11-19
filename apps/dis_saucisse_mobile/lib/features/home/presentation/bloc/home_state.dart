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
  const HomeLoaded({
    required this.photos,
    required this.eventNames,
    required this.eventBoundaries,
    required this.selectedMonth,
  });

  final List<LibraryPhoto> photos;
  final Map<EventId, String> eventNames;
  final EventBoundaries eventBoundaries;
  final Option<PhotoMonth> selectedMonth;

  List<PhotoEvent> get events => groupIntoEvents(photos, eventNames, eventBoundaries);

  List<PhotoMonth> get months => photoMonthsNewestFirst(photos);

  int get visiblePhotoCount =>
      selectedMonth.match(() => photos.length, (PhotoMonth month) => countPhotosIn(photos, month));

  List<MonthEvents> get visibleEventsByMonth => eventsByMonthNewestFirst(
    selectedMonth.match(
      () => events,
      (PhotoMonth month) => events.where((PhotoEvent event) => event.month == month).toList(),
    ),
  );

  HomeLoaded copyWith({
    Map<EventId, String>? eventNames,
    EventBoundaries? eventBoundaries,
    Option<PhotoMonth>? selectedMonth,
  }) => HomeLoaded(
    photos: photos,
    eventNames: eventNames ?? this.eventNames,
    eventBoundaries: eventBoundaries ?? this.eventBoundaries,
    selectedMonth: selectedMonth ?? this.selectedMonth,
  );
}
