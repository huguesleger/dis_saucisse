import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/rules/photo_quality_rules.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../helpers/photo_fixtures.dart';

PhotoQuality _quality(String id, {double sharpness = 300, int fingerprint = 0}) =>
    PhotoQuality(photoId: PhotoId(id), sharpness: sharpness, fingerprint: fingerprint);

Map<PhotoId, PhotoQuality> _byId(List<PhotoQuality> qualities) => <PhotoId, PhotoQuality>{
  for (final PhotoQuality quality in qualities) quality.photoId: quality,
};

List<String> _ids(List<LibraryPhoto> photos) => photos.map((LibraryPhoto photo) => photo.id.value).toList();

void main() {
  final List<LibraryPhoto> photos = <LibraryPhoto>[
    photoTakenAt('original', DateTime(2026, 11, 7, 14)),
    photoTakenAt('copy', DateTime(2026, 11, 7, 14, 0, 30)),
    photoTakenAt('other', DateTime(2026, 11, 7, 14, 1)),
    photoTakenAt('later-copy', DateTime(2026, 11, 7, 18)),
    photoTakenAt('not-analyzed', DateTime(2026, 11, 7, 14, 0, 10)),
  ];

  test('counts the differing bits of two fingerprints', () {
    expect(fingerprintDistance(0, 0), 0);
    expect(fingerprintDistance(0xF0, 0x0F), 8);
    expect(fingerprintDistance(-1, 0), 64);
  });

  test('finds the blurry photos among the analyzed ones', () {
    final Map<PhotoId, PhotoQuality> qualities = _byId(<PhotoQuality>[
      _quality('original'),
      _quality('copy', sharpness: 12),
    ]);

    expect(_ids(blurryPhotos(photos, qualities)), <String>['copy']);
  });

  test('groups near identical photos taken close together and keeps the sharpest', () {
    final Map<PhotoId, PhotoQuality> qualities = _byId(<PhotoQuality>[
      _quality('original', sharpness: 200, fingerprint: 0xFF00),
      _quality('copy', sharpness: 400, fingerprint: 0xFF01),
      _quality('other', fingerprint: 0x00FF),
      _quality('later-copy', fingerprint: 0xFF00),
    ]);

    final List<QualityGroup> groups = duplicateGroups(photos, qualities);

    expect(groups.map((QualityGroup group) => _ids(group.photos)), <List<String>>[
      <String>['original', 'copy'],
    ]);
    expect(groups.single.best.map((LibraryPhoto photo) => photo.id.value), some('copy'));
    expect(_ids(groups.single.photosToDiscard), <String>['original']);
  });

  test('counts the photos to review for each issue', () {
    final Map<PhotoId, PhotoQuality> qualities = _byId(<PhotoQuality>[
      _quality('original', fingerprint: 7),
      _quality('copy', fingerprint: 7),
      _quality('other', sharpness: 3, fingerprint: 7),
    ]);

    expect(photosToReviewCount(QualityIssue.duplicates, photos, qualities), 2);
    expect(photosToReviewCount(QualityIssue.blurry, photos, qualities), 1);
  });
}
