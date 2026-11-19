import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/reception_server_data_source.dart';
import 'package:dis_saucisse_desktop/features/reception/data/data_sources/photo_storage_data_source.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  const int port = 47999;
  const PairingToken token = PairingToken('secret');
  const PairResponse identity = PairResponse(computerId: ComputerId('computer-1'), computerName: 'PC du salon');
  late ReceptionServerDataSource server;
  late HttpClient client;
  late Directory root;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('reception_server_test');
    server = ReceptionServerDataSource(PhotoStorageDataSource(root: root));
    client = HttpClient();
    await server.start(port: port, token: token, identity: identity).run();
  });

  tearDown(() async {
    client.close(force: true);
    await server.stop().run();
    await root.delete(recursive: true);
  });

  Future<(int, String)> send(
    String method,
    String path, {
    String? tokenValue,
    Object? body,
    List<int>? bytes,
    Map<String, String> headers = const <String, String>{},
  }) async {
    final HttpClientRequest request = await client.open(method, '127.0.0.1', port, path);
    if (tokenValue != null) request.headers.set(TransferApi.tokenHeader, tokenValue);
    headers.forEach(request.headers.set);
    if (body != null) request.write(jsonEncode(body));
    if (bytes != null) request.add(bytes);
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

  group('photo transfer', () {
    final List<int> photoBytes = utf8.encode('une photo de gâteau');
    PhotoUpload upload({String? checksum, PhotoDecisionKind decision = PhotoDecisionKind.kept}) => PhotoUpload(
      phoneId: const PhoneId('phone-1'),
      photoId: 'asset/1',
      fileName: 'IMG_0001.jpg',
      takenAt: DateTime(2026, 11, 8, 14, 30),
      eventDate: DateTime(2026, 11, 8, 14),
      eventName: some('Anniversaire de mamie'),
      decision: decision,
      sha256: checksum ?? sha256.convert(photoBytes).toString(),
    );

    test('lists the photos the computer does not have yet', () async {
      final Future<ReceptionEvent> started = server.receptionEvents.first;

      final (int status, String body) = await send(
        'POST',
        TransferApi.transferStartPath,
        tokenValue: token.value,
        body: const TransferStartRequest(
          phoneId: PhoneId('phone-1'),
          phoneName: 'iPhone',
          photoIds: <String>['asset/1', 'asset/2'],
        ).toJson(),
      );

      expect(status, HttpStatus.ok);
      expect(jsonDecode(body), <String, Object>{
        'missingPhotoIds': <String>['asset/1', 'asset/2'],
      });
      expect(await started, isA<TransferStarted>().having((TransferStarted e) => e.photoCount, 'count', 2));
    });

    test('stores a verified photo in its event folder and remembers it', () async {
      final (int status, String body) = await send(
        'PUT',
        TransferApi.photoPath('asset/1'),
        tokenValue: token.value,
        headers: upload().toHeaders(),
        bytes: photoBytes,
      );

      expect(status, HttpStatus.ok);
      expect(jsonDecode(body), <String, Object>{'folder': '2026/2026-11 Novembre/2026-11-08 Anniversaire de mamie'});
      expect(
        File('${root.path}/2026/2026-11 Novembre/2026-11-08 Anniversaire de mamie/IMG_0001.jpg').readAsStringSync(),
        'une photo de gâteau',
      );

      final (_, String missing) = await send(
        'POST',
        TransferApi.transferStartPath,
        tokenValue: token.value,
        body: const TransferStartRequest(
          phoneId: PhoneId('phone-1'),
          phoneName: 'iPhone',
          photoIds: <String>['asset/1'],
        ).toJson(),
      );
      expect(jsonDecode(missing), <String, Object>{'missingPhotoIds': <String>[]});
    });

    test('puts discarded photos in the Écartées folder', () async {
      final (_, String body) = await send(
        'PUT',
        TransferApi.photoPath('asset/1'),
        tokenValue: token.value,
        headers: upload(decision: PhotoDecisionKind.discarded).toHeaders(),
        bytes: photoBytes,
      );

      expect(jsonDecode(body), <String, Object>{
        'folder': '2026/2026-11 Novembre/2026-11-08 Anniversaire de mamie/Écartées',
      });
    });

    test('rejects a photo damaged during the transfer', () async {
      final Future<ReceptionEvent> rejected = server.receptionEvents.first;

      final (int status, _) = await send(
        'PUT',
        TransferApi.photoPath('asset/1'),
        tokenValue: token.value,
        headers: upload(checksum: 'not-the-right-checksum').toHeaders(),
        bytes: photoBytes,
      );

      expect(status, 422);
      expect(await rejected, isA<PhotoRejected>());
      expect(Directory('${root.path}/2026').listSync(recursive: true).whereType<File>(), isEmpty);
    });
  });
}
