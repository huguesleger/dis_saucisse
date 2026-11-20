import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_boundary_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/ignored_origins_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photos_to_sort.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockPhotoLibraryRepository extends Mock implements PhotoLibraryRepository {}

class _MockSortingStartRepository extends Mock implements SortingStartRepository {}

class _MockEventNameRepository extends Mock implements EventNameRepository {}

class _MockEventBoundaryRepository extends Mock implements EventBoundaryRepository {}

class _MockPhotoDecisionRepository extends Mock implements PhotoDecisionRepository {}

class _MockIgnoredOriginsRepository extends Mock implements IgnoredOriginsRepository {}

void main() {
  late _MockPhotoLibraryRepository photoLibraryRepository;
  late _MockSortingStartRepository sortingStartRepository;
  late _MockEventNameRepository eventNameRepository;
  late _MockEventBoundaryRepository eventBoundaryRepository;
  late _MockPhotoDecisionRepository photoDecisionRepository;
  late _MockIgnoredOriginsRepository ignoredOriginsRepository;
  final DateTime start = DateTime(2026, 8, 19);

  setUp(() {
    photoLibraryRepository = _MockPhotoLibraryRepository();
    sortingStartRepository = _MockSortingStartRepository();
    eventNameRepository = _MockEventNameRepository();
    eventBoundaryRepository = _MockEventBoundaryRepository();
    photoDecisionRepository = _MockPhotoDecisionRepository();
    ignoredOriginsRepository = _MockIgnoredOriginsRepository();
    when(() => ignoredOriginsRepository.loadIgnoredOrigins()).thenReturn(TaskEither.right(defaultIgnoredOrigins));
  });

  LoadEventLibrary buildUseCase() => LoadEventLibrary(
    photoLibraryRepository: photoLibraryRepository,
    sortingStartRepository: sortingStartRepository,
    eventNameRepository: eventNameRepository,
    eventBoundaryRepository: eventBoundaryRepository,
    photoDecisionRepository: photoDecisionRepository,
    ignoredOriginsRepository: ignoredOriginsRepository,
  );

  test('asks for a sorting start when none is saved', () async {
    when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(none()));

    final Either<AppFailure, EventLibraryLoad> result = await buildUseCase()().run();

    expect(result.getOrElse((_) => const EventLibraryAccessDenied()), isA<EventLibraryNeedsSortingStart>());
  });

  test('reports a withdrawn access', () async {
    when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(some(start)));
    when(() => photoLibraryRepository.checkAccess()).thenReturn(TaskEither.right(PhotoAccess.denied));

    final Either<AppFailure, EventLibraryLoad> result = await buildUseCase()().run();

    expect(result.getOrElse((_) => const EventLibraryNeedsSortingStart()), isA<EventLibraryAccessDenied>());
  });

  test('loads the camera photos with their names, boundaries and decisions', () async {
    when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(some(start)));
    when(() => photoLibraryRepository.checkAccess()).thenReturn(TaskEither.right(PhotoAccess.granted));
    when(() => photoLibraryRepository.loadPhotosTakenSince(start)).thenReturn(
      TaskEither.right(<LibraryPhoto>[
        ...saturdayPhotos,
        photoTakenAt('screen', DateTime(2026, 11, 7, 20), PhotoOrigin.screenshot),
      ]),
    );
    when(() => eventNameRepository.loadNames()).thenReturn(
      TaskEither.right(<EventId, String>{const EventId('cake-1'): 'Anniversaire'}),
    );
    when(() => eventBoundaryRepository.loadBoundaries()).thenReturn(TaskEither.right(const EventBoundaries.none()));
    when(() => photoDecisionRepository.loadDecisions()).thenReturn(
      TaskEither.right(<PhotoId, PhotoDecision>{const PhotoId('walk'): PhotoDecision.kept}),
    );

    final Either<AppFailure, EventLibraryLoad> result = await buildUseCase()().run();

    expect(
      result.getOrElse((_) => const EventLibraryAccessDenied()),
      isA<EventLibraryLoaded>()
          .having((EventLibraryLoaded loaded) => loaded.library.photos.length, 'photos', saturdayPhotos.length)
          .having((EventLibraryLoaded loaded) => loaded.library.events.first.name, 'name', some('Anniversaire'))
          .having((EventLibraryLoaded loaded) => loaded.library.decisions.length, 'decisions', 1),
    );
  });
}
