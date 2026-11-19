import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:transfer_protocol/transfer_protocol.dart';

class ReceptionServerDataSource {
  final StreamController<PairRequest> _pairRequests = StreamController<PairRequest>.broadcast();
  Option<HttpServer> _server = none();

  Stream<PairRequest> get pairRequests => _pairRequests.stream;

  TaskEither<AppFailure, Unit> start({
    required int port,
    required PairingToken token,
    required PairResponse identity,
  }) => TaskEither<AppFailure, Unit>.tryCatch(() async {
    await _close();
    _server = some(await shelf_io.serve(_handler(token, identity), InternetAddress.anyIPv4, port, shared: true));
    return unit;
  }, _failure);

  TaskEither<AppFailure, Unit> stop() => TaskEither<AppFailure, Unit>.tryCatch(() async {
    await _close();
    return unit;
  }, _failure);

  Future<void> _close() async {
    await _server.match(() async {}, (HttpServer server) => server.close(force: true));
    _server = none();
  }

  Handler _handler(PairingToken token, PairResponse identity) => (Request request) async {
    final String path = '/${request.url.path}';
    final bool authorized = request.headers[TransferApi.tokenHeader] == token.value;
    return switch ((request.method, path, authorized)) {
      ('GET', TransferApi.statusPath, true) => _json(identity.toJson()),
      ('POST', TransferApi.pairPath, true) => await _pair(request, identity),
      (_, _, false) => Response.forbidden('Code d’association invalide'),
      _ => Response.notFound('Inconnu'),
    };
  };

  Future<Response> _pair(Request request, PairResponse identity) async {
    final String body = await request.readAsString();
    final Option<PairRequest> pairRequest = Either<Object, Object?>.tryCatch(
      () => jsonDecode(body),
      (Object error, StackTrace _) => error,
    ).toOption().flatMap(PairRequest.fromJson);
    return pairRequest.match(() => Response.badRequest(body: 'Demande invalide'), (PairRequest pair) {
      _pairRequests.add(pair);
      return _json(identity.toJson());
    });
  }

  Response _json(Map<String, Object> body) =>
      Response.ok(jsonEncode(body), headers: <String, String>{'content-type': 'application/json'});

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Reception server failed', error: error, stackTrace: stackTrace, name: 'pairing');
    return const ReceptionServerFailure();
  }
}
