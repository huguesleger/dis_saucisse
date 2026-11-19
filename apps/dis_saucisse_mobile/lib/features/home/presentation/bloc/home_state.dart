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
  const HomeLoaded({required this.photos, required this.selectedMonth});

  final List<LibraryPhoto> photos;
  final Option<PhotoMonth> selectedMonth;

  List<PhotoMonth> get months => photoMonthsNewestFirst(photos);

  int get visiblePhotoCount =>
      selectedMonth.match(() => photos.length, (PhotoMonth month) => countPhotosIn(photos, month));

  HomeLoaded copyWith({Option<PhotoMonth>? selectedMonth}) =>
      HomeLoaded(photos: photos, selectedMonth: selectedMonth ?? this.selectedMonth);
}
