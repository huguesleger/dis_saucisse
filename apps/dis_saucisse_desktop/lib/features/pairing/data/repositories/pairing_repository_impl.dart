import 'package:core/core.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/local_network_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/pairing_storage_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/reception_server_data_source.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/stored_paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/mappers/pairing_mapper.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/computer_identity.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/pairing_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

class PairingRepositoryImpl implements PairingRepository {
  PairingRepositoryImpl({
    required PairingStorageDataSource storage,
    required LocalNetworkDataSource network,
    required ReceptionServerDataSource server,
    DateTime Function()? clock,
  }) : _storage = storage,
       _network = network,
       _server = server,
       _clock = clock ?? DateTime.now;

  final PairingStorageDataSource _storage;
  final LocalNetworkDataSource _network;
  final ReceptionServerDataSource _server;
  final DateTime Function() _clock;

  @override
  TaskEither<AppFailure, PairingPayload> startReception() => TaskEither<AppFailure, PairingPayload>.Do(($) async {
    final ComputerIdentity identity = storedToComputerIdentity(await $(_storage.loadOrCreateIdentity()));
    final String host = await $(_network.localIpv4Address());
    await $(
      _server.start(
        port: TransferApi.defaultPort,
        token: identity.token,
        identity: PairResponse(computerId: identity.id, computerName: identity.name),
      ),
    );
    return pairingPayloadFrom(identity, host: host, port: TransferApi.defaultPort);
  });

  @override
  TaskEither<AppFailure, Unit> stopReception() => _server.stop();

  @override
  Stream<PairedPhone> get pairedPhones =>
      _server.pairRequests.map((PairRequest request) => pairRequestToPairedPhone(request, _clock()));

  @override
  TaskEither<AppFailure, List<PairedPhone>> loadPairedPhones() => _storage.loadPairedPhones().map(
    (List<StoredPairedPhone> phones) => phones.map(storedToPairedPhone).toList(),
  );

  @override
  TaskEither<AppFailure, Unit> savePairedPhone(PairedPhone phone) =>
      _storage.savePairedPhone(pairedPhoneToStored(phone));
}
