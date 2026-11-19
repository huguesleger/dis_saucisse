import 'dart:convert';
import 'dart:io';

import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/reception_server_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  const int port = 47999;
  const PairingToken token = PairingToken('secret');
  const PairResponse identity = PairResponse(computerId: ComputerId('computer-1'), computerName: 'PC du salon');
  late ReceptionServerDataSource server;
  late HttpClient client;

  setUp(() async {
    server = ReceptionServerDataSource();
    client = HttpClient();
    await server.start(port: port, token: token, identity: identity).run();
  });

  tearDown(() async {
    client.close(force: true);
    await server.stop().run();
  });

  Future<(int, String)> send(String method, String path, {String? tokenValue, Object? body}) async {
    final HttpClientRequest request = await client.open(method, '127.0.0.1', port, path);
    if (tokenValue != null) request.headers.set(TransferApi.tokenHeader, tokenValue);
    if (body != null) request.write(jsonEncode(body));
    final HttpClientResponse response = await request.close();
    return (response.statusCode, await response.transform(utf8.decoder).join());
  }

  test('refuses a request without the pairing token', () async {
    final (int status, _) = await send('GET', TransferApi.statusPath);

    expect(status, HttpStatus.forbidden);
  });

  test('tells who the computer is', () async {
    final (int status, String body) = await send('GET', TransferApi.statusPath, tokenValue: token.value);

    expect(status, HttpStatus.ok);
    expect(jsonDecode(body), identity.toJson());
  });

  test('accepts a pairing request and reports it', () async {
    final Future<PairRequest> reported = server.pairRequests.first;

    final (int status, String body) = await send(
      'POST',
      TransferApi.pairPath,
      tokenValue: token.value,
      body: const PairRequest(phoneId: PhoneId('phone-1'), phoneName: 'iPhone').toJson(),
    );

    expect(status, HttpStatus.ok);
    expect(jsonDecode(body), identity.toJson());
    expect((await reported).phoneName, 'iPhone');
  });

  test('rejects a malformed pairing request', () async {
    final (int status, _) = await send('POST', TransferApi.pairPath, tokenValue: token.value, body: <String, Object>{});

    expect(status, HttpStatus.badRequest);
  });
}
