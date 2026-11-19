import 'package:dis_saucisse_mobile/features/photo_quality/data/data_sources/thumbnail_analysis.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/rules/photo_quality_rules.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

img.Image _checkerboard({int size = 128, int square = 8}) {
  final img.Image image = img.Image(width: size, height: size);
  for (final img.Pixel pixel in image) {
    final bool light = ((pixel.x ~/ square) + (pixel.y ~/ square)).isEven;
    pixel.setRgb(light ? 255 : 0, light ? 255 : 0, light ? 255 : 0);
  }
  return image;
}

img.Image _gradient({bool reversed = false}) {
  final img.Image image = img.Image(width: 128, height: 128);
  for (final img.Pixel pixel in image) {
    final int value = reversed ? 255 - pixel.x * 2 : pixel.x * 2;
    pixel.setRgb(value, value, value);
  }
  return image;
}

Uint8List _jpeg(img.Image image) => img.encodeJpg(image, quality: 95);

void main() {
  test('finds a sharp photo sharper than its blurred copy', () {
    final double sharp = analyzeThumbnail(_jpeg(_checkerboard())).sharpness;
    final double blurred = analyzeThumbnail(_jpeg(img.gaussianBlur(_checkerboard(), radius: 6))).sharpness;

    expect(sharp, greaterThan(blurrySharpnessLimit));
    expect(blurred, lessThan(blurrySharpnessLimit));
  });

  test('gives close fingerprints to the same photo and far ones to different photos', () {
    final int original = analyzeThumbnail(_jpeg(_gradient())).fingerprint;
    final int resaved = analyzeThumbnail(img.encodeJpg(_gradient(), quality: 60)).fingerprint;
    final int mirrored = analyzeThumbnail(_jpeg(_gradient(reversed: true))).fingerprint;

    expect(fingerprintDistance(original, resaved), lessThanOrEqualTo(duplicateFingerprintDistance));
    expect(fingerprintDistance(original, mirrored), greaterThan(duplicateFingerprintDistance));
  });

  test('refuses bytes that are not an image', () {
    expect(
      () => analyzeThumbnail(Uint8List.fromList(<int>[1, 2, 3])),
      throwsA(isA<UnreadableThumbnailException>()),
    );
  });
}
