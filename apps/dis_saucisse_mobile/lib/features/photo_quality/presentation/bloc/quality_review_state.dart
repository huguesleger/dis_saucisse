part of 'quality_review_cubit.dart';

@immutable
sealed class QualityReviewState {
  const QualityReviewState();
}

final class QualityReviewLoading extends QualityReviewState {
  const QualityReviewLoading();
}

final class QualityReviewFailed extends QualityReviewState {
  const QualityReviewFailed();
}

final class QualityReviewReady extends QualityReviewState {
  const QualityReviewReady({required this.groups, required this.selected});

  final List<QualityGroup> groups;
  final Set<PhotoId> selected;

  QualityReviewReady copyWith({Set<PhotoId>? selected}) =>
      QualityReviewReady(groups: groups, selected: selected ?? this.selected);
}

final class QualityReviewDone extends QualityReviewState {
  const QualityReviewDone({required this.discardedCount});

  final int discardedCount;
}
