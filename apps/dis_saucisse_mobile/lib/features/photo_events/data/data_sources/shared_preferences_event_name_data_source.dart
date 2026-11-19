import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/photo_events/data/data_sources/event_name_data_source.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/photo_events_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesEventNameDataSource implements EventNameDataSource {
  SharedPreferencesEventNameDataSource(this._preferences);

  static const String _namesKey = 'photo_events.names';

  final SharedPreferencesAsync _preferences;

  @override
  TaskEither<AppFailure, Map<String, String>> loadNames() =>
      TaskEither<AppFailure, Map<String, String>>.tryCatch(_readNames, _failure);

  @override
  TaskEither<AppFailure, Unit> saveName(String eventId, String name) => TaskEither<AppFailure, Unit>.tryCatch(
    () async => _writeNames(<String, String>{...await _readNames(), eventId: name}),
    _failure,
  );

  @override
  TaskEither<AppFailure, Unit> removeName(String eventId) => TaskEither<AppFailure, Unit>.tryCatch(
    () async => _writeNames(<String, String>{...await _readNames()}..remove(eventId)),
    _failure,
  );

  Future<Map<String, String>> _readNames() async {
    final String? stored = await _preferences.getString(_namesKey);
    return stored == null ? <String, String>{} : Map<String, String>.from(jsonDecode(stored) as Map<String, dynamic>);
  }

  Future<Unit> _writeNames(Map<String, String> names) async {
    await _preferences.setString(_namesKey, jsonEncode(names));
    return unit;
  }

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Event name storage failed', error: error, stackTrace: stackTrace, name: 'photo_events');
    return const EventNameStorageFailure();
  }
}
