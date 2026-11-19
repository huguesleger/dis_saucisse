part of 'free_space_cubit.dart';

@immutable
sealed class FreeSpaceState {
  const FreeSpaceState();
}

final class FreeSpaceLoading extends FreeSpaceState {
  const FreeSpaceLoading();
}

final class FreeSpaceNothingToFree extends FreeSpaceState {
  const FreeSpaceNothingToFree();
}

final class FreeSpaceReady extends FreeSpaceState {
  const FreeSpaceReady({required this.photos, required this.includeDiscarded});

  final FreeablePhotos photos;
  final bool includeDiscarded;

  List<PhotoId> get selected => <PhotoId>[...photos.kept, if (includeDiscarded) ...photos.discarded];

  int get selectedBytes => photos.keptBytes + (includeDiscarded ? photos.discardedBytes : 0);
}

final class FreeSpaceDeleting extends FreeSpaceState {
  const FreeSpaceDeleting();
}

final class FreeSpaceDone extends FreeSpaceState {
  const FreeSpaceDone({required this.deletedCount, required this.freedBytes});

  final int deletedCount;
  final int freedBytes;
}

final class FreeSpaceFailed extends FreeSpaceState {
  const FreeSpaceFailed();
}
