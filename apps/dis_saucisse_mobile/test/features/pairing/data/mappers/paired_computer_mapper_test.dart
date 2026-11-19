import 'package:dis_saucisse_mobile/features/pairing/data/data_sources/stored_paired_computer.dart';
import 'package:dis_saucisse_mobile/features/pairing/data/mappers/paired_computer_mapper.dart';
import 'package:dis_saucisse_mobile/features/pairing/domain/entities/paired_computer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  test('round-trips a paired computer through its stored form', () {
    final PairedComputer computer = invitationToPairedComputer(
      const PairingPayload(
        computerId: ComputerId('computer-1'),
        computerName: 'Ancien nom',
        platform: ComputerPlatform.windows,
        host: '192.168.1.24',
        port: 47820,
        token: PairingToken('secret'),
      ),
      const PairResponse(computerId: ComputerId('computer-1'), computerName: 'PC du salon'),
    );

    final PairedComputer restored = StoredPairedComputer.fromJson(
      pairedComputerToStored(computer).toJson(),
    ).flatMap(storedToPairedComputer).toNullable()!;

    expect(restored.name, 'PC du salon');
    expect(restored.platform, ComputerPlatform.windows);
    expect(restored.host, '192.168.1.24');
    expect(restored.token, const PairingToken('secret'));
  });
}
