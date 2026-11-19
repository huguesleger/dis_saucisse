import 'package:flutter/foundation.dart';

@immutable
final class TransferRecord {
  const TransferRecord({
    required this.receivedAt,
    required this.phoneName,
    required this.photoCount,
    required this.rejectedCount,
    required this.byteCount,
    required this.eventCount,
  });

  final DateTime receivedAt;
  final String phoneName;
  final int photoCount;
  final int rejectedCount;
  final int byteCount;
  final int eventCount;
}
