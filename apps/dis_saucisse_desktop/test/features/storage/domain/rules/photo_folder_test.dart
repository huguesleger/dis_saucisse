import 'package:dis_saucisse_desktop/features/storage/domain/entities/month_folder_format.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/rules/photo_folder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

PhotoUpload _upload({
  Option<String> eventName = const None(),
  PhotoDecisionKind decision = PhotoDecisionKind.kept,
  DateTime? eventDate,
}) => PhotoUpload(
  phoneId: const PhoneId('phone-1'),
  photoId: '1',
  fileName: 'IMG_2034.HEIC',
  takenAt: DateTime(2026, 3, 1, 14, 5, 9),
  eventDate: eventDate ?? DateTime(2026, 3, 1, 14),
  eventName: eventName,
  decision: decision,
  sha256: 'x',
);

void main() {
  test('names an unnamed event folder after its date', () {
    expect(photoFolderSegments(_upload(), StorageLayout.defaults), <String>['2026', '2026-03 Mars', '2026-03-01']);
  });

  test('removes the characters a file system refuses', () {
    expect(
      photoFolderSegments(_upload(eventName: some('Pique-nique : 1/2 ?')), StorageLayout.defaults).last,
      '2026-03-01 Pique-nique 1 2',
    );
  });

  test('puts discarded photos in their own subfolder', () {
    expect(
      photoFolderSegments(_upload(decision: PhotoDecisionKind.discarded), StorageLayout.defaults).last,
      discardedFolderName,
    );
  });

  test('follows the chosen layout', () {
    final StorageLayout monthsOnly = StorageLayout.defaults.copyWith(
      byYear: false,
      byEvent: false,
      discardedSubfolder: false,
      monthFormat: MonthFolderFormat.monthNumberName,
    );

    expect(photoFolderSegments(_upload(decision: PhotoDecisionKind.discarded), monthsOnly), <String>['03 Mars']);
    expect(monthFolderName(DateTime(2026, 8), MonthFolderFormat.monthName), 'Août');
  });

  test('keeps the original file name unless asked to rename it', () {
    expect(storedFileName(_upload(), StorageLayout.defaults), 'IMG_2034.HEIC');
    expect(storedFileName(_upload(), StorageLayout.defaults.copyWith(renameFiles: true)), '2026-03-01 14.05.09.heic');
  });

  test('never overwrites an existing file', () {
    final Set<String> existing = <String>{'IMG.jpg', 'IMG (2).jpg'};

    expect(availableFileName('IMG.jpg', existing.contains), 'IMG (3).jpg');
    expect(availableFileName('autre.jpg', existing.contains), 'autre.jpg');
  });

  test('tells two events of the same day apart', () {
    expect(
      eventKeyOf(_upload(eventDate: DateTime(2026, 3, 1, 9))),
      isNot(eventKeyOf(_upload(eventDate: DateTime(2026, 3, 1, 18)))),
    );
  });
}
