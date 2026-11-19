import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_library/data/data_sources/sorting_start_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/photo_library_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSortingStartDataSource implements SortingStartDataSource {
  SharedPreferencesSortingStartDataSource(this._preferences);

  static const String _startKey = 'photo_library.sorting_start';

  final SharedPreferencesAsync _preferences;

  @override
  TaskEither<AppFailure, int?> loadStartEpochMilliseconds() =>
      TaskEither<AppFailure, int?>.tryCatch(() => _preferences.getInt(_startKey), _failure);

  @override
  TaskEither<AppFailure, Unit> saveStartEpochMilliseconds(int milliseconds) => TaskEither<AppFailure, Unit>.tryCatch(
    () async {
      await _preferences.setInt(_startKey, milliseconds);
      return unit;
    },
    _failure,
  );

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Sorting start storage failed', error: error, stackTrace: stackTrace, name: 'photo_library');
    return const SortingStartStorageFailure();
  }
}
