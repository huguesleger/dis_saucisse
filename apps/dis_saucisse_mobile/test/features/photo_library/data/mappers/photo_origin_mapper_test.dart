import 'package:dis_saucisse_mobile/features/photo_library/data/mappers/photo_origin_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/rules/photos_to_sort.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ignores screenshots and messaging images until the user chooses', () {
    expect(namesToPhotoOrigins(null), defaultIgnoredOrigins);
  });

  test('round-trips the ignored origins through their stored names', () {
    const Set<PhotoOrigin> origins = <PhotoOrigin>{PhotoOrigin.screenshot};

    expect(photoOriginsToNames(origins), <String>['screenshot']);
    expect(namesToPhotoOrigins(photoOriginsToNames(origins)), origins);
    expect(namesToPhotoOrigins(<String>[]), isEmpty);
    expect(namesToPhotoOrigins(<String>['unknown', 'messagingApp']), <PhotoOrigin>{PhotoOrigin.messagingApp});
  });
}
