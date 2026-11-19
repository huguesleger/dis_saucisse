import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ReceptionRepository {
  Stream<ReceptionEvent> get events;

  TaskEither<AppFailure, Unit> openStorageFolder();

  TaskEither<AppFailure, Unit> setPaused(bool paused);
}
