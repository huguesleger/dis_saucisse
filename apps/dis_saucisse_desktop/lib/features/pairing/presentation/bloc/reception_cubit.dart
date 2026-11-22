import 'dart:async';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/config/setup_get_it.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_repository.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/reception_activity_rules.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/received_event.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

part 'reception_state.dart';

class ReceptionCubit extends SafeCubit<ReceptionState> {
  ReceptionCubit({
    PairingRepository? pairingRepository,
    ReceptionRepository? receptionRepository,
    HistoryRepository? historyRepository,
    DateTime Function()? clock,
    Duration? minimalLoading,
  }) : _pairingRepository = pairingRepository ?? getIt.get<PairingRepository>(),
       _receptionRepository = receptionRepository ?? getIt.get<ReceptionRepository>(),
       _historyRepository = historyRepository ?? getIt.get<HistoryRepository>(),
       _clock = clock ?? DateTime.now,
       _minimalLoading = minimalLoading ?? DsLoader.minDuration,
       super(const ReceptionStarting()) {
    _pairings = _pairingRepository.pairedPhones.listen(_onPhonePaired);
    _receptions = _receptionRepository.events.listen(_onReceptionEvent);
  }

  final PairingRepository _pairingRepository;
  final ReceptionRepository _receptionRepository;
  final HistoryRepository _historyRepository;
  final DateTime Function() _clock;
  final Duration _minimalLoading;
  late final StreamSubscription<PairedPhone> _pairings;
  late final StreamSubscription<ReceptionEvent> _receptions;

  Future<void> start() {
    emit(const ReceptionStarting());
    return TaskEither<AppFailure, ReceptionState>.Do(($) async {
          final PairingPayload invitation = await $(_pairingRepository.startReception());
          final List<PairedPhone> phones = await $(_pairingRepository.loadPairedPhones());
          return ReceptionReady(invitation: invitation, phones: phones, activity: const ReceptionIdle());
        })
        .withMinimalDelay(_minimalLoading)
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

  Future<void> openStorageFolder() => _receptionRepository.openStorageFolder().run();

  Future<void> pauseReception() => _setPaused(true);

  Future<void> resumeReception() => _setPaused(false);

  Future<void> _setPaused(bool paused) => _receptionRepository
      .setPaused(paused)
      .match(
        (AppFailure _) => null,
        (Unit _) => _updateActivity(
          (ReceptionActivity activity) => switch (activity) {
            final ReceptionInProgress progress => progress.withPaused(paused),
            ReceptionIdle() || ReceptionDone() => activity,
          },
        ),
      )
      .run();

  void closeSummary() => _updateActivity((ReceptionActivity _) => const ReceptionIdle());

  void _onReceptionEvent(ReceptionEvent event) {
    _recordFinishedTransfer(event);
    _applyReceptionEvent(event);
  }

  void _recordFinishedTransfer(ReceptionEvent event) {
    if (event case TransferFinished()) {
      if (state case ReceptionReady(activity: final ReceptionInProgress progress)) {
        _historyRepository.saveTransfer(transferRecordOf(progress, _clock())).run();
      }
    }
  }

  void _applyReceptionEvent(ReceptionEvent event) =>
      _updateActivity((ReceptionActivity activity) => nextReceptionActivity(activity, event, _clock()));

  void _updateActivity(ReceptionActivity Function(ReceptionActivity activity) update) => switch (state) {
    final ReceptionReady ready => emit(ready.copyWith(activity: update(ready.activity))),
    ReceptionStarting() || ReceptionFailed() => null,
  };

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
    await _receptions.cancel();
    await _pairingRepository.stopReception().run();
    return super.close();
  }
}
