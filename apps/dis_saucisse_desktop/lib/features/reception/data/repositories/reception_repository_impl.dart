import 'dart:developer';

import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/reception_server_data_source.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/entities/reception_event.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_failure.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/reception_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceptionRepositoryImpl implements ReceptionRepository {
  ReceptionRepositoryImpl(this._server);

  final ReceptionServerDataSource _server;

  @override
  Stream<ReceptionEvent> get events => _server.receptionEvents;

  @override
  TaskEither<AppFailure, Unit> setPaused(bool paused) => TaskEither<AppFailure, Unit>.tryCatch(
    () async {
      _server.paused = paused;
      return unit;
    },
    (Object error, StackTrace stackTrace) {
      log('Cannot change the pause', error: error, stackTrace: stackTrace, name: 'reception');
      return const PhotoStorageFailure();
    },
  );

  @override
  TaskEither<AppFailure, Unit> openStorageFolder() => TaskEither<AppFailure, Unit>.tryCatch(
    () async {
      await launchUrl(Uri.directory(await _server.storagePath()));
      return unit;
    },
    (Object error, StackTrace stackTrace) {
      log('Cannot open the storage folder', error: error, stackTrace: stackTrace, name: 'reception');
      return const PhotoStorageFailure();
    },
  );
}
