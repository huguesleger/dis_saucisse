import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/config/setup_get_it.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_repository.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/entities/event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/event_library_load.dart';
import 'package:dis_saucisse_mobile/features/photo_events/domain/use_cases/load_event_library.dart';
import 'package:dis_saucisse_mobile/features/photo_library/domain/entities/photo_id.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/sent_photo.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_item.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/entities/transfer_progress.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/rules/photos_to_send.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_failure.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'transfer_state.dart';

class TransferCubit extends SafeCubit<TransferState> {
  TransferCubit({
    PairingRepository? pairingRepository,
    TransferRepository? transferRepository,
    LoadEventLibrary? loadEventLibrary,
    DateTime Function()? clock,
    this.computerRetryDelay = const Duration(seconds: 5),
    Duration? minimalLoading,
  }) : _pairingRepository = pairingRepository ?? getIt.get<PairingRepository>(),
       _transferRepository = transferRepository ?? getIt.get<TransferRepository>(),
       _loadEventLibrary = loadEventLibrary ?? LoadEventLibrary(),
       _clock = clock ?? DateTime.now,
       _minimalLoading = minimalLoading ?? DsLoader.minDuration,
       super(const TransferPreparing());

  final PairingRepository _pairingRepository;
  final TransferRepository _transferRepository;
  final LoadEventLibrary _loadEventLibrary;
  final DateTime Function() _clock;
  final Duration _minimalLoading;
  final Duration computerRetryDelay;

  DateTime get now => _clock();

  Future<void> start() {
    emit(const TransferPreparing());
    return _pairingRepository
        .loadPairedComputer()
        .flatMap(
          (Option<PairedComputer> computer) => computer.match(
            () => TaskEither<AppFailure, TransferState>.right(const TransferNeedsPairing()),
            _prepareFor,
          ),
        )
        .withMinimalDelay(_minimalLoading)
        .match(_failed, identity)
        .flatMap((TransferState next) => _emitThenContinue(next))
        .run();
  }

  void pause() => switch (state) {
    TransferSending(:final TransferProgress progress) ||
    TransferWaitingForComputer(:final TransferProgress progress) => emit(TransferPaused(progress)),
    TransferPreparing() ||
    TransferNeedsPairing() ||
    TransferNothingToSend() ||
    TransferFailed() ||
    TransferPaused() ||
    TransferFinished() => null,
  };

  Future<void> resume() => switch (state) {
    TransferPaused(:final TransferProgress progress) => _emitThenContinue(TransferSending(progress)).run(),
    TransferPreparing() ||
    TransferNeedsPairing() ||
    TransferNothingToSend() ||
    TransferFailed() ||
    TransferSending() ||
    TransferWaitingForComputer() ||
    TransferFinished() => Future<void>.value(),
  };

  TaskEither<AppFailure, TransferState> _prepareFor(PairedComputer computer) => _loadEventLibrary().flatMap(
    (EventLibraryLoad load) => switch (load) {
      EventLibraryLoaded(:final EventLibrary library) =>
        _transferRepository
            .loadSentPhotoIds(computer.id)
            .map((Set<PhotoId> sent) => photosToSend(library, sent))
            .flatMap(
              (List<TransferItem> items) => items.isEmpty
                  ? TaskEither<AppFailure, TransferState>.right(const TransferNothingToSend())
                  : _startWith(computer, items).orElse(
                      (AppFailure failure) => switch (failure) {
                        ComputerUnreachableFailure() =>
                          _pairingRepository
                              .locateComputer(computer)
                              .flatMap((PairedComputer located) => _startWith(located, items)),
                        _ => TaskEither<AppFailure, TransferState>.left(failure),
                      },
                    ),
            ),
      EventLibraryNeedsSortingStart() || EventLibraryAccessDenied() => TaskEither<AppFailure, TransferState>.right(
        const TransferNothingToSend(),
      ),
    },
  );

  TaskEither<AppFailure, TransferState> _startWith(PairedComputer computer, List<TransferItem> items) =>
      TaskEither<AppFailure, TransferState>.Do(($) async {
        final Set<PhotoId> missing = await $(
          _transferRepository.startTransfer(computer, items.map((TransferItem item) => item.photo.id).toList()),
        );
        final List<TransferItem> toSend = items.where((TransferItem item) => missing.contains(item.photo.id)).toList();
        await $(
          _transferRepository.markAlreadyReceived(
            computer,
            items.where((TransferItem item) => !missing.contains(item.photo.id)).map((item) => item.photo.id).toList(),
          ),
        );
        return toSend.isEmpty
            ? const TransferNothingToSend()
            : TransferSending(TransferProgress.start(computer, toSend, _clock()));
      });

  Task<void> _emitThenContinue(TransferState next) => Task<void>(() async {
    emit(next);
    await _sendNext();
  });

  Future<void> _sendNext() => isClosed
      ? Future<void>.value()
      : switch (state) {
          TransferSending(:final TransferProgress progress) when progress.remaining.isNotEmpty => _sendFirst(progress),
          TransferSending(:final TransferProgress progress) => _finish(progress),
          TransferPreparing() ||
          TransferNeedsPairing() ||
          TransferNothingToSend() ||
          TransferFailed() ||
          TransferPaused() ||
          TransferWaitingForComputer() ||
          TransferFinished() => Future<void>.value(),
        };

  Future<void> _sendFirst(TransferProgress progress) {
    final TransferItem item = progress.remaining.first;
    return _transferRepository
        .sendPhoto(progress.computer, item)
        .match(
          (AppFailure failure) => switch (failure) {
            ComputerPausedFailure() => TransferWaitingForComputer(progress),
            _ => _failed(failure),
          },
          (SentPhoto sent) => _withProgress(progress.afterSending(item, sent)),
        )
        .flatMap(
          (TransferState next) => switch (next) {
            TransferWaitingForComputer() => _waitForComputer(next),
            _ => _emitThenContinue(next),
          },
        )
        .run();
  }

  Task<void> _waitForComputer(TransferWaitingForComputer waiting) => Task<void>(() async {
    emit(waiting);
    await Future<void>.delayed(computerRetryDelay);
    if (!isClosed && state == waiting) await _emitThenContinue(TransferSending(waiting.progress)).run();
  });

  Future<void> _finish(TransferProgress progress) => _transferRepository
      .finishTransfer(progress.computer, progress.sent)
      .match(
        (AppFailure _) => _finished(progress),
        (_) => _finished(progress),
      )
      .map(emit)
      .run();

  TransferState _withProgress(TransferProgress progress) => switch (state) {
    TransferPaused() => TransferPaused(progress),
    TransferWaitingForComputer() ||
    TransferPreparing() ||
    TransferNeedsPairing() ||
    TransferNothingToSend() ||
    TransferFailed() ||
    TransferSending() ||
    TransferFinished() => TransferSending(progress),
  };

  TransferState _finished(TransferProgress progress) => TransferFinished(
    computerName: progress.computer.name,
    sentCount: progress.sent,
    eventCount: progress.eventCount,
    sentBytes: progress.sentBytes,
  );

  TransferState _failed(AppFailure failure) => TransferFailed(switch (failure) {
    ComputerUnreachableFailure() => TransferProblem.unreachable,
    _ => TransferProblem.failed,
  });
}
