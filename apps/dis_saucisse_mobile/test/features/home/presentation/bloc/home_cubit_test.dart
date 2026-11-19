import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/month_events.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_boundary_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
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

class _MockEventBoundaryRepository extends Mock implements EventBoundaryRepository {}

LibraryPhoto _photo(String id, DateTime takenAt, [PhotoOrigin origin = PhotoOrigin.camera]) =>
    LibraryPhoto(id: PhotoId(id), takenAt: takenAt, origin: origin);

HomeLoaded _loaded(List<LibraryPhoto> photos, {EventBoundaries boundaries = const EventBoundaries.none()}) =>
    HomeLoaded(photos: photos, eventNames: <EventId, String>{}, eventBoundaries: boundaries, selectedMonth: none());

List<List<String>> _eventPhotoIds(HomeLoaded state) =>
    state.events.map((PhotoEvent event) => event.photos.map((LibraryPhoto photo) => photo.id.value).toList()).toList();

void main() {
  late _MockPhotoLibraryRepository photoLibraryRepository;
  late _MockSortingStartRepository sortingStartRepository;
  late _MockEventNameRepository eventNameRepository;
  late _MockEventBoundaryRepository eventBoundaryRepository;
  final DateTime start = DateTime(2026, 8, 19);
  final List<LibraryPhoto> photos = <LibraryPhoto>[
    _photo('1', DateTime(2026, 11, 8)),
    _photo('2', DateTime(2026, 11, 9), PhotoOrigin.screenshot),
    _photo('3', DateTime(2026, 10, 2)),
  ];
  final List<LibraryPhoto> afternoon = <LibraryPhoto>[
    _photo('cake', DateTime(2026, 11, 7, 14, 0)),
    _photo('candles', DateTime(2026, 11, 7, 14, 30)),
    _photo('walk', DateTime(2026, 11, 7, 19, 0)),
  ];

  setUpAll(() => registerFallbackValue(const EventBoundaries.none()));

  setUp(() {
    photoLibraryRepository = _MockPhotoLibraryRepository();
    sortingStartRepository = _MockSortingStartRepository();
    eventNameRepository = _MockEventNameRepository();
    eventBoundaryRepository = _MockEventBoundaryRepository();
  });

  HomeCubit buildCubit() => HomeCubit(
    photoLibraryRepository: photoLibraryRepository,
    sortingStartRepository: sortingStartRepository,
    eventNameRepository: eventNameRepository,
    eventBoundaryRepository: eventBoundaryRepository,
  );

  blocTest<HomeCubit, HomeState>(
    'asks for a sorting start when none is saved',
    setUp: () => when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(none())),
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<HomeLoading>(), isA<HomeNeedsSortingStart>()],
  );

  blocTest<HomeCubit, HomeState>(
    'loads the camera photos and their named events',
    setUp: () {
      when(() => sortingStartRepository.loadStartDate()).thenReturn(TaskEither.right(some(start)));
      when(() => photoLibraryRepository.checkAccess()).thenReturn(TaskEither.right(PhotoAccess.granted));
      when(() => photoLibraryRepository.loadPhotosTakenSince(start)).thenReturn(TaskEither.right(photos));
      when(() => eventNameRepository.loadNames()).thenReturn(
        TaskEither.right(<EventId, String>{const EventId('1'): 'Anniversaire de mamie'}),
      );
      when(() => eventBoundaryRepository.loadBoundaries()).thenReturn(TaskEither.right(const EventBoundaries.none()));
    },
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<HomeLoading>(),
      isA<HomeLoaded>()
          .having((HomeLoaded state) => state.visiblePhotoCount, 'visiblePhotoCount', 2)
          .having((HomeLoaded state) => state.months, 'months', const <PhotoMonth>[
            PhotoMonth(year: 2026, month: 11),
            PhotoMonth(year: 2026, month: 10),
          ])
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
    'counts and shows only the selected month',
    build: buildCubit,
    seed: () => _loaded(<LibraryPhoto>[photos[0], photos[2]]),
    act: (HomeCubit cubit) => cubit.selectMonth(some(const PhotoMonth(year: 2026, month: 10))),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having((HomeLoaded state) => state.visiblePhotoCount, 'visiblePhotoCount', 1).having(
        (HomeLoaded state) => state.visibleEventsByMonth.map((MonthEvents group) => group.month),
        'months',
        const <PhotoMonth>[PhotoMonth(year: 2026, month: 10)],
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'saves the new name of an event and shows it',
    setUp: () => when(
      () => eventNameRepository.saveName(const EventId('1'), some('Anniversaire de mamie')),
    ).thenReturn(TaskEither.right(unit)),
    build: buildCubit,
    seed: () => _loaded(<LibraryPhoto>[photos[0]]),
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
    'merges an event into the previous one and saves the boundary',
    setUp: () => when(() => eventBoundaryRepository.saveBoundaries(any())).thenReturn(TaskEither.right(unit)),
    build: buildCubit,
    seed: () => _loaded(afternoon),
    act: (HomeCubit cubit) => cubit.mergeWithPreviousEvent((cubit.state as HomeLoaded).events.last),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having(_eventPhotoIds, 'events', <List<String>>[
        <String>['cake', 'candles', 'walk'],
      ]),
    ],
    verify: (_) => verify(
      () => eventBoundaryRepository.saveBoundaries(
        any(
          that: isA<EventBoundaries>().having(
            (EventBoundaries b) => b.joinedAt,
            'joinedAt',
            <PhotoId>{const PhotoId('walk')},
          ),
        ),
      ),
    ).called(1),
  );

  blocTest<HomeCubit, HomeState>(
    'splits an event before the chosen burst',
    setUp: () => when(() => eventBoundaryRepository.saveBoundaries(any())).thenReturn(TaskEither.right(unit)),
    build: buildCubit,
    seed: () => _loaded(afternoon.take(2).toList()),
    act: (HomeCubit cubit) => cubit.splitEventBefore((cubit.state as HomeLoaded).events.single.bursts.last),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having(_eventPhotoIds, 'events', <List<String>>[
        <String>['cake'],
        <String>['candles'],
      ]),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'keeps the events unchanged when the boundary cannot be saved',
    setUp: () =>
        when(() => eventBoundaryRepository.saveBoundaries(any())).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    seed: () => _loaded(afternoon),
    act: (HomeCubit cubit) => cubit.mergeWithPreviousEvent((cubit.state as HomeLoaded).events.last),
    expect: () => <Matcher>[],
    verify: (HomeCubit cubit) => expect(_eventPhotoIds(cubit.state as HomeLoaded), <List<String>>[
      <String>['cake', 'candles'],
      <String>['walk'],
    ]),
  );
}
