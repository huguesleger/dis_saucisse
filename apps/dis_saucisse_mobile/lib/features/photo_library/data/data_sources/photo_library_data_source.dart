import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/device_photo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

abstract interface class PhotoLibraryDataSource {
  TaskEither<AppFailure, PermissionState> permissionState();

  TaskEither<AppFailure, PermissionState> requestPermission();

  TaskEither<AppFailure, Unit> openSettings();

  TaskEither<AppFailure, List<DevicePhoto>> loadPhotosCreatedSince(DateTime start);
}
