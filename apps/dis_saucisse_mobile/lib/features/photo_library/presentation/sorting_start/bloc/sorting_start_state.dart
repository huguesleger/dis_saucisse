part of 'sorting_start_cubit.dart';

@immutable
sealed class SortingStartState {
  const SortingStartState({required this.choice});

  final SortingStartChoice choice;
}

final class SortingStartEditing extends SortingStartState {
  const SortingStartEditing({required super.choice});
}

final class SortingStartRequestingAccess extends SortingStartState {
  const SortingStartRequestingAccess({required super.choice});
}

final class SortingStartAccessDenied extends SortingStartState {
  const SortingStartAccessDenied({required super.choice});
}

final class SortingStartFailed extends SortingStartState {
  const SortingStartFailed({required super.choice});
}

final class SortingStartCompleted extends SortingStartState {
  const SortingStartCompleted({required super.choice});
}
