import 'package:flutter/foundation.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

@immutable
final class PairedComputer {
  const PairedComputer({
    required this.id,
    required this.name,
    required this.platform,
    required this.host,
    required this.port,
    required this.token,
  });

  final ComputerId id;
  final String name;
  final ComputerPlatform platform;
  final String host;
  final int port;
  final PairingToken token;
}
