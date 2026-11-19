import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

abstract interface class PairingRepository {
  TaskEither<AppFailure, Option<PairedComputer>> loadPairedComputer();

  TaskEither<AppFailure, PairedComputer> pairWith(PairingPayload invitation);

  TaskEither<AppFailure, Option<String>> readQrCodeFromImage(String imagePath);

  TaskEither<AppFailure, PairedComputer> locateComputer(PairedComputer computer);
}
