import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_photo_status.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/presentation/quality_review_groups.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../helpers/photo_fixtures.dart';

void main() {
  final QualityGroup series = QualityGroup(photos: saturdayPhotos.sublist(0, 3), best: some(saturdayPhotos[1]));

  test('keeps one card per series of duplicates', () {
    expect(displayedQualityGroups(QualityIssue.duplicates, <QualityGroup>[series, series]), hasLength(2));
  });

  test('gathers every blurry photo in a single card', () {
    final List<QualityGroup> blurry = <QualityGroup>[
      QualityGroup(photos: <LibraryPhoto>[saturdayPhotos[0]], best: none()),
      QualityGroup(photos: <LibraryPhoto>[saturdayPhotos[3]], best: none()),
    ];

    final List<QualityGroup> displayed = displayedQualityGroups(QualityIssue.blurry, blurry);

    expect(displayed, hasLength(1));
    expect(displayed.single.photos.map((LibraryPhoto photo) => photo.id.value), <String>['cake-1', 'walk']);
  });

  test('names the cards after the issue', () {
    expect(qualityGroupTitle(QualityIssue.duplicates, series), 'Série de 3 photos');
    expect(qualityGroupTitle(QualityIssue.blurry, series), '3 photos floues');
  });

  test('tells the status of each photo of a series', () {
    final Set<PhotoId> toDiscard = <PhotoId>{saturdayPhotos[0].id};

    expect(qualityPhotoStatus(series, saturdayPhotos[1], toDiscard), QualityPhotoStatus.best);
    expect(qualityPhotoStatus(series, saturdayPhotos[0], toDiscard), QualityPhotoStatus.toDiscard);
    expect(qualityPhotoStatus(series, saturdayPhotos[2], toDiscard), QualityPhotoStatus.kept);
  });
}
