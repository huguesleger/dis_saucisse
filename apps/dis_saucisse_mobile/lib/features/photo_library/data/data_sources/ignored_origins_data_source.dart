import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IgnoredOriginsDataSource {
  IgnoredOriginsDataSource(this._preferences);

  static const String _ignoredKey = 'photo_library.ignored_origins';

  final SharedPreferencesAsync _preferences;

  TaskEither<AppFailure, List<String>?> loadIgnoredOriginNames() =>
      TaskEither<AppFailure, List<String>?>.tryCatch(() => _preferences.getStringList(_ignoredKey), _failure);

  TaskEither<AppFailure, Unit> saveIgnoredOriginNames(List<String> names) => TaskEither<AppFailure, Unit>.tryCatch(
    () async {
      await _preferences.setStringList(_ignoredKey, names);
      return unit;
    },
    _failure,
  );

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Ignored origins storage failed', error: error, stackTrace: stackTrace, name: 'photo_library');
    return const IgnoredOriginsStorageFailure();
  }
}
