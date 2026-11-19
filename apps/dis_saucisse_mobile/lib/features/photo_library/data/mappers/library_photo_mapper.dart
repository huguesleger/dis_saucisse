import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/device_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';

const int _iosScreenshotSubtype = 1 << 2;

LibraryPhoto devicePhotoToLibraryPhoto(DevicePhoto photo) {
  final String path = (photo.relativePath ?? '').toLowerCase();
  final bool isScreenshot = photo.mediaSubtypes & _iosScreenshotSubtype != 0 || path.contains('screenshot');
  final bool isFromMessagingApp = photo.isInMessagingAlbum || path.contains('whatsapp');
  return LibraryPhoto(
    id: PhotoId(photo.id),
    takenAt: photo.createdAt,
    origin: switch ((isScreenshot, isFromMessagingApp)) {
      (true, _) => PhotoOrigin.screenshot,
      (false, true) => PhotoOrigin.messagingApp,
      (false, false) => PhotoOrigin.camera,
    },
  );
}
