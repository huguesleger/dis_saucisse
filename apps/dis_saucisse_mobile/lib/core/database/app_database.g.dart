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

class $PhotoTransfersTable extends PhotoTransfers with TableInfo<$PhotoTransfersTable, PhotoTransferRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoTransfersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _computerIdMeta = const VerificationMeta(
    'computerId',
  );
  @override
  late final GeneratedColumn<String> computerId = GeneratedColumn<String>(
    'computer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _byteCountMeta = const VerificationMeta(
    'byteCount',
  );
  @override
  late final GeneratedColumn<int> byteCount = GeneratedColumn<int>(
    'byte_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    photoId,
    computerId,
    sentAt,
    byteCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_transfers';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoTransferRow> instance, {
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
    if (data.containsKey('computer_id')) {
      context.handle(
        _computerIdMeta,
        computerId.isAcceptableOrUnknown(data['computer_id']!, _computerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_computerIdMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    } else if (isInserting) {
      context.missing(_sentAtMeta);
    }
    if (data.containsKey('byte_count')) {
      context.handle(
        _byteCountMeta,
        byteCount.isAcceptableOrUnknown(data['byte_count']!, _byteCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {photoId, computerId};
  @override
  PhotoTransferRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoTransferRow(
      photoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_id'],
      )!,
      computerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}computer_id'],
      )!,
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      )!,
      byteCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}byte_count'],
      )!,
    );
  }

  @override
  $PhotoTransfersTable createAlias(String alias) {
    return $PhotoTransfersTable(attachedDatabase, alias);
  }
}

class PhotoTransferRow extends DataClass implements Insertable<PhotoTransferRow> {
  final String photoId;
  final String computerId;
  final DateTime sentAt;
  final int byteCount;
  const PhotoTransferRow({
    required this.photoId,
    required this.computerId,
    required this.sentAt,
    required this.byteCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['photo_id'] = Variable<String>(photoId);
    map['computer_id'] = Variable<String>(computerId);
    map['sent_at'] = Variable<DateTime>(sentAt);
    map['byte_count'] = Variable<int>(byteCount);
    return map;
  }

  PhotoTransfersCompanion toCompanion(bool nullToAbsent) {
    return PhotoTransfersCompanion(
      photoId: Value(photoId),
      computerId: Value(computerId),
      sentAt: Value(sentAt),
      byteCount: Value(byteCount),
    );
  }

  factory PhotoTransferRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoTransferRow(
      photoId: serializer.fromJson<String>(json['photoId']),
      computerId: serializer.fromJson<String>(json['computerId']),
      sentAt: serializer.fromJson<DateTime>(json['sentAt']),
      byteCount: serializer.fromJson<int>(json['byteCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'photoId': serializer.toJson<String>(photoId),
      'computerId': serializer.toJson<String>(computerId),
      'sentAt': serializer.toJson<DateTime>(sentAt),
      'byteCount': serializer.toJson<int>(byteCount),
    };
  }

  PhotoTransferRow copyWith({
    String? photoId,
    String? computerId,
    DateTime? sentAt,
    int? byteCount,
  }) => PhotoTransferRow(
    photoId: photoId ?? this.photoId,
    computerId: computerId ?? this.computerId,
    sentAt: sentAt ?? this.sentAt,
    byteCount: byteCount ?? this.byteCount,
  );
  PhotoTransferRow copyWithCompanion(PhotoTransfersCompanion data) {
    return PhotoTransferRow(
      photoId: data.photoId.present ? data.photoId.value : this.photoId,
      computerId: data.computerId.present ? data.computerId.value : this.computerId,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      byteCount: data.byteCount.present ? data.byteCount.value : this.byteCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoTransferRow(')
          ..write('photoId: $photoId, ')
          ..write('computerId: $computerId, ')
          ..write('sentAt: $sentAt, ')
          ..write('byteCount: $byteCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(photoId, computerId, sentAt, byteCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoTransferRow &&
          other.photoId == this.photoId &&
          other.computerId == this.computerId &&
          other.sentAt == this.sentAt &&
          other.byteCount == this.byteCount);
}

class PhotoTransfersCompanion extends UpdateCompanion<PhotoTransferRow> {
  final Value<String> photoId;
  final Value<String> computerId;
  final Value<DateTime> sentAt;
  final Value<int> byteCount;
  final Value<int> rowid;
  const PhotoTransfersCompanion({
    this.photoId = const Value.absent(),
    this.computerId = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.byteCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoTransfersCompanion.insert({
    required String photoId,
    required String computerId,
    required DateTime sentAt,
    this.byteCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : photoId = Value(photoId),
       computerId = Value(computerId),
       sentAt = Value(sentAt);
  static Insertable<PhotoTransferRow> custom({
    Expression<String>? photoId,
    Expression<String>? computerId,
    Expression<DateTime>? sentAt,
    Expression<int>? byteCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (photoId != null) 'photo_id': photoId,
      if (computerId != null) 'computer_id': computerId,
      if (sentAt != null) 'sent_at': sentAt,
      if (byteCount != null) 'byte_count': byteCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoTransfersCompanion copyWith({
    Value<String>? photoId,
    Value<String>? computerId,
    Value<DateTime>? sentAt,
    Value<int>? byteCount,
    Value<int>? rowid,
  }) {
    return PhotoTransfersCompanion(
      photoId: photoId ?? this.photoId,
      computerId: computerId ?? this.computerId,
      sentAt: sentAt ?? this.sentAt,
      byteCount: byteCount ?? this.byteCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (photoId.present) {
      map['photo_id'] = Variable<String>(photoId.value);
    }
    if (computerId.present) {
      map['computer_id'] = Variable<String>(computerId.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (byteCount.present) {
      map['byte_count'] = Variable<int>(byteCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoTransfersCompanion(')
          ..write('photoId: $photoId, ')
          ..write('computerId: $computerId, ')
          ..write('sentAt: $sentAt, ')
          ..write('byteCount: $byteCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PhotoDecisionsTable photoDecisions = $PhotoDecisionsTable(this);
  late final $PhotoTransfersTable photoTransfers = $PhotoTransfersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    photoDecisions,
    photoTransfers,
  ];
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
typedef $$PhotoTransfersTableCreateCompanionBuilder =
    PhotoTransfersCompanion Function({
      required String photoId,
      required String computerId,
      required DateTime sentAt,
      Value<int> byteCount,
      Value<int> rowid,
    });
typedef $$PhotoTransfersTableUpdateCompanionBuilder =
    PhotoTransfersCompanion Function({
      Value<String> photoId,
      Value<String> computerId,
      Value<DateTime> sentAt,
      Value<int> byteCount,
      Value<int> rowid,
    });

class $$PhotoTransfersTableFilterComposer extends Composer<_$AppDatabase, $PhotoTransfersTable> {
  $$PhotoTransfersTableFilterComposer({
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

  ColumnFilters<String> get computerId => $composableBuilder(
    column: $table.computerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get byteCount => $composableBuilder(
    column: $table.byteCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotoTransfersTableOrderingComposer extends Composer<_$AppDatabase, $PhotoTransfersTable> {
  $$PhotoTransfersTableOrderingComposer({
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

  ColumnOrderings<String> get computerId => $composableBuilder(
    column: $table.computerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get byteCount => $composableBuilder(
    column: $table.byteCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotoTransfersTableAnnotationComposer extends Composer<_$AppDatabase, $PhotoTransfersTable> {
  $$PhotoTransfersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get photoId => $composableBuilder(column: $table.photoId, builder: (column) => column);

  GeneratedColumn<String> get computerId => $composableBuilder(
    column: $table.computerId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentAt => $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<int> get byteCount => $composableBuilder(column: $table.byteCount, builder: (column) => column);
}

class $$PhotoTransfersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotoTransfersTable,
          PhotoTransferRow,
          $$PhotoTransfersTableFilterComposer,
          $$PhotoTransfersTableOrderingComposer,
          $$PhotoTransfersTableAnnotationComposer,
          $$PhotoTransfersTableCreateCompanionBuilder,
          $$PhotoTransfersTableUpdateCompanionBuilder,
          (
            PhotoTransferRow,
            BaseReferences<_$AppDatabase, $PhotoTransfersTable, PhotoTransferRow>,
          ),
          PhotoTransferRow,
          PrefetchHooks Function()
        > {
  $$PhotoTransfersTableTableManager(
    _$AppDatabase db,
    $PhotoTransfersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PhotoTransfersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PhotoTransfersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PhotoTransfersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> photoId = const Value.absent(),
                Value<String> computerId = const Value.absent(),
                Value<DateTime> sentAt = const Value.absent(),
                Value<int> byteCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoTransfersCompanion(
                photoId: photoId,
                computerId: computerId,
                sentAt: sentAt,
                byteCount: byteCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String photoId,
                required String computerId,
                required DateTime sentAt,
                Value<int> byteCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoTransfersCompanion.insert(
                photoId: photoId,
                computerId: computerId,
                sentAt: sentAt,
                byteCount: byteCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotoTransfersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotoTransfersTable,
      PhotoTransferRow,
      $$PhotoTransfersTableFilterComposer,
      $$PhotoTransfersTableOrderingComposer,
      $$PhotoTransfersTableAnnotationComposer,
      $$PhotoTransfersTableCreateCompanionBuilder,
      $$PhotoTransfersTableUpdateCompanionBuilder,
      (
        PhotoTransferRow,
        BaseReferences<_$AppDatabase, $PhotoTransfersTable, PhotoTransferRow>,
      ),
      PhotoTransferRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PhotoDecisionsTableTableManager get photoDecisions => $$PhotoDecisionsTableTableManager(_db, _db.photoDecisions);
  $$PhotoTransfersTableTableManager get photoTransfers => $$PhotoTransfersTableTableManager(_db, _db.photoTransfers);
}
