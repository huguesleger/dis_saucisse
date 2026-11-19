import 'dart:convert';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/pairing_api_data_source.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  const PairingPayload invitation = PairingPayload(
    computerId: ComputerId('computer-1'),
    computerName: 'PC du salon',
    platform: ComputerPlatform.windows,
    host: '192.168.1.24',
    port: 47820,
    token: PairingToken('secret'),
  );
  const PairRequest phone = PairRequest(phoneId: PhoneId('phone-1'), phoneName: 'iPhone');

  test('sends the pairing request with the token to the computer', () async {
    late http.Request sent;
    final PairingApiDataSource api = PairingApiDataSource(
      client: MockClient((http.Request request) async {
        sent = request;
        return http.Response(
          jsonEncode(const PairResponse(computerId: ComputerId('computer-1'), computerName: 'PC du salon').toJson()),
          200,
        );
      }),
    );

    final Either<AppFailure, PairResponse> result = await api.pair(invitation, phone).run();

    expect(sent.url.toString(), 'http://192.168.1.24:47820/v1/pair');
    expect(sent.headers[TransferApi.tokenHeader], 'secret');
    expect(jsonDecode(sent.body), phone.toJson());
    expect(result.map((PairResponse r) => r.computerName), right<AppFailure, String>('PC du salon'));
  });

  test('reports a refused pairing', () async {
    final PairingApiDataSource api = PairingApiDataSource(
      client: MockClient((http.Request request) async => http.Response('Code invalide', 403)),
    );

    final Either<AppFailure, PairResponse> result = await api.pair(invitation, phone).run();

    expect(result.getLeft().toNullable(), isA<PairingRefusedFailure>());
  });

  test('reports an unreachable computer', () async {
    final PairingApiDataSource api = PairingApiDataSource(
      client: MockClient((http.Request request) async => throw const SocketExceptionFake()),
    );

    final Either<AppFailure, PairResponse> result = await api.pair(invitation, phone).run();

    expect(result.getLeft().toNullable(), isA<ComputerUnreachableFailure>());
  });
}

class SocketExceptionFake implements Exception {
  const SocketExceptionFake();
}
