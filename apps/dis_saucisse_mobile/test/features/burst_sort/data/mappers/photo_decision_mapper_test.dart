import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/data/mappers/photo_decision_mapper.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DateTime decidedAt = DateTime(2026, 11, 19, 17, 30);

  test('round-trips a decision through its row', () {
    final PhotoDecisionRow row = photoDecisionToRow(const PhotoId('cake-1'), PhotoDecision.discarded, decidedAt);

    expect(row.decision, 'discarded');
    expect(rowsToPhotoDecisions(<PhotoDecisionRow>[row]), <PhotoId, PhotoDecision>{
      const PhotoId('cake-1'): PhotoDecision.discarded,
    });
  });

  test('ignores an unknown stored decision', () {
    expect(
      rowsToPhotoDecisions(<PhotoDecisionRow>[PhotoDecisionRow(photoId: 'x', decision: 'maybe', decidedAt: decidedAt)]),
      isEmpty,
    );
  });
}
