import 'dart:async';

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/config/setup_get_it.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

part 'reception_state.dart';

class ReceptionCubit extends SafeCubit<ReceptionState> {
  ReceptionCubit({PairingRepository? pairingRepository})
    : _pairingRepository = pairingRepository ?? getIt.get<PairingRepository>(),
      super(const ReceptionStarting()) {
    _pairings = _pairingRepository.pairedPhones.listen(_onPhonePaired);
  }

  final PairingRepository _pairingRepository;
  late final StreamSubscription<PairedPhone> _pairings;

  Future<void> start() {
    emit(const ReceptionStarting());
    return TaskEither<AppFailure, ReceptionState>.Do(($) async {
          final PairingPayload invitation = await $(_pairingRepository.startReception());
          final List<PairedPhone> phones = await $(_pairingRepository.loadPairedPhones());
          return ReceptionReady(invitation: invitation, phones: phones);
        })
        .match(
          (AppFailure failure) => ReceptionFailed(switch (failure) {
            NoLocalNetworkFailure() => ReceptionProblem.noNetwork,
            _ => ReceptionProblem.serverUnavailable,
          }),
          identity,
        )
        .map(emit)
        .run();
  }

  Future<void> _onPhonePaired(PairedPhone phone) => _pairingRepository
      .savePairedPhone(phone)
      .match((AppFailure _) => state, (_) => _withPhone(phone))
      .map(emit)
      .run();

  ReceptionState _withPhone(PairedPhone phone) => switch (state) {
    final ReceptionReady ready => ready.withPhone(phone),
    ReceptionStarting() || ReceptionFailed() => state,
  };

  @override
  Future<void> close() async {
    await _pairings.cancel();
    await _pairingRepository.stopReception().run();
    return super.close();
  }
}
