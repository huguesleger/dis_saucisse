import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';

@immutable
final class SortCursor {
  const SortCursor({required this.eventIndex, required this.burstIndex, required this.photoId});

  final int eventIndex;
  final int burstIndex;
  final PhotoId photoId;
}
