import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/ignored_origins_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/mappers/photo_origin_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/ignored_origins_repository.dart';
import 'package:fpdart/fpdart.dart';

class IgnoredOriginsRepositoryImpl implements IgnoredOriginsRepository {
  IgnoredOriginsRepositoryImpl(this._dataSource);

  final IgnoredOriginsDataSource _dataSource;

  @override
  TaskEither<AppFailure, Set<PhotoOrigin>> loadIgnoredOrigins() =>
      _dataSource.loadIgnoredOriginNames().map(namesToPhotoOrigins);

  @override
  TaskEither<AppFailure, Unit> saveIgnoredOrigins(Set<PhotoOrigin> origins) =>
      _dataSource.saveIgnoredOriginNames(photoOriginsToNames(origins));
}
