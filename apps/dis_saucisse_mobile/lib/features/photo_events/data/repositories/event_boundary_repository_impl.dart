import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/event_boundary_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/mappers/event_boundaries_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_boundary_repository.dart';
import 'package:fpdart/fpdart.dart';

class EventBoundaryRepositoryImpl implements EventBoundaryRepository {
  EventBoundaryRepositoryImpl(this._dataSource);

  final EventBoundaryDataSource _dataSource;

  @override
  TaskEither<AppFailure, EventBoundaries> loadBoundaries() => _dataSource.loadBoundaries().map(storedToEventBoundaries);

  @override
  TaskEither<AppFailure, Unit> saveBoundaries(EventBoundaries boundaries) =>
      _dataSource.saveBoundaries(eventBoundariesToStored(boundaries));
}
