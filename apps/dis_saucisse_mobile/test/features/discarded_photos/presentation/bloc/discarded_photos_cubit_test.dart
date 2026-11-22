import 'package:bloc_test/bloc_test.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/burst_sort_failure.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/bloc/discarded_photos_cubit.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/free_space_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockLoadEventLibrary extends Mock implements LoadEventLibrary {}

class _MockFreeSpaceRepository extends Mock implements FreeSpaceRepository {}

class _MockPhotoDecisionRepository extends Mock implements PhotoDecisionRepository {}

void main() {
  late _MockLoadEventLibrary loadEventLibrary;
  late _MockFreeSpaceRepository freeSpaceRepository;
  late _MockPhotoDecisionRepository decisionRepository;

  final EventLibrary library = EventLibrary(
    photos: saturdayPhotos,
    names: const {},
    boundaries: const EventBoundaries.none(),
    decisions: const <PhotoId, PhotoDecision>{
      PhotoId('cake-1'): PhotoDecision.discarded,
      PhotoId('cake-2'): PhotoDecision.kept,
      PhotoId('walk'): PhotoDecision.discarded,
    },
  );

  List<String> idsOf(List<LibraryPhoto> photos) => photos.map((LibraryPhoto photo) => photo.id.value).toList();

  setUpAll(() => registerFallbackValue(<PhotoId>{}));

  setUp(() {
    loadEventLibrary = _MockLoadEventLibrary();
    freeSpaceRepository = _MockFreeSpaceRepository();
    decisionRepository = _MockPhotoDecisionRepository();
    when(() => loadEventLibrary()).thenReturn(TaskEither.right(EventLibraryLoaded(library)));
    when(
      () => freeSpaceRepository.loadSentPhotoBytes(),
    ).thenReturn(TaskEither.right(const <PhotoId, int>{PhotoId('cake-1'): 1200}));
    when(() => decisionRepository.removeDecisions(any())).thenReturn(TaskEither.right(unit));
  });

  DiscardedPhotosCubit buildCubit() => DiscardedPhotosCubit(
    loadEventLibrary: loadEventLibrary,
    freeSpaceRepository: freeSpaceRepository,
    decisionRepository: decisionRepository,
    minimalLoading: Duration.zero,
  );

  blocTest<DiscardedPhotosCubit, DiscardedPhotosState>(
    'lists the discarded photos and sets apart those already on the computer',
    build: buildCubit,
    act: (DiscardedPhotosCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<DiscardedPhotosLoading>(),
      isA<DiscardedPhotosReady>()
          .having((DiscardedPhotosReady s) => idsOf(s.photos.onPhoneOnly), 'on phone only', <String>['walk'])
          .having((DiscardedPhotosReady s) => idsOf(s.photos.alreadySent), 'already sent', <String>['cake-1'])
          .having((DiscardedPhotosReady s) => s.selected, 'selected', isEmpty),
    ],
  );

  blocTest<DiscardedPhotosCubit, DiscardedPhotosState>(
    'fails without access to the photos',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.right(const EventLibraryAccessDenied())),
    build: buildCubit,
    act: (DiscardedPhotosCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<DiscardedPhotosLoading>(),
      isA<DiscardedPhotosFailed>().having(
        (DiscardedPhotosFailed s) => s.failure,
        'failure',
        const PhotoAccessDeniedFailure(),
      ),
    ],
  );

  blocTest<DiscardedPhotosCubit, DiscardedPhotosState>(
    'selects then unselects a photo',
    build: buildCubit,
    act: (DiscardedPhotosCubit cubit) async {
      await cubit.load();
      cubit
        ..toggle(const PhotoId('walk'))
        ..toggle(const PhotoId('walk'));
    },
    skip: 2,
    expect: () => <Matcher>[
      isA<DiscardedPhotosReady>().having((DiscardedPhotosReady s) => s.selected, 'selected', <PhotoId>{
        const PhotoId('walk'),
      }),
      isA<DiscardedPhotosReady>().having((DiscardedPhotosReady s) => s.selected, 'selected', isEmpty),
    ],
  );

  blocTest<DiscardedPhotosCubit, DiscardedPhotosState>(
    'puts the selected photos back to sort',
    build: buildCubit,
    act: (DiscardedPhotosCubit cubit) async {
      await cubit.load();
      cubit.toggle(const PhotoId('walk'));
      await cubit.restoreSelected();
    },
    skip: 3,
    expect: () => <Matcher>[
      isA<DiscardedPhotosRestored>().having((DiscardedPhotosRestored s) => s.restoredCount, 'count', 1),
    ],
    verify: (_) => verify(() => decisionRepository.removeDecisions(<PhotoId>{const PhotoId('walk')})).called(1),
  );

  blocTest<DiscardedPhotosCubit, DiscardedPhotosState>(
    'reports a decision that cannot be removed',
    setUp: () => when(
      () => decisionRepository.removeDecisions(any()),
    ).thenReturn(TaskEither.left(const PhotoDecisionStorageFailure())),
    build: buildCubit,
    act: (DiscardedPhotosCubit cubit) async {
      await cubit.load();
      cubit.toggle(const PhotoId('walk'));
      await cubit.restoreSelected();
    },
    skip: 3,
    expect: () => <Matcher>[
      isA<DiscardedPhotosFailed>().having(
        (DiscardedPhotosFailed s) => s.failure,
        'failure',
        const PhotoDecisionStorageFailure(),
      ),
    ],
  );
}
