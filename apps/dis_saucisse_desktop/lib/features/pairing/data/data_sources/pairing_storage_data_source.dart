import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/stored_identity.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/stored_paired_phone.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PairingStorageDataSource {
  TaskEither<AppFailure, StoredIdentity> loadOrCreateIdentity();

  TaskEither<AppFailure, List<StoredPairedPhone>> loadPairedPhones();

  TaskEither<AppFailure, Unit> savePairedPhone(StoredPairedPhone phone);
}
