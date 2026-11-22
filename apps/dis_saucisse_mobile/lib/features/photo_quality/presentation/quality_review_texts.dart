import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';

String qualityReviewTitle(QualityIssue issue) => switch (issue) {
  QualityIssue.duplicates => t.quality.title.duplicates,
  QualityIssue.blurry => t.quality.title.blurry,
};

String qualityReviewIntro(QualityIssue issue) => switch (issue) {
  QualityIssue.duplicates => t.quality.intro.duplicates,
  QualityIssue.blurry => t.quality.intro.blurry,
};

String qualityReviewEmpty(QualityIssue issue) => switch (issue) {
  QualityIssue.duplicates => t.quality.empty.duplicates,
  QualityIssue.blurry => t.quality.empty.blurry,
};

String photoCountLabel(int count) =>
    count <= 1 ? t.quality.photoCount.single(count: count) : t.quality.photoCount.several(count: count);
