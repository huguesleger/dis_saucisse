import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:flutter/foundation.dart';

@immutable
final class MemoryMonth {
  const MemoryMonth({
    required this.month,
    required this.photoCount,
    required this.eventCount,
    required this.byteCount,
    required this.lastSentAt,
    required this.photosOnPhone,
  });

  final PhotoMonth month;
  final int photoCount;
  final int eventCount;
  final int byteCount;
  final DateTime lastSentAt;
  final List<PhotoId> photosOnPhone;
}
