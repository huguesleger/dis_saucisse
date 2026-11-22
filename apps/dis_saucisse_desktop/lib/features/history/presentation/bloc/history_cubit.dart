import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/config/setup_get_it.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/year_stats.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_repository.dart';
import 'package:dis_saucisse_desktop/features/history/domain/rules/history_stats.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_repository.dart';
import 'package:flutter/foundation.dart';

part 'history_state.dart';

class HistoryCubit extends SafeCubit<HistoryState> {
  HistoryCubit({
    HistoryRepository? historyRepository,
    ReceptionRepository? receptionRepository,
    DateTime Function()? clock,
    Duration? minimalLoading,
  }) : _historyRepository = historyRepository ?? getIt.get<HistoryRepository>(),
       _receptionRepository = receptionRepository ?? getIt.get<ReceptionRepository>(),
       _clock = clock ?? DateTime.now,
       _minimalLoading = minimalLoading ?? DsSkeletonizer.minDuration,
       super(const HistoryLoading());

  final HistoryRepository _historyRepository;
  final ReceptionRepository _receptionRepository;
  final DateTime Function() _clock;
  final Duration _minimalLoading;

  Future<void> load() {
    if (state is HistoryFailed) emit(const HistoryLoading());
    return _historyRepository
        .loadHistory()
        .withMinimalDelay(_minimalLoading)
        .match(
          HistoryFailed.new,
          (List<TransferRecord> records) => HistoryLoaded(
            records: records,
            selectedYear: historyYearsNewestFirst(records).firstOrNull ?? _clock().year,
          ),
        )
        .map(emit)
        .run();
  }

  void selectYear(int year) => switch (state) {
    HistoryLoaded(:final List<TransferRecord> records) => emit(HistoryLoaded(records: records, selectedYear: year)),
    HistoryLoading() || HistoryFailed() => null,
  };

  Future<void> openStorageFolder() => _receptionRepository.openStorageFolder().run();
}
