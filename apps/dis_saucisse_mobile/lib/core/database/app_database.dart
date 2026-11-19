import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('PhotoDecisionRow')
class PhotoDecisions extends Table {
  TextColumn get photoId => text()();

  TextColumn get decision => text()();

  DateTimeColumn get decidedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{photoId};
}

@DataClassName('PhotoTransferRow')
class PhotoTransfers extends Table {
  TextColumn get photoId => text()();

  TextColumn get computerId => text()();

  DateTimeColumn get sentAt => dateTime()();

  IntColumn get byteCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{photoId, computerId};
}

@DriftDatabase(tables: <Type>[PhotoDecisions, PhotoTransfers])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'dis_saucisse'));

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (Migrator migrator, int from, int to) async {
      if (from < 2) await migrator.createTable(photoTransfers);
      if (from == 2) await migrator.addColumn(photoTransfers, photoTransfers.byteCount);
    },
  );
}
