import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/sort_cursor.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/presentation/bloc/burst_sort_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockLoadEventLibrary extends Mock implements LoadEventLibrary {}

class _MockPhotoDecisionRepository extends Mock implements PhotoDecisionRepository {}

EventLibrary _library([Map<PhotoId, PhotoDecision> decisions = const <PhotoId, PhotoDecision>{}]) => EventLibrary(
  photos: saturdayPhotos,
  names: const <EventId, String>{},
  boundaries: const EventBoundaries.none(),
  decisions: decisions,
);

Matcher _sortingPhoto(String id) =>
    isA<BurstSortInProgress>().having((BurstSortInProgress s) => s.cursor.photoId.value, 'photo', id);

void main() {
  late _MockLoadEventLibrary loadEventLibrary;
  late _MockPhotoDecisionRepository photoDecisionRepository;

  setUpAll(() {
    registerFallbackValue(const PhotoId('fallback'));
    registerFallbackValue(PhotoDecision.kept);
  });

  setUp(() {
    loadEventLibrary = _MockLoadEventLibrary();
    photoDecisionRepository = _MockPhotoDecisionRepository();
    when(() => photoDecisionRepository.saveDecision(any(), any())).thenReturn(TaskEither.right(unit));
  });

  BurstSortCubit buildCubit([Option<EventId> eventId = const None()]) => BurstSortCubit(
    eventId: eventId,
    loadEventLibrary: loadEventLibrary,
    photoDecisionRepository: photoDecisionRepository,
  );

  blocTest<BurstSortCubit, BurstSortState>(
    'starts with the newest event that still has photos to sort',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.right(EventLibraryLoaded(_library()))),
    build: buildCubit,
    act: (BurstSortCubit cubit) => cubit.load(),
    expect: () => <Matcher>[_sortingPhoto('walk')],
  );

  blocTest<BurstSortCubit, BurstSortState>(
    'sorts only the requested event',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.right(EventLibraryLoaded(_library()))),
    build: () => buildCubit(some(const EventId('cake-1'))),
    act: (BurstSortCubit cubit) => cubit.load(),
    expect: () => <Matcher>[_sortingPhoto('cake-1')],
  );

  blocTest<BurstSortCubit, BurstSortState>(
    'saves each decision and moves through the burst, then the next burst',
    build: () => buildCubit(some(const EventId('cake-1'))),
    seed: () => BurstSortInProgress(
      library: _library(),
      events: _library().events.take(1).toList(),
      cursor: const SortCursor(eventIndex: 0, burstIndex: 0, photoId: PhotoId('cake-1')),
    ),
    act: (BurstSortCubit cubit) async {
      await cubit.keep();
      await cubit.discard();
      await cubit.keep();
    },
    expect: () => <Matcher>[_sortingPhoto('cake-2'), _sortingPhoto('candles'), isA<BurstSortFinished>()],
    verify: (_) {
      verify(() => photoDecisionRepository.saveDecision(const PhotoId('cake-1'), PhotoDecision.kept)).called(1);
      verify(() => photoDecisionRepository.saveDecision(const PhotoId('cake-2'), PhotoDecision.discarded)).called(1);
    },
  );

  blocTest<BurstSortCubit, BurstSortState>(
    'finishes at once when nothing is left to sort',
    setUp: () => when(() => loadEventLibrary()).thenReturn(
      TaskEither.right(
        EventLibraryLoaded(
          _library(<PhotoId, PhotoDecision>{
            for (final photo in saturdayPhotos) photo.id: PhotoDecision.kept,
          }),
        ),
      ),
    ),
    build: buildCubit,
    act: (BurstSortCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<BurstSortFinished>()],
  );

  blocTest<BurstSortCubit, BurstSortState>(
    'stays on the photo when the decision cannot be saved',
    setUp: () => when(
      () => photoDecisionRepository.saveDecision(any(), any()),
    ).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    seed: () => BurstSortInProgress(
      library: _library(),
      events: _library().events,
      cursor: const SortCursor(eventIndex: 0, burstIndex: 0, photoId: PhotoId('cake-1')),
    ),
    act: (BurstSortCubit cubit) => cubit.keep(),
    expect: () => <Matcher>[],
  );

  blocTest<BurstSortCubit, BurstSortState>(
    'shows another photo of the burst when its thumbnail is tapped',
    build: buildCubit,
    seed: () => BurstSortInProgress(
      library: _library(),
      events: _library().events,
      cursor: const SortCursor(eventIndex: 0, burstIndex: 0, photoId: PhotoId('cake-1')),
    ),
    act: (BurstSortCubit cubit) => cubit.showPhoto(const PhotoId('cake-2')),
    expect: () => <Matcher>[_sortingPhoto('cake-2')],
  );

  blocTest<BurstSortCubit, BurstSortState>(
    'fails when the library cannot be loaded',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    act: (BurstSortCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<BurstSortFailed>().having((BurstSortFailed s) => s.failure, 'failure', const UnknownFailure()),
    ],
  );

  blocTest<BurstSortCubit, BurstSortState>(
    'fails without access to the photos',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.right(const EventLibraryAccessDenied())),
    build: buildCubit,
    act: (BurstSortCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<BurstSortFailed>().having((BurstSortFailed s) => s.failure, 'failure', const PhotoAccessDeniedFailure()),
    ],
  );
}
