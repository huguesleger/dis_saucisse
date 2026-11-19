import 'package:fpdart/fpdart.dart';
import 'package:test/test.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  const PairingPayload payload = PairingPayload(
    computerId: ComputerId('computer-1'),
    computerName: 'PC du salon',
    platform: ComputerPlatform.windows,
    host: '192.168.1.24',
    port: TransferApi.defaultPort,
    token: PairingToken('secret'),
  );

  test('decodes what it encodes', () {
    final PairingPayload decoded = PairingPayload.decode(payload.encode()).toNullable()!;

    expect(decoded.computerId, payload.computerId);
    expect(decoded.computerName, 'PC du salon');
    expect(decoded.platform, ComputerPlatform.windows);
    expect(decoded.host, '192.168.1.24');
    expect(decoded.port, TransferApi.defaultPort);
    expect(decoded.token, const PairingToken('secret'));
  });

  test('ignores a QR code that is not JSON', () {
    expect(PairingPayload.decode('https://example.com').isNone(), isTrue);
  });

  test('ignores JSON from another app or version', () {
    expect(PairingPayload.decode('{"app":"other","v":1}').isNone(), isTrue);
    expect(PairingPayload.decode(payload.encode().replaceFirst('"v":1', '"v":2')).isNone(), isTrue);
  });

  test('reads pairing messages', () {
    expect(
      PairRequest.fromJson(
        const PairRequest(phoneId: PhoneId('p'), phoneName: 'iPhone').toJson(),
      ).map((PairRequest r) => r.phoneName),
      some('iPhone'),
    );
    expect(PairResponse.fromJson(<String, Object>{'computerId': 1}).isNone(), isTrue);
  });
}
