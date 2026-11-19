import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
final class StoredPairedComputer {
  const StoredPairedComputer({
    required this.id,
    required this.name,
    required this.platform,
    required this.host,
    required this.port,
    required this.token,
  });

  final String id;
  final String name;
  final String platform;
  final String host;
  final int port;
  final String token;

  Map<String, Object> toJson() => <String, Object>{
    'id': id,
    'name': name,
    'platform': platform,
    'host': host,
    'port': port,
    'token': token,
  };

  static Option<StoredPairedComputer> fromJson(Object? json) => switch (json) {
    {
      'id': final String id,
      'name': final String name,
      'platform': final String platform,
      'host': final String host,
      'port': final int port,
      'token': final String token,
    } =>
      some(StoredPairedComputer(id: id, name: name, platform: platform, host: host, port: port, token: token)),
    _ => none(),
  };
}
