// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CoffeeLotsTable extends CoffeeLots
    with TableInfo<$CoffeeLotsTable, CoffeeLot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeeLotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMMeta = const VerificationMeta(
    'altitudeM',
  );
  @override
  late final GeneratedColumn<int> altitudeM = GeneratedColumn<int>(
    'altitude_m',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _processMethodMeta = const VerificationMeta(
    'processMethod',
  );
  @override
  late final GeneratedColumn<String> processMethod = GeneratedColumn<String>(
    'process_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qGradeScoreMeta = const VerificationMeta(
    'qGradeScore',
  );
  @override
  late final GeneratedColumn<double> qGradeScore = GeneratedColumn<double>(
    'q_grade_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    region,
    altitudeM,
    processMethod,
    qGradeScore,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffee_lots';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoffeeLot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    if (data.containsKey('altitude_m')) {
      context.handle(
        _altitudeMMeta,
        altitudeM.isAcceptableOrUnknown(data['altitude_m']!, _altitudeMMeta),
      );
    } else if (isInserting) {
      context.missing(_altitudeMMeta);
    }
    if (data.containsKey('process_method')) {
      context.handle(
        _processMethodMeta,
        processMethod.isAcceptableOrUnknown(
          data['process_method']!,
          _processMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_processMethodMeta);
    }
    if (data.containsKey('q_grade_score')) {
      context.handle(
        _qGradeScoreMeta,
        qGradeScore.isAcceptableOrUnknown(
          data['q_grade_score']!,
          _qGradeScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_qGradeScoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoffeeLot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoffeeLot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
      altitudeM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_m'],
      )!,
      processMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process_method'],
      )!,
      qGradeScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}q_grade_score'],
      )!,
    );
  }

  @override
  $CoffeeLotsTable createAlias(String alias) {
    return $CoffeeLotsTable(attachedDatabase, alias);
  }
}

class CoffeeLot extends DataClass implements Insertable<CoffeeLot> {
  final String id;
  final String userId;
  final String region;
  final int altitudeM;
  final String processMethod;
  final double qGradeScore;
  const CoffeeLot({
    required this.id,
    required this.userId,
    required this.region,
    required this.altitudeM,
    required this.processMethod,
    required this.qGradeScore,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['region'] = Variable<String>(region);
    map['altitude_m'] = Variable<int>(altitudeM);
    map['process_method'] = Variable<String>(processMethod);
    map['q_grade_score'] = Variable<double>(qGradeScore);
    return map;
  }

  CoffeeLotsCompanion toCompanion(bool nullToAbsent) {
    return CoffeeLotsCompanion(
      id: Value(id),
      userId: Value(userId),
      region: Value(region),
      altitudeM: Value(altitudeM),
      processMethod: Value(processMethod),
      qGradeScore: Value(qGradeScore),
    );
  }

  factory CoffeeLot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoffeeLot(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      region: serializer.fromJson<String>(json['region']),
      altitudeM: serializer.fromJson<int>(json['altitudeM']),
      processMethod: serializer.fromJson<String>(json['processMethod']),
      qGradeScore: serializer.fromJson<double>(json['qGradeScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'region': serializer.toJson<String>(region),
      'altitudeM': serializer.toJson<int>(altitudeM),
      'processMethod': serializer.toJson<String>(processMethod),
      'qGradeScore': serializer.toJson<double>(qGradeScore),
    };
  }

  CoffeeLot copyWith({
    String? id,
    String? userId,
    String? region,
    int? altitudeM,
    String? processMethod,
    double? qGradeScore,
  }) => CoffeeLot(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    region: region ?? this.region,
    altitudeM: altitudeM ?? this.altitudeM,
    processMethod: processMethod ?? this.processMethod,
    qGradeScore: qGradeScore ?? this.qGradeScore,
  );
  CoffeeLot copyWithCompanion(CoffeeLotsCompanion data) {
    return CoffeeLot(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      region: data.region.present ? data.region.value : this.region,
      altitudeM: data.altitudeM.present ? data.altitudeM.value : this.altitudeM,
      processMethod: data.processMethod.present
          ? data.processMethod.value
          : this.processMethod,
      qGradeScore: data.qGradeScore.present
          ? data.qGradeScore.value
          : this.qGradeScore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeLot(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('region: $region, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('processMethod: $processMethod, ')
          ..write('qGradeScore: $qGradeScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, region, altitudeM, processMethod, qGradeScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeeLot &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.region == this.region &&
          other.altitudeM == this.altitudeM &&
          other.processMethod == this.processMethod &&
          other.qGradeScore == this.qGradeScore);
}

class CoffeeLotsCompanion extends UpdateCompanion<CoffeeLot> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> region;
  final Value<int> altitudeM;
  final Value<String> processMethod;
  final Value<double> qGradeScore;
  final Value<int> rowid;
  const CoffeeLotsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.region = const Value.absent(),
    this.altitudeM = const Value.absent(),
    this.processMethod = const Value.absent(),
    this.qGradeScore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeeLotsCompanion.insert({
    required String id,
    required String userId,
    required String region,
    required int altitudeM,
    required String processMethod,
    required double qGradeScore,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       region = Value(region),
       altitudeM = Value(altitudeM),
       processMethod = Value(processMethod),
       qGradeScore = Value(qGradeScore);
  static Insertable<CoffeeLot> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? region,
    Expression<int>? altitudeM,
    Expression<String>? processMethod,
    Expression<double>? qGradeScore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (region != null) 'region': region,
      if (altitudeM != null) 'altitude_m': altitudeM,
      if (processMethod != null) 'process_method': processMethod,
      if (qGradeScore != null) 'q_grade_score': qGradeScore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeeLotsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? region,
    Value<int>? altitudeM,
    Value<String>? processMethod,
    Value<double>? qGradeScore,
    Value<int>? rowid,
  }) {
    return CoffeeLotsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      region: region ?? this.region,
      altitudeM: altitudeM ?? this.altitudeM,
      processMethod: processMethod ?? this.processMethod,
      qGradeScore: qGradeScore ?? this.qGradeScore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (altitudeM.present) {
      map['altitude_m'] = Variable<int>(altitudeM.value);
    }
    if (processMethod.present) {
      map['process_method'] = Variable<String>(processMethod.value);
    }
    if (qGradeScore.present) {
      map['q_grade_score'] = Variable<double>(qGradeScore.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeLotsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('region: $region, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('processMethod: $processMethod, ')
          ..write('qGradeScore: $qGradeScore, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FermentationLogsTable extends FermentationLogs
    with TableInfo<$FermentationLogsTable, FermentationLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FermentationLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<String> lotId = GeneratedColumn<String>(
    'lot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brixMeta = const VerificationMeta('brix');
  @override
  late final GeneratedColumn<double> brix = GeneratedColumn<double>(
    'brix',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phMeta = const VerificationMeta('ph');
  @override
  late final GeneratedColumn<double> ph = GeneratedColumn<double>(
    'ph',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<double> tempC = GeneratedColumn<double>(
    'temp_c',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, lotId, timestamp, brix, ph, tempC];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fermentation_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FermentationLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lot_id')) {
      context.handle(
        _lotIdMeta,
        lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lotIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('brix')) {
      context.handle(
        _brixMeta,
        brix.isAcceptableOrUnknown(data['brix']!, _brixMeta),
      );
    } else if (isInserting) {
      context.missing(_brixMeta);
    }
    if (data.containsKey('ph')) {
      context.handle(_phMeta, ph.isAcceptableOrUnknown(data['ph']!, _phMeta));
    } else if (isInserting) {
      context.missing(_phMeta);
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    } else if (isInserting) {
      context.missing(_tempCMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FermentationLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FermentationLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      lotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      brix: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}brix'],
      )!,
      ph: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ph'],
      )!,
      tempC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temp_c'],
      )!,
    );
  }

  @override
  $FermentationLogsTable createAlias(String alias) {
    return $FermentationLogsTable(attachedDatabase, alias);
  }
}

class FermentationLog extends DataClass implements Insertable<FermentationLog> {
  final String id;
  final String lotId;
  final DateTime timestamp;
  final double brix;
  final double ph;
  final double tempC;
  const FermentationLog({
    required this.id,
    required this.lotId,
    required this.timestamp,
    required this.brix,
    required this.ph,
    required this.tempC,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lot_id'] = Variable<String>(lotId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['brix'] = Variable<double>(brix);
    map['ph'] = Variable<double>(ph);
    map['temp_c'] = Variable<double>(tempC);
    return map;
  }

  FermentationLogsCompanion toCompanion(bool nullToAbsent) {
    return FermentationLogsCompanion(
      id: Value(id),
      lotId: Value(lotId),
      timestamp: Value(timestamp),
      brix: Value(brix),
      ph: Value(ph),
      tempC: Value(tempC),
    );
  }

  factory FermentationLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FermentationLog(
      id: serializer.fromJson<String>(json['id']),
      lotId: serializer.fromJson<String>(json['lotId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      brix: serializer.fromJson<double>(json['brix']),
      ph: serializer.fromJson<double>(json['ph']),
      tempC: serializer.fromJson<double>(json['tempC']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lotId': serializer.toJson<String>(lotId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'brix': serializer.toJson<double>(brix),
      'ph': serializer.toJson<double>(ph),
      'tempC': serializer.toJson<double>(tempC),
    };
  }

  FermentationLog copyWith({
    String? id,
    String? lotId,
    DateTime? timestamp,
    double? brix,
    double? ph,
    double? tempC,
  }) => FermentationLog(
    id: id ?? this.id,
    lotId: lotId ?? this.lotId,
    timestamp: timestamp ?? this.timestamp,
    brix: brix ?? this.brix,
    ph: ph ?? this.ph,
    tempC: tempC ?? this.tempC,
  );
  FermentationLog copyWithCompanion(FermentationLogsCompanion data) {
    return FermentationLog(
      id: data.id.present ? data.id.value : this.id,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      brix: data.brix.present ? data.brix.value : this.brix,
      ph: data.ph.present ? data.ph.value : this.ph,
      tempC: data.tempC.present ? data.tempC.value : this.tempC,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FermentationLog(')
          ..write('id: $id, ')
          ..write('lotId: $lotId, ')
          ..write('timestamp: $timestamp, ')
          ..write('brix: $brix, ')
          ..write('ph: $ph, ')
          ..write('tempC: $tempC')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lotId, timestamp, brix, ph, tempC);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FermentationLog &&
          other.id == this.id &&
          other.lotId == this.lotId &&
          other.timestamp == this.timestamp &&
          other.brix == this.brix &&
          other.ph == this.ph &&
          other.tempC == this.tempC);
}

class FermentationLogsCompanion extends UpdateCompanion<FermentationLog> {
  final Value<String> id;
  final Value<String> lotId;
  final Value<DateTime> timestamp;
  final Value<double> brix;
  final Value<double> ph;
  final Value<double> tempC;
  final Value<int> rowid;
  const FermentationLogsCompanion({
    this.id = const Value.absent(),
    this.lotId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.brix = const Value.absent(),
    this.ph = const Value.absent(),
    this.tempC = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FermentationLogsCompanion.insert({
    required String id,
    required String lotId,
    required DateTime timestamp,
    required double brix,
    required double ph,
    required double tempC,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lotId = Value(lotId),
       timestamp = Value(timestamp),
       brix = Value(brix),
       ph = Value(ph),
       tempC = Value(tempC);
  static Insertable<FermentationLog> custom({
    Expression<String>? id,
    Expression<String>? lotId,
    Expression<DateTime>? timestamp,
    Expression<double>? brix,
    Expression<double>? ph,
    Expression<double>? tempC,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lotId != null) 'lot_id': lotId,
      if (timestamp != null) 'timestamp': timestamp,
      if (brix != null) 'brix': brix,
      if (ph != null) 'ph': ph,
      if (tempC != null) 'temp_c': tempC,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FermentationLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? lotId,
    Value<DateTime>? timestamp,
    Value<double>? brix,
    Value<double>? ph,
    Value<double>? tempC,
    Value<int>? rowid,
  }) {
    return FermentationLogsCompanion(
      id: id ?? this.id,
      lotId: lotId ?? this.lotId,
      timestamp: timestamp ?? this.timestamp,
      brix: brix ?? this.brix,
      ph: ph ?? this.ph,
      tempC: tempC ?? this.tempC,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lotId.present) {
      map['lot_id'] = Variable<String>(lotId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (brix.present) {
      map['brix'] = Variable<double>(brix.value);
    }
    if (ph.present) {
      map['ph'] = Variable<double>(ph.value);
    }
    if (tempC.present) {
      map['temp_c'] = Variable<double>(tempC.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FermentationLogsCompanion(')
          ..write('id: $id, ')
          ..write('lotId: $lotId, ')
          ..write('timestamp: $timestamp, ')
          ..write('brix: $brix, ')
          ..write('ph: $ph, ')
          ..write('tempC: $tempC, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrewingRecipesTable extends BrewingRecipes
    with TableInfo<$BrewingRecipesTable, BrewingRecipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrewingRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _methodKeyMeta = const VerificationMeta(
    'methodKey',
  );
  @override
  late final GeneratedColumn<String> methodKey = GeneratedColumn<String>(
    'method_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratioGramsPerMlMeta = const VerificationMeta(
    'ratioGramsPerMl',
  );
  @override
  late final GeneratedColumn<double> ratioGramsPerMl = GeneratedColumn<double>(
    'ratio_grams_per_ml',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<double> tempC = GeneratedColumn<double>(
    'temp_c',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalTimeSecMeta = const VerificationMeta(
    'totalTimeSec',
  );
  @override
  late final GeneratedColumn<int> totalTimeSec = GeneratedColumn<int>(
    'total_time_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsJsonMeta = const VerificationMeta(
    'stepsJson',
  );
  @override
  late final GeneratedColumn<String> stepsJson = GeneratedColumn<String>(
    'steps_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _flavorProfileMeta = const VerificationMeta(
    'flavorProfile',
  );
  @override
  late final GeneratedColumn<String> flavorProfile = GeneratedColumn<String>(
    'flavor_profile',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    methodKey,
    name,
    description,
    ratioGramsPerMl,
    tempC,
    totalTimeSec,
    difficulty,
    stepsJson,
    flavorProfile,
    iconName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brewing_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrewingRecipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('method_key')) {
      context.handle(
        _methodKeyMeta,
        methodKey.isAcceptableOrUnknown(data['method_key']!, _methodKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_methodKeyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('ratio_grams_per_ml')) {
      context.handle(
        _ratioGramsPerMlMeta,
        ratioGramsPerMl.isAcceptableOrUnknown(
          data['ratio_grams_per_ml']!,
          _ratioGramsPerMlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ratioGramsPerMlMeta);
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    } else if (isInserting) {
      context.missing(_tempCMeta);
    }
    if (data.containsKey('total_time_sec')) {
      context.handle(
        _totalTimeSecMeta,
        totalTimeSec.isAcceptableOrUnknown(
          data['total_time_sec']!,
          _totalTimeSecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalTimeSecMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('steps_json')) {
      context.handle(
        _stepsJsonMeta,
        stepsJson.isAcceptableOrUnknown(data['steps_json']!, _stepsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsJsonMeta);
    }
    if (data.containsKey('flavor_profile')) {
      context.handle(
        _flavorProfileMeta,
        flavorProfile.isAcceptableOrUnknown(
          data['flavor_profile']!,
          _flavorProfileMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_flavorProfileMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    } else if (isInserting) {
      context.missing(_iconNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BrewingRecipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrewingRecipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      methodKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method_key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      ratioGramsPerMl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ratio_grams_per_ml'],
      )!,
      tempC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temp_c'],
      )!,
      totalTimeSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_time_sec'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      stepsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}steps_json'],
      )!,
      flavorProfile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_profile'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
    );
  }

  @override
  $BrewingRecipesTable createAlias(String alias) {
    return $BrewingRecipesTable(attachedDatabase, alias);
  }
}

class BrewingRecipe extends DataClass implements Insertable<BrewingRecipe> {
  final int id;
  final String methodKey;
  final String name;
  final String description;
  final double ratioGramsPerMl;
  final double tempC;
  final int totalTimeSec;
  final String difficulty;
  final String stepsJson;
  final String flavorProfile;
  final String iconName;
  const BrewingRecipe({
    required this.id,
    required this.methodKey,
    required this.name,
    required this.description,
    required this.ratioGramsPerMl,
    required this.tempC,
    required this.totalTimeSec,
    required this.difficulty,
    required this.stepsJson,
    required this.flavorProfile,
    required this.iconName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['method_key'] = Variable<String>(methodKey);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['ratio_grams_per_ml'] = Variable<double>(ratioGramsPerMl);
    map['temp_c'] = Variable<double>(tempC);
    map['total_time_sec'] = Variable<int>(totalTimeSec);
    map['difficulty'] = Variable<String>(difficulty);
    map['steps_json'] = Variable<String>(stepsJson);
    map['flavor_profile'] = Variable<String>(flavorProfile);
    map['icon_name'] = Variable<String>(iconName);
    return map;
  }

  BrewingRecipesCompanion toCompanion(bool nullToAbsent) {
    return BrewingRecipesCompanion(
      id: Value(id),
      methodKey: Value(methodKey),
      name: Value(name),
      description: Value(description),
      ratioGramsPerMl: Value(ratioGramsPerMl),
      tempC: Value(tempC),
      totalTimeSec: Value(totalTimeSec),
      difficulty: Value(difficulty),
      stepsJson: Value(stepsJson),
      flavorProfile: Value(flavorProfile),
      iconName: Value(iconName),
    );
  }

  factory BrewingRecipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrewingRecipe(
      id: serializer.fromJson<int>(json['id']),
      methodKey: serializer.fromJson<String>(json['methodKey']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      ratioGramsPerMl: serializer.fromJson<double>(json['ratioGramsPerMl']),
      tempC: serializer.fromJson<double>(json['tempC']),
      totalTimeSec: serializer.fromJson<int>(json['totalTimeSec']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      stepsJson: serializer.fromJson<String>(json['stepsJson']),
      flavorProfile: serializer.fromJson<String>(json['flavorProfile']),
      iconName: serializer.fromJson<String>(json['iconName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'methodKey': serializer.toJson<String>(methodKey),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'ratioGramsPerMl': serializer.toJson<double>(ratioGramsPerMl),
      'tempC': serializer.toJson<double>(tempC),
      'totalTimeSec': serializer.toJson<int>(totalTimeSec),
      'difficulty': serializer.toJson<String>(difficulty),
      'stepsJson': serializer.toJson<String>(stepsJson),
      'flavorProfile': serializer.toJson<String>(flavorProfile),
      'iconName': serializer.toJson<String>(iconName),
    };
  }

  BrewingRecipe copyWith({
    int? id,
    String? methodKey,
    String? name,
    String? description,
    double? ratioGramsPerMl,
    double? tempC,
    int? totalTimeSec,
    String? difficulty,
    String? stepsJson,
    String? flavorProfile,
    String? iconName,
  }) => BrewingRecipe(
    id: id ?? this.id,
    methodKey: methodKey ?? this.methodKey,
    name: name ?? this.name,
    description: description ?? this.description,
    ratioGramsPerMl: ratioGramsPerMl ?? this.ratioGramsPerMl,
    tempC: tempC ?? this.tempC,
    totalTimeSec: totalTimeSec ?? this.totalTimeSec,
    difficulty: difficulty ?? this.difficulty,
    stepsJson: stepsJson ?? this.stepsJson,
    flavorProfile: flavorProfile ?? this.flavorProfile,
    iconName: iconName ?? this.iconName,
  );
  BrewingRecipe copyWithCompanion(BrewingRecipesCompanion data) {
    return BrewingRecipe(
      id: data.id.present ? data.id.value : this.id,
      methodKey: data.methodKey.present ? data.methodKey.value : this.methodKey,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      ratioGramsPerMl: data.ratioGramsPerMl.present
          ? data.ratioGramsPerMl.value
          : this.ratioGramsPerMl,
      tempC: data.tempC.present ? data.tempC.value : this.tempC,
      totalTimeSec: data.totalTimeSec.present
          ? data.totalTimeSec.value
          : this.totalTimeSec,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      stepsJson: data.stepsJson.present ? data.stepsJson.value : this.stepsJson,
      flavorProfile: data.flavorProfile.present
          ? data.flavorProfile.value
          : this.flavorProfile,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrewingRecipe(')
          ..write('id: $id, ')
          ..write('methodKey: $methodKey, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('ratioGramsPerMl: $ratioGramsPerMl, ')
          ..write('tempC: $tempC, ')
          ..write('totalTimeSec: $totalTimeSec, ')
          ..write('difficulty: $difficulty, ')
          ..write('stepsJson: $stepsJson, ')
          ..write('flavorProfile: $flavorProfile, ')
          ..write('iconName: $iconName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    methodKey,
    name,
    description,
    ratioGramsPerMl,
    tempC,
    totalTimeSec,
    difficulty,
    stepsJson,
    flavorProfile,
    iconName,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrewingRecipe &&
          other.id == this.id &&
          other.methodKey == this.methodKey &&
          other.name == this.name &&
          other.description == this.description &&
          other.ratioGramsPerMl == this.ratioGramsPerMl &&
          other.tempC == this.tempC &&
          other.totalTimeSec == this.totalTimeSec &&
          other.difficulty == this.difficulty &&
          other.stepsJson == this.stepsJson &&
          other.flavorProfile == this.flavorProfile &&
          other.iconName == this.iconName);
}

class BrewingRecipesCompanion extends UpdateCompanion<BrewingRecipe> {
  final Value<int> id;
  final Value<String> methodKey;
  final Value<String> name;
  final Value<String> description;
  final Value<double> ratioGramsPerMl;
  final Value<double> tempC;
  final Value<int> totalTimeSec;
  final Value<String> difficulty;
  final Value<String> stepsJson;
  final Value<String> flavorProfile;
  final Value<String> iconName;
  const BrewingRecipesCompanion({
    this.id = const Value.absent(),
    this.methodKey = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.ratioGramsPerMl = const Value.absent(),
    this.tempC = const Value.absent(),
    this.totalTimeSec = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.stepsJson = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.iconName = const Value.absent(),
  });
  BrewingRecipesCompanion.insert({
    this.id = const Value.absent(),
    required String methodKey,
    required String name,
    required String description,
    required double ratioGramsPerMl,
    required double tempC,
    required int totalTimeSec,
    required String difficulty,
    required String stepsJson,
    required String flavorProfile,
    required String iconName,
  }) : methodKey = Value(methodKey),
       name = Value(name),
       description = Value(description),
       ratioGramsPerMl = Value(ratioGramsPerMl),
       tempC = Value(tempC),
       totalTimeSec = Value(totalTimeSec),
       difficulty = Value(difficulty),
       stepsJson = Value(stepsJson),
       flavorProfile = Value(flavorProfile),
       iconName = Value(iconName);
  static Insertable<BrewingRecipe> custom({
    Expression<int>? id,
    Expression<String>? methodKey,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? ratioGramsPerMl,
    Expression<double>? tempC,
    Expression<int>? totalTimeSec,
    Expression<String>? difficulty,
    Expression<String>? stepsJson,
    Expression<String>? flavorProfile,
    Expression<String>? iconName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (methodKey != null) 'method_key': methodKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (ratioGramsPerMl != null) 'ratio_grams_per_ml': ratioGramsPerMl,
      if (tempC != null) 'temp_c': tempC,
      if (totalTimeSec != null) 'total_time_sec': totalTimeSec,
      if (difficulty != null) 'difficulty': difficulty,
      if (stepsJson != null) 'steps_json': stepsJson,
      if (flavorProfile != null) 'flavor_profile': flavorProfile,
      if (iconName != null) 'icon_name': iconName,
    });
  }

  BrewingRecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? methodKey,
    Value<String>? name,
    Value<String>? description,
    Value<double>? ratioGramsPerMl,
    Value<double>? tempC,
    Value<int>? totalTimeSec,
    Value<String>? difficulty,
    Value<String>? stepsJson,
    Value<String>? flavorProfile,
    Value<String>? iconName,
  }) {
    return BrewingRecipesCompanion(
      id: id ?? this.id,
      methodKey: methodKey ?? this.methodKey,
      name: name ?? this.name,
      description: description ?? this.description,
      ratioGramsPerMl: ratioGramsPerMl ?? this.ratioGramsPerMl,
      tempC: tempC ?? this.tempC,
      totalTimeSec: totalTimeSec ?? this.totalTimeSec,
      difficulty: difficulty ?? this.difficulty,
      stepsJson: stepsJson ?? this.stepsJson,
      flavorProfile: flavorProfile ?? this.flavorProfile,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (methodKey.present) {
      map['method_key'] = Variable<String>(methodKey.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ratioGramsPerMl.present) {
      map['ratio_grams_per_ml'] = Variable<double>(ratioGramsPerMl.value);
    }
    if (tempC.present) {
      map['temp_c'] = Variable<double>(tempC.value);
    }
    if (totalTimeSec.present) {
      map['total_time_sec'] = Variable<int>(totalTimeSec.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (stepsJson.present) {
      map['steps_json'] = Variable<String>(stepsJson.value);
    }
    if (flavorProfile.present) {
      map['flavor_profile'] = Variable<String>(flavorProfile.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrewingRecipesCompanion(')
          ..write('id: $id, ')
          ..write('methodKey: $methodKey, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('ratioGramsPerMl: $ratioGramsPerMl, ')
          ..write('tempC: $tempC, ')
          ..write('totalTimeSec: $totalTimeSec, ')
          ..write('difficulty: $difficulty, ')
          ..write('stepsJson: $stepsJson, ')
          ..write('flavorProfile: $flavorProfile, ')
          ..write('iconName: $iconName')
          ..write(')'))
        .toString();
  }
}

class $BrandsTable extends Brands with TableInfo<$BrandsTable, Brand> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrandsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortDescMeta = const VerificationMeta(
    'shortDesc',
  );
  @override
  late final GeneratedColumn<String> shortDesc = GeneratedColumn<String>(
    'short_desc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullDescMeta = const VerificationMeta(
    'fullDesc',
  );
  @override
  late final GeneratedColumn<String> fullDesc = GeneratedColumn<String>(
    'full_desc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _siteUrlMeta = const VerificationMeta(
    'siteUrl',
  );
  @override
  late final GeneratedColumn<String> siteUrl = GeneratedColumn<String>(
    'site_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    shortDesc,
    fullDesc,
    logoUrl,
    siteUrl,
    location,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brands';
  @override
  VerificationContext validateIntegrity(
    Insertable<Brand> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('short_desc')) {
      context.handle(
        _shortDescMeta,
        shortDesc.isAcceptableOrUnknown(data['short_desc']!, _shortDescMeta),
      );
    } else if (isInserting) {
      context.missing(_shortDescMeta);
    }
    if (data.containsKey('full_desc')) {
      context.handle(
        _fullDescMeta,
        fullDesc.isAcceptableOrUnknown(data['full_desc']!, _fullDescMeta),
      );
    } else if (isInserting) {
      context.missing(_fullDescMeta);
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('site_url')) {
      context.handle(
        _siteUrlMeta,
        siteUrl.isAcceptableOrUnknown(data['site_url']!, _siteUrlMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Brand map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Brand(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      shortDesc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_desc'],
      )!,
      fullDesc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_desc'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      )!,
      siteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}site_url'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
    );
  }

  @override
  $BrandsTable createAlias(String alias) {
    return $BrandsTable(attachedDatabase, alias);
  }
}

class Brand extends DataClass implements Insertable<Brand> {
  final int id;
  final String name;
  final String shortDesc;
  final String fullDesc;
  final String logoUrl;
  final String siteUrl;
  final String location;
  const Brand({
    required this.id,
    required this.name,
    required this.shortDesc,
    required this.fullDesc,
    required this.logoUrl,
    required this.siteUrl,
    required this.location,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['short_desc'] = Variable<String>(shortDesc);
    map['full_desc'] = Variable<String>(fullDesc);
    map['logo_url'] = Variable<String>(logoUrl);
    map['site_url'] = Variable<String>(siteUrl);
    map['location'] = Variable<String>(location);
    return map;
  }

  BrandsCompanion toCompanion(bool nullToAbsent) {
    return BrandsCompanion(
      id: Value(id),
      name: Value(name),
      shortDesc: Value(shortDesc),
      fullDesc: Value(fullDesc),
      logoUrl: Value(logoUrl),
      siteUrl: Value(siteUrl),
      location: Value(location),
    );
  }

  factory Brand.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Brand(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      shortDesc: serializer.fromJson<String>(json['shortDesc']),
      fullDesc: serializer.fromJson<String>(json['fullDesc']),
      logoUrl: serializer.fromJson<String>(json['logoUrl']),
      siteUrl: serializer.fromJson<String>(json['siteUrl']),
      location: serializer.fromJson<String>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'shortDesc': serializer.toJson<String>(shortDesc),
      'fullDesc': serializer.toJson<String>(fullDesc),
      'logoUrl': serializer.toJson<String>(logoUrl),
      'siteUrl': serializer.toJson<String>(siteUrl),
      'location': serializer.toJson<String>(location),
    };
  }

  Brand copyWith({
    int? id,
    String? name,
    String? shortDesc,
    String? fullDesc,
    String? logoUrl,
    String? siteUrl,
    String? location,
  }) => Brand(
    id: id ?? this.id,
    name: name ?? this.name,
    shortDesc: shortDesc ?? this.shortDesc,
    fullDesc: fullDesc ?? this.fullDesc,
    logoUrl: logoUrl ?? this.logoUrl,
    siteUrl: siteUrl ?? this.siteUrl,
    location: location ?? this.location,
  );
  Brand copyWithCompanion(BrandsCompanion data) {
    return Brand(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      shortDesc: data.shortDesc.present ? data.shortDesc.value : this.shortDesc,
      fullDesc: data.fullDesc.present ? data.fullDesc.value : this.fullDesc,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      siteUrl: data.siteUrl.present ? data.siteUrl.value : this.siteUrl,
      location: data.location.present ? data.location.value : this.location,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Brand(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortDesc: $shortDesc, ')
          ..write('fullDesc: $fullDesc, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, shortDesc, fullDesc, logoUrl, siteUrl, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Brand &&
          other.id == this.id &&
          other.name == this.name &&
          other.shortDesc == this.shortDesc &&
          other.fullDesc == this.fullDesc &&
          other.logoUrl == this.logoUrl &&
          other.siteUrl == this.siteUrl &&
          other.location == this.location);
}

class BrandsCompanion extends UpdateCompanion<Brand> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> shortDesc;
  final Value<String> fullDesc;
  final Value<String> logoUrl;
  final Value<String> siteUrl;
  final Value<String> location;
  const BrandsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.shortDesc = const Value.absent(),
    this.fullDesc = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.location = const Value.absent(),
  });
  BrandsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String shortDesc,
    required String fullDesc,
    this.logoUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.location = const Value.absent(),
  }) : name = Value(name),
       shortDesc = Value(shortDesc),
       fullDesc = Value(fullDesc);
  static Insertable<Brand> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? shortDesc,
    Expression<String>? fullDesc,
    Expression<String>? logoUrl,
    Expression<String>? siteUrl,
    Expression<String>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (shortDesc != null) 'short_desc': shortDesc,
      if (fullDesc != null) 'full_desc': fullDesc,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (siteUrl != null) 'site_url': siteUrl,
      if (location != null) 'location': location,
    });
  }

  BrandsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? shortDesc,
    Value<String>? fullDesc,
    Value<String>? logoUrl,
    Value<String>? siteUrl,
    Value<String>? location,
  }) {
    return BrandsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDesc: shortDesc ?? this.shortDesc,
      fullDesc: fullDesc ?? this.fullDesc,
      logoUrl: logoUrl ?? this.logoUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      location: location ?? this.location,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (shortDesc.present) {
      map['short_desc'] = Variable<String>(shortDesc.value);
    }
    if (fullDesc.present) {
      map['full_desc'] = Variable<String>(fullDesc.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (siteUrl.present) {
      map['site_url'] = Variable<String>(siteUrl.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrandsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('shortDesc: $shortDesc, ')
          ..write('fullDesc: $fullDesc, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $EncyclopediaEntriesTable extends EncyclopediaEntries
    with TableInfo<$EncyclopediaEntriesTable, EncyclopediaEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EncyclopediaEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _countryEmojiMeta = const VerificationMeta(
    'countryEmoji',
  );
  @override
  late final GeneratedColumn<String> countryEmoji = GeneratedColumn<String>(
    'country_emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMinMeta = const VerificationMeta(
    'altitudeMin',
  );
  @override
  late final GeneratedColumn<int> altitudeMin = GeneratedColumn<int>(
    'altitude_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMaxMeta = const VerificationMeta(
    'altitudeMax',
  );
  @override
  late final GeneratedColumn<int> altitudeMax = GeneratedColumn<int>(
    'altitude_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _varietiesMeta = const VerificationMeta(
    'varieties',
  );
  @override
  late final GeneratedColumn<String> varieties = GeneratedColumn<String>(
    'varieties',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _flavorNotesMeta = const VerificationMeta(
    'flavorNotes',
  );
  @override
  late final GeneratedColumn<String> flavorNotes = GeneratedColumn<String>(
    'flavor_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _processMethodMeta = const VerificationMeta(
    'processMethod',
  );
  @override
  late final GeneratedColumn<String> processMethod = GeneratedColumn<String>(
    'process_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _harvestSeasonMeta = const VerificationMeta(
    'harvestSeason',
  );
  @override
  late final GeneratedColumn<String> harvestSeason = GeneratedColumn<String>(
    'harvest_season',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cupsScoreMeta = const VerificationMeta(
    'cupsScore',
  );
  @override
  late final GeneratedColumn<double> cupsScore = GeneratedColumn<double>(
    'cups_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _farmDescriptionMeta = const VerificationMeta(
    'farmDescription',
  );
  @override
  late final GeneratedColumn<String> farmDescription = GeneratedColumn<String>(
    'farm_description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _farmPhotosUrlCoverMeta =
      const VerificationMeta('farmPhotosUrlCover');
  @override
  late final GeneratedColumn<String> farmPhotosUrlCover =
      GeneratedColumn<String>(
        'farm_photos_url_cover',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _plantationPhotosUrlMeta =
      const VerificationMeta('plantationPhotosUrl');
  @override
  late final GeneratedColumn<String> plantationPhotosUrl =
      GeneratedColumn<String>(
        'plantation_photos_url',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _processingMethodsJsonMeta =
      const VerificationMeta('processingMethodsJson');
  @override
  late final GeneratedColumn<String> processingMethodsJson =
      GeneratedColumn<String>(
        'processing_methods_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _brandIdMeta = const VerificationMeta(
    'brandId',
  );
  @override
  late final GeneratedColumn<int> brandId = GeneratedColumn<int>(
    'brand_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES brands (id)',
    ),
  );
  static const VerificationMeta _sensoryJsonMeta = const VerificationMeta(
    'sensoryJson',
  );
  @override
  late final GeneratedColumn<String> sensoryJson = GeneratedColumn<String>(
    'sensory_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _roastLevelMeta = const VerificationMeta(
    'roastLevel',
  );
  @override
  late final GeneratedColumn<String> roastLevel = GeneratedColumn<String>(
    'roast_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<String> weight = GeneratedColumn<String>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<String> price = GeneratedColumn<String>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _roastDateMeta = const VerificationMeta(
    'roastDate',
  );
  @override
  late final GeneratedColumn<String> roastDate = GeneratedColumn<String>(
    'roast_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lotNumberMeta = const VerificationMeta(
    'lotNumber',
  );
  @override
  late final GeneratedColumn<String> lotNumber = GeneratedColumn<String>(
    'lot_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isPremiumMeta = const VerificationMeta(
    'isPremium',
  );
  @override
  late final GeneratedColumn<bool> isPremium = GeneratedColumn<bool>(
    'is_premium',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_premium" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _detailedProcessMarkdownMeta =
      const VerificationMeta('detailedProcessMarkdown');
  @override
  late final GeneratedColumn<String> detailedProcessMarkdown =
      GeneratedColumn<String>(
        'detailed_process_markdown',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    countryEmoji,
    country,
    region,
    altitudeMin,
    altitudeMax,
    varieties,
    flavorNotes,
    processMethod,
    harvestSeason,
    description,
    cupsScore,
    farmDescription,
    farmPhotosUrlCover,
    plantationPhotosUrl,
    processingMethodsJson,
    brandId,
    sensoryJson,
    roastLevel,
    weight,
    price,
    roastDate,
    lotNumber,
    url,
    isPremium,
    detailedProcessMarkdown,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'encyclopedia_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<EncyclopediaEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('country_emoji')) {
      context.handle(
        _countryEmojiMeta,
        countryEmoji.isAcceptableOrUnknown(
          data['country_emoji']!,
          _countryEmojiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_countryEmojiMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    if (data.containsKey('altitude_min')) {
      context.handle(
        _altitudeMinMeta,
        altitudeMin.isAcceptableOrUnknown(
          data['altitude_min']!,
          _altitudeMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_altitudeMinMeta);
    }
    if (data.containsKey('altitude_max')) {
      context.handle(
        _altitudeMaxMeta,
        altitudeMax.isAcceptableOrUnknown(
          data['altitude_max']!,
          _altitudeMaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_altitudeMaxMeta);
    }
    if (data.containsKey('varieties')) {
      context.handle(
        _varietiesMeta,
        varieties.isAcceptableOrUnknown(data['varieties']!, _varietiesMeta),
      );
    } else if (isInserting) {
      context.missing(_varietiesMeta);
    }
    if (data.containsKey('flavor_notes')) {
      context.handle(
        _flavorNotesMeta,
        flavorNotes.isAcceptableOrUnknown(
          data['flavor_notes']!,
          _flavorNotesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_flavorNotesMeta);
    }
    if (data.containsKey('process_method')) {
      context.handle(
        _processMethodMeta,
        processMethod.isAcceptableOrUnknown(
          data['process_method']!,
          _processMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_processMethodMeta);
    }
    if (data.containsKey('harvest_season')) {
      context.handle(
        _harvestSeasonMeta,
        harvestSeason.isAcceptableOrUnknown(
          data['harvest_season']!,
          _harvestSeasonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_harvestSeasonMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('cups_score')) {
      context.handle(
        _cupsScoreMeta,
        cupsScore.isAcceptableOrUnknown(data['cups_score']!, _cupsScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_cupsScoreMeta);
    }
    if (data.containsKey('farm_description')) {
      context.handle(
        _farmDescriptionMeta,
        farmDescription.isAcceptableOrUnknown(
          data['farm_description']!,
          _farmDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('farm_photos_url_cover')) {
      context.handle(
        _farmPhotosUrlCoverMeta,
        farmPhotosUrlCover.isAcceptableOrUnknown(
          data['farm_photos_url_cover']!,
          _farmPhotosUrlCoverMeta,
        ),
      );
    }
    if (data.containsKey('plantation_photos_url')) {
      context.handle(
        _plantationPhotosUrlMeta,
        plantationPhotosUrl.isAcceptableOrUnknown(
          data['plantation_photos_url']!,
          _plantationPhotosUrlMeta,
        ),
      );
    }
    if (data.containsKey('processing_methods_json')) {
      context.handle(
        _processingMethodsJsonMeta,
        processingMethodsJson.isAcceptableOrUnknown(
          data['processing_methods_json']!,
          _processingMethodsJsonMeta,
        ),
      );
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    }
    if (data.containsKey('sensory_json')) {
      context.handle(
        _sensoryJsonMeta,
        sensoryJson.isAcceptableOrUnknown(
          data['sensory_json']!,
          _sensoryJsonMeta,
        ),
      );
    }
    if (data.containsKey('roast_level')) {
      context.handle(
        _roastLevelMeta,
        roastLevel.isAcceptableOrUnknown(data['roast_level']!, _roastLevelMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('roast_date')) {
      context.handle(
        _roastDateMeta,
        roastDate.isAcceptableOrUnknown(data['roast_date']!, _roastDateMeta),
      );
    }
    if (data.containsKey('lot_number')) {
      context.handle(
        _lotNumberMeta,
        lotNumber.isAcceptableOrUnknown(data['lot_number']!, _lotNumberMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('is_premium')) {
      context.handle(
        _isPremiumMeta,
        isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta),
      );
    }
    if (data.containsKey('detailed_process_markdown')) {
      context.handle(
        _detailedProcessMarkdownMeta,
        detailedProcessMarkdown.isAcceptableOrUnknown(
          data['detailed_process_markdown']!,
          _detailedProcessMarkdownMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EncyclopediaEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EncyclopediaEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      countryEmoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_emoji'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
      altitudeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_min'],
      )!,
      altitudeMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_max'],
      )!,
      varieties: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}varieties'],
      )!,
      flavorNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_notes'],
      )!,
      processMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process_method'],
      )!,
      harvestSeason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}harvest_season'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      cupsScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cups_score'],
      )!,
      farmDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_description'],
      )!,
      farmPhotosUrlCover: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_photos_url_cover'],
      )!,
      plantationPhotosUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plantation_photos_url'],
      )!,
      processingMethodsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_methods_json'],
      )!,
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brand_id'],
      ),
      sensoryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensory_json'],
      )!,
      roastLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_level'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weight'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price'],
      )!,
      roastDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_date'],
      )!,
      lotNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_number'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      isPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_premium'],
      )!,
      detailedProcessMarkdown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detailed_process_markdown'],
      )!,
    );
  }

  @override
  $EncyclopediaEntriesTable createAlias(String alias) {
    return $EncyclopediaEntriesTable(attachedDatabase, alias);
  }
}

class EncyclopediaEntry extends DataClass
    implements Insertable<EncyclopediaEntry> {
  final int id;
  final String countryEmoji;
  final String country;
  final String region;
  final int altitudeMin;
  final int altitudeMax;
  final String varieties;
  final String flavorNotes;
  final String processMethod;
  final String harvestSeason;
  final String description;
  final double cupsScore;
  final String farmDescription;
  final String farmPhotosUrlCover;
  final String plantationPhotosUrl;
  final String processingMethodsJson;
  final int? brandId;
  final String sensoryJson;
  final String roastLevel;
  final String weight;
  final String price;
  final String roastDate;
  final String lotNumber;
  final String url;
  final bool isPremium;
  final String detailedProcessMarkdown;
  const EncyclopediaEntry({
    required this.id,
    required this.countryEmoji,
    required this.country,
    required this.region,
    required this.altitudeMin,
    required this.altitudeMax,
    required this.varieties,
    required this.flavorNotes,
    required this.processMethod,
    required this.harvestSeason,
    required this.description,
    required this.cupsScore,
    required this.farmDescription,
    required this.farmPhotosUrlCover,
    required this.plantationPhotosUrl,
    required this.processingMethodsJson,
    this.brandId,
    required this.sensoryJson,
    required this.roastLevel,
    required this.weight,
    required this.price,
    required this.roastDate,
    required this.lotNumber,
    required this.url,
    required this.isPremium,
    required this.detailedProcessMarkdown,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['country_emoji'] = Variable<String>(countryEmoji);
    map['country'] = Variable<String>(country);
    map['region'] = Variable<String>(region);
    map['altitude_min'] = Variable<int>(altitudeMin);
    map['altitude_max'] = Variable<int>(altitudeMax);
    map['varieties'] = Variable<String>(varieties);
    map['flavor_notes'] = Variable<String>(flavorNotes);
    map['process_method'] = Variable<String>(processMethod);
    map['harvest_season'] = Variable<String>(harvestSeason);
    map['description'] = Variable<String>(description);
    map['cups_score'] = Variable<double>(cupsScore);
    map['farm_description'] = Variable<String>(farmDescription);
    map['farm_photos_url_cover'] = Variable<String>(farmPhotosUrlCover);
    map['plantation_photos_url'] = Variable<String>(plantationPhotosUrl);
    map['processing_methods_json'] = Variable<String>(processingMethodsJson);
    if (!nullToAbsent || brandId != null) {
      map['brand_id'] = Variable<int>(brandId);
    }
    map['sensory_json'] = Variable<String>(sensoryJson);
    map['roast_level'] = Variable<String>(roastLevel);
    map['weight'] = Variable<String>(weight);
    map['price'] = Variable<String>(price);
    map['roast_date'] = Variable<String>(roastDate);
    map['lot_number'] = Variable<String>(lotNumber);
    map['url'] = Variable<String>(url);
    map['is_premium'] = Variable<bool>(isPremium);
    map['detailed_process_markdown'] = Variable<String>(
      detailedProcessMarkdown,
    );
    return map;
  }

  EncyclopediaEntriesCompanion toCompanion(bool nullToAbsent) {
    return EncyclopediaEntriesCompanion(
      id: Value(id),
      countryEmoji: Value(countryEmoji),
      country: Value(country),
      region: Value(region),
      altitudeMin: Value(altitudeMin),
      altitudeMax: Value(altitudeMax),
      varieties: Value(varieties),
      flavorNotes: Value(flavorNotes),
      processMethod: Value(processMethod),
      harvestSeason: Value(harvestSeason),
      description: Value(description),
      cupsScore: Value(cupsScore),
      farmDescription: Value(farmDescription),
      farmPhotosUrlCover: Value(farmPhotosUrlCover),
      plantationPhotosUrl: Value(plantationPhotosUrl),
      processingMethodsJson: Value(processingMethodsJson),
      brandId: brandId == null && nullToAbsent
          ? const Value.absent()
          : Value(brandId),
      sensoryJson: Value(sensoryJson),
      roastLevel: Value(roastLevel),
      weight: Value(weight),
      price: Value(price),
      roastDate: Value(roastDate),
      lotNumber: Value(lotNumber),
      url: Value(url),
      isPremium: Value(isPremium),
      detailedProcessMarkdown: Value(detailedProcessMarkdown),
    );
  }

  factory EncyclopediaEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EncyclopediaEntry(
      id: serializer.fromJson<int>(json['id']),
      countryEmoji: serializer.fromJson<String>(json['countryEmoji']),
      country: serializer.fromJson<String>(json['country']),
      region: serializer.fromJson<String>(json['region']),
      altitudeMin: serializer.fromJson<int>(json['altitudeMin']),
      altitudeMax: serializer.fromJson<int>(json['altitudeMax']),
      varieties: serializer.fromJson<String>(json['varieties']),
      flavorNotes: serializer.fromJson<String>(json['flavorNotes']),
      processMethod: serializer.fromJson<String>(json['processMethod']),
      harvestSeason: serializer.fromJson<String>(json['harvestSeason']),
      description: serializer.fromJson<String>(json['description']),
      cupsScore: serializer.fromJson<double>(json['cupsScore']),
      farmDescription: serializer.fromJson<String>(json['farmDescription']),
      farmPhotosUrlCover: serializer.fromJson<String>(
        json['farmPhotosUrlCover'],
      ),
      plantationPhotosUrl: serializer.fromJson<String>(
        json['plantationPhotosUrl'],
      ),
      processingMethodsJson: serializer.fromJson<String>(
        json['processingMethodsJson'],
      ),
      brandId: serializer.fromJson<int?>(json['brandId']),
      sensoryJson: serializer.fromJson<String>(json['sensoryJson']),
      roastLevel: serializer.fromJson<String>(json['roastLevel']),
      weight: serializer.fromJson<String>(json['weight']),
      price: serializer.fromJson<String>(json['price']),
      roastDate: serializer.fromJson<String>(json['roastDate']),
      lotNumber: serializer.fromJson<String>(json['lotNumber']),
      url: serializer.fromJson<String>(json['url']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
      detailedProcessMarkdown: serializer.fromJson<String>(
        json['detailedProcessMarkdown'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'countryEmoji': serializer.toJson<String>(countryEmoji),
      'country': serializer.toJson<String>(country),
      'region': serializer.toJson<String>(region),
      'altitudeMin': serializer.toJson<int>(altitudeMin),
      'altitudeMax': serializer.toJson<int>(altitudeMax),
      'varieties': serializer.toJson<String>(varieties),
      'flavorNotes': serializer.toJson<String>(flavorNotes),
      'processMethod': serializer.toJson<String>(processMethod),
      'harvestSeason': serializer.toJson<String>(harvestSeason),
      'description': serializer.toJson<String>(description),
      'cupsScore': serializer.toJson<double>(cupsScore),
      'farmDescription': serializer.toJson<String>(farmDescription),
      'farmPhotosUrlCover': serializer.toJson<String>(farmPhotosUrlCover),
      'plantationPhotosUrl': serializer.toJson<String>(plantationPhotosUrl),
      'processingMethodsJson': serializer.toJson<String>(processingMethodsJson),
      'brandId': serializer.toJson<int?>(brandId),
      'sensoryJson': serializer.toJson<String>(sensoryJson),
      'roastLevel': serializer.toJson<String>(roastLevel),
      'weight': serializer.toJson<String>(weight),
      'price': serializer.toJson<String>(price),
      'roastDate': serializer.toJson<String>(roastDate),
      'lotNumber': serializer.toJson<String>(lotNumber),
      'url': serializer.toJson<String>(url),
      'isPremium': serializer.toJson<bool>(isPremium),
      'detailedProcessMarkdown': serializer.toJson<String>(
        detailedProcessMarkdown,
      ),
    };
  }

  EncyclopediaEntry copyWith({
    int? id,
    String? countryEmoji,
    String? country,
    String? region,
    int? altitudeMin,
    int? altitudeMax,
    String? varieties,
    String? flavorNotes,
    String? processMethod,
    String? harvestSeason,
    String? description,
    double? cupsScore,
    String? farmDescription,
    String? farmPhotosUrlCover,
    String? plantationPhotosUrl,
    String? processingMethodsJson,
    Value<int?> brandId = const Value.absent(),
    String? sensoryJson,
    String? roastLevel,
    String? weight,
    String? price,
    String? roastDate,
    String? lotNumber,
    String? url,
    bool? isPremium,
    String? detailedProcessMarkdown,
  }) => EncyclopediaEntry(
    id: id ?? this.id,
    countryEmoji: countryEmoji ?? this.countryEmoji,
    country: country ?? this.country,
    region: region ?? this.region,
    altitudeMin: altitudeMin ?? this.altitudeMin,
    altitudeMax: altitudeMax ?? this.altitudeMax,
    varieties: varieties ?? this.varieties,
    flavorNotes: flavorNotes ?? this.flavorNotes,
    processMethod: processMethod ?? this.processMethod,
    harvestSeason: harvestSeason ?? this.harvestSeason,
    description: description ?? this.description,
    cupsScore: cupsScore ?? this.cupsScore,
    farmDescription: farmDescription ?? this.farmDescription,
    farmPhotosUrlCover: farmPhotosUrlCover ?? this.farmPhotosUrlCover,
    plantationPhotosUrl: plantationPhotosUrl ?? this.plantationPhotosUrl,
    processingMethodsJson: processingMethodsJson ?? this.processingMethodsJson,
    brandId: brandId.present ? brandId.value : this.brandId,
    sensoryJson: sensoryJson ?? this.sensoryJson,
    roastLevel: roastLevel ?? this.roastLevel,
    weight: weight ?? this.weight,
    price: price ?? this.price,
    roastDate: roastDate ?? this.roastDate,
    lotNumber: lotNumber ?? this.lotNumber,
    url: url ?? this.url,
    isPremium: isPremium ?? this.isPremium,
    detailedProcessMarkdown:
        detailedProcessMarkdown ?? this.detailedProcessMarkdown,
  );
  EncyclopediaEntry copyWithCompanion(EncyclopediaEntriesCompanion data) {
    return EncyclopediaEntry(
      id: data.id.present ? data.id.value : this.id,
      countryEmoji: data.countryEmoji.present
          ? data.countryEmoji.value
          : this.countryEmoji,
      country: data.country.present ? data.country.value : this.country,
      region: data.region.present ? data.region.value : this.region,
      altitudeMin: data.altitudeMin.present
          ? data.altitudeMin.value
          : this.altitudeMin,
      altitudeMax: data.altitudeMax.present
          ? data.altitudeMax.value
          : this.altitudeMax,
      varieties: data.varieties.present ? data.varieties.value : this.varieties,
      flavorNotes: data.flavorNotes.present
          ? data.flavorNotes.value
          : this.flavorNotes,
      processMethod: data.processMethod.present
          ? data.processMethod.value
          : this.processMethod,
      harvestSeason: data.harvestSeason.present
          ? data.harvestSeason.value
          : this.harvestSeason,
      description: data.description.present
          ? data.description.value
          : this.description,
      cupsScore: data.cupsScore.present ? data.cupsScore.value : this.cupsScore,
      farmDescription: data.farmDescription.present
          ? data.farmDescription.value
          : this.farmDescription,
      farmPhotosUrlCover: data.farmPhotosUrlCover.present
          ? data.farmPhotosUrlCover.value
          : this.farmPhotosUrlCover,
      plantationPhotosUrl: data.plantationPhotosUrl.present
          ? data.plantationPhotosUrl.value
          : this.plantationPhotosUrl,
      processingMethodsJson: data.processingMethodsJson.present
          ? data.processingMethodsJson.value
          : this.processingMethodsJson,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      sensoryJson: data.sensoryJson.present
          ? data.sensoryJson.value
          : this.sensoryJson,
      roastLevel: data.roastLevel.present
          ? data.roastLevel.value
          : this.roastLevel,
      weight: data.weight.present ? data.weight.value : this.weight,
      price: data.price.present ? data.price.value : this.price,
      roastDate: data.roastDate.present ? data.roastDate.value : this.roastDate,
      lotNumber: data.lotNumber.present ? data.lotNumber.value : this.lotNumber,
      url: data.url.present ? data.url.value : this.url,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
      detailedProcessMarkdown: data.detailedProcessMarkdown.present
          ? data.detailedProcessMarkdown.value
          : this.detailedProcessMarkdown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EncyclopediaEntry(')
          ..write('id: $id, ')
          ..write('countryEmoji: $countryEmoji, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('altitudeMin: $altitudeMin, ')
          ..write('altitudeMax: $altitudeMax, ')
          ..write('varieties: $varieties, ')
          ..write('flavorNotes: $flavorNotes, ')
          ..write('processMethod: $processMethod, ')
          ..write('harvestSeason: $harvestSeason, ')
          ..write('description: $description, ')
          ..write('cupsScore: $cupsScore, ')
          ..write('farmDescription: $farmDescription, ')
          ..write('farmPhotosUrlCover: $farmPhotosUrlCover, ')
          ..write('plantationPhotosUrl: $plantationPhotosUrl, ')
          ..write('processingMethodsJson: $processingMethodsJson, ')
          ..write('brandId: $brandId, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('roastLevel: $roastLevel, ')
          ..write('weight: $weight, ')
          ..write('price: $price, ')
          ..write('roastDate: $roastDate, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('url: $url, ')
          ..write('isPremium: $isPremium, ')
          ..write('detailedProcessMarkdown: $detailedProcessMarkdown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    countryEmoji,
    country,
    region,
    altitudeMin,
    altitudeMax,
    varieties,
    flavorNotes,
    processMethod,
    harvestSeason,
    description,
    cupsScore,
    farmDescription,
    farmPhotosUrlCover,
    plantationPhotosUrl,
    processingMethodsJson,
    brandId,
    sensoryJson,
    roastLevel,
    weight,
    price,
    roastDate,
    lotNumber,
    url,
    isPremium,
    detailedProcessMarkdown,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EncyclopediaEntry &&
          other.id == this.id &&
          other.countryEmoji == this.countryEmoji &&
          other.country == this.country &&
          other.region == this.region &&
          other.altitudeMin == this.altitudeMin &&
          other.altitudeMax == this.altitudeMax &&
          other.varieties == this.varieties &&
          other.flavorNotes == this.flavorNotes &&
          other.processMethod == this.processMethod &&
          other.harvestSeason == this.harvestSeason &&
          other.description == this.description &&
          other.cupsScore == this.cupsScore &&
          other.farmDescription == this.farmDescription &&
          other.farmPhotosUrlCover == this.farmPhotosUrlCover &&
          other.plantationPhotosUrl == this.plantationPhotosUrl &&
          other.processingMethodsJson == this.processingMethodsJson &&
          other.brandId == this.brandId &&
          other.sensoryJson == this.sensoryJson &&
          other.roastLevel == this.roastLevel &&
          other.weight == this.weight &&
          other.price == this.price &&
          other.roastDate == this.roastDate &&
          other.lotNumber == this.lotNumber &&
          other.url == this.url &&
          other.isPremium == this.isPremium &&
          other.detailedProcessMarkdown == this.detailedProcessMarkdown);
}

class EncyclopediaEntriesCompanion extends UpdateCompanion<EncyclopediaEntry> {
  final Value<int> id;
  final Value<String> countryEmoji;
  final Value<String> country;
  final Value<String> region;
  final Value<int> altitudeMin;
  final Value<int> altitudeMax;
  final Value<String> varieties;
  final Value<String> flavorNotes;
  final Value<String> processMethod;
  final Value<String> harvestSeason;
  final Value<String> description;
  final Value<double> cupsScore;
  final Value<String> farmDescription;
  final Value<String> farmPhotosUrlCover;
  final Value<String> plantationPhotosUrl;
  final Value<String> processingMethodsJson;
  final Value<int?> brandId;
  final Value<String> sensoryJson;
  final Value<String> roastLevel;
  final Value<String> weight;
  final Value<String> price;
  final Value<String> roastDate;
  final Value<String> lotNumber;
  final Value<String> url;
  final Value<bool> isPremium;
  final Value<String> detailedProcessMarkdown;
  const EncyclopediaEntriesCompanion({
    this.id = const Value.absent(),
    this.countryEmoji = const Value.absent(),
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.altitudeMin = const Value.absent(),
    this.altitudeMax = const Value.absent(),
    this.varieties = const Value.absent(),
    this.flavorNotes = const Value.absent(),
    this.processMethod = const Value.absent(),
    this.harvestSeason = const Value.absent(),
    this.description = const Value.absent(),
    this.cupsScore = const Value.absent(),
    this.farmDescription = const Value.absent(),
    this.farmPhotosUrlCover = const Value.absent(),
    this.plantationPhotosUrl = const Value.absent(),
    this.processingMethodsJson = const Value.absent(),
    this.brandId = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.weight = const Value.absent(),
    this.price = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.url = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.detailedProcessMarkdown = const Value.absent(),
  });
  EncyclopediaEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String countryEmoji,
    required String country,
    required String region,
    required int altitudeMin,
    required int altitudeMax,
    required String varieties,
    required String flavorNotes,
    required String processMethod,
    required String harvestSeason,
    required String description,
    required double cupsScore,
    this.farmDescription = const Value.absent(),
    this.farmPhotosUrlCover = const Value.absent(),
    this.plantationPhotosUrl = const Value.absent(),
    this.processingMethodsJson = const Value.absent(),
    this.brandId = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.weight = const Value.absent(),
    this.price = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.url = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.detailedProcessMarkdown = const Value.absent(),
  }) : countryEmoji = Value(countryEmoji),
       country = Value(country),
       region = Value(region),
       altitudeMin = Value(altitudeMin),
       altitudeMax = Value(altitudeMax),
       varieties = Value(varieties),
       flavorNotes = Value(flavorNotes),
       processMethod = Value(processMethod),
       harvestSeason = Value(harvestSeason),
       description = Value(description),
       cupsScore = Value(cupsScore);
  static Insertable<EncyclopediaEntry> custom({
    Expression<int>? id,
    Expression<String>? countryEmoji,
    Expression<String>? country,
    Expression<String>? region,
    Expression<int>? altitudeMin,
    Expression<int>? altitudeMax,
    Expression<String>? varieties,
    Expression<String>? flavorNotes,
    Expression<String>? processMethod,
    Expression<String>? harvestSeason,
    Expression<String>? description,
    Expression<double>? cupsScore,
    Expression<String>? farmDescription,
    Expression<String>? farmPhotosUrlCover,
    Expression<String>? plantationPhotosUrl,
    Expression<String>? processingMethodsJson,
    Expression<int>? brandId,
    Expression<String>? sensoryJson,
    Expression<String>? roastLevel,
    Expression<String>? weight,
    Expression<String>? price,
    Expression<String>? roastDate,
    Expression<String>? lotNumber,
    Expression<String>? url,
    Expression<bool>? isPremium,
    Expression<String>? detailedProcessMarkdown,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (countryEmoji != null) 'country_emoji': countryEmoji,
      if (country != null) 'country': country,
      if (region != null) 'region': region,
      if (altitudeMin != null) 'altitude_min': altitudeMin,
      if (altitudeMax != null) 'altitude_max': altitudeMax,
      if (varieties != null) 'varieties': varieties,
      if (flavorNotes != null) 'flavor_notes': flavorNotes,
      if (processMethod != null) 'process_method': processMethod,
      if (harvestSeason != null) 'harvest_season': harvestSeason,
      if (description != null) 'description': description,
      if (cupsScore != null) 'cups_score': cupsScore,
      if (farmDescription != null) 'farm_description': farmDescription,
      if (farmPhotosUrlCover != null)
        'farm_photos_url_cover': farmPhotosUrlCover,
      if (plantationPhotosUrl != null)
        'plantation_photos_url': plantationPhotosUrl,
      if (processingMethodsJson != null)
        'processing_methods_json': processingMethodsJson,
      if (brandId != null) 'brand_id': brandId,
      if (sensoryJson != null) 'sensory_json': sensoryJson,
      if (roastLevel != null) 'roast_level': roastLevel,
      if (weight != null) 'weight': weight,
      if (price != null) 'price': price,
      if (roastDate != null) 'roast_date': roastDate,
      if (lotNumber != null) 'lot_number': lotNumber,
      if (url != null) 'url': url,
      if (isPremium != null) 'is_premium': isPremium,
      if (detailedProcessMarkdown != null)
        'detailed_process_markdown': detailedProcessMarkdown,
    });
  }

  EncyclopediaEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? countryEmoji,
    Value<String>? country,
    Value<String>? region,
    Value<int>? altitudeMin,
    Value<int>? altitudeMax,
    Value<String>? varieties,
    Value<String>? flavorNotes,
    Value<String>? processMethod,
    Value<String>? harvestSeason,
    Value<String>? description,
    Value<double>? cupsScore,
    Value<String>? farmDescription,
    Value<String>? farmPhotosUrlCover,
    Value<String>? plantationPhotosUrl,
    Value<String>? processingMethodsJson,
    Value<int?>? brandId,
    Value<String>? sensoryJson,
    Value<String>? roastLevel,
    Value<String>? weight,
    Value<String>? price,
    Value<String>? roastDate,
    Value<String>? lotNumber,
    Value<String>? url,
    Value<bool>? isPremium,
    Value<String>? detailedProcessMarkdown,
  }) {
    return EncyclopediaEntriesCompanion(
      id: id ?? this.id,
      countryEmoji: countryEmoji ?? this.countryEmoji,
      country: country ?? this.country,
      region: region ?? this.region,
      altitudeMin: altitudeMin ?? this.altitudeMin,
      altitudeMax: altitudeMax ?? this.altitudeMax,
      varieties: varieties ?? this.varieties,
      flavorNotes: flavorNotes ?? this.flavorNotes,
      processMethod: processMethod ?? this.processMethod,
      harvestSeason: harvestSeason ?? this.harvestSeason,
      description: description ?? this.description,
      cupsScore: cupsScore ?? this.cupsScore,
      farmDescription: farmDescription ?? this.farmDescription,
      farmPhotosUrlCover: farmPhotosUrlCover ?? this.farmPhotosUrlCover,
      plantationPhotosUrl: plantationPhotosUrl ?? this.plantationPhotosUrl,
      processingMethodsJson:
          processingMethodsJson ?? this.processingMethodsJson,
      brandId: brandId ?? this.brandId,
      sensoryJson: sensoryJson ?? this.sensoryJson,
      roastLevel: roastLevel ?? this.roastLevel,
      weight: weight ?? this.weight,
      price: price ?? this.price,
      roastDate: roastDate ?? this.roastDate,
      lotNumber: lotNumber ?? this.lotNumber,
      url: url ?? this.url,
      isPremium: isPremium ?? this.isPremium,
      detailedProcessMarkdown:
          detailedProcessMarkdown ?? this.detailedProcessMarkdown,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (countryEmoji.present) {
      map['country_emoji'] = Variable<String>(countryEmoji.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (altitudeMin.present) {
      map['altitude_min'] = Variable<int>(altitudeMin.value);
    }
    if (altitudeMax.present) {
      map['altitude_max'] = Variable<int>(altitudeMax.value);
    }
    if (varieties.present) {
      map['varieties'] = Variable<String>(varieties.value);
    }
    if (flavorNotes.present) {
      map['flavor_notes'] = Variable<String>(flavorNotes.value);
    }
    if (processMethod.present) {
      map['process_method'] = Variable<String>(processMethod.value);
    }
    if (harvestSeason.present) {
      map['harvest_season'] = Variable<String>(harvestSeason.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (cupsScore.present) {
      map['cups_score'] = Variable<double>(cupsScore.value);
    }
    if (farmDescription.present) {
      map['farm_description'] = Variable<String>(farmDescription.value);
    }
    if (farmPhotosUrlCover.present) {
      map['farm_photos_url_cover'] = Variable<String>(farmPhotosUrlCover.value);
    }
    if (plantationPhotosUrl.present) {
      map['plantation_photos_url'] = Variable<String>(
        plantationPhotosUrl.value,
      );
    }
    if (processingMethodsJson.present) {
      map['processing_methods_json'] = Variable<String>(
        processingMethodsJson.value,
      );
    }
    if (brandId.present) {
      map['brand_id'] = Variable<int>(brandId.value);
    }
    if (sensoryJson.present) {
      map['sensory_json'] = Variable<String>(sensoryJson.value);
    }
    if (roastLevel.present) {
      map['roast_level'] = Variable<String>(roastLevel.value);
    }
    if (weight.present) {
      map['weight'] = Variable<String>(weight.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (roastDate.present) {
      map['roast_date'] = Variable<String>(roastDate.value);
    }
    if (lotNumber.present) {
      map['lot_number'] = Variable<String>(lotNumber.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    if (detailedProcessMarkdown.present) {
      map['detailed_process_markdown'] = Variable<String>(
        detailedProcessMarkdown.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EncyclopediaEntriesCompanion(')
          ..write('id: $id, ')
          ..write('countryEmoji: $countryEmoji, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('altitudeMin: $altitudeMin, ')
          ..write('altitudeMax: $altitudeMax, ')
          ..write('varieties: $varieties, ')
          ..write('flavorNotes: $flavorNotes, ')
          ..write('processMethod: $processMethod, ')
          ..write('harvestSeason: $harvestSeason, ')
          ..write('description: $description, ')
          ..write('cupsScore: $cupsScore, ')
          ..write('farmDescription: $farmDescription, ')
          ..write('farmPhotosUrlCover: $farmPhotosUrlCover, ')
          ..write('plantationPhotosUrl: $plantationPhotosUrl, ')
          ..write('processingMethodsJson: $processingMethodsJson, ')
          ..write('brandId: $brandId, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('roastLevel: $roastLevel, ')
          ..write('weight: $weight, ')
          ..write('price: $price, ')
          ..write('roastDate: $roastDate, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('url: $url, ')
          ..write('isPremium: $isPremium, ')
          ..write('detailedProcessMarkdown: $detailedProcessMarkdown')
          ..write(')'))
        .toString();
  }
}

class $LatteArtPatternsTable extends LatteArtPatterns
    with TableInfo<$LatteArtPatternsTable, LatteArtPattern> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LatteArtPatternsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsJsonMeta = const VerificationMeta(
    'stepsJson',
  );
  @override
  late final GeneratedColumn<String> stepsJson = GeneratedColumn<String>(
    'steps_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _userBestScoreMeta = const VerificationMeta(
    'userBestScore',
  );
  @override
  late final GeneratedColumn<int> userBestScore = GeneratedColumn<int>(
    'user_best_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipTextMeta = const VerificationMeta(
    'tipText',
  );
  @override
  late final GeneratedColumn<String> tipText = GeneratedColumn<String>(
    'tip_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    difficulty,
    stepsJson,
    isFavorite,
    userBestScore,
    description,
    tipText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'latte_art_patterns';
  @override
  VerificationContext validateIntegrity(
    Insertable<LatteArtPattern> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('steps_json')) {
      context.handle(
        _stepsJsonMeta,
        stepsJson.isAcceptableOrUnknown(data['steps_json']!, _stepsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsJsonMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('user_best_score')) {
      context.handle(
        _userBestScoreMeta,
        userBestScore.isAcceptableOrUnknown(
          data['user_best_score']!,
          _userBestScoreMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('tip_text')) {
      context.handle(
        _tipTextMeta,
        tipText.isAcceptableOrUnknown(data['tip_text']!, _tipTextMeta),
      );
    } else if (isInserting) {
      context.missing(_tipTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LatteArtPattern map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LatteArtPattern(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty'],
      )!,
      stepsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}steps_json'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      userBestScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_best_score'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      tipText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tip_text'],
      )!,
    );
  }

  @override
  $LatteArtPatternsTable createAlias(String alias) {
    return $LatteArtPatternsTable(attachedDatabase, alias);
  }
}

class LatteArtPattern extends DataClass implements Insertable<LatteArtPattern> {
  final int id;
  final String name;
  final int difficulty;
  final String stepsJson;
  final bool isFavorite;
  final int userBestScore;
  final String description;
  final String tipText;
  const LatteArtPattern({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.stepsJson,
    required this.isFavorite,
    required this.userBestScore,
    required this.description,
    required this.tipText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['difficulty'] = Variable<int>(difficulty);
    map['steps_json'] = Variable<String>(stepsJson);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['user_best_score'] = Variable<int>(userBestScore);
    map['description'] = Variable<String>(description);
    map['tip_text'] = Variable<String>(tipText);
    return map;
  }

  LatteArtPatternsCompanion toCompanion(bool nullToAbsent) {
    return LatteArtPatternsCompanion(
      id: Value(id),
      name: Value(name),
      difficulty: Value(difficulty),
      stepsJson: Value(stepsJson),
      isFavorite: Value(isFavorite),
      userBestScore: Value(userBestScore),
      description: Value(description),
      tipText: Value(tipText),
    );
  }

  factory LatteArtPattern.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LatteArtPattern(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      stepsJson: serializer.fromJson<String>(json['stepsJson']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      userBestScore: serializer.fromJson<int>(json['userBestScore']),
      description: serializer.fromJson<String>(json['description']),
      tipText: serializer.fromJson<String>(json['tipText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'difficulty': serializer.toJson<int>(difficulty),
      'stepsJson': serializer.toJson<String>(stepsJson),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'userBestScore': serializer.toJson<int>(userBestScore),
      'description': serializer.toJson<String>(description),
      'tipText': serializer.toJson<String>(tipText),
    };
  }

  LatteArtPattern copyWith({
    int? id,
    String? name,
    int? difficulty,
    String? stepsJson,
    bool? isFavorite,
    int? userBestScore,
    String? description,
    String? tipText,
  }) => LatteArtPattern(
    id: id ?? this.id,
    name: name ?? this.name,
    difficulty: difficulty ?? this.difficulty,
    stepsJson: stepsJson ?? this.stepsJson,
    isFavorite: isFavorite ?? this.isFavorite,
    userBestScore: userBestScore ?? this.userBestScore,
    description: description ?? this.description,
    tipText: tipText ?? this.tipText,
  );
  LatteArtPattern copyWithCompanion(LatteArtPatternsCompanion data) {
    return LatteArtPattern(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      stepsJson: data.stepsJson.present ? data.stepsJson.value : this.stepsJson,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      userBestScore: data.userBestScore.present
          ? data.userBestScore.value
          : this.userBestScore,
      description: data.description.present
          ? data.description.value
          : this.description,
      tipText: data.tipText.present ? data.tipText.value : this.tipText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LatteArtPattern(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('difficulty: $difficulty, ')
          ..write('stepsJson: $stepsJson, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('userBestScore: $userBestScore, ')
          ..write('description: $description, ')
          ..write('tipText: $tipText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    difficulty,
    stepsJson,
    isFavorite,
    userBestScore,
    description,
    tipText,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LatteArtPattern &&
          other.id == this.id &&
          other.name == this.name &&
          other.difficulty == this.difficulty &&
          other.stepsJson == this.stepsJson &&
          other.isFavorite == this.isFavorite &&
          other.userBestScore == this.userBestScore &&
          other.description == this.description &&
          other.tipText == this.tipText);
}

class LatteArtPatternsCompanion extends UpdateCompanion<LatteArtPattern> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> difficulty;
  final Value<String> stepsJson;
  final Value<bool> isFavorite;
  final Value<int> userBestScore;
  final Value<String> description;
  final Value<String> tipText;
  const LatteArtPatternsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.stepsJson = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.userBestScore = const Value.absent(),
    this.description = const Value.absent(),
    this.tipText = const Value.absent(),
  });
  LatteArtPatternsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int difficulty,
    required String stepsJson,
    this.isFavorite = const Value.absent(),
    this.userBestScore = const Value.absent(),
    required String description,
    required String tipText,
  }) : name = Value(name),
       difficulty = Value(difficulty),
       stepsJson = Value(stepsJson),
       description = Value(description),
       tipText = Value(tipText);
  static Insertable<LatteArtPattern> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? difficulty,
    Expression<String>? stepsJson,
    Expression<bool>? isFavorite,
    Expression<int>? userBestScore,
    Expression<String>? description,
    Expression<String>? tipText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (difficulty != null) 'difficulty': difficulty,
      if (stepsJson != null) 'steps_json': stepsJson,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (userBestScore != null) 'user_best_score': userBestScore,
      if (description != null) 'description': description,
      if (tipText != null) 'tip_text': tipText,
    });
  }

  LatteArtPatternsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? difficulty,
    Value<String>? stepsJson,
    Value<bool>? isFavorite,
    Value<int>? userBestScore,
    Value<String>? description,
    Value<String>? tipText,
  }) {
    return LatteArtPatternsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      stepsJson: stepsJson ?? this.stepsJson,
      isFavorite: isFavorite ?? this.isFavorite,
      userBestScore: userBestScore ?? this.userBestScore,
      description: description ?? this.description,
      tipText: tipText ?? this.tipText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (stepsJson.present) {
      map['steps_json'] = Variable<String>(stepsJson.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (userBestScore.present) {
      map['user_best_score'] = Variable<int>(userBestScore.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (tipText.present) {
      map['tip_text'] = Variable<String>(tipText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LatteArtPatternsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('difficulty: $difficulty, ')
          ..write('stepsJson: $stepsJson, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('userBestScore: $userBestScore, ')
          ..write('description: $description, ')
          ..write('tipText: $tipText')
          ..write(')'))
        .toString();
  }
}

class $BeanScansTable extends BeanScans
    with TableInfo<$BeanScansTable, BeanScan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BeanScansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scannedAtMeta = const VerificationMeta(
    'scannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> scannedAt = GeneratedColumn<DateTime>(
    'scanned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _agtronValueMeta = const VerificationMeta(
    'agtronValue',
  );
  @override
  late final GeneratedColumn<double> agtronValue = GeneratedColumn<double>(
    'agtron_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roastLabelMeta = const VerificationMeta(
    'roastLabel',
  );
  @override
  late final GeneratedColumn<String> roastLabel = GeneratedColumn<String>(
    'roast_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _flavorProfileMeta = const VerificationMeta(
    'flavorProfile',
  );
  @override
  late final GeneratedColumn<String> flavorProfile = GeneratedColumn<String>(
    'flavor_profile',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recommendedMethodMeta = const VerificationMeta(
    'recommendedMethod',
  );
  @override
  late final GeneratedColumn<String> recommendedMethod =
      GeneratedColumn<String>(
        'recommended_method',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scannedAt,
    agtronValue,
    roastLabel,
    flavorProfile,
    recommendedMethod,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bean_scans';
  @override
  VerificationContext validateIntegrity(
    Insertable<BeanScan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('scanned_at')) {
      context.handle(
        _scannedAtMeta,
        scannedAt.isAcceptableOrUnknown(data['scanned_at']!, _scannedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_scannedAtMeta);
    }
    if (data.containsKey('agtron_value')) {
      context.handle(
        _agtronValueMeta,
        agtronValue.isAcceptableOrUnknown(
          data['agtron_value']!,
          _agtronValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_agtronValueMeta);
    }
    if (data.containsKey('roast_label')) {
      context.handle(
        _roastLabelMeta,
        roastLabel.isAcceptableOrUnknown(data['roast_label']!, _roastLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_roastLabelMeta);
    }
    if (data.containsKey('flavor_profile')) {
      context.handle(
        _flavorProfileMeta,
        flavorProfile.isAcceptableOrUnknown(
          data['flavor_profile']!,
          _flavorProfileMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_flavorProfileMeta);
    }
    if (data.containsKey('recommended_method')) {
      context.handle(
        _recommendedMethodMeta,
        recommendedMethod.isAcceptableOrUnknown(
          data['recommended_method']!,
          _recommendedMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recommendedMethodMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BeanScan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BeanScan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      scannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scanned_at'],
      )!,
      agtronValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}agtron_value'],
      )!,
      roastLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_label'],
      )!,
      flavorProfile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_profile'],
      )!,
      recommendedMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommended_method'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $BeanScansTable createAlias(String alias) {
    return $BeanScansTable(attachedDatabase, alias);
  }
}

class BeanScan extends DataClass implements Insertable<BeanScan> {
  final int id;
  final DateTime scannedAt;
  final double agtronValue;
  final String roastLabel;
  final String flavorProfile;
  final String recommendedMethod;
  final String notes;
  const BeanScan({
    required this.id,
    required this.scannedAt,
    required this.agtronValue,
    required this.roastLabel,
    required this.flavorProfile,
    required this.recommendedMethod,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['scanned_at'] = Variable<DateTime>(scannedAt);
    map['agtron_value'] = Variable<double>(agtronValue);
    map['roast_label'] = Variable<String>(roastLabel);
    map['flavor_profile'] = Variable<String>(flavorProfile);
    map['recommended_method'] = Variable<String>(recommendedMethod);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  BeanScansCompanion toCompanion(bool nullToAbsent) {
    return BeanScansCompanion(
      id: Value(id),
      scannedAt: Value(scannedAt),
      agtronValue: Value(agtronValue),
      roastLabel: Value(roastLabel),
      flavorProfile: Value(flavorProfile),
      recommendedMethod: Value(recommendedMethod),
      notes: Value(notes),
    );
  }

  factory BeanScan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BeanScan(
      id: serializer.fromJson<int>(json['id']),
      scannedAt: serializer.fromJson<DateTime>(json['scannedAt']),
      agtronValue: serializer.fromJson<double>(json['agtronValue']),
      roastLabel: serializer.fromJson<String>(json['roastLabel']),
      flavorProfile: serializer.fromJson<String>(json['flavorProfile']),
      recommendedMethod: serializer.fromJson<String>(json['recommendedMethod']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scannedAt': serializer.toJson<DateTime>(scannedAt),
      'agtronValue': serializer.toJson<double>(agtronValue),
      'roastLabel': serializer.toJson<String>(roastLabel),
      'flavorProfile': serializer.toJson<String>(flavorProfile),
      'recommendedMethod': serializer.toJson<String>(recommendedMethod),
      'notes': serializer.toJson<String>(notes),
    };
  }

  BeanScan copyWith({
    int? id,
    DateTime? scannedAt,
    double? agtronValue,
    String? roastLabel,
    String? flavorProfile,
    String? recommendedMethod,
    String? notes,
  }) => BeanScan(
    id: id ?? this.id,
    scannedAt: scannedAt ?? this.scannedAt,
    agtronValue: agtronValue ?? this.agtronValue,
    roastLabel: roastLabel ?? this.roastLabel,
    flavorProfile: flavorProfile ?? this.flavorProfile,
    recommendedMethod: recommendedMethod ?? this.recommendedMethod,
    notes: notes ?? this.notes,
  );
  BeanScan copyWithCompanion(BeanScansCompanion data) {
    return BeanScan(
      id: data.id.present ? data.id.value : this.id,
      scannedAt: data.scannedAt.present ? data.scannedAt.value : this.scannedAt,
      agtronValue: data.agtronValue.present
          ? data.agtronValue.value
          : this.agtronValue,
      roastLabel: data.roastLabel.present
          ? data.roastLabel.value
          : this.roastLabel,
      flavorProfile: data.flavorProfile.present
          ? data.flavorProfile.value
          : this.flavorProfile,
      recommendedMethod: data.recommendedMethod.present
          ? data.recommendedMethod.value
          : this.recommendedMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BeanScan(')
          ..write('id: $id, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('agtronValue: $agtronValue, ')
          ..write('roastLabel: $roastLabel, ')
          ..write('flavorProfile: $flavorProfile, ')
          ..write('recommendedMethod: $recommendedMethod, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scannedAt,
    agtronValue,
    roastLabel,
    flavorProfile,
    recommendedMethod,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BeanScan &&
          other.id == this.id &&
          other.scannedAt == this.scannedAt &&
          other.agtronValue == this.agtronValue &&
          other.roastLabel == this.roastLabel &&
          other.flavorProfile == this.flavorProfile &&
          other.recommendedMethod == this.recommendedMethod &&
          other.notes == this.notes);
}

class BeanScansCompanion extends UpdateCompanion<BeanScan> {
  final Value<int> id;
  final Value<DateTime> scannedAt;
  final Value<double> agtronValue;
  final Value<String> roastLabel;
  final Value<String> flavorProfile;
  final Value<String> recommendedMethod;
  final Value<String> notes;
  const BeanScansCompanion({
    this.id = const Value.absent(),
    this.scannedAt = const Value.absent(),
    this.agtronValue = const Value.absent(),
    this.roastLabel = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.recommendedMethod = const Value.absent(),
    this.notes = const Value.absent(),
  });
  BeanScansCompanion.insert({
    this.id = const Value.absent(),
    required DateTime scannedAt,
    required double agtronValue,
    required String roastLabel,
    required String flavorProfile,
    required String recommendedMethod,
    this.notes = const Value.absent(),
  }) : scannedAt = Value(scannedAt),
       agtronValue = Value(agtronValue),
       roastLabel = Value(roastLabel),
       flavorProfile = Value(flavorProfile),
       recommendedMethod = Value(recommendedMethod);
  static Insertable<BeanScan> custom({
    Expression<int>? id,
    Expression<DateTime>? scannedAt,
    Expression<double>? agtronValue,
    Expression<String>? roastLabel,
    Expression<String>? flavorProfile,
    Expression<String>? recommendedMethod,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scannedAt != null) 'scanned_at': scannedAt,
      if (agtronValue != null) 'agtron_value': agtronValue,
      if (roastLabel != null) 'roast_label': roastLabel,
      if (flavorProfile != null) 'flavor_profile': flavorProfile,
      if (recommendedMethod != null) 'recommended_method': recommendedMethod,
      if (notes != null) 'notes': notes,
    });
  }

  BeanScansCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? scannedAt,
    Value<double>? agtronValue,
    Value<String>? roastLabel,
    Value<String>? flavorProfile,
    Value<String>? recommendedMethod,
    Value<String>? notes,
  }) {
    return BeanScansCompanion(
      id: id ?? this.id,
      scannedAt: scannedAt ?? this.scannedAt,
      agtronValue: agtronValue ?? this.agtronValue,
      roastLabel: roastLabel ?? this.roastLabel,
      flavorProfile: flavorProfile ?? this.flavorProfile,
      recommendedMethod: recommendedMethod ?? this.recommendedMethod,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scannedAt.present) {
      map['scanned_at'] = Variable<DateTime>(scannedAt.value);
    }
    if (agtronValue.present) {
      map['agtron_value'] = Variable<double>(agtronValue.value);
    }
    if (roastLabel.present) {
      map['roast_label'] = Variable<String>(roastLabel.value);
    }
    if (flavorProfile.present) {
      map['flavor_profile'] = Variable<String>(flavorProfile.value);
    }
    if (recommendedMethod.present) {
      map['recommended_method'] = Variable<String>(recommendedMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BeanScansCompanion(')
          ..write('id: $id, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('agtronValue: $agtronValue, ')
          ..write('roastLabel: $roastLabel, ')
          ..write('flavorProfile: $flavorProfile, ')
          ..write('recommendedMethod: $recommendedMethod, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $CustomRecipesTable extends CustomRecipes
    with TableInfo<$CustomRecipesTable, CustomRecipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _methodKeyMeta = const VerificationMeta(
    'methodKey',
  );
  @override
  late final GeneratedColumn<String> methodKey = GeneratedColumn<String>(
    'method_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeGramsMeta = const VerificationMeta(
    'coffeeGrams',
  );
  @override
  late final GeneratedColumn<double> coffeeGrams = GeneratedColumn<double>(
    'coffee_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalWaterMlMeta = const VerificationMeta(
    'totalWaterMl',
  );
  @override
  late final GeneratedColumn<double> totalWaterMl = GeneratedColumn<double>(
    'total_water_ml',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grindNumberMeta = const VerificationMeta(
    'grindNumber',
  );
  @override
  late final GeneratedColumn<int> grindNumber = GeneratedColumn<int>(
    'grind_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _comandanteClicksMeta = const VerificationMeta(
    'comandanteClicks',
  );
  @override
  late final GeneratedColumn<int> comandanteClicks = GeneratedColumn<int>(
    'comandante_clicks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ek43DivisionMeta = const VerificationMeta(
    'ek43Division',
  );
  @override
  late final GeneratedColumn<int> ek43Division = GeneratedColumn<int>(
    'ek43_division',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalPoursMeta = const VerificationMeta(
    'totalPours',
  );
  @override
  late final GeneratedColumn<int> totalPours = GeneratedColumn<int>(
    'total_pours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _pourScheduleJsonMeta = const VerificationMeta(
    'pourScheduleJson',
  );
  @override
  late final GeneratedColumn<String> pourScheduleJson = GeneratedColumn<String>(
    'pour_schedule_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _brewTempCMeta = const VerificationMeta(
    'brewTempC',
  );
  @override
  late final GeneratedColumn<double> brewTempC = GeneratedColumn<double>(
    'brew_temp_c',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(93.0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    methodKey,
    name,
    createdAt,
    updatedAt,
    coffeeGrams,
    totalWaterMl,
    grindNumber,
    comandanteClicks,
    ek43Division,
    totalPours,
    pourScheduleJson,
    brewTempC,
    notes,
    rating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomRecipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('method_key')) {
      context.handle(
        _methodKeyMeta,
        methodKey.isAcceptableOrUnknown(data['method_key']!, _methodKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_methodKeyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('coffee_grams')) {
      context.handle(
        _coffeeGramsMeta,
        coffeeGrams.isAcceptableOrUnknown(
          data['coffee_grams']!,
          _coffeeGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coffeeGramsMeta);
    }
    if (data.containsKey('total_water_ml')) {
      context.handle(
        _totalWaterMlMeta,
        totalWaterMl.isAcceptableOrUnknown(
          data['total_water_ml']!,
          _totalWaterMlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalWaterMlMeta);
    }
    if (data.containsKey('grind_number')) {
      context.handle(
        _grindNumberMeta,
        grindNumber.isAcceptableOrUnknown(
          data['grind_number']!,
          _grindNumberMeta,
        ),
      );
    }
    if (data.containsKey('comandante_clicks')) {
      context.handle(
        _comandanteClicksMeta,
        comandanteClicks.isAcceptableOrUnknown(
          data['comandante_clicks']!,
          _comandanteClicksMeta,
        ),
      );
    }
    if (data.containsKey('ek43_division')) {
      context.handle(
        _ek43DivisionMeta,
        ek43Division.isAcceptableOrUnknown(
          data['ek43_division']!,
          _ek43DivisionMeta,
        ),
      );
    }
    if (data.containsKey('total_pours')) {
      context.handle(
        _totalPoursMeta,
        totalPours.isAcceptableOrUnknown(data['total_pours']!, _totalPoursMeta),
      );
    }
    if (data.containsKey('pour_schedule_json')) {
      context.handle(
        _pourScheduleJsonMeta,
        pourScheduleJson.isAcceptableOrUnknown(
          data['pour_schedule_json']!,
          _pourScheduleJsonMeta,
        ),
      );
    }
    if (data.containsKey('brew_temp_c')) {
      context.handle(
        _brewTempCMeta,
        brewTempC.isAcceptableOrUnknown(data['brew_temp_c']!, _brewTempCMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomRecipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomRecipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      methodKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method_key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      coffeeGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}coffee_grams'],
      )!,
      totalWaterMl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_water_ml'],
      )!,
      grindNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grind_number'],
      )!,
      comandanteClicks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}comandante_clicks'],
      )!,
      ek43Division: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ek43_division'],
      )!,
      totalPours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pours'],
      )!,
      pourScheduleJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pour_schedule_json'],
      )!,
      brewTempC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}brew_temp_c'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
    );
  }

  @override
  $CustomRecipesTable createAlias(String alias) {
    return $CustomRecipesTable(attachedDatabase, alias);
  }
}

class CustomRecipe extends DataClass implements Insertable<CustomRecipe> {
  final int id;
  final String methodKey;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double coffeeGrams;
  final double totalWaterMl;
  final int grindNumber;
  final int comandanteClicks;
  final int ek43Division;
  final int totalPours;
  final String pourScheduleJson;
  final double brewTempC;
  final String notes;
  final int rating;
  const CustomRecipe({
    required this.id,
    required this.methodKey,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.coffeeGrams,
    required this.totalWaterMl,
    required this.grindNumber,
    required this.comandanteClicks,
    required this.ek43Division,
    required this.totalPours,
    required this.pourScheduleJson,
    required this.brewTempC,
    required this.notes,
    required this.rating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['method_key'] = Variable<String>(methodKey);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['coffee_grams'] = Variable<double>(coffeeGrams);
    map['total_water_ml'] = Variable<double>(totalWaterMl);
    map['grind_number'] = Variable<int>(grindNumber);
    map['comandante_clicks'] = Variable<int>(comandanteClicks);
    map['ek43_division'] = Variable<int>(ek43Division);
    map['total_pours'] = Variable<int>(totalPours);
    map['pour_schedule_json'] = Variable<String>(pourScheduleJson);
    map['brew_temp_c'] = Variable<double>(brewTempC);
    map['notes'] = Variable<String>(notes);
    map['rating'] = Variable<int>(rating);
    return map;
  }

  CustomRecipesCompanion toCompanion(bool nullToAbsent) {
    return CustomRecipesCompanion(
      id: Value(id),
      methodKey: Value(methodKey),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      coffeeGrams: Value(coffeeGrams),
      totalWaterMl: Value(totalWaterMl),
      grindNumber: Value(grindNumber),
      comandanteClicks: Value(comandanteClicks),
      ek43Division: Value(ek43Division),
      totalPours: Value(totalPours),
      pourScheduleJson: Value(pourScheduleJson),
      brewTempC: Value(brewTempC),
      notes: Value(notes),
      rating: Value(rating),
    );
  }

  factory CustomRecipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomRecipe(
      id: serializer.fromJson<int>(json['id']),
      methodKey: serializer.fromJson<String>(json['methodKey']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      coffeeGrams: serializer.fromJson<double>(json['coffeeGrams']),
      totalWaterMl: serializer.fromJson<double>(json['totalWaterMl']),
      grindNumber: serializer.fromJson<int>(json['grindNumber']),
      comandanteClicks: serializer.fromJson<int>(json['comandanteClicks']),
      ek43Division: serializer.fromJson<int>(json['ek43Division']),
      totalPours: serializer.fromJson<int>(json['totalPours']),
      pourScheduleJson: serializer.fromJson<String>(json['pourScheduleJson']),
      brewTempC: serializer.fromJson<double>(json['brewTempC']),
      notes: serializer.fromJson<String>(json['notes']),
      rating: serializer.fromJson<int>(json['rating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'methodKey': serializer.toJson<String>(methodKey),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'coffeeGrams': serializer.toJson<double>(coffeeGrams),
      'totalWaterMl': serializer.toJson<double>(totalWaterMl),
      'grindNumber': serializer.toJson<int>(grindNumber),
      'comandanteClicks': serializer.toJson<int>(comandanteClicks),
      'ek43Division': serializer.toJson<int>(ek43Division),
      'totalPours': serializer.toJson<int>(totalPours),
      'pourScheduleJson': serializer.toJson<String>(pourScheduleJson),
      'brewTempC': serializer.toJson<double>(brewTempC),
      'notes': serializer.toJson<String>(notes),
      'rating': serializer.toJson<int>(rating),
    };
  }

  CustomRecipe copyWith({
    int? id,
    String? methodKey,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? coffeeGrams,
    double? totalWaterMl,
    int? grindNumber,
    int? comandanteClicks,
    int? ek43Division,
    int? totalPours,
    String? pourScheduleJson,
    double? brewTempC,
    String? notes,
    int? rating,
  }) => CustomRecipe(
    id: id ?? this.id,
    methodKey: methodKey ?? this.methodKey,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    coffeeGrams: coffeeGrams ?? this.coffeeGrams,
    totalWaterMl: totalWaterMl ?? this.totalWaterMl,
    grindNumber: grindNumber ?? this.grindNumber,
    comandanteClicks: comandanteClicks ?? this.comandanteClicks,
    ek43Division: ek43Division ?? this.ek43Division,
    totalPours: totalPours ?? this.totalPours,
    pourScheduleJson: pourScheduleJson ?? this.pourScheduleJson,
    brewTempC: brewTempC ?? this.brewTempC,
    notes: notes ?? this.notes,
    rating: rating ?? this.rating,
  );
  CustomRecipe copyWithCompanion(CustomRecipesCompanion data) {
    return CustomRecipe(
      id: data.id.present ? data.id.value : this.id,
      methodKey: data.methodKey.present ? data.methodKey.value : this.methodKey,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      coffeeGrams: data.coffeeGrams.present
          ? data.coffeeGrams.value
          : this.coffeeGrams,
      totalWaterMl: data.totalWaterMl.present
          ? data.totalWaterMl.value
          : this.totalWaterMl,
      grindNumber: data.grindNumber.present
          ? data.grindNumber.value
          : this.grindNumber,
      comandanteClicks: data.comandanteClicks.present
          ? data.comandanteClicks.value
          : this.comandanteClicks,
      ek43Division: data.ek43Division.present
          ? data.ek43Division.value
          : this.ek43Division,
      totalPours: data.totalPours.present
          ? data.totalPours.value
          : this.totalPours,
      pourScheduleJson: data.pourScheduleJson.present
          ? data.pourScheduleJson.value
          : this.pourScheduleJson,
      brewTempC: data.brewTempC.present ? data.brewTempC.value : this.brewTempC,
      notes: data.notes.present ? data.notes.value : this.notes,
      rating: data.rating.present ? data.rating.value : this.rating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomRecipe(')
          ..write('id: $id, ')
          ..write('methodKey: $methodKey, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('coffeeGrams: $coffeeGrams, ')
          ..write('totalWaterMl: $totalWaterMl, ')
          ..write('grindNumber: $grindNumber, ')
          ..write('comandanteClicks: $comandanteClicks, ')
          ..write('ek43Division: $ek43Division, ')
          ..write('totalPours: $totalPours, ')
          ..write('pourScheduleJson: $pourScheduleJson, ')
          ..write('brewTempC: $brewTempC, ')
          ..write('notes: $notes, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    methodKey,
    name,
    createdAt,
    updatedAt,
    coffeeGrams,
    totalWaterMl,
    grindNumber,
    comandanteClicks,
    ek43Division,
    totalPours,
    pourScheduleJson,
    brewTempC,
    notes,
    rating,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomRecipe &&
          other.id == this.id &&
          other.methodKey == this.methodKey &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.coffeeGrams == this.coffeeGrams &&
          other.totalWaterMl == this.totalWaterMl &&
          other.grindNumber == this.grindNumber &&
          other.comandanteClicks == this.comandanteClicks &&
          other.ek43Division == this.ek43Division &&
          other.totalPours == this.totalPours &&
          other.pourScheduleJson == this.pourScheduleJson &&
          other.brewTempC == this.brewTempC &&
          other.notes == this.notes &&
          other.rating == this.rating);
}

class CustomRecipesCompanion extends UpdateCompanion<CustomRecipe> {
  final Value<int> id;
  final Value<String> methodKey;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<double> coffeeGrams;
  final Value<double> totalWaterMl;
  final Value<int> grindNumber;
  final Value<int> comandanteClicks;
  final Value<int> ek43Division;
  final Value<int> totalPours;
  final Value<String> pourScheduleJson;
  final Value<double> brewTempC;
  final Value<String> notes;
  final Value<int> rating;
  const CustomRecipesCompanion({
    this.id = const Value.absent(),
    this.methodKey = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.coffeeGrams = const Value.absent(),
    this.totalWaterMl = const Value.absent(),
    this.grindNumber = const Value.absent(),
    this.comandanteClicks = const Value.absent(),
    this.ek43Division = const Value.absent(),
    this.totalPours = const Value.absent(),
    this.pourScheduleJson = const Value.absent(),
    this.brewTempC = const Value.absent(),
    this.notes = const Value.absent(),
    this.rating = const Value.absent(),
  });
  CustomRecipesCompanion.insert({
    this.id = const Value.absent(),
    required String methodKey,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    required double coffeeGrams,
    required double totalWaterMl,
    this.grindNumber = const Value.absent(),
    this.comandanteClicks = const Value.absent(),
    this.ek43Division = const Value.absent(),
    this.totalPours = const Value.absent(),
    this.pourScheduleJson = const Value.absent(),
    this.brewTempC = const Value.absent(),
    this.notes = const Value.absent(),
    this.rating = const Value.absent(),
  }) : methodKey = Value(methodKey),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       coffeeGrams = Value(coffeeGrams),
       totalWaterMl = Value(totalWaterMl);
  static Insertable<CustomRecipe> custom({
    Expression<int>? id,
    Expression<String>? methodKey,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<double>? coffeeGrams,
    Expression<double>? totalWaterMl,
    Expression<int>? grindNumber,
    Expression<int>? comandanteClicks,
    Expression<int>? ek43Division,
    Expression<int>? totalPours,
    Expression<String>? pourScheduleJson,
    Expression<double>? brewTempC,
    Expression<String>? notes,
    Expression<int>? rating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (methodKey != null) 'method_key': methodKey,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (coffeeGrams != null) 'coffee_grams': coffeeGrams,
      if (totalWaterMl != null) 'total_water_ml': totalWaterMl,
      if (grindNumber != null) 'grind_number': grindNumber,
      if (comandanteClicks != null) 'comandante_clicks': comandanteClicks,
      if (ek43Division != null) 'ek43_division': ek43Division,
      if (totalPours != null) 'total_pours': totalPours,
      if (pourScheduleJson != null) 'pour_schedule_json': pourScheduleJson,
      if (brewTempC != null) 'brew_temp_c': brewTempC,
      if (notes != null) 'notes': notes,
      if (rating != null) 'rating': rating,
    });
  }

  CustomRecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? methodKey,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<double>? coffeeGrams,
    Value<double>? totalWaterMl,
    Value<int>? grindNumber,
    Value<int>? comandanteClicks,
    Value<int>? ek43Division,
    Value<int>? totalPours,
    Value<String>? pourScheduleJson,
    Value<double>? brewTempC,
    Value<String>? notes,
    Value<int>? rating,
  }) {
    return CustomRecipesCompanion(
      id: id ?? this.id,
      methodKey: methodKey ?? this.methodKey,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      coffeeGrams: coffeeGrams ?? this.coffeeGrams,
      totalWaterMl: totalWaterMl ?? this.totalWaterMl,
      grindNumber: grindNumber ?? this.grindNumber,
      comandanteClicks: comandanteClicks ?? this.comandanteClicks,
      ek43Division: ek43Division ?? this.ek43Division,
      totalPours: totalPours ?? this.totalPours,
      pourScheduleJson: pourScheduleJson ?? this.pourScheduleJson,
      brewTempC: brewTempC ?? this.brewTempC,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (methodKey.present) {
      map['method_key'] = Variable<String>(methodKey.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (coffeeGrams.present) {
      map['coffee_grams'] = Variable<double>(coffeeGrams.value);
    }
    if (totalWaterMl.present) {
      map['total_water_ml'] = Variable<double>(totalWaterMl.value);
    }
    if (grindNumber.present) {
      map['grind_number'] = Variable<int>(grindNumber.value);
    }
    if (comandanteClicks.present) {
      map['comandante_clicks'] = Variable<int>(comandanteClicks.value);
    }
    if (ek43Division.present) {
      map['ek43_division'] = Variable<int>(ek43Division.value);
    }
    if (totalPours.present) {
      map['total_pours'] = Variable<int>(totalPours.value);
    }
    if (pourScheduleJson.present) {
      map['pour_schedule_json'] = Variable<String>(pourScheduleJson.value);
    }
    if (brewTempC.present) {
      map['brew_temp_c'] = Variable<double>(brewTempC.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomRecipesCompanion(')
          ..write('id: $id, ')
          ..write('methodKey: $methodKey, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('coffeeGrams: $coffeeGrams, ')
          ..write('totalWaterMl: $totalWaterMl, ')
          ..write('grindNumber: $grindNumber, ')
          ..write('comandanteClicks: $comandanteClicks, ')
          ..write('ek43Division: $ek43Division, ')
          ..write('totalPours: $totalPours, ')
          ..write('pourScheduleJson: $pourScheduleJson, ')
          ..write('brewTempC: $brewTempC, ')
          ..write('notes: $notes, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }
}

class $SpecialtyArticlesTable extends SpecialtyArticles
    with TableInfo<$SpecialtyArticlesTable, SpecialtyArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpecialtyArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentHtmlMeta = const VerificationMeta(
    'contentHtml',
  );
  @override
  late final GeneratedColumn<String> contentHtml = GeneratedColumn<String>(
    'content_html',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readTimeMinMeta = const VerificationMeta(
    'readTimeMin',
  );
  @override
  late final GeneratedColumn<int> readTimeMin = GeneratedColumn<int>(
    'read_time_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    subtitle,
    contentHtml,
    imageUrl,
    readTimeMin,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'specialty_articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpecialtyArticle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    } else if (isInserting) {
      context.missing(_subtitleMeta);
    }
    if (data.containsKey('content_html')) {
      context.handle(
        _contentHtmlMeta,
        contentHtml.isAcceptableOrUnknown(
          data['content_html']!,
          _contentHtmlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentHtmlMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('read_time_min')) {
      context.handle(
        _readTimeMinMeta,
        readTimeMin.isAcceptableOrUnknown(
          data['read_time_min']!,
          _readTimeMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_readTimeMinMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpecialtyArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpecialtyArticle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      )!,
      contentHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      readTimeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}read_time_min'],
      )!,
    );
  }

  @override
  $SpecialtyArticlesTable createAlias(String alias) {
    return $SpecialtyArticlesTable(attachedDatabase, alias);
  }
}

class SpecialtyArticle extends DataClass
    implements Insertable<SpecialtyArticle> {
  final int id;
  final String title;
  final String subtitle;
  final String contentHtml;
  final String imageUrl;
  final int readTimeMin;
  const SpecialtyArticle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.contentHtml,
    required this.imageUrl,
    required this.readTimeMin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['subtitle'] = Variable<String>(subtitle);
    map['content_html'] = Variable<String>(contentHtml);
    map['image_url'] = Variable<String>(imageUrl);
    map['read_time_min'] = Variable<int>(readTimeMin);
    return map;
  }

  SpecialtyArticlesCompanion toCompanion(bool nullToAbsent) {
    return SpecialtyArticlesCompanion(
      id: Value(id),
      title: Value(title),
      subtitle: Value(subtitle),
      contentHtml: Value(contentHtml),
      imageUrl: Value(imageUrl),
      readTimeMin: Value(readTimeMin),
    );
  }

  factory SpecialtyArticle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecialtyArticle(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String>(json['subtitle']),
      contentHtml: serializer.fromJson<String>(json['contentHtml']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      readTimeMin: serializer.fromJson<int>(json['readTimeMin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String>(subtitle),
      'contentHtml': serializer.toJson<String>(contentHtml),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'readTimeMin': serializer.toJson<int>(readTimeMin),
    };
  }

  SpecialtyArticle copyWith({
    int? id,
    String? title,
    String? subtitle,
    String? contentHtml,
    String? imageUrl,
    int? readTimeMin,
  }) => SpecialtyArticle(
    id: id ?? this.id,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    contentHtml: contentHtml ?? this.contentHtml,
    imageUrl: imageUrl ?? this.imageUrl,
    readTimeMin: readTimeMin ?? this.readTimeMin,
  );
  SpecialtyArticle copyWithCompanion(SpecialtyArticlesCompanion data) {
    return SpecialtyArticle(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      contentHtml: data.contentHtml.present
          ? data.contentHtml.value
          : this.contentHtml,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      readTimeMin: data.readTimeMin.present
          ? data.readTimeMin.value
          : this.readTimeMin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticle(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('readTimeMin: $readTimeMin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, subtitle, contentHtml, imageUrl, readTimeMin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecialtyArticle &&
          other.id == this.id &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.contentHtml == this.contentHtml &&
          other.imageUrl == this.imageUrl &&
          other.readTimeMin == this.readTimeMin);
}

class SpecialtyArticlesCompanion extends UpdateCompanion<SpecialtyArticle> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> subtitle;
  final Value<String> contentHtml;
  final Value<String> imageUrl;
  final Value<int> readTimeMin;
  const SpecialtyArticlesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.readTimeMin = const Value.absent(),
  });
  SpecialtyArticlesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String subtitle,
    required String contentHtml,
    required String imageUrl,
    required int readTimeMin,
  }) : title = Value(title),
       subtitle = Value(subtitle),
       contentHtml = Value(contentHtml),
       imageUrl = Value(imageUrl),
       readTimeMin = Value(readTimeMin);
  static Insertable<SpecialtyArticle> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? contentHtml,
    Expression<String>? imageUrl,
    Expression<int>? readTimeMin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (contentHtml != null) 'content_html': contentHtml,
      if (imageUrl != null) 'image_url': imageUrl,
      if (readTimeMin != null) 'read_time_min': readTimeMin,
    });
  }

  SpecialtyArticlesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? subtitle,
    Value<String>? contentHtml,
    Value<String>? imageUrl,
    Value<int>? readTimeMin,
  }) {
    return SpecialtyArticlesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      contentHtml: contentHtml ?? this.contentHtml,
      imageUrl: imageUrl ?? this.imageUrl,
      readTimeMin: readTimeMin ?? this.readTimeMin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (contentHtml.present) {
      map['content_html'] = Variable<String>(contentHtml.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (readTimeMin.present) {
      map['read_time_min'] = Variable<int>(readTimeMin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticlesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('readTimeMin: $readTimeMin')
          ..write(')'))
        .toString();
  }
}

class $RecommendedRecipesTable extends RecommendedRecipes
    with TableInfo<$RecommendedRecipesTable, RecommendedRecipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecommendedRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<int> lotId = GeneratedColumn<int>(
    'lot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES encyclopedia_entries (id)',
    ),
  );
  static const VerificationMeta _methodKeyMeta = const VerificationMeta(
    'methodKey',
  );
  @override
  late final GeneratedColumn<String> methodKey = GeneratedColumn<String>(
    'method_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeGramsMeta = const VerificationMeta(
    'coffeeGrams',
  );
  @override
  late final GeneratedColumn<double> coffeeGrams = GeneratedColumn<double>(
    'coffee_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterGramsMeta = const VerificationMeta(
    'waterGrams',
  );
  @override
  late final GeneratedColumn<double> waterGrams = GeneratedColumn<double>(
    'water_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<double> tempC = GeneratedColumn<double>(
    'temp_c',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeSecMeta = const VerificationMeta(
    'timeSec',
  );
  @override
  late final GeneratedColumn<int> timeSec = GeneratedColumn<int>(
    'time_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sensoryJsonMeta = const VerificationMeta(
    'sensoryJson',
  );
  @override
  late final GeneratedColumn<String> sensoryJson = GeneratedColumn<String>(
    'sensory_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lotId,
    methodKey,
    coffeeGrams,
    waterGrams,
    tempC,
    timeSec,
    rating,
    sensoryJson,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recommended_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecommendedRecipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lot_id')) {
      context.handle(
        _lotIdMeta,
        lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lotIdMeta);
    }
    if (data.containsKey('method_key')) {
      context.handle(
        _methodKeyMeta,
        methodKey.isAcceptableOrUnknown(data['method_key']!, _methodKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_methodKeyMeta);
    }
    if (data.containsKey('coffee_grams')) {
      context.handle(
        _coffeeGramsMeta,
        coffeeGrams.isAcceptableOrUnknown(
          data['coffee_grams']!,
          _coffeeGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coffeeGramsMeta);
    }
    if (data.containsKey('water_grams')) {
      context.handle(
        _waterGramsMeta,
        waterGrams.isAcceptableOrUnknown(data['water_grams']!, _waterGramsMeta),
      );
    } else if (isInserting) {
      context.missing(_waterGramsMeta);
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    } else if (isInserting) {
      context.missing(_tempCMeta);
    }
    if (data.containsKey('time_sec')) {
      context.handle(
        _timeSecMeta,
        timeSec.isAcceptableOrUnknown(data['time_sec']!, _timeSecMeta),
      );
    } else if (isInserting) {
      context.missing(_timeSecMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('sensory_json')) {
      context.handle(
        _sensoryJsonMeta,
        sensoryJson.isAcceptableOrUnknown(
          data['sensory_json']!,
          _sensoryJsonMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecommendedRecipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecommendedRecipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lot_id'],
      )!,
      methodKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method_key'],
      )!,
      coffeeGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}coffee_grams'],
      )!,
      waterGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_grams'],
      )!,
      tempC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temp_c'],
      )!,
      timeSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_sec'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      sensoryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensory_json'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $RecommendedRecipesTable createAlias(String alias) {
    return $RecommendedRecipesTable(attachedDatabase, alias);
  }
}

class RecommendedRecipe extends DataClass
    implements Insertable<RecommendedRecipe> {
  final int id;
  final int lotId;
  final String methodKey;
  final double coffeeGrams;
  final double waterGrams;
  final double tempC;
  final int timeSec;
  final double rating;
  final String sensoryJson;
  final String notes;
  const RecommendedRecipe({
    required this.id,
    required this.lotId,
    required this.methodKey,
    required this.coffeeGrams,
    required this.waterGrams,
    required this.tempC,
    required this.timeSec,
    required this.rating,
    required this.sensoryJson,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lot_id'] = Variable<int>(lotId);
    map['method_key'] = Variable<String>(methodKey);
    map['coffee_grams'] = Variable<double>(coffeeGrams);
    map['water_grams'] = Variable<double>(waterGrams);
    map['temp_c'] = Variable<double>(tempC);
    map['time_sec'] = Variable<int>(timeSec);
    map['rating'] = Variable<double>(rating);
    map['sensory_json'] = Variable<String>(sensoryJson);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  RecommendedRecipesCompanion toCompanion(bool nullToAbsent) {
    return RecommendedRecipesCompanion(
      id: Value(id),
      lotId: Value(lotId),
      methodKey: Value(methodKey),
      coffeeGrams: Value(coffeeGrams),
      waterGrams: Value(waterGrams),
      tempC: Value(tempC),
      timeSec: Value(timeSec),
      rating: Value(rating),
      sensoryJson: Value(sensoryJson),
      notes: Value(notes),
    );
  }

  factory RecommendedRecipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecommendedRecipe(
      id: serializer.fromJson<int>(json['id']),
      lotId: serializer.fromJson<int>(json['lotId']),
      methodKey: serializer.fromJson<String>(json['methodKey']),
      coffeeGrams: serializer.fromJson<double>(json['coffeeGrams']),
      waterGrams: serializer.fromJson<double>(json['waterGrams']),
      tempC: serializer.fromJson<double>(json['tempC']),
      timeSec: serializer.fromJson<int>(json['timeSec']),
      rating: serializer.fromJson<double>(json['rating']),
      sensoryJson: serializer.fromJson<String>(json['sensoryJson']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lotId': serializer.toJson<int>(lotId),
      'methodKey': serializer.toJson<String>(methodKey),
      'coffeeGrams': serializer.toJson<double>(coffeeGrams),
      'waterGrams': serializer.toJson<double>(waterGrams),
      'tempC': serializer.toJson<double>(tempC),
      'timeSec': serializer.toJson<int>(timeSec),
      'rating': serializer.toJson<double>(rating),
      'sensoryJson': serializer.toJson<String>(sensoryJson),
      'notes': serializer.toJson<String>(notes),
    };
  }

  RecommendedRecipe copyWith({
    int? id,
    int? lotId,
    String? methodKey,
    double? coffeeGrams,
    double? waterGrams,
    double? tempC,
    int? timeSec,
    double? rating,
    String? sensoryJson,
    String? notes,
  }) => RecommendedRecipe(
    id: id ?? this.id,
    lotId: lotId ?? this.lotId,
    methodKey: methodKey ?? this.methodKey,
    coffeeGrams: coffeeGrams ?? this.coffeeGrams,
    waterGrams: waterGrams ?? this.waterGrams,
    tempC: tempC ?? this.tempC,
    timeSec: timeSec ?? this.timeSec,
    rating: rating ?? this.rating,
    sensoryJson: sensoryJson ?? this.sensoryJson,
    notes: notes ?? this.notes,
  );
  RecommendedRecipe copyWithCompanion(RecommendedRecipesCompanion data) {
    return RecommendedRecipe(
      id: data.id.present ? data.id.value : this.id,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
      methodKey: data.methodKey.present ? data.methodKey.value : this.methodKey,
      coffeeGrams: data.coffeeGrams.present
          ? data.coffeeGrams.value
          : this.coffeeGrams,
      waterGrams: data.waterGrams.present
          ? data.waterGrams.value
          : this.waterGrams,
      tempC: data.tempC.present ? data.tempC.value : this.tempC,
      timeSec: data.timeSec.present ? data.timeSec.value : this.timeSec,
      rating: data.rating.present ? data.rating.value : this.rating,
      sensoryJson: data.sensoryJson.present
          ? data.sensoryJson.value
          : this.sensoryJson,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecommendedRecipe(')
          ..write('id: $id, ')
          ..write('lotId: $lotId, ')
          ..write('methodKey: $methodKey, ')
          ..write('coffeeGrams: $coffeeGrams, ')
          ..write('waterGrams: $waterGrams, ')
          ..write('tempC: $tempC, ')
          ..write('timeSec: $timeSec, ')
          ..write('rating: $rating, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lotId,
    methodKey,
    coffeeGrams,
    waterGrams,
    tempC,
    timeSec,
    rating,
    sensoryJson,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecommendedRecipe &&
          other.id == this.id &&
          other.lotId == this.lotId &&
          other.methodKey == this.methodKey &&
          other.coffeeGrams == this.coffeeGrams &&
          other.waterGrams == this.waterGrams &&
          other.tempC == this.tempC &&
          other.timeSec == this.timeSec &&
          other.rating == this.rating &&
          other.sensoryJson == this.sensoryJson &&
          other.notes == this.notes);
}

class RecommendedRecipesCompanion extends UpdateCompanion<RecommendedRecipe> {
  final Value<int> id;
  final Value<int> lotId;
  final Value<String> methodKey;
  final Value<double> coffeeGrams;
  final Value<double> waterGrams;
  final Value<double> tempC;
  final Value<int> timeSec;
  final Value<double> rating;
  final Value<String> sensoryJson;
  final Value<String> notes;
  const RecommendedRecipesCompanion({
    this.id = const Value.absent(),
    this.lotId = const Value.absent(),
    this.methodKey = const Value.absent(),
    this.coffeeGrams = const Value.absent(),
    this.waterGrams = const Value.absent(),
    this.tempC = const Value.absent(),
    this.timeSec = const Value.absent(),
    this.rating = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.notes = const Value.absent(),
  });
  RecommendedRecipesCompanion.insert({
    this.id = const Value.absent(),
    required int lotId,
    required String methodKey,
    required double coffeeGrams,
    required double waterGrams,
    required double tempC,
    required int timeSec,
    required double rating,
    this.sensoryJson = const Value.absent(),
    this.notes = const Value.absent(),
  }) : lotId = Value(lotId),
       methodKey = Value(methodKey),
       coffeeGrams = Value(coffeeGrams),
       waterGrams = Value(waterGrams),
       tempC = Value(tempC),
       timeSec = Value(timeSec),
       rating = Value(rating);
  static Insertable<RecommendedRecipe> custom({
    Expression<int>? id,
    Expression<int>? lotId,
    Expression<String>? methodKey,
    Expression<double>? coffeeGrams,
    Expression<double>? waterGrams,
    Expression<double>? tempC,
    Expression<int>? timeSec,
    Expression<double>? rating,
    Expression<String>? sensoryJson,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lotId != null) 'lot_id': lotId,
      if (methodKey != null) 'method_key': methodKey,
      if (coffeeGrams != null) 'coffee_grams': coffeeGrams,
      if (waterGrams != null) 'water_grams': waterGrams,
      if (tempC != null) 'temp_c': tempC,
      if (timeSec != null) 'time_sec': timeSec,
      if (rating != null) 'rating': rating,
      if (sensoryJson != null) 'sensory_json': sensoryJson,
      if (notes != null) 'notes': notes,
    });
  }

  RecommendedRecipesCompanion copyWith({
    Value<int>? id,
    Value<int>? lotId,
    Value<String>? methodKey,
    Value<double>? coffeeGrams,
    Value<double>? waterGrams,
    Value<double>? tempC,
    Value<int>? timeSec,
    Value<double>? rating,
    Value<String>? sensoryJson,
    Value<String>? notes,
  }) {
    return RecommendedRecipesCompanion(
      id: id ?? this.id,
      lotId: lotId ?? this.lotId,
      methodKey: methodKey ?? this.methodKey,
      coffeeGrams: coffeeGrams ?? this.coffeeGrams,
      waterGrams: waterGrams ?? this.waterGrams,
      tempC: tempC ?? this.tempC,
      timeSec: timeSec ?? this.timeSec,
      rating: rating ?? this.rating,
      sensoryJson: sensoryJson ?? this.sensoryJson,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lotId.present) {
      map['lot_id'] = Variable<int>(lotId.value);
    }
    if (methodKey.present) {
      map['method_key'] = Variable<String>(methodKey.value);
    }
    if (coffeeGrams.present) {
      map['coffee_grams'] = Variable<double>(coffeeGrams.value);
    }
    if (waterGrams.present) {
      map['water_grams'] = Variable<double>(waterGrams.value);
    }
    if (tempC.present) {
      map['temp_c'] = Variable<double>(tempC.value);
    }
    if (timeSec.present) {
      map['time_sec'] = Variable<int>(timeSec.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (sensoryJson.present) {
      map['sensory_json'] = Variable<String>(sensoryJson.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecommendedRecipesCompanion(')
          ..write('id: $id, ')
          ..write('lotId: $lotId, ')
          ..write('methodKey: $methodKey, ')
          ..write('coffeeGrams: $coffeeGrams, ')
          ..write('waterGrams: $waterGrams, ')
          ..write('tempC: $tempC, ')
          ..write('timeSec: $timeSec, ')
          ..write('rating: $rating, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CoffeeLotsTable coffeeLots = $CoffeeLotsTable(this);
  late final $FermentationLogsTable fermentationLogs = $FermentationLogsTable(
    this,
  );
  late final $BrewingRecipesTable brewingRecipes = $BrewingRecipesTable(this);
  late final $BrandsTable brands = $BrandsTable(this);
  late final $EncyclopediaEntriesTable encyclopediaEntries =
      $EncyclopediaEntriesTable(this);
  late final $LatteArtPatternsTable latteArtPatterns = $LatteArtPatternsTable(
    this,
  );
  late final $BeanScansTable beanScans = $BeanScansTable(this);
  late final $CustomRecipesTable customRecipes = $CustomRecipesTable(this);
  late final $SpecialtyArticlesTable specialtyArticles =
      $SpecialtyArticlesTable(this);
  late final $RecommendedRecipesTable recommendedRecipes =
      $RecommendedRecipesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    coffeeLots,
    fermentationLogs,
    brewingRecipes,
    brands,
    encyclopediaEntries,
    latteArtPatterns,
    beanScans,
    customRecipes,
    specialtyArticles,
    recommendedRecipes,
  ];
}

typedef $$CoffeeLotsTableCreateCompanionBuilder =
    CoffeeLotsCompanion Function({
      required String id,
      required String userId,
      required String region,
      required int altitudeM,
      required String processMethod,
      required double qGradeScore,
      Value<int> rowid,
    });
typedef $$CoffeeLotsTableUpdateCompanionBuilder =
    CoffeeLotsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> region,
      Value<int> altitudeM,
      Value<String> processMethod,
      Value<double> qGradeScore,
      Value<int> rowid,
    });

class $$CoffeeLotsTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeeLotsTable> {
  $$CoffeeLotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processMethod => $composableBuilder(
    column: $table.processMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get qGradeScore => $composableBuilder(
    column: $table.qGradeScore,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoffeeLotsTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeeLotsTable> {
  $$CoffeeLotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processMethod => $composableBuilder(
    column: $table.processMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get qGradeScore => $composableBuilder(
    column: $table.qGradeScore,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoffeeLotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeeLotsTable> {
  $$CoffeeLotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<int> get altitudeM =>
      $composableBuilder(column: $table.altitudeM, builder: (column) => column);

  GeneratedColumn<String> get processMethod => $composableBuilder(
    column: $table.processMethod,
    builder: (column) => column,
  );

  GeneratedColumn<double> get qGradeScore => $composableBuilder(
    column: $table.qGradeScore,
    builder: (column) => column,
  );
}

class $$CoffeeLotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeeLotsTable,
          CoffeeLot,
          $$CoffeeLotsTableFilterComposer,
          $$CoffeeLotsTableOrderingComposer,
          $$CoffeeLotsTableAnnotationComposer,
          $$CoffeeLotsTableCreateCompanionBuilder,
          $$CoffeeLotsTableUpdateCompanionBuilder,
          (
            CoffeeLot,
            BaseReferences<_$AppDatabase, $CoffeeLotsTable, CoffeeLot>,
          ),
          CoffeeLot,
          PrefetchHooks Function()
        > {
  $$CoffeeLotsTableTableManager(_$AppDatabase db, $CoffeeLotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeeLotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeeLotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeeLotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<int> altitudeM = const Value.absent(),
                Value<String> processMethod = const Value.absent(),
                Value<double> qGradeScore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeLotsCompanion(
                id: id,
                userId: userId,
                region: region,
                altitudeM: altitudeM,
                processMethod: processMethod,
                qGradeScore: qGradeScore,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String region,
                required int altitudeM,
                required String processMethod,
                required double qGradeScore,
                Value<int> rowid = const Value.absent(),
              }) => CoffeeLotsCompanion.insert(
                id: id,
                userId: userId,
                region: region,
                altitudeM: altitudeM,
                processMethod: processMethod,
                qGradeScore: qGradeScore,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoffeeLotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeeLotsTable,
      CoffeeLot,
      $$CoffeeLotsTableFilterComposer,
      $$CoffeeLotsTableOrderingComposer,
      $$CoffeeLotsTableAnnotationComposer,
      $$CoffeeLotsTableCreateCompanionBuilder,
      $$CoffeeLotsTableUpdateCompanionBuilder,
      (CoffeeLot, BaseReferences<_$AppDatabase, $CoffeeLotsTable, CoffeeLot>),
      CoffeeLot,
      PrefetchHooks Function()
    >;
typedef $$FermentationLogsTableCreateCompanionBuilder =
    FermentationLogsCompanion Function({
      required String id,
      required String lotId,
      required DateTime timestamp,
      required double brix,
      required double ph,
      required double tempC,
      Value<int> rowid,
    });
typedef $$FermentationLogsTableUpdateCompanionBuilder =
    FermentationLogsCompanion Function({
      Value<String> id,
      Value<String> lotId,
      Value<DateTime> timestamp,
      Value<double> brix,
      Value<double> ph,
      Value<double> tempC,
      Value<int> rowid,
    });

class $$FermentationLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FermentationLogsTable> {
  $$FermentationLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotId => $composableBuilder(
    column: $table.lotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get brix => $composableBuilder(
    column: $table.brix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ph => $composableBuilder(
    column: $table.ph,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FermentationLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FermentationLogsTable> {
  $$FermentationLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotId => $composableBuilder(
    column: $table.lotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get brix => $composableBuilder(
    column: $table.brix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ph => $composableBuilder(
    column: $table.ph,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FermentationLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FermentationLogsTable> {
  $$FermentationLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lotId =>
      $composableBuilder(column: $table.lotId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get brix =>
      $composableBuilder(column: $table.brix, builder: (column) => column);

  GeneratedColumn<double> get ph =>
      $composableBuilder(column: $table.ph, builder: (column) => column);

  GeneratedColumn<double> get tempC =>
      $composableBuilder(column: $table.tempC, builder: (column) => column);
}

class $$FermentationLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FermentationLogsTable,
          FermentationLog,
          $$FermentationLogsTableFilterComposer,
          $$FermentationLogsTableOrderingComposer,
          $$FermentationLogsTableAnnotationComposer,
          $$FermentationLogsTableCreateCompanionBuilder,
          $$FermentationLogsTableUpdateCompanionBuilder,
          (
            FermentationLog,
            BaseReferences<
              _$AppDatabase,
              $FermentationLogsTable,
              FermentationLog
            >,
          ),
          FermentationLog,
          PrefetchHooks Function()
        > {
  $$FermentationLogsTableTableManager(
    _$AppDatabase db,
    $FermentationLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FermentationLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FermentationLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FermentationLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> lotId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double> brix = const Value.absent(),
                Value<double> ph = const Value.absent(),
                Value<double> tempC = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FermentationLogsCompanion(
                id: id,
                lotId: lotId,
                timestamp: timestamp,
                brix: brix,
                ph: ph,
                tempC: tempC,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String lotId,
                required DateTime timestamp,
                required double brix,
                required double ph,
                required double tempC,
                Value<int> rowid = const Value.absent(),
              }) => FermentationLogsCompanion.insert(
                id: id,
                lotId: lotId,
                timestamp: timestamp,
                brix: brix,
                ph: ph,
                tempC: tempC,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FermentationLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FermentationLogsTable,
      FermentationLog,
      $$FermentationLogsTableFilterComposer,
      $$FermentationLogsTableOrderingComposer,
      $$FermentationLogsTableAnnotationComposer,
      $$FermentationLogsTableCreateCompanionBuilder,
      $$FermentationLogsTableUpdateCompanionBuilder,
      (
        FermentationLog,
        BaseReferences<_$AppDatabase, $FermentationLogsTable, FermentationLog>,
      ),
      FermentationLog,
      PrefetchHooks Function()
    >;
typedef $$BrewingRecipesTableCreateCompanionBuilder =
    BrewingRecipesCompanion Function({
      Value<int> id,
      required String methodKey,
      required String name,
      required String description,
      required double ratioGramsPerMl,
      required double tempC,
      required int totalTimeSec,
      required String difficulty,
      required String stepsJson,
      required String flavorProfile,
      required String iconName,
    });
typedef $$BrewingRecipesTableUpdateCompanionBuilder =
    BrewingRecipesCompanion Function({
      Value<int> id,
      Value<String> methodKey,
      Value<String> name,
      Value<String> description,
      Value<double> ratioGramsPerMl,
      Value<double> tempC,
      Value<int> totalTimeSec,
      Value<String> difficulty,
      Value<String> stepsJson,
      Value<String> flavorProfile,
      Value<String> iconName,
    });

class $$BrewingRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $BrewingRecipesTable> {
  $$BrewingRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get methodKey => $composableBuilder(
    column: $table.methodKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ratioGramsPerMl => $composableBuilder(
    column: $table.ratioGramsPerMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTimeSec => $composableBuilder(
    column: $table.totalTimeSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepsJson => $composableBuilder(
    column: $table.stepsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BrewingRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $BrewingRecipesTable> {
  $$BrewingRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get methodKey => $composableBuilder(
    column: $table.methodKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ratioGramsPerMl => $composableBuilder(
    column: $table.ratioGramsPerMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTimeSec => $composableBuilder(
    column: $table.totalTimeSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepsJson => $composableBuilder(
    column: $table.stepsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BrewingRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrewingRecipesTable> {
  $$BrewingRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get methodKey =>
      $composableBuilder(column: $table.methodKey, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ratioGramsPerMl => $composableBuilder(
    column: $table.ratioGramsPerMl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tempC =>
      $composableBuilder(column: $table.tempC, builder: (column) => column);

  GeneratedColumn<int> get totalTimeSec => $composableBuilder(
    column: $table.totalTimeSec,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stepsJson =>
      $composableBuilder(column: $table.stepsJson, builder: (column) => column);

  GeneratedColumn<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);
}

class $$BrewingRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrewingRecipesTable,
          BrewingRecipe,
          $$BrewingRecipesTableFilterComposer,
          $$BrewingRecipesTableOrderingComposer,
          $$BrewingRecipesTableAnnotationComposer,
          $$BrewingRecipesTableCreateCompanionBuilder,
          $$BrewingRecipesTableUpdateCompanionBuilder,
          (
            BrewingRecipe,
            BaseReferences<_$AppDatabase, $BrewingRecipesTable, BrewingRecipe>,
          ),
          BrewingRecipe,
          PrefetchHooks Function()
        > {
  $$BrewingRecipesTableTableManager(
    _$AppDatabase db,
    $BrewingRecipesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrewingRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrewingRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrewingRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> methodKey = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> ratioGramsPerMl = const Value.absent(),
                Value<double> tempC = const Value.absent(),
                Value<int> totalTimeSec = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> stepsJson = const Value.absent(),
                Value<String> flavorProfile = const Value.absent(),
                Value<String> iconName = const Value.absent(),
              }) => BrewingRecipesCompanion(
                id: id,
                methodKey: methodKey,
                name: name,
                description: description,
                ratioGramsPerMl: ratioGramsPerMl,
                tempC: tempC,
                totalTimeSec: totalTimeSec,
                difficulty: difficulty,
                stepsJson: stepsJson,
                flavorProfile: flavorProfile,
                iconName: iconName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String methodKey,
                required String name,
                required String description,
                required double ratioGramsPerMl,
                required double tempC,
                required int totalTimeSec,
                required String difficulty,
                required String stepsJson,
                required String flavorProfile,
                required String iconName,
              }) => BrewingRecipesCompanion.insert(
                id: id,
                methodKey: methodKey,
                name: name,
                description: description,
                ratioGramsPerMl: ratioGramsPerMl,
                tempC: tempC,
                totalTimeSec: totalTimeSec,
                difficulty: difficulty,
                stepsJson: stepsJson,
                flavorProfile: flavorProfile,
                iconName: iconName,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BrewingRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrewingRecipesTable,
      BrewingRecipe,
      $$BrewingRecipesTableFilterComposer,
      $$BrewingRecipesTableOrderingComposer,
      $$BrewingRecipesTableAnnotationComposer,
      $$BrewingRecipesTableCreateCompanionBuilder,
      $$BrewingRecipesTableUpdateCompanionBuilder,
      (
        BrewingRecipe,
        BaseReferences<_$AppDatabase, $BrewingRecipesTable, BrewingRecipe>,
      ),
      BrewingRecipe,
      PrefetchHooks Function()
    >;
typedef $$BrandsTableCreateCompanionBuilder =
    BrandsCompanion Function({
      Value<int> id,
      required String name,
      required String shortDesc,
      required String fullDesc,
      Value<String> logoUrl,
      Value<String> siteUrl,
      Value<String> location,
    });
typedef $$BrandsTableUpdateCompanionBuilder =
    BrandsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> shortDesc,
      Value<String> fullDesc,
      Value<String> logoUrl,
      Value<String> siteUrl,
      Value<String> location,
    });

final class $$BrandsTableReferences
    extends BaseReferences<_$AppDatabase, $BrandsTable, Brand> {
  $$BrandsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EncyclopediaEntriesTable, List<EncyclopediaEntry>>
  _encyclopediaEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.encyclopediaEntries,
        aliasName: $_aliasNameGenerator(
          db.brands.id,
          db.encyclopediaEntries.brandId,
        ),
      );

  $$EncyclopediaEntriesTableProcessedTableManager get encyclopediaEntriesRefs {
    final manager = $$EncyclopediaEntriesTableTableManager(
      $_db,
      $_db.encyclopediaEntries,
    ).filter((f) => f.brandId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _encyclopediaEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BrandsTableFilterComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortDesc => $composableBuilder(
    column: $table.shortDesc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullDesc => $composableBuilder(
    column: $table.fullDesc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get siteUrl => $composableBuilder(
    column: $table.siteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> encyclopediaEntriesRefs(
    Expression<bool> Function($$EncyclopediaEntriesTableFilterComposer f) f,
  ) {
    final $$EncyclopediaEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.encyclopediaEntries,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EncyclopediaEntriesTableFilterComposer(
            $db: $db,
            $table: $db.encyclopediaEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BrandsTableOrderingComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortDesc => $composableBuilder(
    column: $table.shortDesc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullDesc => $composableBuilder(
    column: $table.fullDesc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get siteUrl => $composableBuilder(
    column: $table.siteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BrandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get shortDesc =>
      $composableBuilder(column: $table.shortDesc, builder: (column) => column);

  GeneratedColumn<String> get fullDesc =>
      $composableBuilder(column: $table.fullDesc, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get siteUrl =>
      $composableBuilder(column: $table.siteUrl, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  Expression<T> encyclopediaEntriesRefs<T extends Object>(
    Expression<T> Function($$EncyclopediaEntriesTableAnnotationComposer a) f,
  ) {
    final $$EncyclopediaEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.encyclopediaEntries,
          getReferencedColumn: (t) => t.brandId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EncyclopediaEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.encyclopediaEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BrandsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrandsTable,
          Brand,
          $$BrandsTableFilterComposer,
          $$BrandsTableOrderingComposer,
          $$BrandsTableAnnotationComposer,
          $$BrandsTableCreateCompanionBuilder,
          $$BrandsTableUpdateCompanionBuilder,
          (Brand, $$BrandsTableReferences),
          Brand,
          PrefetchHooks Function({bool encyclopediaEntriesRefs})
        > {
  $$BrandsTableTableManager(_$AppDatabase db, $BrandsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> shortDesc = const Value.absent(),
                Value<String> fullDesc = const Value.absent(),
                Value<String> logoUrl = const Value.absent(),
                Value<String> siteUrl = const Value.absent(),
                Value<String> location = const Value.absent(),
              }) => BrandsCompanion(
                id: id,
                name: name,
                shortDesc: shortDesc,
                fullDesc: fullDesc,
                logoUrl: logoUrl,
                siteUrl: siteUrl,
                location: location,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String shortDesc,
                required String fullDesc,
                Value<String> logoUrl = const Value.absent(),
                Value<String> siteUrl = const Value.absent(),
                Value<String> location = const Value.absent(),
              }) => BrandsCompanion.insert(
                id: id,
                name: name,
                shortDesc: shortDesc,
                fullDesc: fullDesc,
                logoUrl: logoUrl,
                siteUrl: siteUrl,
                location: location,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BrandsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({encyclopediaEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (encyclopediaEntriesRefs) db.encyclopediaEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (encyclopediaEntriesRefs)
                    await $_getPrefetchedData<
                      Brand,
                      $BrandsTable,
                      EncyclopediaEntry
                    >(
                      currentTable: table,
                      referencedTable: $$BrandsTableReferences
                          ._encyclopediaEntriesRefsTable(db),
                      managerFromTypedResult: (p0) => $$BrandsTableReferences(
                        db,
                        table,
                        p0,
                      ).encyclopediaEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.brandId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BrandsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrandsTable,
      Brand,
      $$BrandsTableFilterComposer,
      $$BrandsTableOrderingComposer,
      $$BrandsTableAnnotationComposer,
      $$BrandsTableCreateCompanionBuilder,
      $$BrandsTableUpdateCompanionBuilder,
      (Brand, $$BrandsTableReferences),
      Brand,
      PrefetchHooks Function({bool encyclopediaEntriesRefs})
    >;
typedef $$EncyclopediaEntriesTableCreateCompanionBuilder =
    EncyclopediaEntriesCompanion Function({
      Value<int> id,
      required String countryEmoji,
      required String country,
      required String region,
      required int altitudeMin,
      required int altitudeMax,
      required String varieties,
      required String flavorNotes,
      required String processMethod,
      required String harvestSeason,
      required String description,
      required double cupsScore,
      Value<String> farmDescription,
      Value<String> farmPhotosUrlCover,
      Value<String> plantationPhotosUrl,
      Value<String> processingMethodsJson,
      Value<int?> brandId,
      Value<String> sensoryJson,
      Value<String> roastLevel,
      Value<String> weight,
      Value<String> price,
      Value<String> roastDate,
      Value<String> lotNumber,
      Value<String> url,
      Value<bool> isPremium,
      Value<String> detailedProcessMarkdown,
    });
typedef $$EncyclopediaEntriesTableUpdateCompanionBuilder =
    EncyclopediaEntriesCompanion Function({
      Value<int> id,
      Value<String> countryEmoji,
      Value<String> country,
      Value<String> region,
      Value<int> altitudeMin,
      Value<int> altitudeMax,
      Value<String> varieties,
      Value<String> flavorNotes,
      Value<String> processMethod,
      Value<String> harvestSeason,
      Value<String> description,
      Value<double> cupsScore,
      Value<String> farmDescription,
      Value<String> farmPhotosUrlCover,
      Value<String> plantationPhotosUrl,
      Value<String> processingMethodsJson,
      Value<int?> brandId,
      Value<String> sensoryJson,
      Value<String> roastLevel,
      Value<String> weight,
      Value<String> price,
      Value<String> roastDate,
      Value<String> lotNumber,
      Value<String> url,
      Value<bool> isPremium,
      Value<String> detailedProcessMarkdown,
    });

final class $$EncyclopediaEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EncyclopediaEntriesTable,
          EncyclopediaEntry
        > {
  $$EncyclopediaEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BrandsTable _brandIdTable(_$AppDatabase db) => db.brands.createAlias(
    $_aliasNameGenerator(db.encyclopediaEntries.brandId, db.brands.id),
  );

  $$BrandsTableProcessedTableManager? get brandId {
    final $_column = $_itemColumn<int>('brand_id');
    if ($_column == null) return null;
    final manager = $$BrandsTableTableManager(
      $_db,
      $_db.brands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RecommendedRecipesTable, List<RecommendedRecipe>>
  _recommendedRecipesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recommendedRecipes,
        aliasName: $_aliasNameGenerator(
          db.encyclopediaEntries.id,
          db.recommendedRecipes.lotId,
        ),
      );

  $$RecommendedRecipesTableProcessedTableManager get recommendedRecipesRefs {
    final manager = $$RecommendedRecipesTableTableManager(
      $_db,
      $_db.recommendedRecipes,
    ).filter((f) => f.lotId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recommendedRecipesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EncyclopediaEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $EncyclopediaEntriesTable> {
  $$EncyclopediaEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryEmoji => $composableBuilder(
    column: $table.countryEmoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get varieties => $composableBuilder(
    column: $table.varieties,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavorNotes => $composableBuilder(
    column: $table.flavorNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processMethod => $composableBuilder(
    column: $table.processMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cupsScore => $composableBuilder(
    column: $table.cupsScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detailedProcessMarkdown => $composableBuilder(
    column: $table.detailedProcessMarkdown,
    builder: (column) => ColumnFilters(column),
  );

  $$BrandsTableFilterComposer get brandId {
    final $$BrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableFilterComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> recommendedRecipesRefs(
    Expression<bool> Function($$RecommendedRecipesTableFilterComposer f) f,
  ) {
    final $$RecommendedRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recommendedRecipes,
      getReferencedColumn: (t) => t.lotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecommendedRecipesTableFilterComposer(
            $db: $db,
            $table: $db.recommendedRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EncyclopediaEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EncyclopediaEntriesTable> {
  $$EncyclopediaEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryEmoji => $composableBuilder(
    column: $table.countryEmoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get varieties => $composableBuilder(
    column: $table.varieties,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavorNotes => $composableBuilder(
    column: $table.flavorNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processMethod => $composableBuilder(
    column: $table.processMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cupsScore => $composableBuilder(
    column: $table.cupsScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPremium => $composableBuilder(
    column: $table.isPremium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detailedProcessMarkdown => $composableBuilder(
    column: $table.detailedProcessMarkdown,
    builder: (column) => ColumnOrderings(column),
  );

  $$BrandsTableOrderingComposer get brandId {
    final $$BrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableOrderingComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EncyclopediaEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EncyclopediaEntriesTable> {
  $$EncyclopediaEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get countryEmoji => $composableBuilder(
    column: $table.countryEmoji,
    builder: (column) => column,
  );

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => column,
  );

  GeneratedColumn<String> get varieties =>
      $composableBuilder(column: $table.varieties, builder: (column) => column);

  GeneratedColumn<String> get flavorNotes => $composableBuilder(
    column: $table.flavorNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processMethod => $composableBuilder(
    column: $table.processMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cupsScore =>
      $composableBuilder(column: $table.cupsScore, builder: (column) => column);

  GeneratedColumn<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get roastDate =>
      $composableBuilder(column: $table.roastDate, builder: (column) => column);

  GeneratedColumn<String> get lotNumber =>
      $composableBuilder(column: $table.lotNumber, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);

  GeneratedColumn<String> get detailedProcessMarkdown => $composableBuilder(
    column: $table.detailedProcessMarkdown,
    builder: (column) => column,
  );

  $$BrandsTableAnnotationComposer get brandId {
    final $$BrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> recommendedRecipesRefs<T extends Object>(
    Expression<T> Function($$RecommendedRecipesTableAnnotationComposer a) f,
  ) {
    final $$RecommendedRecipesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recommendedRecipes,
          getReferencedColumn: (t) => t.lotId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecommendedRecipesTableAnnotationComposer(
                $db: $db,
                $table: $db.recommendedRecipes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EncyclopediaEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EncyclopediaEntriesTable,
          EncyclopediaEntry,
          $$EncyclopediaEntriesTableFilterComposer,
          $$EncyclopediaEntriesTableOrderingComposer,
          $$EncyclopediaEntriesTableAnnotationComposer,
          $$EncyclopediaEntriesTableCreateCompanionBuilder,
          $$EncyclopediaEntriesTableUpdateCompanionBuilder,
          (EncyclopediaEntry, $$EncyclopediaEntriesTableReferences),
          EncyclopediaEntry,
          PrefetchHooks Function({bool brandId, bool recommendedRecipesRefs})
        > {
  $$EncyclopediaEntriesTableTableManager(
    _$AppDatabase db,
    $EncyclopediaEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EncyclopediaEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EncyclopediaEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EncyclopediaEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> countryEmoji = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<int> altitudeMin = const Value.absent(),
                Value<int> altitudeMax = const Value.absent(),
                Value<String> varieties = const Value.absent(),
                Value<String> flavorNotes = const Value.absent(),
                Value<String> processMethod = const Value.absent(),
                Value<String> harvestSeason = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> cupsScore = const Value.absent(),
                Value<String> farmDescription = const Value.absent(),
                Value<String> farmPhotosUrlCover = const Value.absent(),
                Value<String> plantationPhotosUrl = const Value.absent(),
                Value<String> processingMethodsJson = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> roastLevel = const Value.absent(),
                Value<String> weight = const Value.absent(),
                Value<String> price = const Value.absent(),
                Value<String> roastDate = const Value.absent(),
                Value<String> lotNumber = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<String> detailedProcessMarkdown = const Value.absent(),
              }) => EncyclopediaEntriesCompanion(
                id: id,
                countryEmoji: countryEmoji,
                country: country,
                region: region,
                altitudeMin: altitudeMin,
                altitudeMax: altitudeMax,
                varieties: varieties,
                flavorNotes: flavorNotes,
                processMethod: processMethod,
                harvestSeason: harvestSeason,
                description: description,
                cupsScore: cupsScore,
                farmDescription: farmDescription,
                farmPhotosUrlCover: farmPhotosUrlCover,
                plantationPhotosUrl: plantationPhotosUrl,
                processingMethodsJson: processingMethodsJson,
                brandId: brandId,
                sensoryJson: sensoryJson,
                roastLevel: roastLevel,
                weight: weight,
                price: price,
                roastDate: roastDate,
                lotNumber: lotNumber,
                url: url,
                isPremium: isPremium,
                detailedProcessMarkdown: detailedProcessMarkdown,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String countryEmoji,
                required String country,
                required String region,
                required int altitudeMin,
                required int altitudeMax,
                required String varieties,
                required String flavorNotes,
                required String processMethod,
                required String harvestSeason,
                required String description,
                required double cupsScore,
                Value<String> farmDescription = const Value.absent(),
                Value<String> farmPhotosUrlCover = const Value.absent(),
                Value<String> plantationPhotosUrl = const Value.absent(),
                Value<String> processingMethodsJson = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> roastLevel = const Value.absent(),
                Value<String> weight = const Value.absent(),
                Value<String> price = const Value.absent(),
                Value<String> roastDate = const Value.absent(),
                Value<String> lotNumber = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<String> detailedProcessMarkdown = const Value.absent(),
              }) => EncyclopediaEntriesCompanion.insert(
                id: id,
                countryEmoji: countryEmoji,
                country: country,
                region: region,
                altitudeMin: altitudeMin,
                altitudeMax: altitudeMax,
                varieties: varieties,
                flavorNotes: flavorNotes,
                processMethod: processMethod,
                harvestSeason: harvestSeason,
                description: description,
                cupsScore: cupsScore,
                farmDescription: farmDescription,
                farmPhotosUrlCover: farmPhotosUrlCover,
                plantationPhotosUrl: plantationPhotosUrl,
                processingMethodsJson: processingMethodsJson,
                brandId: brandId,
                sensoryJson: sensoryJson,
                roastLevel: roastLevel,
                weight: weight,
                price: price,
                roastDate: roastDate,
                lotNumber: lotNumber,
                url: url,
                isPremium: isPremium,
                detailedProcessMarkdown: detailedProcessMarkdown,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EncyclopediaEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({brandId = false, recommendedRecipesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recommendedRecipesRefs) db.recommendedRecipes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (brandId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.brandId,
                                    referencedTable:
                                        $$EncyclopediaEntriesTableReferences
                                            ._brandIdTable(db),
                                    referencedColumn:
                                        $$EncyclopediaEntriesTableReferences
                                            ._brandIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recommendedRecipesRefs)
                        await $_getPrefetchedData<
                          EncyclopediaEntry,
                          $EncyclopediaEntriesTable,
                          RecommendedRecipe
                        >(
                          currentTable: table,
                          referencedTable: $$EncyclopediaEntriesTableReferences
                              ._recommendedRecipesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EncyclopediaEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).recommendedRecipesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lotId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EncyclopediaEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EncyclopediaEntriesTable,
      EncyclopediaEntry,
      $$EncyclopediaEntriesTableFilterComposer,
      $$EncyclopediaEntriesTableOrderingComposer,
      $$EncyclopediaEntriesTableAnnotationComposer,
      $$EncyclopediaEntriesTableCreateCompanionBuilder,
      $$EncyclopediaEntriesTableUpdateCompanionBuilder,
      (EncyclopediaEntry, $$EncyclopediaEntriesTableReferences),
      EncyclopediaEntry,
      PrefetchHooks Function({bool brandId, bool recommendedRecipesRefs})
    >;
typedef $$LatteArtPatternsTableCreateCompanionBuilder =
    LatteArtPatternsCompanion Function({
      Value<int> id,
      required String name,
      required int difficulty,
      required String stepsJson,
      Value<bool> isFavorite,
      Value<int> userBestScore,
      required String description,
      required String tipText,
    });
typedef $$LatteArtPatternsTableUpdateCompanionBuilder =
    LatteArtPatternsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> difficulty,
      Value<String> stepsJson,
      Value<bool> isFavorite,
      Value<int> userBestScore,
      Value<String> description,
      Value<String> tipText,
    });

class $$LatteArtPatternsTableFilterComposer
    extends Composer<_$AppDatabase, $LatteArtPatternsTable> {
  $$LatteArtPatternsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepsJson => $composableBuilder(
    column: $table.stepsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userBestScore => $composableBuilder(
    column: $table.userBestScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipText => $composableBuilder(
    column: $table.tipText,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LatteArtPatternsTableOrderingComposer
    extends Composer<_$AppDatabase, $LatteArtPatternsTable> {
  $$LatteArtPatternsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepsJson => $composableBuilder(
    column: $table.stepsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userBestScore => $composableBuilder(
    column: $table.userBestScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipText => $composableBuilder(
    column: $table.tipText,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LatteArtPatternsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LatteArtPatternsTable> {
  $$LatteArtPatternsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stepsJson =>
      $composableBuilder(column: $table.stepsJson, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get userBestScore => $composableBuilder(
    column: $table.userBestScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipText =>
      $composableBuilder(column: $table.tipText, builder: (column) => column);
}

class $$LatteArtPatternsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LatteArtPatternsTable,
          LatteArtPattern,
          $$LatteArtPatternsTableFilterComposer,
          $$LatteArtPatternsTableOrderingComposer,
          $$LatteArtPatternsTableAnnotationComposer,
          $$LatteArtPatternsTableCreateCompanionBuilder,
          $$LatteArtPatternsTableUpdateCompanionBuilder,
          (
            LatteArtPattern,
            BaseReferences<
              _$AppDatabase,
              $LatteArtPatternsTable,
              LatteArtPattern
            >,
          ),
          LatteArtPattern,
          PrefetchHooks Function()
        > {
  $$LatteArtPatternsTableTableManager(
    _$AppDatabase db,
    $LatteArtPatternsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LatteArtPatternsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LatteArtPatternsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LatteArtPatternsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<String> stepsJson = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> userBestScore = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> tipText = const Value.absent(),
              }) => LatteArtPatternsCompanion(
                id: id,
                name: name,
                difficulty: difficulty,
                stepsJson: stepsJson,
                isFavorite: isFavorite,
                userBestScore: userBestScore,
                description: description,
                tipText: tipText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int difficulty,
                required String stepsJson,
                Value<bool> isFavorite = const Value.absent(),
                Value<int> userBestScore = const Value.absent(),
                required String description,
                required String tipText,
              }) => LatteArtPatternsCompanion.insert(
                id: id,
                name: name,
                difficulty: difficulty,
                stepsJson: stepsJson,
                isFavorite: isFavorite,
                userBestScore: userBestScore,
                description: description,
                tipText: tipText,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LatteArtPatternsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LatteArtPatternsTable,
      LatteArtPattern,
      $$LatteArtPatternsTableFilterComposer,
      $$LatteArtPatternsTableOrderingComposer,
      $$LatteArtPatternsTableAnnotationComposer,
      $$LatteArtPatternsTableCreateCompanionBuilder,
      $$LatteArtPatternsTableUpdateCompanionBuilder,
      (
        LatteArtPattern,
        BaseReferences<_$AppDatabase, $LatteArtPatternsTable, LatteArtPattern>,
      ),
      LatteArtPattern,
      PrefetchHooks Function()
    >;
typedef $$BeanScansTableCreateCompanionBuilder =
    BeanScansCompanion Function({
      Value<int> id,
      required DateTime scannedAt,
      required double agtronValue,
      required String roastLabel,
      required String flavorProfile,
      required String recommendedMethod,
      Value<String> notes,
    });
typedef $$BeanScansTableUpdateCompanionBuilder =
    BeanScansCompanion Function({
      Value<int> id,
      Value<DateTime> scannedAt,
      Value<double> agtronValue,
      Value<String> roastLabel,
      Value<String> flavorProfile,
      Value<String> recommendedMethod,
      Value<String> notes,
    });

class $$BeanScansTableFilterComposer
    extends Composer<_$AppDatabase, $BeanScansTable> {
  $$BeanScansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get agtronValue => $composableBuilder(
    column: $table.agtronValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLabel => $composableBuilder(
    column: $table.roastLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recommendedMethod => $composableBuilder(
    column: $table.recommendedMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BeanScansTableOrderingComposer
    extends Composer<_$AppDatabase, $BeanScansTable> {
  $$BeanScansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get agtronValue => $composableBuilder(
    column: $table.agtronValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLabel => $composableBuilder(
    column: $table.roastLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recommendedMethod => $composableBuilder(
    column: $table.recommendedMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BeanScansTableAnnotationComposer
    extends Composer<_$AppDatabase, $BeanScansTable> {
  $$BeanScansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get scannedAt =>
      $composableBuilder(column: $table.scannedAt, builder: (column) => column);

  GeneratedColumn<double> get agtronValue => $composableBuilder(
    column: $table.agtronValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastLabel => $composableBuilder(
    column: $table.roastLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recommendedMethod => $composableBuilder(
    column: $table.recommendedMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$BeanScansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BeanScansTable,
          BeanScan,
          $$BeanScansTableFilterComposer,
          $$BeanScansTableOrderingComposer,
          $$BeanScansTableAnnotationComposer,
          $$BeanScansTableCreateCompanionBuilder,
          $$BeanScansTableUpdateCompanionBuilder,
          (BeanScan, BaseReferences<_$AppDatabase, $BeanScansTable, BeanScan>),
          BeanScan,
          PrefetchHooks Function()
        > {
  $$BeanScansTableTableManager(_$AppDatabase db, $BeanScansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BeanScansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BeanScansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BeanScansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> scannedAt = const Value.absent(),
                Value<double> agtronValue = const Value.absent(),
                Value<String> roastLabel = const Value.absent(),
                Value<String> flavorProfile = const Value.absent(),
                Value<String> recommendedMethod = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => BeanScansCompanion(
                id: id,
                scannedAt: scannedAt,
                agtronValue: agtronValue,
                roastLabel: roastLabel,
                flavorProfile: flavorProfile,
                recommendedMethod: recommendedMethod,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime scannedAt,
                required double agtronValue,
                required String roastLabel,
                required String flavorProfile,
                required String recommendedMethod,
                Value<String> notes = const Value.absent(),
              }) => BeanScansCompanion.insert(
                id: id,
                scannedAt: scannedAt,
                agtronValue: agtronValue,
                roastLabel: roastLabel,
                flavorProfile: flavorProfile,
                recommendedMethod: recommendedMethod,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BeanScansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BeanScansTable,
      BeanScan,
      $$BeanScansTableFilterComposer,
      $$BeanScansTableOrderingComposer,
      $$BeanScansTableAnnotationComposer,
      $$BeanScansTableCreateCompanionBuilder,
      $$BeanScansTableUpdateCompanionBuilder,
      (BeanScan, BaseReferences<_$AppDatabase, $BeanScansTable, BeanScan>),
      BeanScan,
      PrefetchHooks Function()
    >;
typedef $$CustomRecipesTableCreateCompanionBuilder =
    CustomRecipesCompanion Function({
      Value<int> id,
      required String methodKey,
      required String name,
      required DateTime createdAt,
      required DateTime updatedAt,
      required double coffeeGrams,
      required double totalWaterMl,
      Value<int> grindNumber,
      Value<int> comandanteClicks,
      Value<int> ek43Division,
      Value<int> totalPours,
      Value<String> pourScheduleJson,
      Value<double> brewTempC,
      Value<String> notes,
      Value<int> rating,
    });
typedef $$CustomRecipesTableUpdateCompanionBuilder =
    CustomRecipesCompanion Function({
      Value<int> id,
      Value<String> methodKey,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<double> coffeeGrams,
      Value<double> totalWaterMl,
      Value<int> grindNumber,
      Value<int> comandanteClicks,
      Value<int> ek43Division,
      Value<int> totalPours,
      Value<String> pourScheduleJson,
      Value<double> brewTempC,
      Value<String> notes,
      Value<int> rating,
    });

class $$CustomRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $CustomRecipesTable> {
  $$CustomRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get methodKey => $composableBuilder(
    column: $table.methodKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coffeeGrams => $composableBuilder(
    column: $table.coffeeGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalWaterMl => $composableBuilder(
    column: $table.totalWaterMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grindNumber => $composableBuilder(
    column: $table.grindNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get comandanteClicks => $composableBuilder(
    column: $table.comandanteClicks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ek43Division => $composableBuilder(
    column: $table.ek43Division,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPours => $composableBuilder(
    column: $table.totalPours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pourScheduleJson => $composableBuilder(
    column: $table.pourScheduleJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get brewTempC => $composableBuilder(
    column: $table.brewTempC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomRecipesTable> {
  $$CustomRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get methodKey => $composableBuilder(
    column: $table.methodKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coffeeGrams => $composableBuilder(
    column: $table.coffeeGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalWaterMl => $composableBuilder(
    column: $table.totalWaterMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grindNumber => $composableBuilder(
    column: $table.grindNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get comandanteClicks => $composableBuilder(
    column: $table.comandanteClicks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ek43Division => $composableBuilder(
    column: $table.ek43Division,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPours => $composableBuilder(
    column: $table.totalPours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pourScheduleJson => $composableBuilder(
    column: $table.pourScheduleJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get brewTempC => $composableBuilder(
    column: $table.brewTempC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomRecipesTable> {
  $$CustomRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get methodKey =>
      $composableBuilder(column: $table.methodKey, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<double> get coffeeGrams => $composableBuilder(
    column: $table.coffeeGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalWaterMl => $composableBuilder(
    column: $table.totalWaterMl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get grindNumber => $composableBuilder(
    column: $table.grindNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get comandanteClicks => $composableBuilder(
    column: $table.comandanteClicks,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ek43Division => $composableBuilder(
    column: $table.ek43Division,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPours => $composableBuilder(
    column: $table.totalPours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pourScheduleJson => $composableBuilder(
    column: $table.pourScheduleJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get brewTempC =>
      $composableBuilder(column: $table.brewTempC, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);
}

class $$CustomRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomRecipesTable,
          CustomRecipe,
          $$CustomRecipesTableFilterComposer,
          $$CustomRecipesTableOrderingComposer,
          $$CustomRecipesTableAnnotationComposer,
          $$CustomRecipesTableCreateCompanionBuilder,
          $$CustomRecipesTableUpdateCompanionBuilder,
          (
            CustomRecipe,
            BaseReferences<_$AppDatabase, $CustomRecipesTable, CustomRecipe>,
          ),
          CustomRecipe,
          PrefetchHooks Function()
        > {
  $$CustomRecipesTableTableManager(_$AppDatabase db, $CustomRecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomRecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> methodKey = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<double> coffeeGrams = const Value.absent(),
                Value<double> totalWaterMl = const Value.absent(),
                Value<int> grindNumber = const Value.absent(),
                Value<int> comandanteClicks = const Value.absent(),
                Value<int> ek43Division = const Value.absent(),
                Value<int> totalPours = const Value.absent(),
                Value<String> pourScheduleJson = const Value.absent(),
                Value<double> brewTempC = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rating = const Value.absent(),
              }) => CustomRecipesCompanion(
                id: id,
                methodKey: methodKey,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                coffeeGrams: coffeeGrams,
                totalWaterMl: totalWaterMl,
                grindNumber: grindNumber,
                comandanteClicks: comandanteClicks,
                ek43Division: ek43Division,
                totalPours: totalPours,
                pourScheduleJson: pourScheduleJson,
                brewTempC: brewTempC,
                notes: notes,
                rating: rating,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String methodKey,
                required String name,
                required DateTime createdAt,
                required DateTime updatedAt,
                required double coffeeGrams,
                required double totalWaterMl,
                Value<int> grindNumber = const Value.absent(),
                Value<int> comandanteClicks = const Value.absent(),
                Value<int> ek43Division = const Value.absent(),
                Value<int> totalPours = const Value.absent(),
                Value<String> pourScheduleJson = const Value.absent(),
                Value<double> brewTempC = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rating = const Value.absent(),
              }) => CustomRecipesCompanion.insert(
                id: id,
                methodKey: methodKey,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                coffeeGrams: coffeeGrams,
                totalWaterMl: totalWaterMl,
                grindNumber: grindNumber,
                comandanteClicks: comandanteClicks,
                ek43Division: ek43Division,
                totalPours: totalPours,
                pourScheduleJson: pourScheduleJson,
                brewTempC: brewTempC,
                notes: notes,
                rating: rating,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomRecipesTable,
      CustomRecipe,
      $$CustomRecipesTableFilterComposer,
      $$CustomRecipesTableOrderingComposer,
      $$CustomRecipesTableAnnotationComposer,
      $$CustomRecipesTableCreateCompanionBuilder,
      $$CustomRecipesTableUpdateCompanionBuilder,
      (
        CustomRecipe,
        BaseReferences<_$AppDatabase, $CustomRecipesTable, CustomRecipe>,
      ),
      CustomRecipe,
      PrefetchHooks Function()
    >;
typedef $$SpecialtyArticlesTableCreateCompanionBuilder =
    SpecialtyArticlesCompanion Function({
      Value<int> id,
      required String title,
      required String subtitle,
      required String contentHtml,
      required String imageUrl,
      required int readTimeMin,
    });
typedef $$SpecialtyArticlesTableUpdateCompanionBuilder =
    SpecialtyArticlesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> subtitle,
      Value<String> contentHtml,
      Value<String> imageUrl,
      Value<int> readTimeMin,
    });

class $$SpecialtyArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $SpecialtyArticlesTable> {
  $$SpecialtyArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtml => $composableBuilder(
    column: $table.contentHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SpecialtyArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $SpecialtyArticlesTable> {
  $$SpecialtyArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtml => $composableBuilder(
    column: $table.contentHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpecialtyArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpecialtyArticlesTable> {
  $$SpecialtyArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get contentHtml => $composableBuilder(
    column: $table.contentHtml,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => column,
  );
}

class $$SpecialtyArticlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpecialtyArticlesTable,
          SpecialtyArticle,
          $$SpecialtyArticlesTableFilterComposer,
          $$SpecialtyArticlesTableOrderingComposer,
          $$SpecialtyArticlesTableAnnotationComposer,
          $$SpecialtyArticlesTableCreateCompanionBuilder,
          $$SpecialtyArticlesTableUpdateCompanionBuilder,
          (
            SpecialtyArticle,
            BaseReferences<
              _$AppDatabase,
              $SpecialtyArticlesTable,
              SpecialtyArticle
            >,
          ),
          SpecialtyArticle,
          PrefetchHooks Function()
        > {
  $$SpecialtyArticlesTableTableManager(
    _$AppDatabase db,
    $SpecialtyArticlesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpecialtyArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpecialtyArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpecialtyArticlesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> subtitle = const Value.absent(),
                Value<String> contentHtml = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> readTimeMin = const Value.absent(),
              }) => SpecialtyArticlesCompanion(
                id: id,
                title: title,
                subtitle: subtitle,
                contentHtml: contentHtml,
                imageUrl: imageUrl,
                readTimeMin: readTimeMin,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String subtitle,
                required String contentHtml,
                required String imageUrl,
                required int readTimeMin,
              }) => SpecialtyArticlesCompanion.insert(
                id: id,
                title: title,
                subtitle: subtitle,
                contentHtml: contentHtml,
                imageUrl: imageUrl,
                readTimeMin: readTimeMin,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SpecialtyArticlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpecialtyArticlesTable,
      SpecialtyArticle,
      $$SpecialtyArticlesTableFilterComposer,
      $$SpecialtyArticlesTableOrderingComposer,
      $$SpecialtyArticlesTableAnnotationComposer,
      $$SpecialtyArticlesTableCreateCompanionBuilder,
      $$SpecialtyArticlesTableUpdateCompanionBuilder,
      (
        SpecialtyArticle,
        BaseReferences<
          _$AppDatabase,
          $SpecialtyArticlesTable,
          SpecialtyArticle
        >,
      ),
      SpecialtyArticle,
      PrefetchHooks Function()
    >;
typedef $$RecommendedRecipesTableCreateCompanionBuilder =
    RecommendedRecipesCompanion Function({
      Value<int> id,
      required int lotId,
      required String methodKey,
      required double coffeeGrams,
      required double waterGrams,
      required double tempC,
      required int timeSec,
      required double rating,
      Value<String> sensoryJson,
      Value<String> notes,
    });
typedef $$RecommendedRecipesTableUpdateCompanionBuilder =
    RecommendedRecipesCompanion Function({
      Value<int> id,
      Value<int> lotId,
      Value<String> methodKey,
      Value<double> coffeeGrams,
      Value<double> waterGrams,
      Value<double> tempC,
      Value<int> timeSec,
      Value<double> rating,
      Value<String> sensoryJson,
      Value<String> notes,
    });

final class $$RecommendedRecipesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecommendedRecipesTable,
          RecommendedRecipe
        > {
  $$RecommendedRecipesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EncyclopediaEntriesTable _lotIdTable(_$AppDatabase db) =>
      db.encyclopediaEntries.createAlias(
        $_aliasNameGenerator(
          db.recommendedRecipes.lotId,
          db.encyclopediaEntries.id,
        ),
      );

  $$EncyclopediaEntriesTableProcessedTableManager get lotId {
    final $_column = $_itemColumn<int>('lot_id')!;

    final manager = $$EncyclopediaEntriesTableTableManager(
      $_db,
      $_db.encyclopediaEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecommendedRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecommendedRecipesTable> {
  $$RecommendedRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get methodKey => $composableBuilder(
    column: $table.methodKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coffeeGrams => $composableBuilder(
    column: $table.coffeeGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterGrams => $composableBuilder(
    column: $table.waterGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeSec => $composableBuilder(
    column: $table.timeSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$EncyclopediaEntriesTableFilterComposer get lotId {
    final $$EncyclopediaEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lotId,
      referencedTable: $db.encyclopediaEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EncyclopediaEntriesTableFilterComposer(
            $db: $db,
            $table: $db.encyclopediaEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecommendedRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecommendedRecipesTable> {
  $$RecommendedRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get methodKey => $composableBuilder(
    column: $table.methodKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coffeeGrams => $composableBuilder(
    column: $table.coffeeGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterGrams => $composableBuilder(
    column: $table.waterGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeSec => $composableBuilder(
    column: $table.timeSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$EncyclopediaEntriesTableOrderingComposer get lotId {
    final $$EncyclopediaEntriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.lotId,
          referencedTable: $db.encyclopediaEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EncyclopediaEntriesTableOrderingComposer(
                $db: $db,
                $table: $db.encyclopediaEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RecommendedRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecommendedRecipesTable> {
  $$RecommendedRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get methodKey =>
      $composableBuilder(column: $table.methodKey, builder: (column) => column);

  GeneratedColumn<double> get coffeeGrams => $composableBuilder(
    column: $table.coffeeGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waterGrams => $composableBuilder(
    column: $table.waterGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tempC =>
      $composableBuilder(column: $table.tempC, builder: (column) => column);

  GeneratedColumn<int> get timeSec =>
      $composableBuilder(column: $table.timeSec, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$EncyclopediaEntriesTableAnnotationComposer get lotId {
    final $$EncyclopediaEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.lotId,
          referencedTable: $db.encyclopediaEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EncyclopediaEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.encyclopediaEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RecommendedRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecommendedRecipesTable,
          RecommendedRecipe,
          $$RecommendedRecipesTableFilterComposer,
          $$RecommendedRecipesTableOrderingComposer,
          $$RecommendedRecipesTableAnnotationComposer,
          $$RecommendedRecipesTableCreateCompanionBuilder,
          $$RecommendedRecipesTableUpdateCompanionBuilder,
          (RecommendedRecipe, $$RecommendedRecipesTableReferences),
          RecommendedRecipe,
          PrefetchHooks Function({bool lotId})
        > {
  $$RecommendedRecipesTableTableManager(
    _$AppDatabase db,
    $RecommendedRecipesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecommendedRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecommendedRecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecommendedRecipesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lotId = const Value.absent(),
                Value<String> methodKey = const Value.absent(),
                Value<double> coffeeGrams = const Value.absent(),
                Value<double> waterGrams = const Value.absent(),
                Value<double> tempC = const Value.absent(),
                Value<int> timeSec = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => RecommendedRecipesCompanion(
                id: id,
                lotId: lotId,
                methodKey: methodKey,
                coffeeGrams: coffeeGrams,
                waterGrams: waterGrams,
                tempC: tempC,
                timeSec: timeSec,
                rating: rating,
                sensoryJson: sensoryJson,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int lotId,
                required String methodKey,
                required double coffeeGrams,
                required double waterGrams,
                required double tempC,
                required int timeSec,
                required double rating,
                Value<String> sensoryJson = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => RecommendedRecipesCompanion.insert(
                id: id,
                lotId: lotId,
                methodKey: methodKey,
                coffeeGrams: coffeeGrams,
                waterGrams: waterGrams,
                tempC: tempC,
                timeSec: timeSec,
                rating: rating,
                sensoryJson: sensoryJson,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecommendedRecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lotId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lotId,
                                referencedTable:
                                    $$RecommendedRecipesTableReferences
                                        ._lotIdTable(db),
                                referencedColumn:
                                    $$RecommendedRecipesTableReferences
                                        ._lotIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecommendedRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecommendedRecipesTable,
      RecommendedRecipe,
      $$RecommendedRecipesTableFilterComposer,
      $$RecommendedRecipesTableOrderingComposer,
      $$RecommendedRecipesTableAnnotationComposer,
      $$RecommendedRecipesTableCreateCompanionBuilder,
      $$RecommendedRecipesTableUpdateCompanionBuilder,
      (RecommendedRecipe, $$RecommendedRecipesTableReferences),
      RecommendedRecipe,
      PrefetchHooks Function({bool lotId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CoffeeLotsTableTableManager get coffeeLots =>
      $$CoffeeLotsTableTableManager(_db, _db.coffeeLots);
  $$FermentationLogsTableTableManager get fermentationLogs =>
      $$FermentationLogsTableTableManager(_db, _db.fermentationLogs);
  $$BrewingRecipesTableTableManager get brewingRecipes =>
      $$BrewingRecipesTableTableManager(_db, _db.brewingRecipes);
  $$BrandsTableTableManager get brands =>
      $$BrandsTableTableManager(_db, _db.brands);
  $$EncyclopediaEntriesTableTableManager get encyclopediaEntries =>
      $$EncyclopediaEntriesTableTableManager(_db, _db.encyclopediaEntries);
  $$LatteArtPatternsTableTableManager get latteArtPatterns =>
      $$LatteArtPatternsTableTableManager(_db, _db.latteArtPatterns);
  $$BeanScansTableTableManager get beanScans =>
      $$BeanScansTableTableManager(_db, _db.beanScans);
  $$CustomRecipesTableTableManager get customRecipes =>
      $$CustomRecipesTableTableManager(_db, _db.customRecipes);
  $$SpecialtyArticlesTableTableManager get specialtyArticles =>
      $$SpecialtyArticlesTableTableManager(_db, _db.specialtyArticles);
  $$RecommendedRecipesTableTableManager get recommendedRecipes =>
      $$RecommendedRecipesTableTableManager(_db, _db.recommendedRecipes);
}
