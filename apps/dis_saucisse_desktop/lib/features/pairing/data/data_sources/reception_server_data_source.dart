import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_failure.dart';
import 'package:dis_saucisse_desktop/features/reception/data/data_sources/photo_storage_data_source.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:transfer_protocol/transfer_protocol.dart';

class ReceptionServerDataSource {
  ReceptionServerDataSource(this._storage);

  final PhotoStorageDataSource _storage;
  final StreamController<PairRequest> _pairRequests = StreamController<PairRequest>.broadcast();
  final StreamController<ReceptionEvent> _receptionEvents = StreamController<ReceptionEvent>.broadcast();
  Option<HttpServer> _server = none();

  Stream<PairRequest> get pairRequests => _pairRequests.stream;

  Stream<ReceptionEvent> get receptionEvents => _receptionEvents.stream;

  String get storagePath => _storage.root.path;

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
    final List<String> segments = request.url.pathSegments;
    final bool isPhotoUpload = segments.length == 3 && '/${segments[0]}/${segments[1]}/' == TransferApi.photosPath;
    return switch ((request.method, path, authorized)) {
      (_, _, false) => Response.forbidden('Code d’association invalide'),
      ('GET', TransferApi.statusPath, true) => _json(identity.toJson()),
      ('POST', TransferApi.pairPath, true) => await _pair(request, identity),
      ('POST', TransferApi.transferStartPath, true) => await _startTransfer(request),
      ('POST', TransferApi.transferFinishPath, true) => await _finishTransfer(request),
      ('PUT', _, true) when isPhotoUpload => await _receivePhoto(segments[2], request),
      _ => Response.notFound('Inconnu'),
    };
  };

  Future<Response> _pair(Request request, PairResponse identity) async =>
      (await _readJson(request)).flatMap(PairRequest.fromJson).match(
        () => Response.badRequest(body: 'Demande invalide'),
        (PairRequest pair) {
          _pairRequests.add(pair);
          return _json(identity.toJson());
        },
      );

  Future<Response> _startTransfer(Request request) async =>
      (await _readJson(request)).flatMap(TransferStartRequest.fromJson).match(
        () async => Response.badRequest(body: 'Demande invalide'),
        (TransferStartRequest start) async {
          final Set<String> received = await _storage.receivedPhotoIds(start.phoneId);
          final List<String> missing = start.photoIds.where((String id) => !received.contains(id)).toList();
          if (missing.isNotEmpty) {
            _receptionEvents.add(TransferStarted(phoneName: start.phoneName, photoCount: missing.length));
          }
          return _json(TransferStartResponse(missingPhotoIds: missing).toJson());
        },
      );

  Future<Response> _finishTransfer(Request request) async =>
      (await _readJson(request)).flatMap(TransferFinishRequest.fromJson).match(
        () => Response.badRequest(body: 'Demande invalide'),
        (TransferFinishRequest finish) {
          _receptionEvents.add(TransferFinished(photoCount: finish.sentCount));
          return Response.ok('');
        },
      );

  Future<Response> _receivePhoto(String photoId, Request request) =>
      PhotoUpload.fromHeaders(photoId, request.headers).match(
        () async => Response.badRequest(body: 'Photo incomplète'),
        (PhotoUpload upload) =>
            TaskEither<Object, String>.tryCatch(
                  () => _storage.store(upload, request.read()),
                  (Object error, StackTrace stackTrace) {
                    log('Photo not stored', error: error, stackTrace: stackTrace, name: 'reception');
                    return error;
                  },
                )
                .match(
                  (Object error) {
                    _receptionEvents.add(const PhotoRejected());
                    return error is ChecksumMismatchException
                        ? Response(422, body: 'Photo abîmée pendant l’envoi')
                        : Response.internalServerError(body: 'Photo non enregistrée');
                  },
                  (String folder) {
                    _receptionEvents.add(
                      PhotoReceived(folder: folder, byteCount: request.contentLength ?? 0, decision: upload.decision),
                    );
                    return _json(PhotoStoredResponse(folder: folder).toJson());
                  },
                )
                .run(),
      );

  Future<Option<Object?>> _readJson(Request request) async {
    final String body = await request.readAsString();
    return Either<Object, Object?>.tryCatch(() => jsonDecode(body), (Object error, StackTrace _) => error).toOption();
  }

  Response _json(Map<String, Object> body) =>
      Response.ok(jsonEncode(body), headers: <String, String>{'content-type': 'application/json'});

  AppFailure _failure(Object error, StackTrace stackTrace) {
    log('Reception server failed', error: error, stackTrace: stackTrace, name: 'pairing');
    return const ReceptionServerFailure();
  }
}
