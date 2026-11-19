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

    await dataSource.markSent('mac', <String, int>{'a': 100, 'b': 200}, sentAt).run();
    await dataSource.markSent('mac', <String, int>{'b': 250}, sentAt).run();
    await dataSource.markSent('windows', <String, int>{'c': 300}, sentAt).run();

    final Set<String> sentToMac = (await dataSource.loadSentPhotoIds('mac').run()).getOrElse((_) => <String>{});
    expect(sentToMac, <String>{'a', 'b'});
    expect(
      (await dataSource.loadSentPhotoBytes().run()).getOrElse((_) => <String, int>{}),
      <String, int>{'a': 100, 'b': 250, 'c': 300},
    );
  });
}
