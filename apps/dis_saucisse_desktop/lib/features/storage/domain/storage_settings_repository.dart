import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_settings.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class StorageSettingsRepository {
  TaskEither<AppFailure, StorageSettings> loadSettings();

  TaskEither<AppFailure, Unit> saveLayout(StorageLayout layout);

  TaskEither<AppFailure, Option<String>> chooseFolder();
}
