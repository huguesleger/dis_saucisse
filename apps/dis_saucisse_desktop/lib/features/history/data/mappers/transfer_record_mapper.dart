import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:fpdart/fpdart.dart';

Map<String, Object?> transferRecordToJson(TransferRecord record) => <String, Object?>{
  'receivedAt': record.receivedAt.toIso8601String(),
  'phoneName': record.phoneName,
  'photoCount': record.photoCount,
  'rejectedCount': record.rejectedCount,
  'byteCount': record.byteCount,
  'eventCount': record.eventCount,
};

Option<TransferRecord> jsonToTransferRecord(Map<String, Object?> json) => switch (json) {
  {
    'receivedAt': final String receivedAt,
    'phoneName': final String phoneName,
    'photoCount': final int photoCount,
    'rejectedCount': final int rejectedCount,
    'byteCount': final int byteCount,
    'eventCount': final int eventCount,
  } =>
    Option<DateTime>.fromNullable(DateTime.tryParse(receivedAt)).map(
      (DateTime date) => TransferRecord(
        receivedAt: date,
        phoneName: phoneName,
        photoCount: photoCount,
        rejectedCount: rejectedCount,
        byteCount: byteCount,
        eventCount: eventCount,
      ),
    ),
  _ => none(),
};
