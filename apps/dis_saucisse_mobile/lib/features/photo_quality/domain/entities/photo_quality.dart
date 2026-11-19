import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PhotoQuality {
  const PhotoQuality({required this.photoId, required this.sharpness, required this.fingerprint});

  final PhotoId photoId;
  final double sharpness;
  final int fingerprint;
}
