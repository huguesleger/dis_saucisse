import 'package:dis_saucisse_desktop/features/reception/domain/rules/photo_folder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

PhotoUpload _upload({Option<String> eventName = const None()}) => PhotoUpload(
  phoneId: const PhoneId('phone-1'),
  photoId: '1',
  fileName: 'IMG.jpg',
  takenAt: DateTime(2026, 3, 1),
  eventDate: DateTime(2026, 3, 1),
  eventName: eventName,
  decision: PhotoDecisionKind.kept,
  sha256: 'x',
);

void main() {
  test('names an unnamed event folder after its date', () {
    expect(photoFolderSegments(_upload()), <String>['2026', '2026-03 Mars', '2026-03-01']);
  });

  test('removes the characters a file system refuses', () {
    expect(photoFolderSegments(_upload(eventName: some('Pique-nique : 1/2 ?'))).last, '2026-03-01 Pique-nique 1 2');
  });

  test('never overwrites an existing file', () {
    final Set<String> existing = <String>{'IMG.jpg', 'IMG (2).jpg'};

    expect(availableFileName('IMG.jpg', existing.contains), 'IMG (3).jpg');
    expect(availableFileName('autre.jpg', existing.contains), 'autre.jpg');
  });
}
