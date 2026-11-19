import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/foundation.dart';

@immutable
final class PhotoBurst {
  const PhotoBurst({required this.photos});

  final List<LibraryPhoto> photos;

  DateTime get startedAt => photos.first.takenAt;
}
