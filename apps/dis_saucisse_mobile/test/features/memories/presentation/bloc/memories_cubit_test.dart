import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/memory_month.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/sent_photo_record.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/memories_failure.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/memories_repository.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/bloc/memories_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockMemoriesRepository extends Mock implements MemoriesRepository {}

class _MockLoadEventLibrary extends Mock implements LoadEventLibrary {}

void main() {
  late _MockMemoriesRepository repository;
  late _MockLoadEventLibrary loadEventLibrary;
  final EventLibrary library = EventLibrary(
    photos: <LibraryPhoto>[...saturdayPhotos, photoTakenAt('october', DateTime(2025, 10, 4, 10))],
    names: const <EventId, String>{},
    boundaries: const EventBoundaries.none(),
    decisions: const <PhotoId, PhotoDecision>{},
  );
  final List<SentPhotoRecord> sent = <SentPhotoRecord>[
    SentPhotoRecord(photoId: const PhotoId('cake-1'), sentAt: DateTime(2026, 11, 8), byteCount: 3000),
    SentPhotoRecord(photoId: const PhotoId('october'), sentAt: DateTime(2026, 11, 8), byteCount: 1000),
  ];

  setUp(() {
    repository = _MockMemoriesRepository();
    loadEventLibrary = _MockLoadEventLibrary();
    when(() => loadEventLibrary()).thenReturn(TaskEither.right(EventLibraryLoaded(library)));
    when(() => repository.loadSentPhotos()).thenReturn(TaskEither.right(sent));
  });

  MemoriesCubit buildCubit() => MemoriesCubit(memoriesRepository: repository, loadEventLibrary: loadEventLibrary);

  blocTest<MemoriesCubit, MemoriesState>(
    'loads the months sent to the computer and filters them by year',
    build: buildCubit,
    act: (MemoriesCubit cubit) async {
      await cubit.load();
      cubit.selectYear(some(2025));
    },
    expect: () => <Matcher>[
      isA<MemoriesLoaded>()
          .having((MemoriesLoaded s) => s.years, 'years', <int>[2026, 2025])
          .having((MemoriesLoaded s) => s.photoCount, 'photo count', 2)
          .having((MemoriesLoaded s) => s.visibleMonths.length, 'visible months', 2),
      isA<MemoriesLoaded>().having((MemoriesLoaded s) => s.visibleMonths.single.month.year, 'year', 2025),
    ],
  );

  blocTest<MemoriesCubit, MemoriesState>(
    'keeps the selected year when it reloads',
    build: buildCubit,
    seed: () => const MemoriesLoaded(months: <MemoryMonth>[], selectedYear: Some<int>(2025)),
    act: (MemoriesCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<MemoriesLoaded>().having((MemoriesLoaded s) => s.selectedYear, 'year', some(2025)),
    ],
  );

  blocTest<MemoriesCubit, MemoriesState>(
    'shows the sent months without thumbnails when the photos cannot be read',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.right(const EventLibraryAccessDenied())),
    build: buildCubit,
    act: (MemoriesCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<MemoriesLoaded>().having(
        (MemoriesLoaded s) => s.months.single.photosOnPhone,
        'photos on phone',
        isEmpty,
      ),
    ],
  );

  blocTest<MemoriesCubit, MemoriesState>(
    'fails when the sent photos cannot be read',
    setUp: () => when(
      () => repository.loadSentPhotos(),
    ).thenReturn(TaskEither<AppFailure, List<SentPhotoRecord>>.left(const SentPhotoHistoryFailure())),
    build: buildCubit,
    act: (MemoriesCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<MemoriesFailed>().having((MemoriesFailed s) => s.failure, 'failure', const SentPhotoHistoryFailure()),
    ],
  );
}
