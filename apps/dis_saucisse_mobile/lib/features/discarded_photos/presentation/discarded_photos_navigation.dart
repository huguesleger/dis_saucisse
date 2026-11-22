import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/bloc/discarded_photos_cubit.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_viewer.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter/material.dart';

Future<void> openDiscardedPhoto(
  BuildContext context, {
  required DiscardedPhotosCubit cubit,
  required List<LibraryPhoto> photos,
  required int index,
  required bool canRestore,
}) async {
  final PhotoId? photo = await Navigator.of(context, rootNavigator: true).push<PhotoId>(
    MaterialPageRoute<PhotoId>(
      fullscreenDialog: true,
      builder: (BuildContext context) =>
          DiscardedPhotoViewer(photos: photos, initialIndex: index, canRestore: canRestore),
    ),
  );
  if (photo != null) await cubit.restore(<PhotoId>{photo});
}
