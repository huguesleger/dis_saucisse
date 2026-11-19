import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_item.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

extension PhotoDecisionToKind on PhotoDecision {
  PhotoDecisionKind toKind() => switch (this) {
    PhotoDecision.kept => PhotoDecisionKind.kept,
    PhotoDecision.discarded => PhotoDecisionKind.discarded,
  };
}

PhotoUpload transferItemToUpload(
  TransferItem item, {
  required PhoneId phone,
  required String fileName,
  required String sha256,
}) => PhotoUpload(
  phoneId: phone,
  photoId: item.photo.id.value,
  fileName: fileName,
  takenAt: item.photo.takenAt,
  eventDate: item.eventDate,
  eventName: item.eventName,
  decision: item.decision.toKind(),
  sha256: sha256,
);
