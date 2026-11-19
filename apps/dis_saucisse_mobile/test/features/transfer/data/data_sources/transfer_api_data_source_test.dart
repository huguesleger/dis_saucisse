import 'dart:convert';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/transfer_api_data_source.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  const PairingToken token = PairingToken('secret');
  final PhotoUpload upload = PhotoUpload(
    phoneId: const PhoneId('phone-1'),
    photoId: 'ABC/L0/001',
    fileName: 'IMG_0001.jpg',
    takenAt: DateTime(2026, 11, 8, 14, 30),
    eventDate: DateTime(2026, 11, 8, 14),
    eventName: some('Anniversaire'),
    decision: PhotoDecisionKind.kept,
    sha256: 'abc',
  );

  test('uploads the photo bytes with their description', () async {
    late http.Request sent;
    final TransferApiDataSource api = TransferApiDataSource(
      client: MockClient((http.Request request) async {
        sent = request;
        return http.Response(jsonEncode(const PhotoStoredResponse(folder: '2026').toJson()), 200);
      }),
    );

    final Either<AppFailure, PhotoStoredResponse> result = await api
        .upload('192.168.1.11', 47820, token, upload, Uint8List.fromList(<int>[1, 2, 3]))
        .run();

    expect(sent.method, 'PUT');
    expect(sent.url.toString(), 'http://192.168.1.11:47820/v1/photos/ABC%2FL0%2F001');
    expect(sent.bodyBytes, <int>[1, 2, 3]);
    expect(sent.headers[TransferApi.tokenHeader], 'secret');
    expect(PhotoUpload.fromHeaders('ABC/L0/001', sent.headers).isSome(), isTrue);
    expect(result.map((PhotoStoredResponse r) => r.folder), right<AppFailure, String>('2026'));
  });

  test('reports a photo the computer refused', () async {
    final TransferApiDataSource api = TransferApiDataSource(
      client: MockClient((http.Request request) async => http.Response('Photo abîmée', 422)),
    );

    final Either<AppFailure, PhotoStoredResponse> result = await api
        .upload('192.168.1.11', 47820, token, upload, Uint8List(0))
        .run();

    expect(result.getLeft().toNullable(), isA<TransferRejectedFailure>());
  });
}
