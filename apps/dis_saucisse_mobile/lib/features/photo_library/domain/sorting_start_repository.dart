import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SortingStartRepository {
  TaskEither<AppFailure, Option<DateTime>> loadStartDate();

  TaskEither<AppFailure, Unit> saveStartDate(DateTime start);
}
