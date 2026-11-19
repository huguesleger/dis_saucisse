import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/free_space/domain/free_space_repository.dart';
import 'package:dis_saucisse_mobile/features/free_space/presentation/bloc/free_space_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockFreeSpaceRepository extends Mock implements FreeSpaceRepository {}

class _MockLoadEventLibrary extends Mock implements LoadEventLibrary {}

void main() {
  late _MockFreeSpaceRepository repository;
  late _MockLoadEventLibrary loadEventLibrary;
  final EventLibrary library = EventLibrary(
    photos: saturdayPhotos,
    names: const <EventId, String>{},
    boundaries: const EventBoundaries.none(),
    decisions: const <PhotoId, PhotoDecision>{
      PhotoId('cake-1'): PhotoDecision.kept,
      PhotoId('cake-2'): PhotoDecision.discarded,
    },
  );

  setUpAll(() => registerFallbackValue(<PhotoId>[]));

  setUp(() {
    repository = _MockFreeSpaceRepository();
    loadEventLibrary = _MockLoadEventLibrary();
    when(() => loadEventLibrary()).thenReturn(TaskEither.right(EventLibraryLoaded(library)));
    when(() => repository.loadSentPhotoBytes()).thenReturn(
      TaskEither.right(<PhotoId, int>{const PhotoId('cake-1'): 3000, const PhotoId('cake-2'): 1000}),
    );
  });

  FreeSpaceCubit buildCubit() => FreeSpaceCubit(freeSpaceRepository: repository, loadEventLibrary: loadEventLibrary);

  blocTest<FreeSpaceCubit, FreeSpaceState>(
    'proposes to free the kept photos, the discarded ones only on request',
    build: buildCubit,
    act: (FreeSpaceCubit cubit) async {
      await cubit.load();
      cubit.includeDiscarded(true);
    },
    expect: () => <Matcher>[
      isA<FreeSpaceLoading>(),
      isA<FreeSpaceReady>()
          .having((FreeSpaceReady s) => s.selected, 'selected', const <PhotoId>[PhotoId('cake-1')])
          .having((FreeSpaceReady s) => s.selectedBytes, 'bytes', 3000),
      isA<FreeSpaceReady>().having((FreeSpaceReady s) => s.selectedBytes, 'bytes', 4000),
    ],
  );

  blocTest<FreeSpaceCubit, FreeSpaceState>(
    'moves the selected photos to the trash and tells how much was freed',
    setUp: () => when(
      () => repository.movePhotosToTrash(any()),
    ).thenReturn(TaskEither.right(<PhotoId>{const PhotoId('cake-1')})),
    build: buildCubit,
    act: (FreeSpaceCubit cubit) async {
      await cubit.load();
      await cubit.freeSpace();
    },
    skip: 2,
    expect: () => <Matcher>[
      isA<FreeSpaceDeleting>(),
      isA<FreeSpaceDone>()
          .having((FreeSpaceDone s) => s.deletedCount, 'deleted', 1)
          .having((FreeSpaceDone s) => s.freedBytes, 'freed', 3000),
    ],
    verify: (_) => verify(() => repository.movePhotosToTrash(const <PhotoId>[PhotoId('cake-1')])).called(1),
  );

  blocTest<FreeSpaceCubit, FreeSpaceState>(
    'keeps everything when the user cancels the system confirmation',
    setUp: () => when(() => repository.movePhotosToTrash(any())).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    act: (FreeSpaceCubit cubit) async {
      await cubit.load();
      await cubit.freeSpace();
    },
    skip: 2,
    expect: () => <Matcher>[isA<FreeSpaceDeleting>(), isA<FreeSpaceFailed>()],
  );

  blocTest<FreeSpaceCubit, FreeSpaceState>(
    'has nothing to free before any transfer',
    setUp: () => when(() => repository.loadSentPhotoBytes()).thenReturn(TaskEither.right(<PhotoId, int>{})),
    build: buildCubit,
    act: (FreeSpaceCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<FreeSpaceLoading>(), isA<FreeSpaceNothingToFree>()],
  );
}
