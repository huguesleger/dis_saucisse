import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';

List<LibraryPhoto> photosToSort(List<LibraryPhoto> photos) =>
    photos.where((LibraryPhoto photo) => photo.origin == PhotoOrigin.camera).toList();
