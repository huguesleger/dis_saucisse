import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/event_name_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/mappers/event_names_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_id.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/event_name_repository.dart';
import 'package:fpdart/fpdart.dart';

class EventNameRepositoryImpl implements EventNameRepository {
  EventNameRepositoryImpl(this._dataSource);

  final EventNameDataSource _dataSource;

  @override
  TaskEither<AppFailure, Map<EventId, String>> loadNames() => _dataSource.loadNames().map(storedNamesToEventNames);

  @override
  TaskEither<AppFailure, Unit> saveName(EventId id, Option<String> name) => name.match(
    () => _dataSource.removeName(id.value),
    (String value) => _dataSource.saveName(id.value, value),
  );
}
