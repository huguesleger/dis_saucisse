import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/event_boundary_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/stored_event_boundaries.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/photo_events_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesEventBoundaryDataSource implements EventBoundaryDataSource {
  SharedPreferencesEventBoundaryDataSource(this._preferences);

  static const String _boundariesKey = 'photo_events.boundaries';

  final SharedPreferencesAsync _preferences;

  @override
  TaskEither<AppFailure, StoredEventBoundaries> loadBoundaries() =>
      TaskEither<AppFailure, StoredEventBoundaries>.tryCatch(() async {
        final String? stored = await _preferences.getString(_boundariesKey);
        return stored == null
            ? const StoredEventBoundaries(joinedAt: <String>[], splitAt: <String>[])
            : StoredEventBoundaries.fromJson(jsonDecode(stored) as Map<String, dynamic>);
      }, _failure);

  @override
  TaskEither<AppFailure, Unit> saveBoundaries(StoredEventBoundaries boundaries) =>
      TaskEither<AppFailure, Unit>.tryCatch(() async {
        await _preferences.setString(_boundariesKey, jsonEncode(boundaries.toJson()));
        return unit;
      }, _failure);

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Event boundary storage failed', error: error, stackTrace: stackTrace, name: 'photo_events');
    return const EventBoundaryStorageFailure();
  }
}
