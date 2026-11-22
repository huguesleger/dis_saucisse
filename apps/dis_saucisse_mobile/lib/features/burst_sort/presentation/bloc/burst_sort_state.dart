part of 'burst_sort_cubit.dart';

@immutable
sealed class BurstSortState {
  const BurstSortState();
}

final class BurstSortLoading extends BurstSortState {
  const BurstSortLoading();
}

final class BurstSortFailed extends BurstSortState {
  const BurstSortFailed(this.failure);

  final AppFailure failure;
}

final class BurstSortFinished extends BurstSortState {
  const BurstSortFinished();
}

final class BurstSortInProgress extends BurstSortState {
  const BurstSortInProgress({required this.library, required this.events, required this.cursor});

  final EventLibrary library;
  final List<PhotoEvent> events;
  final SortCursor cursor;

  PhotoEvent get event => events[cursor.eventIndex];

  PhotoBurst get burst => event.bursts[cursor.burstIndex];

  Option<PhotoDecision> decisionOf(PhotoId photo) => Option<PhotoDecision>.fromNullable(library.decisions[photo]);

  BurstSortInProgress copyWith({SortCursor? cursor}) =>
      BurstSortInProgress(library: library, events: events, cursor: cursor ?? this.cursor);
}
