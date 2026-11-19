import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

abstract interface class PairingRepository {
  TaskEither<AppFailure, PairingPayload> startReception();

  TaskEither<AppFailure, Unit> stopReception();

  Stream<PairedPhone> get pairedPhones;

  TaskEither<AppFailure, List<PairedPhone>> loadPairedPhones();

  TaskEither<AppFailure, Unit> savePairedPhone(PairedPhone phone);
}
