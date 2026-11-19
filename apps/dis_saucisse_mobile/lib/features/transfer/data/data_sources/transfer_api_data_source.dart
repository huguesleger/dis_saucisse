import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_mobile/features/transfer/domain/transfer_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:transfer_protocol/transfer_protocol.dart';

class TransferApiDataSource {
  TransferApiDataSource({http.Client? client}) : _client = client ?? http.Client();

  static const Duration _messageTimeout = Duration(seconds: 10);
  static const Duration _uploadTimeout = Duration(seconds: 90);

  final http.Client _client;

  TaskEither<AppFailure, TransferStartResponse> start(
    String host,
    int port,
    PairingToken token,
    TransferStartRequest request,
  ) => _send(
    () => _client.post(
      _uri(host, port, TransferApi.transferStartPath),
      headers: _headers(token),
      body: jsonEncode(request.toJson()),
    ),
    _messageTimeout,
  ).flatMap((http.Response response) => _decode(response, TransferStartResponse.fromJson));

  TaskEither<AppFailure, PhotoStoredResponse> upload(
    String host,
    int port,
    PairingToken token,
    PhotoUpload upload,
    Uint8List bytes,
  ) => _send(
    () => _client.put(
      _uri(host, port, TransferApi.photoPath(upload.photoId)),
      headers: <String, String>{
        ..._headers(token),
        ...upload.toHeaders(),
        'content-type': 'application/octet-stream',
      },
      body: bytes,
    ),
    _uploadTimeout,
  ).flatMap((http.Response response) => _decode(response, PhotoStoredResponse.fromJson));

  TaskEither<AppFailure, Unit> finish(String host, int port, PairingToken token, TransferFinishRequest request) =>
      _send(
        () => _client.post(
          _uri(host, port, TransferApi.transferFinishPath),
          headers: _headers(token),
          body: jsonEncode(request.toJson()),
        ),
        _messageTimeout,
      ).flatMap(
        (http.Response response) => response.statusCode == 200
            ? TaskEither<AppFailure, Unit>.right(unit)
            : TaskEither<AppFailure, Unit>.left(const TransferRejectedFailure()),
      );

  Uri _uri(String host, int port, String path) => Uri.parse('http://$host:$port$path');

  Map<String, String> _headers(PairingToken token) => <String, String>{
    TransferApi.tokenHeader: token.value,
    'content-type': 'application/json',
  };

  TaskEither<AppFailure, http.Response> _send(Future<http.Response> Function() request, Duration timeout) =>
      TaskEither<AppFailure, http.Response>.tryCatch(() => request().timeout(timeout), (
        Object error,
        StackTrace stackTrace,
      ) {
        log('Computer unreachable', error: error, stackTrace: stackTrace, name: 'transfer');
        return const ComputerUnreachableFailure();
      });

  TaskEither<AppFailure, T> _decode<T>(http.Response response, Option<T> Function(Object? json) fromJson) =>
      TaskEither<AppFailure, T>.fromOption(
        response.statusCode == 200
            ? Either<Object, Object?>.tryCatch(
                () => jsonDecode(response.body),
                (Object error, StackTrace _) => error,
              ).toOption().flatMap(fromJson)
            : none(),
        TransferRejectedFailure.new,
      );
}
