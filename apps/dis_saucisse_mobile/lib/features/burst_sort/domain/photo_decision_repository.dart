import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/domain/entities/photo_decision.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PhotoDecisionRepository {
  TaskEither<AppFailure, Map<PhotoId, PhotoDecision>> loadDecisions();

  TaskEither<AppFailure, Unit> saveDecision(PhotoId photo, PhotoDecision decision);
}
