import 'package:dis_saucisse_desktop/features/pairing/data/data_sources/stored_identity.dart';
import 'package:dis_saucisse_desktop/features/pairing/data/mappers/pairing_mapper.dart';
import 'package:dis_saucisse_desktop/features/pairing/domain/entities/computer_identity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  test('turns the hostname into a readable computer name', () {
    final ComputerIdentity identity = storedToComputerIdentity(
      const StoredIdentity(computerId: 'id', token: 'token', hostname: 'MacBook-Pro-de-Hugues.local', isMacOS: true),
    );

    expect(identity.name, 'MacBook Pro de Hugues');
    expect(identity.platform, ComputerPlatform.macos);
  });

  test('drops the network domain of the hostname', () {
    final ComputerIdentity identity = storedToComputerIdentity(
      const StoredIdentity(computerId: 'id', token: 'token', hostname: 'mac.home', isMacOS: true),
    );

    expect(identity.name, 'Mac');
  });

  test('builds the QR code content from the identity and the address', () {
    final PairingPayload payload = pairingPayloadFrom(
      storedToComputerIdentity(
        const StoredIdentity(computerId: 'id', token: 'token', hostname: 'PC-SALON', isMacOS: false),
      ),
      host: '192.168.1.24',
      port: 47820,
    );

    expect(payload.computerName, 'PC SALON');
    expect(payload.platform, ComputerPlatform.windows);
    expect(payload.host, '192.168.1.24');
    expect(payload.token, const PairingToken('token'));
  });
}
