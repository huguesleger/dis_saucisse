import 'package:flutter/foundation.dart';

@immutable
final class StoredIdentity {
  const StoredIdentity({required this.computerId, required this.token, required this.hostname, required this.isMacOS});

  final String computerId;
  final String token;
  final String hostname;
  final bool isMacOS;
}
