part of 'history_cubit.dart';

@immutable
sealed class HistoryState {
  const HistoryState();
}

final class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

final class HistoryFailed extends HistoryState {
  const HistoryFailed(this.failure);

  final AppFailure failure;
}

final class HistoryLoaded extends HistoryState {
  const HistoryLoaded({required this.records, required this.selectedYear});

  final List<TransferRecord> records;
  final int selectedYear;

  List<int> get years => historyYearsNewestFirst(records);

  List<TransferRecord> get yearRecords => recordsOfYear(records, selectedYear);

  YearStats get stats => statsOf(yearRecords);
}
