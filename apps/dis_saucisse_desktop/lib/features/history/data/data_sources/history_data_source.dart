import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDataSource {
  HistoryDataSource(this._preferences);

  static const String _historyKey = 'history.transfers';

  final SharedPreferencesAsync _preferences;

  TaskEither<AppFailure, List<Map<String, Object?>>> loadRecords() =>
      TaskEither<AppFailure, List<Map<String, Object?>>>.tryCatch(_read, _failure);

  TaskEither<AppFailure, Unit> addRecord(Map<String, Object?> record) =>
      TaskEither<AppFailure, Unit>.tryCatch(() async {
        await _preferences.setString(_historyKey, jsonEncode(<Map<String, Object?>>[...await _read(), record]));
        return unit;
      }, _failure);

  Future<List<Map<String, Object?>>> _read() async {
    final String? stored = await _preferences.getString(_historyKey);
    return stored == null
        ? <Map<String, Object?>>[]
        : (jsonDecode(stored) as List<dynamic>).whereType<Map<String, dynamic>>().toList();
  }

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('History storage failed', error: error, stackTrace: stackTrace, name: 'history');
    return const HistoryStorageFailure();
  }
}
