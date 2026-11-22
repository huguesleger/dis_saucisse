import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/bloc/quality_review_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockLoadEventLibrary extends Mock implements LoadEventLibrary {}

class _MockPhotoQualityRepository extends Mock implements PhotoQualityRepository {}

class _MockPhotoDecisionRepository extends Mock implements PhotoDecisionRepository {}

void main() {
  late _MockLoadEventLibrary loadEventLibrary;
  late _MockPhotoQualityRepository qualityRepository;
  late _MockPhotoDecisionRepository decisionRepository;
  final Map<PhotoId, PhotoQuality> qualities = <PhotoId, PhotoQuality>{
    const PhotoId('cake-1'): const PhotoQuality(photoId: PhotoId('cake-1'), sharpness: 300, fingerprint: 5),
    const PhotoId('cake-2'): const PhotoQuality(photoId: PhotoId('cake-2'), sharpness: 20, fingerprint: 5),
    const PhotoId('walk'): const PhotoQuality(photoId: PhotoId('walk'), sharpness: 10, fingerprint: 99),
  };

  setUpAll(() {
    registerFallbackValue(const PhotoId('fallback'));
    registerFallbackValue(PhotoDecision.kept);
  });

  setUp(() {
    loadEventLibrary = _MockLoadEventLibrary();
    qualityRepository = _MockPhotoQualityRepository();
    decisionRepository = _MockPhotoDecisionRepository();
    when(() => qualityRepository.loadQualities()).thenReturn(TaskEither.right(qualities));
    when(() => loadEventLibrary()).thenReturn(
      TaskEither.right(
        EventLibraryLoaded(
          EventLibrary(
            photos: saturdayPhotos,
            names: const <EventId, String>{},
            boundaries: const EventBoundaries.none(),
            decisions: <PhotoId, PhotoDecision>{const PhotoId('walk'): PhotoDecision.kept},
          ),
        ),
      ),
    );
  });

  QualityReviewCubit buildCubit(QualityIssue issue) => QualityReviewCubit(
    issue: issue,
    loadEventLibrary: loadEventLibrary,
    qualityRepository: qualityRepository,
    decisionRepository: decisionRepository,
  );

  blocTest<QualityReviewCubit, QualityReviewState>(
    'selects the copies of a duplicate, not the sharpest one',
    build: () => buildCubit(QualityIssue.duplicates),
    act: (QualityReviewCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<QualityReviewReady>().having((QualityReviewReady s) => s.groups.single.photos.length, 'group size', 2).having(
        (QualityReviewReady s) => s.selected,
        'selected',
        <PhotoId>{const PhotoId('cake-2')},
      ),
    ],
  );

  blocTest<QualityReviewCubit, QualityReviewState>(
    'ignores photos already sorted',
    build: () => buildCubit(QualityIssue.blurry),
    act: (QualityReviewCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<QualityReviewReady>().having((QualityReviewReady s) => s.selected, 'selected', <PhotoId>{
        const PhotoId('cake-2'),
      }),
    ],
  );

  blocTest<QualityReviewCubit, QualityReviewState>(
    'reports a library that cannot be read',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.left(const UnknownFailure())),
    build: () => buildCubit(QualityIssue.blurry),
    act: (QualityReviewCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<QualityReviewFailed>().having((QualityReviewFailed s) => s.failure, 'failure', const UnknownFailure()),
    ],
  );

  blocTest<QualityReviewCubit, QualityReviewState>(
    'keeps a photo the user unticks and discards the others',
    setUp: () => when(
      () => decisionRepository.saveDecision(any(), PhotoDecision.discarded),
    ).thenReturn(TaskEither.right(unit)),
    build: () => buildCubit(QualityIssue.blurry),
    seed: () => const QualityReviewReady(groups: [], selected: <PhotoId>{PhotoId('a'), PhotoId('b')}),
    act: (QualityReviewCubit cubit) async {
      cubit.toggle(const PhotoId('a'));
      await cubit.discardSelected();
    },
    expect: () => <Matcher>[
      isA<QualityReviewReady>().having((QualityReviewReady s) => s.selected, 'selected', <PhotoId>{
        const PhotoId('b'),
      }),
      isA<QualityReviewDone>().having((QualityReviewDone s) => s.discardedCount, 'discardedCount', 1),
    ],
    verify: (_) {
      verify(() => decisionRepository.saveDecision(const PhotoId('b'), PhotoDecision.discarded)).called(1);
      verifyNever(() => decisionRepository.saveDecision(const PhotoId('a'), any()));
    },
  );
}
