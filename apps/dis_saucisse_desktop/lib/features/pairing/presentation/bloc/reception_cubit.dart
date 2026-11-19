import 'dart:async';

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/config/setup_get_it.dart';
import 'package:dis_saucisse_desktop/features/history/domain/entities/transfer_record.dart';
import 'package:dis_saucisse_desktop/features/history/domain/history_repository.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
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
  }) : _pairingRepository = pairingRepository ?? getIt.get<PairingRepository>(),
       _receptionRepository = receptionRepository ?? getIt.get<ReceptionRepository>(),
       _historyRepository = historyRepository ?? getIt.get<HistoryRepository>(),
       _clock = clock ?? DateTime.now,
       super(const ReceptionStarting()) {
    _pairings = _pairingRepository.pairedPhones.listen(_onPhonePaired);
    _receptions = _receptionRepository.events.listen(_onReceptionEvent);
  }

  final PairingRepository _pairingRepository;
  final ReceptionRepository _receptionRepository;
  final HistoryRepository _historyRepository;
  final DateTime Function() _clock;
  late final StreamSubscription<PairedPhone> _pairings;
  late final StreamSubscription<ReceptionEvent> _receptions;

  Future<void> start() {
    emit(const ReceptionStarting());
    return TaskEither<AppFailure, ReceptionState>.Do(($) async {
          final PairingPayload invitation = await $(_pairingRepository.startReception());
          final List<PairedPhone> phones = await $(_pairingRepository.loadPairedPhones());
          return ReceptionReady(invitation: invitation, phones: phones, activity: const ReceptionIdle());
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

  Future<void> openStorageFolder() => _receptionRepository.openStorageFolder().run();

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

  void _applyReceptionEvent(ReceptionEvent event) => _updateActivity(
    (ReceptionActivity activity) => switch ((event, activity)) {
      (TransferStarted(:final String phoneName, :final int photoCount), _) => ReceptionInProgress(
        phoneName: phoneName,
        expected: photoCount,
        received: 0,
        rejected: 0,
        byteCount: 0,
        folders: const <String>[],
        eventKeys: const <String>{},
      ),
      (
        PhotoReceived(:final String folder, :final String eventKey, :final int byteCount),
        final ReceptionInProgress progress,
      ) =>
        ReceptionInProgress(
          phoneName: progress.phoneName,
          expected: progress.expected,
          received: progress.received + 1,
          rejected: progress.rejected,
          byteCount: progress.byteCount + byteCount,
          folders: <String>[...progress.folders.where((String known) => known != folder), folder],
          eventKeys: <String>{...progress.eventKeys, eventKey},
        ),
      (PhotoRejected(), final ReceptionInProgress progress) => ReceptionInProgress(
        phoneName: progress.phoneName,
        expected: progress.expected,
        received: progress.received,
        rejected: progress.rejected + 1,
        byteCount: progress.byteCount,
        folders: progress.folders,
        eventKeys: progress.eventKeys,
      ),
      (TransferFinished(), final ReceptionInProgress progress) => ReceptionDone(
        phoneName: progress.phoneName,
        received: progress.received,
        folders: progress.folders,
      ),
      (PhotoReceived() || PhotoRejected() || TransferFinished(), ReceptionIdle() || ReceptionDone()) => activity,
    },
  );

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

TransferRecord transferRecordOf(ReceptionInProgress progress, DateTime receivedAt) => TransferRecord(
  receivedAt: receivedAt,
  phoneName: progress.phoneName,
  photoCount: progress.received,
  rejectedCount: progress.rejected,
  byteCount: progress.byteCount,
  eventCount: progress.eventKeys.length,
);
