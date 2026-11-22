import 'package:dis_saucisse_mobile/app/app.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/photo_decision_repository.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/home_screen.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_boundary_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/ignored_origins_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photos_to_sort.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/sorting_start_screen.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/photo_quality_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockPhotoLibraryRepository extends Mock implements PhotoLibraryRepository {}

class _MockSortingStartRepository extends Mock implements SortingStartRepository {}

class _MockEventNameRepository extends Mock implements EventNameRepository {}

class _MockEventBoundaryRepository extends Mock implements EventBoundaryRepository {}

class _MockPhotoDecisionRepository extends Mock implements PhotoDecisionRepository {}

class _MockPhotoQualityRepository extends Mock implements PhotoQualityRepository {}

class _MockIgnoredOriginsRepository extends Mock implements IgnoredOriginsRepository {}

void main() {
  late _MockPhotoLibraryRepository photoLibraryRepository;
  late _MockSortingStartRepository sortingStartRepository;
  late _MockEventNameRepository eventNameRepository;
  late _MockEventBoundaryRepository eventBoundaryRepository;
  late _MockPhotoDecisionRepository photoDecisionRepository;

  setUp(() {
    photoLibraryRepository = _MockPhotoLibraryRepository();
    sortingStartRepository = _MockSortingStartRepository();
    eventNameRepository = _MockEventNameRepository();
    eventBoundaryRepository = _MockEventBoundaryRepository();
    photoDecisionRepository = _MockPhotoDecisionRepository();
    final _MockPhotoQualityRepository photoQualityRepository = _MockPhotoQualityRepository();
    when(() => photoQualityRepository.loadQualities()).thenReturn(
      TaskEither.right(<PhotoId, PhotoQuality>{
        for (final String id in <String>['1', '2'])
          PhotoId(id): PhotoQuality(photoId: PhotoId(id), sharpness: 500, fingerprint: id.hashCode),
      }),
    );
    final _MockIgnoredOriginsRepository ignoredOriginsRepository = _MockIgnoredOriginsRepository();
    when(() => ignoredOriginsRepository.loadIgnoredOrigins()).thenReturn(TaskEither.right(defaultIgnoredOrigins));
    getIt
      ..registerSingleton<IgnoredOriginsRepository>(ignoredOriginsRepository)
      ..registerSingleton<PhotoDecisionRepository>(photoDecisionRepository)
      ..registerSingleton<EventBoundaryRepository>(eventBoundaryRepository)
      ..registerSingleton<EventNameRepository>(eventNameRepository)
      ..registerSingleton<PhotoLibraryRepository>(photoLibraryRepository)
      ..registerSingleton<SortingStartRepository>(sortingStartRepository)
      ..registerSingleton<PhotoQualityRepository>(photoQualityRepository);
  });

  tearDown(getIt.reset);

  testWidgets('opens the sorting start screen on first launch', (WidgetTester tester) async {
    when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(none()));

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(SortingStartScreen), findsOneWidget);
  });

  testWidgets('shows the number of photos to sort', (WidgetTester tester) async {
    final DateTime start = DateTime(2026, 8, 19);
    when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(some(start)));
    when(() => photoLibraryRepository.checkAccess()).thenReturn(TaskEither.right(PhotoAccess.granted));
    when(() => photoLibraryRepository.loadPhotosTakenSince(start)).thenReturn(
      TaskEither.right(<LibraryPhoto>[
        LibraryPhoto(id: const PhotoId('1'), takenAt: DateTime(2026, 11, 8), origin: PhotoOrigin.camera),
        LibraryPhoto(id: const PhotoId('2'), takenAt: DateTime(2026, 11, 9), origin: PhotoOrigin.camera),
      ]),
    );

    when(
      () => photoDecisionRepository.loadDecisions(),
    ).thenReturn(TaskEither.right(<PhotoId, PhotoDecision>{}));
    when(() => eventBoundaryRepository.loadBoundaries()).thenReturn(TaskEither.right(const EventBoundaries.none()));
    when(() => eventNameRepository.loadNames()).thenReturn(
      TaskEither.right(<EventId, String>{const EventId('1'): 'Anniversaire de mamie'}),
    );

    await tester.pumpWidget(const App());
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('2 photos\nà trier'), findsOneWidget);
    expect(find.text('Anniversaire de mamie'), findsOneWidget);
  });
}
