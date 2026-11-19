import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/src/computer_platform.dart';
import 'package:transfer_protocol/src/identifiers.dart';

/// Content of the QR code shown by the computer and scanned by the phone.
final class PairingPayload {
  const PairingPayload({
    required this.computerId,
    required this.computerName,
    required this.platform,
    required this.host,
    required this.port,
    required this.token,
  });

  static const String _app = 'dis-saucisse';
  static const int _version = 1;

  final ComputerId computerId;
  final String computerName;
  final ComputerPlatform platform;
  final String host;
  final int port;
  final PairingToken token;

  /// Text encoded in the QR code.
  String encode() => jsonEncode(<String, Object>{
    'app': _app,
    'v': _version,
    'id': computerId.value,
    'name': computerName,
    'platform': platform.name,
    'host': host,
    'port': port,
    'token': token.value,
  });

  /// Reads a scanned QR code, or nothing when it is not a Dis Saucisse ! pairing code.
  static Option<PairingPayload> decode(String raw) => Either<Object, Map<String, dynamic>>.tryCatch(
    () => jsonDecode(raw) as Map<String, dynamic>,
    (Object error, StackTrace _) => error,
  ).toOption().flatMap(_fromJson);

  static Option<PairingPayload> _fromJson(Map<String, dynamic> json) {
    final Object? platform = json['platform'];
    final bool valid =
        json['app'] == _app &&
        json['v'] == _version &&
        json['id'] is String &&
        json['name'] is String &&
        json['host'] is String &&
        json['port'] is int &&
        json['token'] is String &&
        ComputerPlatform.values.any((ComputerPlatform p) => p.name == platform);
    return valid
        ? some(
            PairingPayload(
              computerId: ComputerId(json['id'] as String),
              computerName: json['name'] as String,
              platform: ComputerPlatform.values.byName(platform! as String),
              host: json['host'] as String,
              port: json['port'] as int,
              token: PairingToken(json['token'] as String),
            ),
          )
        : none();
  }
}
