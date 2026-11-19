import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class EventNameRepository {
  TaskEither<AppFailure, Map<EventId, String>> loadNames();

  TaskEither<AppFailure, Unit> saveName(EventId id, Option<String> name);
}
