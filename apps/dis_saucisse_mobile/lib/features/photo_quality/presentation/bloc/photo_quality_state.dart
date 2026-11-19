part of 'photo_quality_cubit.dart';

@immutable
sealed class PhotoQualityState {
  const PhotoQualityState(this.qualities);

  final Map<PhotoId, PhotoQuality> qualities;
}

final class PhotoQualityAnalyzing extends PhotoQualityState {
  const PhotoQualityAnalyzing(super.qualities, {required this.remaining});

  final int remaining;
}

final class PhotoQualityReady extends PhotoQualityState {
  const PhotoQualityReady(super.qualities);
}
