import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/rules/photo_grouping.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
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
  final DateTime start = DateTime(2026, 8, 19);
  final List<LibraryPhoto> photos = <LibraryPhoto>[
    LibraryPhoto(id: const PhotoId('1'), takenAt: DateTime(2026, 11, 8), origin: PhotoOrigin.camera),
    LibraryPhoto(id: const PhotoId('2'), takenAt: DateTime(2026, 11, 9), origin: PhotoOrigin.screenshot),
    LibraryPhoto(id: const PhotoId('3'), takenAt: DateTime(2026, 10, 2), origin: PhotoOrigin.camera),
  ];

  setUp(() {
    photoLibraryRepository = _MockPhotoLibraryRepository();
    sortingStartRepository = _MockSortingStartRepository();
    eventNameRepository = _MockEventNameRepository();
  });

  HomeCubit buildCubit() => HomeCubit(
    photoLibraryRepository: photoLibraryRepository,
    sortingStartRepository: sortingStartRepository,
    eventNameRepository: eventNameRepository,
  );

  blocTest<HomeCubit, HomeState>(
    'asks for a sorting start when none is saved',
    setUp: () => when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(none())),
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<HomeLoading>(), isA<HomeNeedsSortingStart>()],
  );

  blocTest<HomeCubit, HomeState>(
    'loads the camera photos taken since the sorting start',
    setUp: () {
      when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(some(start)));
      when(() => photoLibraryRepository.checkAccess()).thenReturn(TaskEither.right(PhotoAccess.granted));
      when(() => photoLibraryRepository.loadPhotosTakenSince(start)).thenReturn(TaskEither.right(photos));
      when(() => eventNameRepository.loadNames()).thenReturn(
        TaskEither.right(<EventId, String>{const EventId('1'): 'Anniversaire de mamie'}),
      );
    },
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<HomeLoading>(),
      isA<HomeLoaded>()
          .having((HomeLoaded state) => state.visiblePhotoCount, 'visiblePhotoCount', 2)
          .having(
            (HomeLoaded state) => state.months,
            'months',
            const <PhotoMonth>[
              PhotoMonth(year: 2026, month: 11),
              PhotoMonth(year: 2026, month: 10),
            ],
          )
          .having(
            (HomeLoaded state) => state.events.map((PhotoEvent event) => event.name),
            'event names',
            <Option<String>>[none(), some('Anniversaire de mamie')],
          ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'shows the access denied state when the access was withdrawn',
    setUp: () {
      when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(some(start)));
      when(() => photoLibraryRepository.checkAccess()).thenReturn(TaskEither.right(PhotoAccess.denied));
    },
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<HomeLoading>(), isA<HomeAccessDenied>()],
    verify: (_) => verifyNever(() => photoLibraryRepository.loadPhotosTakenSince(any())),
  );

  blocTest<HomeCubit, HomeState>(
    'reports a failure',
    setUp: () => when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<HomeLoading>(), isA<HomeFailed>()],
  );

  blocTest<HomeCubit, HomeState>(
    'counts only the photos of the selected month',
    build: buildCubit,
    seed: () => HomeLoaded(
      photos: <LibraryPhoto>[photos[0], photos[2]],
      events: groupIntoEvents(<LibraryPhoto>[photos[0], photos[2]], <EventId, String>{}),
      selectedMonth: none(),
    ),
    act: (HomeCubit cubit) => cubit.selectMonth(some(const PhotoMonth(year: 2026, month: 10))),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having((HomeLoaded state) => state.visiblePhotoCount, 'visiblePhotoCount', 1),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'saves the new name of an event and shows it',
    setUp: () => when(
      () => eventNameRepository.saveName(const EventId('1'), some('Anniversaire de mamie')),
    ).thenReturn(TaskEither.right(unit)),
    build: buildCubit,
    seed: () => HomeLoaded(
      photos: <LibraryPhoto>[photos[0]],
      events: groupIntoEvents(<LibraryPhoto>[photos[0]], <EventId, String>{}),
      selectedMonth: none(),
    ),
    act: (HomeCubit cubit) => cubit.renameEvent(const EventId('1'), some('Anniversaire de mamie')),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having(
        (HomeLoaded state) => state.events.single.name,
        'name',
        some('Anniversaire de mamie'),
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'shows only the events of the selected month',
    build: buildCubit,
    seed: () => HomeLoaded(
      photos: <LibraryPhoto>[photos[0], photos[2]],
      events: groupIntoEvents(<LibraryPhoto>[photos[0], photos[2]], <EventId, String>{}),
      selectedMonth: none(),
    ),
    act: (HomeCubit cubit) => cubit.selectMonth(some(const PhotoMonth(year: 2026, month: 11))),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having(
        (HomeLoaded state) => state.visibleEventsByMonth.map((group) => group.month),
        'months',
        const <PhotoMonth>[PhotoMonth(year: 2026, month: 11)],
      ),
    ],
  );
}
