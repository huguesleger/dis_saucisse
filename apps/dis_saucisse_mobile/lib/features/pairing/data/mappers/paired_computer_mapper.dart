import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/stored_paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

PairedComputer invitationToPairedComputer(PairingPayload invitation, PairResponse response) => PairedComputer(
  id: response.computerId,
  name: response.computerName,
  platform: invitation.platform,
  host: invitation.host,
  port: invitation.port,
  token: invitation.token,
);

StoredPairedComputer pairedComputerToStored(PairedComputer computer) => StoredPairedComputer(
  id: computer.id.value,
  name: computer.name,
  platform: computer.platform.name,
  host: computer.host,
  port: computer.port,
  token: computer.token.value,
);

Option<PairedComputer> storedToPairedComputer(StoredPairedComputer stored) =>
    Option<ComputerPlatform>.fromNullable(
      ComputerPlatform.values.where((ComputerPlatform platform) => platform.name == stored.platform).firstOrNull,
    ).map(
      (ComputerPlatform platform) => PairedComputer(
        id: ComputerId(stored.id),
        name: stored.name,
        platform: platform,
        host: stored.host,
        port: stored.port,
        token: PairingToken(stored.token),
      ),
    );
