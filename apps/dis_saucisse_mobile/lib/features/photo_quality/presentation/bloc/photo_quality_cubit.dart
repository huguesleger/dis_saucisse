import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_repository.dart';
import 'package:flutter/foundation.dart';

part 'photo_quality_state.dart';

class PhotoQualityCubit extends SafeCubit<PhotoQualityState> {
  PhotoQualityCubit({PhotoQualityRepository? repository, this.emitEvery = 10})
    : _repository = repository ?? getIt.get<PhotoQualityRepository>(),
      super(const PhotoQualityReady(<PhotoId, PhotoQuality>{}));

  final PhotoQualityRepository _repository;
  final int emitEvery;
  int _run = 0;

  Future<void> analyze(List<LibraryPhoto> photos) async {
    final int run = ++_run;
    final Map<PhotoId, PhotoQuality> qualities = Map<PhotoId, PhotoQuality>.of(
      await _repository.loadQualities().getOrElse((AppFailure _) => <PhotoId, PhotoQuality>{}).run(),
    );
    final List<PhotoId> missing =
        (List<LibraryPhoto>.of(
              photos,
            )..sort((LibraryPhoto a, LibraryPhoto b) => b.takenAt.compareTo(a.takenAt)))
            .map((LibraryPhoto p) => p.id)
            .where(
              (PhotoId id) => !qualities.containsKey(id),
            )
            .toList();
    if (_isStale(run)) return;
    emit(_stateOf(qualities, missing.length));
    for (final (int index, PhotoId photo) in missing.indexed) {
      if (_isStale(run)) return;
      await _repository
          .analyzePhoto(photo)
          .match((AppFailure _) => null, (PhotoQuality quality) => qualities[photo] = quality)
          .run();
      final int remaining = missing.length - index - 1;
      if (!_isStale(run) && (remaining % emitEvery == 0)) emit(_stateOf(qualities, remaining));
    }
  }

  bool _isStale(int run) => isClosed || run != _run;

  PhotoQualityState _stateOf(Map<PhotoId, PhotoQuality> qualities, int remaining) {
    final Map<PhotoId, PhotoQuality> snapshot = Map<PhotoId, PhotoQuality>.unmodifiable(qualities);
    return remaining == 0 ? PhotoQualityReady(snapshot) : PhotoQualityAnalyzing(snapshot, remaining: remaining);
  }
}
