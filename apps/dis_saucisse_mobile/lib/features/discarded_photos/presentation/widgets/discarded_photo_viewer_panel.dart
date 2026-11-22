import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_badge.dart';
import 'package:dis_saucisse_mobile/features/discarded_photos/presentation/widgets/discarded_photo_details.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:flutter/material.dart';

class DiscardedPhotoViewerPanel extends StatelessWidget {
  const DiscardedPhotoViewerPanel({super.key, required this.photo, required this.canRestore, required this.onRestore});

  final LibraryPhoto photo;
  final bool canRestore;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(DsSpacing.l, 0, DsSpacing.l, DsSpacing.m),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: DsSpacing.m,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: DsSpacing.s,
          children: <Widget>[
            Expanded(
              child: Text(
                frenchWeekdayAndDay(photo.takenAt),
                style: DsTextStyles.display.copyWith(color: DsColors.background),
              ),
            ),
            if (!canRestore)
              const Padding(
                padding: EdgeInsets.only(bottom: DsSpacing.xxs),
                child: DiscardedPhotoBadge(),
              ),
          ],
        ),
        DsGlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: DsSpacing.m,
            children: <Widget>[
              DiscardedPhotoDetails(photo: photo),
              Text(
                canRestore ? t.discarded.viewer.message.restorable : t.discarded.viewer.message.alreadySent,
                style: DsTextStyles.body.copyWith(color: DsColors.textSoft),
              ),
              if (canRestore)
                DsButton(label: t.discarded.viewer.restore, variant: DsButtonVariant.dark, onPressed: onRestore),
            ],
          ),
        ),
      ],
    ),
  );
}
