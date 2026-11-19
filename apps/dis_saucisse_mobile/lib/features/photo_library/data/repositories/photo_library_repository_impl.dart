import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/device_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_library_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/mappers/library_photo_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/mappers/photo_access_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoLibraryRepositoryImpl implements PhotoLibraryRepository {
  PhotoLibraryRepositoryImpl(this._dataSource);

  final PhotoLibraryDataSource _dataSource;

  @override
  TaskEither<AppFailure, PhotoAccess> checkAccess() =>
      _dataSource.permissionState().map((PermissionState state) => state.toPhotoAccess());

  @override
  TaskEither<AppFailure, PhotoAccess> requestAccess() =>
      _dataSource.requestPermission().map((PermissionState state) => state.toPhotoAccess());

  @override
  TaskEither<AppFailure, Unit> openAccessSettings() => _dataSource.openSettings();

  @override
  TaskEither<AppFailure, List<LibraryPhoto>> loadPhotosTakenSince(DateTime start) => _dataSource
      .loadPhotosCreatedSince(start)
      .map((List<DevicePhoto> photos) => photos.map(devicePhotoToLibraryPhoto).toList());
}
