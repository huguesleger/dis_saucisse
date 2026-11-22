import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PhotoDecisionDataSource {
  TaskEither<AppFailure, List<PhotoDecisionRow>> loadDecisions();

  TaskEither<AppFailure, Unit> saveDecision(PhotoDecisionRow decision);

  TaskEither<AppFailure, Unit> deleteDecisions(List<String> photoIds);
}
