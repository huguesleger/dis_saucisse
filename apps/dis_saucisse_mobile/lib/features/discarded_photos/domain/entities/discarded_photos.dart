import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/foundation.dart';

@immutable
final class DiscardedPhotos {
  const DiscardedPhotos({required this.onPhoneOnly, required this.alreadySent});

  final List<LibraryPhoto> onPhoneOnly;
  final List<LibraryPhoto> alreadySent;

  bool get isEmpty => onPhoneOnly.isEmpty && alreadySent.isEmpty;
}
