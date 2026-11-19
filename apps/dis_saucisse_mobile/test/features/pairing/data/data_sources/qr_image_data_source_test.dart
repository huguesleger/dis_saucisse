import 'dart:io';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/qr_image_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image/image.dart' as img;
import 'package:zxing2/qrcode.dart';
import 'package:zxing2/src/qrcode/encoder/byte_matrix.dart';

Future<String> _writeQrImage(Directory directory, String content) async {
  final ByteMatrix matrix = Encoder.encode(content, ErrorCorrectionLevel.m).matrix!;
  const int scale = 8;
  const int margin = 4 * scale;
  final img.Image image = img.Image(
    width: matrix.width * scale + 2 * margin,
    height: matrix.height * scale + 2 * margin,
  )..clear(img.ColorRgb8(255, 255, 255));
  for (int y = 0; y < matrix.height; y++) {
    for (int x = 0; x < matrix.width; x++) {
      if (matrix.get(x, y) == 1) {
        img.fillRect(
          image,
          x1: margin + x * scale,
          y1: margin + y * scale,
          x2: margin + (x + 1) * scale - 1,
          y2: margin + (y + 1) * scale - 1,
          color: img.ColorRgb8(0, 0, 0),
        );
      }
    }
  }
  final File file = File('${directory.path}/qr.png');
  await file.writeAsBytes(img.encodePng(image));
  return file.path;
}

void main() {
  late Directory directory;

  setUp(() async => directory = await Directory.systemTemp.createTemp('qr_image_test'));

  tearDown(() => directory.delete(recursive: true));

  test('reads the text of a QR code in an image', () async {
    final String path = await _writeQrImage(directory, '{"app":"dis-saucisse","v":1}');

    final Either<AppFailure, Option<String>> result = await QrImageDataSource().readQrCode(path).run();

    expect(result, right<AppFailure, Option<String>>(some('{"app":"dis-saucisse","v":1}')));
  });

  test('finds nothing in an image without QR code', () async {
    final File file = File('${directory.path}/blank.png');
    await file.writeAsBytes(img.encodePng(img.Image(width: 200, height: 200)..clear(img.ColorRgb8(255, 255, 255))));

    final Either<AppFailure, Option<String>> result = await QrImageDataSource().readQrCode(file.path).run();

    expect(result, right<AppFailure, Option<String>>(none()));
  });
}
