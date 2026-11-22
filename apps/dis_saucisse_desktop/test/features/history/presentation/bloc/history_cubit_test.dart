import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_repository.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/bloc/history_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockHistoryRepository extends Mock implements HistoryRepository {}

class _MockReceptionRepository extends Mock implements ReceptionRepository {}

void main() {
  late _MockHistoryRepository historyRepository;
  final TransferRecord lastYear = TransferRecord(
    receivedAt: DateTime(2025, 12, 24),
    phoneName: 'iPhone',
    photoCount: 10,
    rejectedCount: 0,
    byteCount: 1000,
    eventCount: 2,
  );

  setUp(() => historyRepository = _MockHistoryRepository());

  HistoryCubit buildCubit() => HistoryCubit(
    historyRepository: historyRepository,
    receptionRepository: _MockReceptionRepository(),
    clock: () => DateTime(2026, 11, 19),
  );

  blocTest<HistoryCubit, HistoryState>(
    'opens on the most recent year with a transfer',
    setUp: () => when(() => historyRepository.loadHistory()).thenReturn(TaskEither.right(<TransferRecord>[lastYear])),
    build: buildCubit,
    act: (HistoryCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<HistoryLoaded>()
          .having((HistoryLoaded s) => s.selectedYear, 'selectedYear', 2025)
          .having((HistoryLoaded s) => s.stats.photoCount, 'photoCount', 10),
    ],
  );

  blocTest<HistoryCubit, HistoryState>(
    'opens on the current year when nothing was received',
    setUp: () => when(() => historyRepository.loadHistory()).thenReturn(TaskEither.right(<TransferRecord>[])),
    build: buildCubit,
    act: (HistoryCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<HistoryLoaded>().having((HistoryLoaded s) => s.selectedYear, 'selectedYear', 2026)],
  );

  blocTest<HistoryCubit, HistoryState>(
    'reports an unreadable history',
    setUp: () => when(() => historyRepository.loadHistory()).thenReturn(TaskEither.left(const UnknownFailure())),
    build: buildCubit,
    act: (HistoryCubit cubit) => cubit.load(),
    expect: () => <Matcher>[
      isA<HistoryFailed>().having((HistoryFailed s) => s.failure, 'failure', const UnknownFailure()),
    ],
  );

  blocTest<HistoryCubit, HistoryState>(
    'shows the loader again when retrying after a failure',
    setUp: () => when(() => historyRepository.loadHistory()).thenReturn(TaskEither.right(<TransferRecord>[])),
    build: buildCubit,
    seed: () => const HistoryFailed(UnknownFailure()),
    act: (HistoryCubit cubit) => cubit.load(),
    expect: () => <Matcher>[isA<HistoryLoading>(), isA<HistoryLoaded>()],
  );

  blocTest<HistoryCubit, HistoryState>(
    'shows another year',
    build: buildCubit,
    seed: () => HistoryLoaded(records: <TransferRecord>[lastYear], selectedYear: 2025),
    act: (HistoryCubit cubit) => cubit.selectYear(2026),
    expect: () => <Matcher>[
      isA<HistoryLoaded>()
          .having((HistoryLoaded s) => s.selectedYear, 'selectedYear', 2026)
          .having((HistoryLoaded s) => s.yearRecords, 'yearRecords', isEmpty),
    ],
  );
}
