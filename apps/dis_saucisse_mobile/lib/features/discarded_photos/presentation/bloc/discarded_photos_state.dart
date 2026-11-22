part of 'discarded_photos_cubit.dart';

@immutable
sealed class DiscardedPhotosState {
  const DiscardedPhotosState();
}

final class DiscardedPhotosLoading extends DiscardedPhotosState {
  const DiscardedPhotosLoading();
}

final class DiscardedPhotosFailed extends DiscardedPhotosState {
  const DiscardedPhotosFailed(this.failure);

  final AppFailure failure;
}

final class DiscardedPhotosReady extends DiscardedPhotosState {
  const DiscardedPhotosReady({required this.photos, required this.selected});

  final DiscardedPhotos photos;
  final Set<PhotoId> selected;

  DiscardedPhotosReady copyWith({Set<PhotoId>? selected}) =>
      DiscardedPhotosReady(photos: photos, selected: selected ?? this.selected);
}

final class DiscardedPhotosRestored extends DiscardedPhotosState {
  const DiscardedPhotosRestored({required this.restoredCount});

  final int restoredCount;
}
