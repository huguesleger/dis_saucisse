import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/bloc/home_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/month_events.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_boundary_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/photo_fixtures.dart';

class _MockLoadEventLibrary extends Mock implements LoadEventLibrary {}

class _MockPhotoLibraryRepository extends Mock implements PhotoLibraryRepository {}

class _MockEventNameRepository extends Mock implements EventNameRepository {}

class _MockEventBoundaryRepository extends Mock implements EventBoundaryRepository {}

final List<LibraryPhoto> _photos = <LibraryPhoto>[
  ...saturdayPhotos,
  photoTakenAt('october', DateTime(2026, 10, 2, 10)),
];

EventLibrary _library({
  Map<EventId, String> names = const <EventId, String>{},
  Map<PhotoId, PhotoDecision> decisions = const <PhotoId, PhotoDecision>{},
}) => EventLibrary(photos: _photos, names: names, boundaries: const EventBoundaries.none(), decisions: decisions);

HomeLoaded _loaded([EventLibrary? library]) => HomeLoaded(library: library ?? _library(), selectedMonth: none());

List<List<String>> _eventPhotoIds(HomeLoaded state) =>
    state.events.map((PhotoEvent event) => event.photos.map((LibraryPhoto photo) => photo.id.value).toList()).toList();

void main() {
  late _MockLoadEventLibrary loadEventLibrary;
  late _MockPhotoLibraryRepository photoLibraryRepository;
  late _MockEventNameRepository eventNameRepository;
  late _MockEventBoundaryRepository eventBoundaryRepository;

  setUpAll(() => registerFallbackValue(const EventBoundaries.none()));

  setUp(() {
    loadEventLibrary = _MockLoadEventLibrary();
    photoLibraryRepository = _MockPhotoLibraryRepository();
    eventNameRepository = _MockEventNameRepository();
    eventBoundaryRepository = _MockEventBoundaryRepository();
  });

  HomeCubit buildCubit() => HomeCubit(
    minimalLoading: Duration.zero,
    loadEventLibrary: loadEventLibrary,
    photoLibraryRepository: photoLibraryRepository,
    eventNameRepository: eventNameRepository,
    eventBoundaryRepository: eventBoundaryRepository,
  );

  blocTest<HomeCubit, HomeState>(
    'asks for a sorting start when none is saved',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.right(const EventLibraryNeedsSortingStart())),
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<HomeLoading>(), isA<HomeNeedsSortingStart>()],
  );

  blocTest<HomeCubit, HomeState>(
    'shows the access denied state',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.right(const EventLibraryAccessDenied())),
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<HomeLoading>(), isA<HomeAccessDenied>()],
  );

  blocTest<HomeCubit, HomeState>(
    'reports a failure',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<HomeLoading>(),
      isA<HomeFailed>().having((HomeFailed s) => s.failure, 'failure', const UnknownFailure()),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'counts only the photos and events left to sort',
    setUp: () => when(() => loadEventLibrary()).thenReturn(
      TaskEither.right(
        EventLibraryLoaded(
          _library(
            decisions: <PhotoId, PhotoDecision>{
              const PhotoId('october'): PhotoDecision.kept,
              const PhotoId('walk'): PhotoDecision.discarded,
            },
          ),
        ),
      ),
    ),
    build: buildCubit,
    act: (HomeCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<HomeLoading>(),
      isA<HomeLoaded>()
          .having((HomeLoaded state) => state.visiblePhotoCount, 'visiblePhotoCount', 3)
          .having((HomeLoaded state) => state.months, 'months', const <PhotoMonth>[PhotoMonth(year: 2026, month: 11)])
          .having(
            (HomeLoaded state) =>
                state.visibleEventsByMonth.expand((MonthEvents group) => group.events).map((e) => e.id),
            'events to sort',
            const <EventId>[EventId('cake-1')],
          ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'refreshes without a loading screen and keeps the selected month',
    setUp: () => when(() => loadEventLibrary()).thenReturn(TaskEither.right(EventLibraryLoaded(_library()))),
    build: buildCubit,
    seed: () => _loaded().copyWith(selectedMonth: some(const PhotoMonth(year: 2026, month: 10))),
    act: (HomeCubit cubit) => cubit.refresh(),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having(
        (HomeLoaded state) => state.selectedMonth,
        'selectedMonth',
        some(const PhotoMonth(year: 2026, month: 10)),
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'counts and shows only the selected month',
    build: buildCubit,
    seed: _loaded,
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
      () => eventNameRepository.saveName(const EventId('cake-1'), some('Anniversaire de mamie')),
    ).thenReturn(TaskEither.right(unit)),
    build: buildCubit,
    seed: _loaded,
    act: (HomeCubit cubit) => cubit.renameEvent(const EventId('cake-1'), some('Anniversaire de mamie')),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having(
        (HomeLoaded state) => state.events.firstWhere((PhotoEvent e) => e.id == const EventId('cake-1')).name,
        'name',
        some('Anniversaire de mamie'),
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'merges an event into the previous one and saves the boundary',
    setUp: () => when(() => eventBoundaryRepository.saveBoundaries(any())).thenReturn(TaskEither.right(unit)),
    build: buildCubit,
    seed: _loaded,
    act: (HomeCubit cubit) => cubit.mergeWithPreviousEvent((cubit.state as HomeLoaded).events.last),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having(_eventPhotoIds, 'events', <List<String>>[
        <String>['october'],
        <String>['cake-1', 'cake-2', 'candles', 'walk'],
      ]),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'splits an event before the chosen burst',
    setUp: () => when(() => eventBoundaryRepository.saveBoundaries(any())).thenReturn(TaskEither.right(unit)),
    build: buildCubit,
    seed: _loaded,
    act: (HomeCubit cubit) => cubit.splitEventBefore((cubit.state as HomeLoaded).events[1].bursts.last),
    expect: () => <Matcher>[
      isA<HomeLoaded>().having(_eventPhotoIds, 'events', <List<String>>[
        <String>['october'],
        <String>['cake-1', 'cake-2'],
        <String>['candles'],
        <String>['walk'],
      ]),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'keeps the events unchanged when the boundary cannot be saved',
    setUp: () =>
        when(() => eventBoundaryRepository.saveBoundaries(any())).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    seed: _loaded,
    act: (HomeCubit cubit) => cubit.mergeWithPreviousEvent((cubit.state as HomeLoaded).events.last),
    expect: () => <Matcher>[],
  );
}
