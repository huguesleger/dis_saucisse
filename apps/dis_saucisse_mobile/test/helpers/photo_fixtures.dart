import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';

LibraryPhoto photoTakenAt(String id, DateTime takenAt, [PhotoOrigin origin = PhotoOrigin.camera]) =>
    LibraryPhoto(id: PhotoId(id), takenAt: takenAt, origin: origin);

final List<LibraryPhoto> saturdayPhotos = <LibraryPhoto>[
  photoTakenAt('cake-1', DateTime(2026, 11, 7, 14, 0, 0)),
  photoTakenAt('cake-2', DateTime(2026, 11, 7, 14, 0, 3)),
  photoTakenAt('candles', DateTime(2026, 11, 7, 14, 30)),
  photoTakenAt('walk', DateTime(2026, 11, 7, 19, 0)),
];
