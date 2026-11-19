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

class $PhotoQualitiesTable extends PhotoQualities with TableInfo<$PhotoQualitiesTable, PhotoQualityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoQualitiesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sharpnessMeta = const VerificationMeta(
    'sharpness',
  );
  @override
  late final GeneratedColumn<double> sharpness = GeneratedColumn<double>(
    'sharpness',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fingerprintMeta = const VerificationMeta(
    'fingerprint',
  );
  @override
  late final GeneratedColumn<int> fingerprint = GeneratedColumn<int>(
    'fingerprint',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _algorithmMeta = const VerificationMeta(
    'algorithm',
  );
  @override
  late final GeneratedColumn<int> algorithm = GeneratedColumn<int>(
    'algorithm',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _analyzedAtMeta = const VerificationMeta(
    'analyzedAt',
  );
  @override
  late final GeneratedColumn<DateTime> analyzedAt = GeneratedColumn<DateTime>(
    'analyzed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    photoId,
    sharpness,
    fingerprint,
    algorithm,
    analyzedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_qualities';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoQualityRow> instance, {
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
    if (data.containsKey('sharpness')) {
      context.handle(
        _sharpnessMeta,
        sharpness.isAcceptableOrUnknown(data['sharpness']!, _sharpnessMeta),
      );
    } else if (isInserting) {
      context.missing(_sharpnessMeta);
    }
    if (data.containsKey('fingerprint')) {
      context.handle(
        _fingerprintMeta,
        fingerprint.isAcceptableOrUnknown(
          data['fingerprint']!,
          _fingerprintMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fingerprintMeta);
    }
    if (data.containsKey('algorithm')) {
      context.handle(
        _algorithmMeta,
        algorithm.isAcceptableOrUnknown(data['algorithm']!, _algorithmMeta),
      );
    }
    if (data.containsKey('analyzed_at')) {
      context.handle(
        _analyzedAtMeta,
        analyzedAt.isAcceptableOrUnknown(data['analyzed_at']!, _analyzedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_analyzedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {photoId};
  @override
  PhotoQualityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoQualityRow(
      photoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_id'],
      )!,
      sharpness: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sharpness'],
      )!,
      fingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fingerprint'],
      )!,
      algorithm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}algorithm'],
      )!,
      analyzedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}analyzed_at'],
      )!,
    );
  }

  @override
  $PhotoQualitiesTable createAlias(String alias) {
    return $PhotoQualitiesTable(attachedDatabase, alias);
  }
}

class PhotoQualityRow extends DataClass implements Insertable<PhotoQualityRow> {
  final String photoId;
  final double sharpness;
  final int fingerprint;
  final int algorithm;
  final DateTime analyzedAt;
  const PhotoQualityRow({
    required this.photoId,
    required this.sharpness,
    required this.fingerprint,
    required this.algorithm,
    required this.analyzedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['photo_id'] = Variable<String>(photoId);
    map['sharpness'] = Variable<double>(sharpness);
    map['fingerprint'] = Variable<int>(fingerprint);
    map['algorithm'] = Variable<int>(algorithm);
    map['analyzed_at'] = Variable<DateTime>(analyzedAt);
    return map;
  }

  PhotoQualitiesCompanion toCompanion(bool nullToAbsent) {
    return PhotoQualitiesCompanion(
      photoId: Value(photoId),
      sharpness: Value(sharpness),
      fingerprint: Value(fingerprint),
      algorithm: Value(algorithm),
      analyzedAt: Value(analyzedAt),
    );
  }

  factory PhotoQualityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoQualityRow(
      photoId: serializer.fromJson<String>(json['photoId']),
      sharpness: serializer.fromJson<double>(json['sharpness']),
      fingerprint: serializer.fromJson<int>(json['fingerprint']),
      algorithm: serializer.fromJson<int>(json['algorithm']),
      analyzedAt: serializer.fromJson<DateTime>(json['analyzedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'photoId': serializer.toJson<String>(photoId),
      'sharpness': serializer.toJson<double>(sharpness),
      'fingerprint': serializer.toJson<int>(fingerprint),
      'algorithm': serializer.toJson<int>(algorithm),
      'analyzedAt': serializer.toJson<DateTime>(analyzedAt),
    };
  }

  PhotoQualityRow copyWith({
    String? photoId,
    double? sharpness,
    int? fingerprint,
    int? algorithm,
    DateTime? analyzedAt,
  }) => PhotoQualityRow(
    photoId: photoId ?? this.photoId,
    sharpness: sharpness ?? this.sharpness,
    fingerprint: fingerprint ?? this.fingerprint,
    algorithm: algorithm ?? this.algorithm,
    analyzedAt: analyzedAt ?? this.analyzedAt,
  );
  PhotoQualityRow copyWithCompanion(PhotoQualitiesCompanion data) {
    return PhotoQualityRow(
      photoId: data.photoId.present ? data.photoId.value : this.photoId,
      sharpness: data.sharpness.present ? data.sharpness.value : this.sharpness,
      fingerprint: data.fingerprint.present ? data.fingerprint.value : this.fingerprint,
      algorithm: data.algorithm.present ? data.algorithm.value : this.algorithm,
      analyzedAt: data.analyzedAt.present ? data.analyzedAt.value : this.analyzedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoQualityRow(')
          ..write('photoId: $photoId, ')
          ..write('sharpness: $sharpness, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('algorithm: $algorithm, ')
          ..write('analyzedAt: $analyzedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(photoId, sharpness, fingerprint, algorithm, analyzedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoQualityRow &&
          other.photoId == this.photoId &&
          other.sharpness == this.sharpness &&
          other.fingerprint == this.fingerprint &&
          other.algorithm == this.algorithm &&
          other.analyzedAt == this.analyzedAt);
}

class PhotoQualitiesCompanion extends UpdateCompanion<PhotoQualityRow> {
  final Value<String> photoId;
  final Value<double> sharpness;
  final Value<int> fingerprint;
  final Value<int> algorithm;
  final Value<DateTime> analyzedAt;
  final Value<int> rowid;
  const PhotoQualitiesCompanion({
    this.photoId = const Value.absent(),
    this.sharpness = const Value.absent(),
    this.fingerprint = const Value.absent(),
    this.algorithm = const Value.absent(),
    this.analyzedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoQualitiesCompanion.insert({
    required String photoId,
    required double sharpness,
    required int fingerprint,
    this.algorithm = const Value.absent(),
    required DateTime analyzedAt,
    this.rowid = const Value.absent(),
  }) : photoId = Value(photoId),
       sharpness = Value(sharpness),
       fingerprint = Value(fingerprint),
       analyzedAt = Value(analyzedAt);
  static Insertable<PhotoQualityRow> custom({
    Expression<String>? photoId,
    Expression<double>? sharpness,
    Expression<int>? fingerprint,
    Expression<int>? algorithm,
    Expression<DateTime>? analyzedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (photoId != null) 'photo_id': photoId,
      if (sharpness != null) 'sharpness': sharpness,
      if (fingerprint != null) 'fingerprint': fingerprint,
      if (algorithm != null) 'algorithm': algorithm,
      if (analyzedAt != null) 'analyzed_at': analyzedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoQualitiesCompanion copyWith({
    Value<String>? photoId,
    Value<double>? sharpness,
    Value<int>? fingerprint,
    Value<int>? algorithm,
    Value<DateTime>? analyzedAt,
    Value<int>? rowid,
  }) {
    return PhotoQualitiesCompanion(
      photoId: photoId ?? this.photoId,
      sharpness: sharpness ?? this.sharpness,
      fingerprint: fingerprint ?? this.fingerprint,
      algorithm: algorithm ?? this.algorithm,
      analyzedAt: analyzedAt ?? this.analyzedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (photoId.present) {
      map['photo_id'] = Variable<String>(photoId.value);
    }
    if (sharpness.present) {
      map['sharpness'] = Variable<double>(sharpness.value);
    }
    if (fingerprint.present) {
      map['fingerprint'] = Variable<int>(fingerprint.value);
    }
    if (algorithm.present) {
      map['algorithm'] = Variable<int>(algorithm.value);
    }
    if (analyzedAt.present) {
      map['analyzed_at'] = Variable<DateTime>(analyzedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoQualitiesCompanion(')
          ..write('photoId: $photoId, ')
          ..write('sharpness: $sharpness, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('algorithm: $algorithm, ')
          ..write('analyzedAt: $analyzedAt, ')
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
  late final $PhotoQualitiesTable photoQualities = $PhotoQualitiesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    photoDecisions,
    photoTransfers,
    photoQualities,
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
typedef $$PhotoQualitiesTableCreateCompanionBuilder =
    PhotoQualitiesCompanion Function({
      required String photoId,
      required double sharpness,
      required int fingerprint,
      Value<int> algorithm,
      required DateTime analyzedAt,
      Value<int> rowid,
    });
typedef $$PhotoQualitiesTableUpdateCompanionBuilder =
    PhotoQualitiesCompanion Function({
      Value<String> photoId,
      Value<double> sharpness,
      Value<int> fingerprint,
      Value<int> algorithm,
      Value<DateTime> analyzedAt,
      Value<int> rowid,
    });

class $$PhotoQualitiesTableFilterComposer extends Composer<_$AppDatabase, $PhotoQualitiesTable> {
  $$PhotoQualitiesTableFilterComposer({
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

  ColumnFilters<double> get sharpness => $composableBuilder(
    column: $table.sharpness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get algorithm => $composableBuilder(
    column: $table.algorithm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get analyzedAt => $composableBuilder(
    column: $table.analyzedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotoQualitiesTableOrderingComposer extends Composer<_$AppDatabase, $PhotoQualitiesTable> {
  $$PhotoQualitiesTableOrderingComposer({
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

  ColumnOrderings<double> get sharpness => $composableBuilder(
    column: $table.sharpness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get algorithm => $composableBuilder(
    column: $table.algorithm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get analyzedAt => $composableBuilder(
    column: $table.analyzedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotoQualitiesTableAnnotationComposer extends Composer<_$AppDatabase, $PhotoQualitiesTable> {
  $$PhotoQualitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get photoId => $composableBuilder(column: $table.photoId, builder: (column) => column);

  GeneratedColumn<double> get sharpness => $composableBuilder(column: $table.sharpness, builder: (column) => column);

  GeneratedColumn<int> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<int> get algorithm => $composableBuilder(column: $table.algorithm, builder: (column) => column);

  GeneratedColumn<DateTime> get analyzedAt => $composableBuilder(
    column: $table.analyzedAt,
    builder: (column) => column,
  );
}

class $$PhotoQualitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotoQualitiesTable,
          PhotoQualityRow,
          $$PhotoQualitiesTableFilterComposer,
          $$PhotoQualitiesTableOrderingComposer,
          $$PhotoQualitiesTableAnnotationComposer,
          $$PhotoQualitiesTableCreateCompanionBuilder,
          $$PhotoQualitiesTableUpdateCompanionBuilder,
          (
            PhotoQualityRow,
            BaseReferences<_$AppDatabase, $PhotoQualitiesTable, PhotoQualityRow>,
          ),
          PhotoQualityRow,
          PrefetchHooks Function()
        > {
  $$PhotoQualitiesTableTableManager(
    _$AppDatabase db,
    $PhotoQualitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PhotoQualitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PhotoQualitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PhotoQualitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> photoId = const Value.absent(),
                Value<double> sharpness = const Value.absent(),
                Value<int> fingerprint = const Value.absent(),
                Value<int> algorithm = const Value.absent(),
                Value<DateTime> analyzedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoQualitiesCompanion(
                photoId: photoId,
                sharpness: sharpness,
                fingerprint: fingerprint,
                algorithm: algorithm,
                analyzedAt: analyzedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String photoId,
                required double sharpness,
                required int fingerprint,
                Value<int> algorithm = const Value.absent(),
                required DateTime analyzedAt,
                Value<int> rowid = const Value.absent(),
              }) => PhotoQualitiesCompanion.insert(
                photoId: photoId,
                sharpness: sharpness,
                fingerprint: fingerprint,
                algorithm: algorithm,
                analyzedAt: analyzedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotoQualitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotoQualitiesTable,
      PhotoQualityRow,
      $$PhotoQualitiesTableFilterComposer,
      $$PhotoQualitiesTableOrderingComposer,
      $$PhotoQualitiesTableAnnotationComposer,
      $$PhotoQualitiesTableCreateCompanionBuilder,
      $$PhotoQualitiesTableUpdateCompanionBuilder,
      (
        PhotoQualityRow,
        BaseReferences<_$AppDatabase, $PhotoQualitiesTable, PhotoQualityRow>,
      ),
      PhotoQualityRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PhotoDecisionsTableTableManager get photoDecisions => $$PhotoDecisionsTableTableManager(_db, _db.photoDecisions);
  $$PhotoTransfersTableTableManager get photoTransfers => $$PhotoTransfersTableTableManager(_db, _db.photoTransfers);
  $$PhotoQualitiesTableTableManager get photoQualities => $$PhotoQualitiesTableTableManager(_db, _db.photoQualities);
}
