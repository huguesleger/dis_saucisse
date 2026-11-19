import 'package:flutter/foundation.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

@immutable
final class PairedPhone {
  const PairedPhone({required this.id, required this.name, required this.pairedAt});

  final PhoneId id;
  final String name;
  final DateTime pairedAt;
}
