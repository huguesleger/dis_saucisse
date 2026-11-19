import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:fpdart/fpdart.dart';

extension PhotoDecisionToStored on PhotoDecision {
  String toStored() => switch (this) {
    PhotoDecision.kept => 'kept',
    PhotoDecision.discarded => 'discarded',
  };
}

Option<PhotoDecision> storedToPhotoDecision(String stored) => switch (stored) {
  'kept' => some(PhotoDecision.kept),
  'discarded' => some(PhotoDecision.discarded),
  _ => none(),
};

Map<PhotoId, PhotoDecision> rowsToPhotoDecisions(List<PhotoDecisionRow> rows) => <PhotoId, PhotoDecision>{
  for (final PhotoDecisionRow row in rows)
    ...storedToPhotoDecision(row.decision).match(
      () => <PhotoId, PhotoDecision>{},
      (PhotoDecision decision) => <PhotoId, PhotoDecision>{PhotoId(row.photoId): decision},
    ),
};

PhotoDecisionRow photoDecisionToRow(PhotoId photo, PhotoDecision decision, DateTime decidedAt) =>
    PhotoDecisionRow(photoId: photo.value, decision: decision.toStored(), decidedAt: decidedAt);
