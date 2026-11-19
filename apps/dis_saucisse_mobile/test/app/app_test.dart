import 'package:dis_saucisse_mobile/app/app.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/home_screen.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/sorting_start_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockPhotoLibraryRepository extends Mock implements PhotoLibraryRepository {}

class _MockSortingStartRepository extends Mock implements SortingStartRepository {}

class _MockEventNameRepository extends Mock implements EventNameRepository {}

void main() {
  late _MockPhotoLibraryRepository photoLibraryRepository;
  late _MockSortingStartRepository sortingStartRepository;
  late _MockEventNameRepository eventNameRepository;

  setUp(() {
    photoLibraryRepository = _MockPhotoLibraryRepository();
    sortingStartRepository = _MockSortingStartRepository();
    eventNameRepository = _MockEventNameRepository();
    getIt
      ..registerSingleton<EventNameRepository>(eventNameRepository)
      ..registerSingleton<PhotoLibraryRepository>(photoLibraryRepository)
      ..registerSingleton<SortingStartRepository>(sortingStartRepository);
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

    when(() => eventNameRepository.loadNames()).thenReturn(
      TaskEither.right(<EventId, String>{const EventId('1'): 'Anniversaire de mamie'}),
    );

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('2 photos\nà trier'), findsOneWidget);
    expect(find.text('Anniversaire de mamie'), findsOneWidget);
  });
}
