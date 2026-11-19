import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show Random;

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/stored_paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class PairingStorageDataSource {
  PairingStorageDataSource(this._preferences);

  static const String _computerKey = 'pairing.computer';
  static const String _phoneIdKey = 'pairing.phone_id';

  final SharedPreferencesAsync _preferences;

  TaskEither<AppFailure, PairRequest> phoneIdentity() => TaskEither<AppFailure, PairRequest>.tryCatch(() async {
    final String? stored = await _preferences.getString(_phoneIdKey);
    final String phoneId = stored ?? _newPhoneId();
    if (stored == null) await _preferences.setString(_phoneIdKey, phoneId);
    return PairRequest(phoneId: PhoneId(phoneId), phoneName: Platform.isIOS ? 'iPhone' : 'Téléphone Android');
  }, _failure);

  TaskEither<AppFailure, Option<StoredPairedComputer>> loadComputer() =>
      TaskEither<AppFailure, Option<StoredPairedComputer>>.tryCatch(() async {
        final String? stored = await _preferences.getString(_computerKey);
        return stored == null ? none() : StoredPairedComputer.fromJson(jsonDecode(stored));
      }, _failure);

  TaskEither<AppFailure, Unit> saveComputer(StoredPairedComputer computer) =>
      TaskEither<AppFailure, Unit>.tryCatch(() async {
        await _preferences.setString(_computerKey, jsonEncode(computer.toJson()));
        return unit;
      }, _failure);

  String _newPhoneId() {
    final Random random = Random.secure();
    return base64UrlEncode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Pairing storage failed', error: error, stackTrace: stackTrace, name: 'pairing');
    return const PairingStorageFailure();
  }
}
