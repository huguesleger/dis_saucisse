import 'dart:developer';

import 'package:bonsoir/bonsoir.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class ComputerAdvertiserDataSource {
  Option<BonsoirBroadcast> _broadcast = none();

  TaskEither<AppFailure, Unit> advertise({required ComputerId id, required String name, required int port}) =>
      TaskEither<AppFailure, Unit>.tryCatch(() async {
        await _stop();
        final BonsoirBroadcast broadcast = BonsoirBroadcast(
          service: BonsoirService(
            name: name,
            type: TransferApi.serviceType,
            port: port,
            attributes: <String, String>{'id': id.value},
          ),
        );
        await broadcast.initialize();
        await broadcast.start();
        _broadcast = some(broadcast);
        return unit;
      }, _failure);

  TaskEither<AppFailure, Unit> stop() => TaskEither<AppFailure, Unit>.tryCatch(() async {
    await _stop();
    return unit;
  }, _failure);

  Future<void> _stop() async {
    await _broadcast.match(() async {}, (BonsoirBroadcast broadcast) => broadcast.stop());
    _broadcast = none();
  }

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Network announcement failed', error: error, stackTrace: stackTrace, name: 'pairing');
    return const ReceptionServerFailure();
  }
}
