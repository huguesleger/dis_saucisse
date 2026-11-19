import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:fpdart/fpdart.dart';

class LocalNetworkDataSource {
  TaskEither<AppFailure, String> localIpv4Address() =>
      TaskEither<AppFailure, List<NetworkInterface>>.tryCatch(
        () => NetworkInterface.list(type: InternetAddressType.IPv4),
        (Object error, StackTrace stackTrace) {
          log('Cannot list network interfaces', error: error, stackTrace: stackTrace, name: 'pairing');
          return const NoLocalNetworkFailure();
        },
      ).flatMap(
        (List<NetworkInterface> interfaces) =>
            TaskEither<AppFailure, String>.fromOption(_privateAddress(interfaces), NoLocalNetworkFailure.new),
      );

  Option<String> _privateAddress(List<NetworkInterface> interfaces) {
    final List<InternetAddress> addresses = <InternetAddress>[
      for (final NetworkInterface interface in interfaces) ...interface.addresses,
    ].where((InternetAddress address) => !address.isLoopback && !address.isLinkLocal).toList();
    final List<InternetAddress> privateFirst = <InternetAddress>[
      ...addresses.where(_isPrivate),
      ...addresses.where((InternetAddress address) => !_isPrivate(address)),
    ];
    return Option<InternetAddress>.fromNullable(privateFirst.firstOrNull).map((InternetAddress a) => a.address);
  }

  bool _isPrivate(InternetAddress address) =>
      address.address.startsWith('192.168.') ||
      address.address.startsWith('10.') ||
      RegExp(r'^172\.(1[6-9]|2\d|3[01])\.').hasMatch(address.address);
}
