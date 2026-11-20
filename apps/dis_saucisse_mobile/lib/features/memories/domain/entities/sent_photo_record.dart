import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';

@immutable
final class SentPhotoRecord {
  const SentPhotoRecord({required this.photoId, required this.sentAt, required this.byteCount});

  final PhotoId photoId;
  final DateTime sentAt;
  final int byteCount;
}
