import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/src/identifiers.dart';

/// Sent by the phone to pair with a computer.
final class PairRequest {
  const PairRequest({required this.phoneId, required this.phoneName});

  final PhoneId phoneId;
  final String phoneName;

  Map<String, Object> toJson() => <String, Object>{'phoneId': phoneId.value, 'phoneName': phoneName};

  static Option<PairRequest> fromJson(Object? json) => switch (json) {
    {'phoneId': final String id, 'phoneName': final String name} => some(
      PairRequest(phoneId: PhoneId(id), phoneName: name),
    ),
    _ => none(),
  };
}

/// Answer of the computer once the phone is paired.
final class PairResponse {
  const PairResponse({required this.computerId, required this.computerName});

  final ComputerId computerId;
  final String computerName;

  Map<String, Object> toJson() => <String, Object>{'computerId': computerId.value, 'computerName': computerName};

  static Option<PairResponse> fromJson(Object? json) => switch (json) {
    {'computerId': final String id, 'computerName': final String name} => some(
      PairResponse(computerId: ComputerId(id), computerName: name),
    ),
    _ => none(),
  };
}
