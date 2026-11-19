import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class EventNameDataSource {
  TaskEither<AppFailure, Map<String, String>> loadNames();

  TaskEither<AppFailure, Unit> saveName(String eventId, String name);

  TaskEither<AppFailure, Unit> removeName(String eventId);
}
