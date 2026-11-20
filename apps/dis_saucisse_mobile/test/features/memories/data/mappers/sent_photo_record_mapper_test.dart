import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/memories/data/mappers/sent_photo_record_mapper.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/sent_photo_record.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps a transfer row to a sent photo record', () {
    final SentPhotoRecord record = photoTransferRowToSentPhotoRecord(
      PhotoTransferRow(photoId: 'cake-1', computerId: 'mac', sentAt: DateTime(2026, 11, 8), byteCount: 3000),
    );

    expect(record.photoId, const PhotoId('cake-1'));
    expect(record.sentAt, DateTime(2026, 11, 8));
    expect(record.byteCount, 3000);
  });
}
