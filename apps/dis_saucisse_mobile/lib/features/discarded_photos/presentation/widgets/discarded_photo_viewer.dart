import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/presentation/widgets/photo_viewer/photo_viewer.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_viewer_panel.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoViewer extends StatelessWidget {
  const DiscardedPhotoViewer({super.key, required this.photos, required this.initialIndex, required this.canRestore});

  final List<LibraryPhoto> photos;
  final int initialIndex;
  final bool canRestore;

  @override
  Widget build(BuildContext context) => PhotoViewer(
    photos: photos.map((LibraryPhoto photo) => photo.id).toList(),
    initialIndex: initialIndex,
    title: t.discarded.viewer.title,
    panelBuilder: (BuildContext context, int index) => DiscardedPhotoViewerPanel(
      photo: photos[index],
      canRestore: canRestore,
      onRestore: () => Navigator.of(context).pop(photos[index].id),
    ),
  );
}
