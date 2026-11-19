import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/pairing_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:transfer_protocol/transfer_protocol.dart';

class PairingApiDataSource {
  PairingApiDataSource({http.Client? client}) : _client = client ?? http.Client();

  static const Duration _timeout = Duration(seconds: 6);

  final http.Client _client;

  TaskEither<AppFailure, PairResponse> pair(PairingPayload invitation, PairRequest request) =>
      TaskEither<AppFailure, http.Response>.tryCatch(
        () => _client
            .post(
              Uri(scheme: 'http', host: invitation.host, port: invitation.port, path: TransferApi.pairPath),
              headers: <String, String>{
                TransferApi.tokenHeader: invitation.token.value,
                'content-type': 'application/json',
              },
              body: jsonEncode(request.toJson()),
            )
            .timeout(_timeout),
        (Object error, StackTrace stackTrace) {
          log('Computer unreachable', error: error, stackTrace: stackTrace, name: 'pairing');
          return const ComputerUnreachableFailure();
        },
      ).flatMap(_pairResponse);

  TaskEither<AppFailure, PairResponse> _pairResponse(http.Response response) =>
      TaskEither<AppFailure, PairResponse>.fromOption(
        response.statusCode == 200
            ? Either<Object, Object?>.tryCatch(
                () => jsonDecode(response.body),
                (Object error, StackTrace _) => error,
              ).toOption().flatMap(PairResponse.fromJson)
            : none(),
        PairingRefusedFailure.new,
      );
}
