import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/data/mappers/photo_quality_mapper.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reads back a stored analysis, even with a negative fingerprint', () {
    const PhotoQuality quality = PhotoQuality(photoId: PhotoId('asset/1'), sharpness: 123.5, fingerprint: -42);

    final PhotoQuality restored = photoQualityRowToPhotoQuality(photoQualityToRow(quality, DateTime(2026, 11, 19)));

    expect(restored.photoId, const PhotoId('asset/1'));
    expect(restored.sharpness, 123.5);
    expect(restored.fingerprint, -42);
  });
}
