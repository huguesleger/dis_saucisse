import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/library_photo.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/photo_quality.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_group.dart';
import 'package:dis_saucisse_mobile/features/photo_quality/domain/entities/quality_issue.dart';
import 'package:fpdart/fpdart.dart';

const double blurrySharpnessLimit = 60;
const int duplicateFingerprintDistance = 4;
const Duration duplicateTimeWindow = Duration(minutes: 2);

bool isBlurry(PhotoQuality quality) => quality.sharpness < blurrySharpnessLimit;

int fingerprintDistance(int a, int b) {
  int difference = a ^ b;
  int distance = 0;
  while (difference != 0) {
    difference &= difference - 1;
    distance++;
  }
  return distance;
}

List<LibraryPhoto> blurryPhotos(List<LibraryPhoto> photos, Map<PhotoId, PhotoQuality> qualities) => photos
    .where((LibraryPhoto photo) => Option<PhotoQuality>.fromNullable(qualities[photo.id]).match(() => false, isBlurry))
    .toList();

List<QualityGroup> duplicateGroups(List<LibraryPhoto> photos, Map<PhotoId, PhotoQuality> qualities) {
  final List<(LibraryPhoto, PhotoQuality)> analyzed = <(LibraryPhoto, PhotoQuality)>[
    for (final LibraryPhoto photo in photos)
      if (qualities[photo.id] case final PhotoQuality quality) (photo, quality),
  ]..sort(((LibraryPhoto, PhotoQuality) a, (LibraryPhoto, PhotoQuality) b) => a.$1.takenAt.compareTo(b.$1.takenAt));
  final List<int> parent = List<int>.generate(analyzed.length, (int index) => index);
  int root(int index) => parent[index] == index ? index : parent[index] = root(parent[index]);
  for (int i = 0; i < analyzed.length; i++) {
    for (int j = i + 1; j < analyzed.length; j++) {
      if (analyzed[j].$1.takenAt.difference(analyzed[i].$1.takenAt) > duplicateTimeWindow) break;
      if (fingerprintDistance(analyzed[i].$2.fingerprint, analyzed[j].$2.fingerprint) <= duplicateFingerprintDistance) {
        parent[root(j)] = root(i);
      }
    }
  }
  final Map<int, List<(LibraryPhoto, PhotoQuality)>> groups = <int, List<(LibraryPhoto, PhotoQuality)>>{};
  for (int index = 0; index < analyzed.length; index++) {
    groups.putIfAbsent(root(index), () => <(LibraryPhoto, PhotoQuality)>[]).add(analyzed[index]);
  }
  return groups.values
      .where((List<(LibraryPhoto, PhotoQuality)> group) => group.length > 1)
      .map(
        (List<(LibraryPhoto, PhotoQuality)> group) => QualityGroup(
          photos: group.map(((LibraryPhoto, PhotoQuality) entry) => entry.$1).toList(),
          best: some(
            group
                .reduce(
                  ((LibraryPhoto, PhotoQuality) best, (LibraryPhoto, PhotoQuality) entry) =>
                      entry.$2.sharpness > best.$2.sharpness ? entry : best,
                )
                .$1,
          ),
        ),
      )
      .toList();
}

List<QualityGroup> qualityGroups(
  QualityIssue issue,
  List<LibraryPhoto> photos,
  Map<PhotoId, PhotoQuality> qualities,
) => switch (issue) {
  QualityIssue.duplicates => duplicateGroups(photos, qualities),
  QualityIssue.blurry => blurryPhotos(
    photos,
    qualities,
  ).map((LibraryPhoto photo) => QualityGroup(photos: <LibraryPhoto>[photo], best: none())).toList(),
};

int photosToReviewCount(QualityIssue issue, List<LibraryPhoto> photos, Map<PhotoId, PhotoQuality> qualities) =>
    qualityGroups(
      issue,
      photos,
      qualities,
    ).fold(0, (int total, QualityGroup group) => total + group.photosToDiscard.length);
