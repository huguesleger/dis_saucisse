import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_event.dart';
import 'package:dis_saucisse_mobile/features/photo_events/presentation/event_labels.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/widgets.dart';

class HomeEventCard extends StatelessWidget {
  const HomeEventCard({super.key, required this.event, required this.onTap});

  final PhotoEvent event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final List<LibraryPhoto> photos = event.photos;
    return DsEventPhotoCard(
      title: eventTitle(event),
      subtitle: eventSubtitle(event),
      badge: burstsToSortLabel(event),
      cover: PhotoThumbnailImage(photos.first.id, size: 720),
      thumbnails: photos
          .skip(1)
          .take(3)
          .map<ImageProvider?>((LibraryPhoto photo) => PhotoThumbnailImage(photo.id, size: 96))
          .toList(),
      extraCount: min(max(0, photos.length - 4), 99),
      onTap: onTap,
    );
  }
}
