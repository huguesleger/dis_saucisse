import 'package:dis_saucisse_desktop/features/history/data/mappers/transfer_record_mapper.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  test('reads back a saved transfer', () {
    final TransferRecord record = TransferRecord(
      receivedAt: DateTime(2026, 11, 8, 20, 15),
      phoneName: 'iPhone de Julie',
      photoCount: 42,
      rejectedCount: 1,
      byteCount: 123456,
      eventCount: 3,
    );

    final TransferRecord restored = jsonToTransferRecord(transferRecordToJson(record)).toNullable()!;

    expect(restored.receivedAt, record.receivedAt);
    expect(restored.phoneName, 'iPhone de Julie');
    expect(restored.photoCount, 42);
    expect(restored.eventCount, 3);
  });

  test('ignores an unreadable transfer', () {
    expect(jsonToTransferRecord(<String, Object?>{'receivedAt': 'hier'}), none<TransferRecord>());
  });
}
