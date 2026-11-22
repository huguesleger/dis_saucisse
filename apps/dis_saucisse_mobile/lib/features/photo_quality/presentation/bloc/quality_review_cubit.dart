import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/rules/sorting_progress.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/rules/photo_quality_rules.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'quality_review_state.dart';

class QualityReviewCubit extends SafeCubit<QualityReviewState> {
  QualityReviewCubit({
    required this.issue,
    LoadEventLibrary? loadEventLibrary,
    PhotoQualityRepository? qualityRepository,
    PhotoDecisionRepository? decisionRepository,
  }) : _loadEventLibrary = loadEventLibrary ?? LoadEventLibrary(),
       _qualityRepository = qualityRepository ?? getIt.get<PhotoQualityRepository>(),
       _decisionRepository = decisionRepository ?? getIt.get<PhotoDecisionRepository>(),
       super(const QualityReviewLoading());

  final QualityIssue issue;
  final LoadEventLibrary _loadEventLibrary;
  final PhotoQualityRepository _qualityRepository;
  final PhotoDecisionRepository _decisionRepository;

  Future<void> load() => TaskEither<AppFailure, QualityReviewState>.Do(($) async {
    final EventLibraryLoad load = await $(_loadEventLibrary());
    final Map<PhotoId, PhotoQuality> qualities = await $(_qualityRepository.loadQualities());
    return switch (load) {
      EventLibraryLoaded(:final EventLibrary library) => _readyState(
        qualityGroups(issue, undecidedPhotos(library.photos, library.decisions), qualities),
      ),
      EventLibraryNeedsSortingStart() => const QualityReviewFailed(UnknownFailure()),
      EventLibraryAccessDenied() => const QualityReviewFailed(PhotoAccessDeniedFailure()),
    };
  }).match(QualityReviewFailed.new, identity).map(emit).run();

  void toggle(PhotoId photo) => switch (state) {
    final QualityReviewReady ready => emit(
      ready.copyWith(
        selected: ready.selected.contains(photo)
            ? (Set<PhotoId>.of(ready.selected)..remove(photo))
            : <PhotoId>{...ready.selected, photo},
      ),
    ),
    QualityReviewLoading() || QualityReviewFailed() || QualityReviewDone() => null,
  };

  Future<void> discardSelected() async => switch (state) {
    final QualityReviewReady ready =>
      await TaskEither.traverseListSeq(
            ready.selected.toList(),
            (PhotoId photo) => _decisionRepository.saveDecision(photo, PhotoDecision.discarded),
          )
          .match((AppFailure _) => ready, (List<Unit> saved) => QualityReviewDone(discardedCount: saved.length))
          .map(emit)
          .run(),
    QualityReviewLoading() || QualityReviewFailed() || QualityReviewDone() => null,
  };

  QualityReviewState _readyState(List<QualityGroup> groups) => QualityReviewReady(
    groups: groups,
    selected: <PhotoId>{
      for (final QualityGroup group in groups)
        for (final LibraryPhoto photo in group.photosToDiscard) photo.id,
    },
  );
}
