import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dis_saucisse_desktop/features/reception/data/data_sources/photo_storage_data_source.dart';
import 'package:dis_saucisse_desktop/features/storage/domain/entities/storage_layout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:transfer_protocol/transfer_protocol.dart';

void main() {
  late Directory root;
  final List<int> bytes = <int>[1, 2, 3, 4];

  PhotoUpload upload(String photoId) => PhotoUpload(
    phoneId: const PhoneId('phone-1'),
    photoId: photoId,
    fileName: 'IMG_2034.jpg',
    takenAt: DateTime(2026, 11, 8, 14, 30, 5),
    eventDate: DateTime(2026, 11, 8, 14),
    eventName: some('Anniversaire'),
    decision: PhotoDecisionKind.discarded,
    sha256: sha256.convert(bytes).toString(),
  );

  setUp(() async => root = await Directory.systemTemp.createTemp('photo_storage_test'));

  tearDown(() => root.delete(recursive: true));

  test('stores photos with the chosen layout without overwriting any', () async {
    final PhotoStorageDataSource storage = PhotoStorageDataSource.fixed(
      root,
      layout: StorageLayout.defaults.copyWith(
        byYear: false,
        byEvent: false,
        discardedSubfolder: false,
        renameFiles: true,
      ),
    );

    final StoredPhotoFile first = await storage.store(upload('a'), Stream<List<int>>.value(bytes));
    await storage.store(upload('b'), Stream<List<int>>.value(bytes));

    expect(first.folder, '2026-11 Novembre');
    expect(first.filePath, '${root.path}/2026-11 Novembre/2026-11-08 14.30.05.jpg');
    expect(
      Directory(
        '${root.path}/2026-11 Novembre',
      ).listSync().map((FileSystemEntity f) => f.uri.pathSegments.last).toSet(),
      <String>{'2026-11-08 14.30.05.jpg', '2026-11-08 14.30.05 (2).jpg'},
    );
    expect(await storage.receivedPhotoIds(const PhoneId('phone-1')), <String>{'a', 'b'});
  });

  test('throws away a photo whose checksum does not match', () async {
    final PhotoStorageDataSource storage = PhotoStorageDataSource.fixed(root);

    await expectLater(
      storage.store(upload('a'), Stream<List<int>>.value(<int>[9, 9])),
      throwsA(isA<ChecksumMismatchException>()),
    );
    expect(await storage.receivedPhotoIds(const PhoneId('phone-1')), isEmpty);
  });
}
