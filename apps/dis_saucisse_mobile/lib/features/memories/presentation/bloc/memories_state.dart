part of 'memories_cubit.dart';

@immutable
sealed class MemoriesState {
  const MemoriesState();
}

final class MemoriesLoading extends MemoriesState {
  const MemoriesLoading();
}

final class MemoriesFailed extends MemoriesState {
  const MemoriesFailed();
}

final class MemoriesLoaded extends MemoriesState {
  const MemoriesLoaded({required this.months, required this.selectedYear});

  final List<MemoryMonth> months;
  final Option<int> selectedYear;

  List<int> get years => memoryYearsNewestFirst(months);

  List<MemoryMonth> get visibleMonths => memoryMonthsOf(months, selectedYear);

  int get photoCount => months.fold(0, (int total, MemoryMonth memory) => total + memory.photoCount);
}
