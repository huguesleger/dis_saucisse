import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class EventBoundaryRepository {
  TaskEither<AppFailure, EventBoundaries> loadBoundaries();

  TaskEither<AppFailure, Unit> saveBoundaries(EventBoundaries boundaries);
}
