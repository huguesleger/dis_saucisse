import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_origin.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IgnoredOriginsRepository {
  TaskEither<AppFailure, Set<PhotoOrigin>> loadIgnoredOrigins();

  TaskEither<AppFailure, Unit> saveIgnoredOrigins(Set<PhotoOrigin> origins);
}
