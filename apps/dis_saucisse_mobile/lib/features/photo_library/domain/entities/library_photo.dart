import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:flutter/foundation.dart';

@immutable
final class LibraryPhoto {
  const LibraryPhoto({required this.id, required this.takenAt, required this.origin});

  final PhotoId id;
  final DateTime takenAt;
  final PhotoOrigin origin;

  PhotoMonth get month => PhotoMonth(year: takenAt.year, month: takenAt.month);
}
