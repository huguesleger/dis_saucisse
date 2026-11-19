import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/stored_event_boundaries.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class EventBoundaryDataSource {
  TaskEither<AppFailure, StoredEventBoundaries> loadBoundaries();

  TaskEither<AppFailure, Unit> saveBoundaries(StoredEventBoundaries boundaries);
}
