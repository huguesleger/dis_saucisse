// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PhotoDecisionsTable extends PhotoDecisions with TableInfo<$PhotoDecisionsTable, PhotoDecisionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoDecisionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _photoIdMeta = const VerificationMeta(
    'photoId',
  );
  @override
  late final GeneratedColumn<String> photoId = GeneratedColumn<String>(
    'photo_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decisionMeta = const VerificationMeta(
    'decision',
  );
  @override
  late final GeneratedColumn<String> decision = GeneratedColumn<String>(
    'decision',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decidedAtMeta = const VerificationMeta(
    'decidedAt',
  );
  @override
  late final GeneratedColumn<DateTime> decidedAt = GeneratedColumn<DateTime>(
    'decided_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [photoId, decision, decidedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_decisions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoDecisionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('photo_id')) {
      context.handle(
        _photoIdMeta,
        photoId.isAcceptableOrUnknown(data['photo_id']!, _photoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_photoIdMeta);
    }
    if (data.containsKey('decision')) {
      context.handle(
        _decisionMeta,
        decision.isAcceptableOrUnknown(data['decision']!, _decisionMeta),
      );
    } else if (isInserting) {
      context.missing(_decisionMeta);
    }
    if (data.containsKey('decided_at')) {
      context.handle(
        _decidedAtMeta,
        decidedAt.isAcceptableOrUnknown(data['decided_at']!, _decidedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_decidedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {photoId};
  @override
  PhotoDecisionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoDecisionRow(
      photoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_id'],
      )!,
      decision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision'],
      )!,
      decidedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}decided_at'],
      )!,
    );
  }

  @override
  $PhotoDecisionsTable createAlias(String alias) {
    return $PhotoDecisionsTable(attachedDatabase, alias);
  }
}

class PhotoDecisionRow extends DataClass implements Insertable<PhotoDecisionRow> {
  final String photoId;
  final String decision;
  final DateTime decidedAt;
  const PhotoDecisionRow({
    required this.photoId,
    required this.decision,
    required this.decidedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['photo_id'] = Variable<String>(photoId);
    map['decision'] = Variable<String>(decision);
    map['decided_at'] = Variable<DateTime>(decidedAt);
    return map;
  }

  PhotoDecisionsCompanion toCompanion(bool nullToAbsent) {
    return PhotoDecisionsCompanion(
      photoId: Value(photoId),
      decision: Value(decision),
      decidedAt: Value(decidedAt),
    );
  }

  factory PhotoDecisionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoDecisionRow(
      photoId: serializer.fromJson<String>(json['photoId']),
      decision: serializer.fromJson<String>(json['decision']),
      decidedAt: serializer.fromJson<DateTime>(json['decidedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'photoId': serializer.toJson<String>(photoId),
      'decision': serializer.toJson<String>(decision),
      'decidedAt': serializer.toJson<DateTime>(decidedAt),
    };
  }

  PhotoDecisionRow copyWith({
    String? photoId,
    String? decision,
    DateTime? decidedAt,
  }) => PhotoDecisionRow(
    photoId: photoId ?? this.photoId,
    decision: decision ?? this.decision,
    decidedAt: decidedAt ?? this.decidedAt,
  );
  PhotoDecisionRow copyWithCompanion(PhotoDecisionsCompanion data) {
    return PhotoDecisionRow(
      photoId: data.photoId.present ? data.photoId.value : this.photoId,
      decision: data.decision.present ? data.decision.value : this.decision,
      decidedAt: data.decidedAt.present ? data.decidedAt.value : this.decidedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoDecisionRow(')
          ..write('photoId: $photoId, ')
          ..write('decision: $decision, ')
          ..write('decidedAt: $decidedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(photoId, decision, decidedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoDecisionRow &&
          other.photoId == this.photoId &&
          other.decision == this.decision &&
          other.decidedAt == this.decidedAt);
}

class PhotoDecisionsCompanion extends UpdateCompanion<PhotoDecisionRow> {
  final Value<String> photoId;
  final Value<String> decision;
  final Value<DateTime> decidedAt;
  final Value<int> rowid;
  const PhotoDecisionsCompanion({
    this.photoId = const Value.absent(),
    this.decision = const Value.absent(),
    this.decidedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoDecisionsCompanion.insert({
    required String photoId,
    required String decision,
    required DateTime decidedAt,
    this.rowid = const Value.absent(),
  }) : photoId = Value(photoId),
       decision = Value(decision),
       decidedAt = Value(decidedAt);
  static Insertable<PhotoDecisionRow> custom({
    Expression<String>? photoId,
    Expression<String>? decision,
    Expression<DateTime>? decidedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (photoId != null) 'photo_id': photoId,
      if (decision != null) 'decision': decision,
      if (decidedAt != null) 'decided_at': decidedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoDecisionsCompanion copyWith({
    Value<String>? photoId,
    Value<String>? decision,
    Value<DateTime>? decidedAt,
    Value<int>? rowid,
  }) {
    return PhotoDecisionsCompanion(
      photoId: photoId ?? this.photoId,
      decision: decision ?? this.decision,
      decidedAt: decidedAt ?? this.decidedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (photoId.present) {
      map['photo_id'] = Variable<String>(photoId.value);
    }
    if (decision.present) {
      map['decision'] = Variable<String>(decision.value);
    }
    if (decidedAt.present) {
      map['decided_at'] = Variable<DateTime>(decidedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoDecisionsCompanion(')
          ..write('photoId: $photoId, ')
          ..write('decision: $decision, ')
          ..write('decidedAt: $decidedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PhotoDecisionsTable photoDecisions = $PhotoDecisionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [photoDecisions];
}

typedef $$PhotoDecisionsTableCreateCompanionBuilder =
    PhotoDecisionsCompanion Function({
      required String photoId,
      required String decision,
      required DateTime decidedAt,
      Value<int> rowid,
    });
typedef $$PhotoDecisionsTableUpdateCompanionBuilder =
    PhotoDecisionsCompanion Function({
      Value<String> photoId,
      Value<String> decision,
      Value<DateTime> decidedAt,
      Value<int> rowid,
    });

class $$PhotoDecisionsTableFilterComposer extends Composer<_$AppDatabase, $PhotoDecisionsTable> {
  $$PhotoDecisionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get photoId => $composableBuilder(
    column: $table.photoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get decidedAt => $composableBuilder(
    column: $table.decidedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotoDecisionsTableOrderingComposer extends Composer<_$AppDatabase, $PhotoDecisionsTable> {
  $$PhotoDecisionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get photoId => $composableBuilder(
    column: $table.photoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get decidedAt => $composableBuilder(
    column: $table.decidedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotoDecisionsTableAnnotationComposer extends Composer<_$AppDatabase, $PhotoDecisionsTable> {
  $$PhotoDecisionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get photoId => $composableBuilder(column: $table.photoId, builder: (column) => column);

  GeneratedColumn<String> get decision => $composableBuilder(column: $table.decision, builder: (column) => column);

  GeneratedColumn<DateTime> get decidedAt => $composableBuilder(column: $table.decidedAt, builder: (column) => column);
}

class $$PhotoDecisionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotoDecisionsTable,
          PhotoDecisionRow,
          $$PhotoDecisionsTableFilterComposer,
          $$PhotoDecisionsTableOrderingComposer,
          $$PhotoDecisionsTableAnnotationComposer,
          $$PhotoDecisionsTableCreateCompanionBuilder,
          $$PhotoDecisionsTableUpdateCompanionBuilder,
          (
            PhotoDecisionRow,
            BaseReferences<_$AppDatabase, $PhotoDecisionsTable, PhotoDecisionRow>,
          ),
          PhotoDecisionRow,
          PrefetchHooks Function()
        > {
  $$PhotoDecisionsTableTableManager(
    _$AppDatabase db,
    $PhotoDecisionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PhotoDecisionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PhotoDecisionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PhotoDecisionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> photoId = const Value.absent(),
                Value<String> decision = const Value.absent(),
                Value<DateTime> decidedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoDecisionsCompanion(
                photoId: photoId,
                decision: decision,
                decidedAt: decidedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String photoId,
                required String decision,
                required DateTime decidedAt,
                Value<int> rowid = const Value.absent(),
              }) => PhotoDecisionsCompanion.insert(
                photoId: photoId,
                decision: decision,
                decidedAt: decidedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotoDecisionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotoDecisionsTable,
      PhotoDecisionRow,
      $$PhotoDecisionsTableFilterComposer,
      $$PhotoDecisionsTableOrderingComposer,
      $$PhotoDecisionsTableAnnotationComposer,
      $$PhotoDecisionsTableCreateCompanionBuilder,
      $$PhotoDecisionsTableUpdateCompanionBuilder,
      (
        PhotoDecisionRow,
        BaseReferences<_$AppDatabase, $PhotoDecisionsTable, PhotoDecisionRow>,
      ),
      PhotoDecisionRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PhotoDecisionsTableTableManager get photoDecisions => $$PhotoDecisionsTableTableManager(_db, _db.photoDecisions);
}
