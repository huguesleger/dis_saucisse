import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';

String qualityReviewTitle(QualityIssue issue) => switch (issue) {
  QualityIssue.duplicates => 'Doublons',
  QualityIssue.blurry => 'Photos floues',
};

String qualityReviewIntro(QualityIssue issue) => switch (issue) {
  QualityIssue.duplicates => 'Ces photos se ressemblent comme deux gouttes d’eau. La plus nette est gardée.',
  QualityIssue.blurry => 'Ces photos semblent floues. Décoche celles que tu veux garder.',
};

String qualityReviewEmpty(QualityIssue issue) => switch (issue) {
  QualityIssue.duplicates => 'Aucun doublon parmi les photos à trier.',
  QualityIssue.blurry => 'Aucune photo floue parmi les photos à trier.',
};

String photoCountLabel(int count) => count <= 1 ? '$count photo' : '$count photos';
