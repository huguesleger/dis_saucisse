import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/transfer/data/data_sources/sent_photo_data_source.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() => database = AppDatabase(NativeDatabase.memory()));

  tearDown(() => database.close());

  test('remembers which photos were sent to which computer', () async {
    final SentPhotoDataSource dataSource = SentPhotoDataSource(database);
    final DateTime sentAt = DateTime(2026, 11, 19, 21);

    await dataSource.markSent('mac', <String>['a', 'b'], sentAt).run();
    await dataSource.markSent('mac', <String>['b'], sentAt).run();
    await dataSource.markSent('windows', <String>['c'], sentAt).run();

    final Set<String> sentToMac = (await dataSource.loadSentPhotoIds('mac').run()).getOrElse((_) => <String>{});
    expect(sentToMac, <String>{'a', 'b'});
  });
}
