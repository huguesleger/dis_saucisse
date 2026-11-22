import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/photo_burst.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/photo_thumbnail_image.dart';
import 'package:flutter/material.dart';

class EventSplitOption extends StatelessWidget {
  const EventSplitOption({super.key, required this.burst, required this.onTap});

  final PhotoBurst burst;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: DsRadius.mediumAll,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: DsSpacing.xs),
      child: Row(
        spacing: DsSpacing.s,
        children: <Widget>[
          DsPhoto(image: PhotoThumbnailImage(burst.photos.first.id, size: 160), width: 56, height: 56),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  t.events.splitOption.startedAt(
                    day: frenchShortWeekdayAndDay(burst.startedAt),
                    time: frenchTime(burst.startedAt),
                  ),
                  style: DsTextStyles.bodyBold,
                ),
                Text(
                  burst.photos.length == 1
                      ? t.events.splitOption.photoSingle
                      : t.events.splitOption.photoSeveral(count: burst.photos.length),
                  style: DsTextStyles.caption,
                ),
              ],
            ),
          ),
          const Icon(Icons.call_split_rounded, color: DsColors.textSoft),
        ],
      ),
    ),
  );
}
