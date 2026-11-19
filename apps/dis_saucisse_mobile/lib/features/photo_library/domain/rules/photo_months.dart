import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_month.dart';

List<PhotoMonth> photoMonthsNewestFirst(List<LibraryPhoto> photos) =>
    photos.map((LibraryPhoto photo) => photo.month).toSet().toList()
      ..sort((PhotoMonth a, PhotoMonth b) => b.compareTo(a));

int countPhotosIn(List<LibraryPhoto> photos, PhotoMonth month) =>
    photos.where((LibraryPhoto photo) => photo.month == month).length;
