import 'package:flutter/foundation.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

@immutable
final class ComputerIdentity {
  const ComputerIdentity({required this.id, required this.name, required this.platform, required this.token});

  final ComputerId id;
  final String name;
  final ComputerPlatform platform;
  final PairingToken token;
}
