import 'dart:async';
import 'dart:developer';

import 'package:bonsoir/bonsoir.dart';
import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

typedef ComputerAddress = ({String host, int port});

class ComputerDiscoveryDataSource {
  static const Duration _timeout = Duration(seconds: 6);

  TaskEither<AppFailure, Option<ComputerAddress>> find(ComputerId computer) =>
      TaskEither<AppFailure, Option<ComputerAddress>>.tryCatch(() async {
        final BonsoirDiscovery discovery = BonsoirDiscovery(type: TransferApi.serviceType);
        await discovery.initialize();
        final Completer<Option<ComputerAddress>> found = Completer<Option<ComputerAddress>>();
        final StreamSubscription<BonsoirDiscoveryEvent>? events = discovery.eventStream?.listen((
          BonsoirDiscoveryEvent event,
        ) {
          switch (event) {
            case BonsoirDiscoveryServiceFoundEvent(:final BonsoirService service)
                when service.attributes['id'] == computer.value:
              service.resolve(discovery.serviceResolver);
            case BonsoirDiscoveryServiceResolvedEvent(:final BonsoirService service)
                when service.attributes['id'] == computer.value && !found.isCompleted:
              final String? host =
                  service.hostAddresses.where((String address) => !address.contains(':')).firstOrNull ??
                  service.hostAddress;
              if (host != null) found.complete(some((host: host, port: service.port)));
            case _:
              break;
          }
        });
        await discovery.start();
        final Option<ComputerAddress> address = await found.future.timeout(_timeout, onTimeout: none);
        await events?.cancel();
        await discovery.stop();
        return address;
      }, _failure);

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Computer discovery failed', error: error, stackTrace: stackTrace, name: 'pairing');
    return const ComputerUnreachableFailure();
  }
}
