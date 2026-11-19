import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/stored_identity.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/stored_paired_phone.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/computer_identity.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/paired_phone.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

String _readableHostname(String hostname) {
  final String name = hostname.split('.').first.replaceAll('-', ' ');
  return name.isEmpty ? 'Ordinateur' : '${name[0].toUpperCase()}${name.substring(1)}';
}

ComputerIdentity storedToComputerIdentity(StoredIdentity stored) => ComputerIdentity(
  id: ComputerId(stored.computerId),
  name: _readableHostname(stored.hostname),
  platform: stored.isMacOS ? ComputerPlatform.macos : ComputerPlatform.windows,
  token: PairingToken(stored.token),
);

PairedPhone storedToPairedPhone(StoredPairedPhone stored) => PairedPhone(
  id: PhoneId(stored.id),
  name: stored.name,
  pairedAt: DateTime.fromMillisecondsSinceEpoch(stored.pairedAtMilliseconds),
);

StoredPairedPhone pairedPhoneToStored(PairedPhone phone) => StoredPairedPhone(
  id: phone.id.value,
  name: phone.name,
  pairedAtMilliseconds: phone.pairedAt.millisecondsSinceEpoch,
);

PairedPhone pairRequestToPairedPhone(PairRequest request, DateTime pairedAt) =>
    PairedPhone(id: request.phoneId, name: request.phoneName, pairedAt: pairedAt);

PairingPayload pairingPayloadFrom(ComputerIdentity identity, {required String host, required int port}) =>
    PairingPayload(
      computerId: identity.id,
      computerName: identity.name,
      platform: identity.platform,
      host: host,
      port: port,
      token: identity.token,
    );
