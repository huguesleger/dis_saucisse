import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/sorting_start_preset.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/bloc/sorting_start_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/sorting_start_choice.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockPhotoLibraryRepository extends Mock implements PhotoLibraryRepository {}

class _MockSortingStartRepository extends Mock implements SortingStartRepository {}

void main() {
  late _MockPhotoLibraryRepository photoLibraryRepository;
  late _MockSortingStartRepository sortingStartRepository;
  final DateTime today = DateTime(2026, 11, 19, 16, 42);

  setUpAll(() => registerFallbackValue(DateTime(2000)));

  setUp(() {
    photoLibraryRepository = _MockPhotoLibraryRepository();
    sortingStartRepository = _MockSortingStartRepository();
  });

  SortingStartCubit buildCubit() => SortingStartCubit(
    photoLibraryRepository: photoLibraryRepository,
    sortingStartRepository: sortingStartRepository,
    clock: () => today,
  );

  test('proposes three months by default', () {
    final SortingStartChoice choice = buildCubit().state.choice;

    expect(
      choice,
      isA<PresetSortingStart>().having((PresetSortingStart c) => c.preset, 'preset', SortingStartPreset.threeMonths),
    );
  });

  blocTest<SortingStartCubit, SortingStartState>(
    'saves the start date once the access is granted',
    setUp: () {
      when(() => photoLibraryRepository.requestAccess()).thenReturn(TaskEither.right(PhotoAccess.granted));
      when(() => sortingStartRepository.saveStartDate(any())).thenReturn(TaskEither.right(unit));
    },
    build: buildCubit,
    act: (SortingStartCubit cubit) => cubit.confirm(),
    expect: () => <Matcher>[isA<SortingStartRequestingAccess>(), isA<SortingStartCompleted>()],
    verify: (_) => verify(() => sortingStartRepository.saveStartDate(DateTime(2026, 8, 19))).called(1),
  );

  blocTest<SortingStartCubit, SortingStartState>(
    'accepts a limited access',
    setUp: () {
      when(() => photoLibraryRepository.requestAccess()).thenReturn(TaskEither.right(PhotoAccess.limited));
      when(() => sortingStartRepository.saveStartDate(any())).thenReturn(TaskEither.right(unit));
    },
    build: buildCubit,
    act: (SortingStartCubit cubit) => cubit.confirm(),
    expect: () => <Matcher>[isA<SortingStartRequestingAccess>(), isA<SortingStartCompleted>()],
  );

  blocTest<SortingStartCubit, SortingStartState>(
    'does not save anything when the access is denied',
    setUp: () => when(() => photoLibraryRepository.requestAccess()).thenReturn(TaskEither.right(PhotoAccess.denied)),
    build: buildCubit,
    act: (SortingStartCubit cubit) => cubit.confirm(),
    expect: () => <Matcher>[isA<SortingStartRequestingAccess>(), isA<SortingStartAccessDenied>()],
    verify: (_) => verifyNever(() => sortingStartRepository.saveStartDate(any())),
  );

  blocTest<SortingStartCubit, SortingStartState>(
    'reports a failure',
    setUp: () => when(() => photoLibraryRepository.requestAccess()).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    act: (SortingStartCubit cubit) => cubit.confirm(),
    expect: () => <Matcher>[isA<SortingStartRequestingAccess>(), isA<SortingStartFailed>()],
  );

  blocTest<SortingStartCubit, SortingStartState>(
    'saves the custom date chosen by the user',
    setUp: () {
      when(() => photoLibraryRepository.requestAccess()).thenReturn(TaskEither.right(PhotoAccess.granted));
      when(() => sortingStartRepository.saveStartDate(any())).thenReturn(TaskEither.right(unit));
    },
    build: buildCubit,
    act: (SortingStartCubit cubit) async {
      cubit.choose(CustomSortingStart(DateTime(2026, 6, 1)));
      await cubit.confirm();
    },
    skip: 1,
    expect: () => <Matcher>[isA<SortingStartRequestingAccess>(), isA<SortingStartCompleted>()],
    verify: (_) => verify(() => sortingStartRepository.saveStartDate(DateTime(2026, 6, 1))).called(1),
  );
}
