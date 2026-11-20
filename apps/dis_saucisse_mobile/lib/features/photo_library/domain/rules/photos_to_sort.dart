import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';

const Set<PhotoOrigin> defaultIgnoredOrigins = <PhotoOrigin>{PhotoOrigin.screenshot, PhotoOrigin.messagingApp};

List<LibraryPhoto> photosToSort(List<LibraryPhoto> photos, {Set<PhotoOrigin> ignored = defaultIgnoredOrigins}) =>
    photos.where((LibraryPhoto photo) => !ignored.contains(photo.origin)).toList();
