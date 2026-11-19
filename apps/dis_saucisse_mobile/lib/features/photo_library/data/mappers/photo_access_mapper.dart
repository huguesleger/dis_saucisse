import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_access.dart';
import 'package:photo_manager/photo_manager.dart';

extension PermissionStateToPhotoAccess on PermissionState {
  PhotoAccess toPhotoAccess() => switch (this) {
    PermissionState.authorized => PhotoAccess.granted,
    PermissionState.limited => PhotoAccess.limited,
    PermissionState.notDetermined || PermissionState.denied || PermissionState.restricted => PhotoAccess.denied,
  };
}
