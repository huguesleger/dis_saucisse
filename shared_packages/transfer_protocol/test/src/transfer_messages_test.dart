import 'package:fpdart/fpdart.dart';
import 'package:test/test.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  test('reads back a photo upload from its headers', () {
    final PhotoUpload upload = PhotoUpload(
      phoneId: const PhoneId('phone-1'),
      photoId: 'asset/1',
      fileName: 'IMG_2034 copie.HEIC',
      takenAt: DateTime(2026, 11, 8, 14, 30),
      eventDate: DateTime(2026, 11, 8, 14),
      eventName: some('Anniversaire de mamie'),
      decision: PhotoDecisionKind.discarded,
      sha256: 'abc123',
    );

    final PhotoUpload restored = PhotoUpload.fromHeaders('asset/1', upload.toHeaders()).toNullable()!;

    expect(restored.fileName, 'IMG_2034 copie.HEIC');
    expect(restored.takenAt, DateTime(2026, 11, 8, 14, 30));
    expect(restored.eventName, some('Anniversaire de mamie'));
    expect(restored.decision, PhotoDecisionKind.discarded);
    expect(restored.sha256, 'abc123');
  });

  test('reads an upload without event name', () {
    final PhotoUpload upload = PhotoUpload(
      phoneId: const PhoneId('phone-1'),
      photoId: '1',
      fileName: 'IMG.jpg',
      takenAt: DateTime(2026, 11, 8),
      eventDate: DateTime(2026, 11, 8),
      eventName: none(),
      decision: PhotoDecisionKind.kept,
      sha256: 'abc',
    );

    expect(PhotoUpload.fromHeaders('1', upload.toHeaders()).flatMap((PhotoUpload u) => u.eventName), none<String>());
  });

  test('rejects an upload missing its checksum', () {
    expect(PhotoUpload.fromHeaders('1', <String, String>{}).isNone(), isTrue);
  });

  test('reads transfer messages', () {
    const TransferStartRequest start = TransferStartRequest(
      phoneId: PhoneId('phone-1'),
      phoneName: 'iPhone',
      photoIds: <String>['a', 'b'],
    );
    expect(TransferStartRequest.fromJson(start.toJson()).toNullable()?.photoIds, <String>['a', 'b']);
    expect(
      TransferStartResponse.fromJson(<String, Object>{
        'missingPhotoIds': <Object>['a', 1],
      }).isNone(),
      isTrue,
    );
    expect(
      TransferFinishRequest.fromJson(
        const TransferFinishRequest(phoneId: PhoneId('p'), sentCount: 3).toJson(),
      ).map((TransferFinishRequest r) => r.sentCount),
      some(3),
    );
  });

  test('builds the upload path of a photo', () {
    expect(TransferApi.photoPath('ABC/L0/001'), '/v1/photos/ABC%2FL0%2F001');
  });
}
