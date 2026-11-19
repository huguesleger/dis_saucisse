import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

part 'pair_computer_state.dart';

class PairComputerCubit extends SafeCubit<PairComputerState> {
  PairComputerCubit({PairingRepository? pairingRepository})
    : _pairingRepository = pairingRepository ?? getIt.get<PairingRepository>(),
      super(const PairComputerScanning());

  final PairingRepository _pairingRepository;

  Future<void> codeScanned(String rawCode) => switch (state) {
    PairComputerScanning() => PairingPayload.decode(rawCode).match(() async => codeNotFound(), _pairWith),
    PairComputerPairing() || PairComputerPaired() || PairComputerFailed() => Future<void>.value(),
  };

  Future<void> qrImagePicked(String imagePath) => switch (state) {
    PairComputerScanning() =>
      _pairingRepository
          .readQrCodeFromImage(imagePath)
          .match((AppFailure _) => none<String>(), identity)
          .flatMap(
            (Option<String> code) => Task<void>(() => code.match(() async => codeNotFound(), codeScanned)),
          )
          .run(),
    PairComputerPairing() || PairComputerPaired() || PairComputerFailed() => Future<void>.value(),
  };

  void codeNotFound() => emit(const PairComputerFailed(PairingProblem.invalidCode));

  void retry() => emit(const PairComputerScanning());

  Future<void> _pairWith(PairingPayload invitation) {
    emit(PairComputerPairing(invitation.computerName));
    return _pairingRepository
        .pairWith(invitation)
        .match(
          (AppFailure failure) => PairComputerFailed(switch (failure) {
            PairingRefusedFailure() => PairingProblem.refused,
            _ => PairingProblem.unreachable,
          }),
          PairComputerPaired.new,
        )
        .map(emit)
        .run();
  }
}
