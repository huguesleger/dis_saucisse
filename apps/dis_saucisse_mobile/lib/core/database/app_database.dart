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

@DriftDatabase(tables: <Type>[PhotoDecisions])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'dis_saucisse'));

  @override
  int get schemaVersion => 1;
}
