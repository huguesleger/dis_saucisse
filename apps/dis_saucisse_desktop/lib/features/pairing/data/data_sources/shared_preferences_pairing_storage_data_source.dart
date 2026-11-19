import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show Random;

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/pairing_storage_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/stored_identity.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/stored_paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPairingStorageDataSource implements PairingStorageDataSource {
  SharedPreferencesPairingStorageDataSource(this._preferences);

  static const String _computerIdKey = 'pairing.computer_id';
  static const String _tokenKey = 'pairing.token';
  static const String _phonesKey = 'pairing.phones';

  final SharedPreferencesAsync _preferences;

  @override
  TaskEither<AppFailure, StoredIdentity> loadOrCreateIdentity() => TaskEither<AppFailure, StoredIdentity>.tryCatch(
    () async => StoredIdentity(
      computerId: await _readOrCreate(_computerIdKey, 16),
      token: await _readOrCreate(_tokenKey, 24),
      hostname: Platform.localHostname,
      isMacOS: Platform.isMacOS,
    ),
    _failure,
  );

  @override
  TaskEither<AppFailure, List<StoredPairedPhone>> loadPairedPhones() =>
      TaskEither<AppFailure, List<StoredPairedPhone>>.tryCatch(_readPhones, _failure);

  @override
  TaskEither<AppFailure, Unit> savePairedPhone(StoredPairedPhone phone) => TaskEither<AppFailure, Unit>.tryCatch(
    () async {
      final List<StoredPairedPhone> phones = <StoredPairedPhone>[
        ...(await _readPhones()).where((StoredPairedPhone stored) => stored.id != phone.id),
        phone,
      ];
      await _preferences.setString(
        _phonesKey,
        jsonEncode(phones.map((StoredPairedPhone stored) => stored.toJson()).toList()),
      );
      return unit;
    },
    _failure,
  );

  Future<List<StoredPairedPhone>> _readPhones() async {
    final String? stored = await _preferences.getString(_phonesKey);
    return stored == null ? <StoredPairedPhone>[] : StoredPairedPhone.listFromJson(jsonDecode(stored));
  }

  Future<String> _readOrCreate(String key, int byteCount) async {
    final String? stored = await _preferences.getString(key);
    if (stored != null) return stored;
    final Random random = Random.secure();
    final String created = base64UrlEncode(List<int>.generate(byteCount, (_) => random.nextInt(256)));
    await _preferences.setString(key, created);
    return created;
  }

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Pairing storage failed', error: error, stackTrace: stackTrace, name: 'pairing');
    return const PairingStorageFailure();
  }
}
