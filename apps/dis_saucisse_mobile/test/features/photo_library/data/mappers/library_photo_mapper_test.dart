import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/device_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/mappers/library_photo_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:flutter_test/flutter_test.dart';

DevicePhoto _photo({int mediaSubtypes = 0, String? relativePath, bool isInMessagingAlbum = false}) => DevicePhoto(
  id: 'asset-1',
  createdAt: DateTime(2026, 11, 8, 14, 30),
  mediaSubtypes: mediaSubtypes,
  relativePath: relativePath,
  isInMessagingAlbum: isInMessagingAlbum,
);

void main() {
  test('keeps the id and the date', () {
    final photo = devicePhotoToLibraryPhoto(_photo(relativePath: 'DCIM/Camera/'));

    expect(photo.id, const PhotoId('asset-1'));
    expect(photo.takenAt, DateTime(2026, 11, 8, 14, 30));
    expect(photo.origin, PhotoOrigin.camera);
  });

  test('detects an iOS screenshot from its media subtype', () {
    expect(devicePhotoToLibraryPhoto(_photo(mediaSubtypes: 4)).origin, PhotoOrigin.screenshot);
  });

  test('detects an Android screenshot from its folder', () {
    expect(devicePhotoToLibraryPhoto(_photo(relativePath: 'Pictures/Screenshots/')).origin, PhotoOrigin.screenshot);
  });

  test('detects a WhatsApp image from its Android folder', () {
    expect(
      devicePhotoToLibraryPhoto(_photo(relativePath: 'Android/media/com.whatsapp/WhatsApp/Media/')).origin,
      PhotoOrigin.messagingApp,
    );
  });

  test('detects a WhatsApp image from its iOS album', () {
    expect(devicePhotoToLibraryPhoto(_photo(isInMessagingAlbum: true)).origin, PhotoOrigin.messagingApp);
  });

  test('a screenshot saved by WhatsApp stays a screenshot', () {
    expect(
      devicePhotoToLibraryPhoto(_photo(mediaSubtypes: 4, isInMessagingAlbum: true)).origin,
      PhotoOrigin.screenshot,
    );
  });
}
