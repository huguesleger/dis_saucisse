import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
final class QualityGroup {
  const QualityGroup({required this.photos, required this.best});

  final List<LibraryPhoto> photos;
  final Option<LibraryPhoto> best;

  List<LibraryPhoto> get photosToDiscard =>
      photos.where((LibraryPhoto photo) => best.match(() => true, (LibraryPhoto kept) => kept.id != photo.id)).toList();
}
