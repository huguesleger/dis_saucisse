import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SortingStartDataSource {
  TaskEither<AppFailure, int?> loadStartEpochMilliseconds();

  TaskEither<AppFailure, Unit> saveStartEpochMilliseconds(int milliseconds);
}
