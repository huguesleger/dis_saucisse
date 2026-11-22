import 'package:dis_saucisse_mobile/core/formatting/french_dates.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_photo_status.dart';
import 'package:fpdart/fpdart.dart';

List<QualityGroup> displayedQualityGroups(QualityIssue issue, List<QualityGroup> groups) => switch (issue) {
  QualityIssue.duplicates => groups,
  QualityIssue.blurry =>
    groups.isEmpty
        ? groups
        : <QualityGroup>[
            QualityGroup(photos: groups.expand((QualityGroup group) => group.photos).toList(), best: none()),
          ],
};

String qualityGroupTitle(QualityIssue issue, QualityGroup group) => switch (issue) {
  QualityIssue.duplicates => t.quality.card.series(count: group.photos.length),
  QualityIssue.blurry =>
    group.photos.length == 1 ? t.quality.card.blurrySingle : t.quality.card.blurrySeveral(count: group.photos.length),
};

Option<String> qualityGroupSubtitle(QualityIssue issue, QualityGroup group) => switch (issue) {
  QualityIssue.duplicates => some(
    t.quality.card.takenAt(
      date: frenchWeekdayAndDay(group.photos.first.takenAt),
      time: frenchTime(group.photos.first.takenAt),
    ),
  ),
  QualityIssue.blurry => none(),
};

QualityPhotoStatus qualityPhotoStatus(QualityGroup group, LibraryPhoto photo, Set<PhotoId> toDiscard) =>
    group.best.match(() => false, (LibraryPhoto best) => best.id == photo.id)
    ? QualityPhotoStatus.best
    : (toDiscard.contains(photo.id) ? QualityPhotoStatus.toDiscard : QualityPhotoStatus.kept);
