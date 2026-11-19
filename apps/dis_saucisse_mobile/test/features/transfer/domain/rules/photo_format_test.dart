import 'package:dis_saucisse_mobile/features/transfer/domain/rules/photo_format.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  test('converts HEIC photos only for a Windows computer', () {
    expect(convertsHeicFor(ComputerPlatform.windows), isTrue);
    expect(convertsHeicFor(ComputerPlatform.macos), isFalse);
  });

  test('recognises HEIC and HEIF files whatever their case', () {
    expect(isHeic('IMG_2034.HEIC'), isTrue);
    expect(isHeic('IMG_2034.heif'), isTrue);
    expect(isHeic('IMG_2034.JPG'), isFalse);
    expect(isHeic('heic.png'), isFalse);
  });

  test('keeps the name and gives a JPEG extension', () {
    expect(jpegFileName('IMG_2034.HEIC'), 'IMG_2034.jpg');
    expect(jpegFileName('photo.heic.HEIF'), 'photo.heic.jpg');
  });
}
