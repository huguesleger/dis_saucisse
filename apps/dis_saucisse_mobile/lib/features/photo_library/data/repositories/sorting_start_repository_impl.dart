import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/sorting_start_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/sorting_start_repository.dart';
import 'package:fpdart/fpdart.dart';

class SortingStartRepositoryImpl implements SortingStartRepository {
  SortingStartRepositoryImpl(this._dataSource);

  final SortingStartDataSource _dataSource;

  @override
  TaskEither<AppFailure, Option<DateTime>> loadStartDate() => _dataSource.loadStartEpochMilliseconds().map(
    (int? milliseconds) => Option<int>.fromNullable(milliseconds).map(DateTime.fromMillisecondsSinceEpoch),
  );

  @override
  TaskEither<AppFailure, Unit> saveStartDate(DateTime start) =>
      _dataSource.saveStartEpochMilliseconds(start.millisecondsSinceEpoch);
}
