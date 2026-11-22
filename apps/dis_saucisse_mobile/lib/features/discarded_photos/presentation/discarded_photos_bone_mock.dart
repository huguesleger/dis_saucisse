import 'package:dis_saucisse_mobile/features/discarded_photos/domain/entities/discarded_photos.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/bloc/discarded_photos_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';

final DiscardedPhotosReady discardedPhotosBoneMock = DiscardedPhotosReady(
  photos: DiscardedPhotos(
    onPhoneOnly: <LibraryPhoto>[
      for (int index = 0; index < 8; index++)
        LibraryPhoto(id: PhotoId('bone-$index'), takenAt: DateTime(2026, 1, 1), origin: PhotoOrigin.camera),
    ],
    alreadySent: const <LibraryPhoto>[],
  ),
  selected: const <PhotoId>{},
);
