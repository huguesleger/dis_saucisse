import 'package:dis_saucisse_mobile/core/database/app_database.dart';
import 'package:dis_saucisse_mobile/features/burst_sort/data/data_sources/drift_photo_decision_data_source.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DriftPhotoDecisionDataSource dataSource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = DriftPhotoDecisionDataSource(database);
  });

  tearDown(() => database.close());

  test('saves a decision and replaces it when the user changes their mind', () async {
    final DateTime decidedAt = DateTime(2026, 11, 19, 17, 30);
    await dataSource.saveDecision(PhotoDecisionRow(photoId: 'cake-1', decision: 'kept', decidedAt: decidedAt)).run();
    await dataSource
        .saveDecision(PhotoDecisionRow(photoId: 'cake-1', decision: 'discarded', decidedAt: decidedAt))
        .run();

    final rows = (await dataSource.loadDecisions().run()).getOrElse((_) => <PhotoDecisionRow>[]);

    expect(rows.map((PhotoDecisionRow row) => (row.photoId, row.decision)), <(String, String)>[
      ('cake-1', 'discarded'),
    ]);
  });

  test('deletes only the given decisions', () async {
    final DateTime decidedAt = DateTime(2026, 11, 19, 17, 30);
    for (final String id in <String>['cake-1', 'cake-2', 'walk']) {
      await dataSource.saveDecision(PhotoDecisionRow(photoId: id, decision: 'discarded', decidedAt: decidedAt)).run();
    }

    await dataSource.deleteDecisions(<String>['cake-1', 'walk']).run();

    final rows = (await dataSource.loadDecisions().run()).getOrElse((_) => <PhotoDecisionRow>[]);
    expect(rows.map((PhotoDecisionRow row) => row.photoId), <String>['cake-2']);
  });
}
