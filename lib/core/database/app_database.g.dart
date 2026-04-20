// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalizedBrandsTable extends LocalizedBrands
    with TableInfo<$LocalizedBrandsTable, LocalizedBrand> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedBrandsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _siteUrlMeta = const VerificationMeta(
    'siteUrl',
  );
  @override
  late final GeneratedColumn<String> siteUrl = GeneratedColumn<String>(
    'site_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedLocalMeta = const VerificationMeta(
    'isDeletedLocal',
  );
  @override
  late final GeneratedColumn<bool> isDeletedLocal = GeneratedColumn<bool>(
    'is_deleted_local',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted_local" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    logoUrl,
    siteUrl,
    createdAt,
    isSynced,
    isDeletedLocal,
    isFavorite,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_brands';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedBrand> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted_local')) {
      context.handle(
        _isDeletedLocalMeta,
        isDeletedLocal.isAcceptableOrUnknown(
          data['is_deleted_local']!,
          _isDeletedLocalMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalizedBrand map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedBrand(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      siteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}site_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeletedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted_local'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
    );
  }

  @override
  $LocalizedBrandsTable createAlias(String alias) {
    return $LocalizedBrandsTable(attachedDatabase, alias);
  }
}

class LocalizedBrand extends DataClass implements Insertable<LocalizedBrand> {
  final int id;
  final String? userId;
  final String name;
  final String? logoUrl;
  final String? siteUrl;
  final DateTime? createdAt;
  final bool isSynced;
  final bool isDeletedLocal;
  final bool isFavorite;
  final bool isArchived;
  const LocalizedBrand({
    required this.id,
    this.userId,
    required this.name,
    this.logoUrl,
    this.siteUrl,
    this.createdAt,
    required this.isSynced,
    required this.isDeletedLocal,
    required this.isFavorite,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || siteUrl != null) {
      map['site_url'] = Variable<String>(siteUrl);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted_local'] = Variable<bool>(isDeletedLocal);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  LocalizedBrandsCompanion toCompanion(bool nullToAbsent) {
    return LocalizedBrandsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      name: Value(name),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      siteUrl: siteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(siteUrl),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      isSynced: Value(isSynced),
      isDeletedLocal: Value(isDeletedLocal),
      isFavorite: Value(isFavorite),
      isArchived: Value(isArchived),
    );
  }

  factory LocalizedBrand.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedBrand(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      siteUrl: serializer.fromJson<String?>(json['siteUrl']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeletedLocal: serializer.fromJson<bool>(json['isDeletedLocal']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String?>(userId),
      'name': serializer.toJson<String>(name),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'siteUrl': serializer.toJson<String?>(siteUrl),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeletedLocal': serializer.toJson<bool>(isDeletedLocal),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  LocalizedBrand copyWith({
    int? id,
    Value<String?> userId = const Value.absent(),
    String? name,
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> siteUrl = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
    bool? isSynced,
    bool? isDeletedLocal,
    bool? isFavorite,
    bool? isArchived,
  }) => LocalizedBrand(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    name: name ?? this.name,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    siteUrl: siteUrl.present ? siteUrl.value : this.siteUrl,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    isSynced: isSynced ?? this.isSynced,
    isDeletedLocal: isDeletedLocal ?? this.isDeletedLocal,
    isFavorite: isFavorite ?? this.isFavorite,
    isArchived: isArchived ?? this.isArchived,
  );
  LocalizedBrand copyWithCompanion(LocalizedBrandsCompanion data) {
    return LocalizedBrand(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      siteUrl: data.siteUrl.present ? data.siteUrl.value : this.siteUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeletedLocal: data.isDeletedLocal.present
          ? data.isDeletedLocal.value
          : this.isDeletedLocal,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBrand(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeletedLocal: $isDeletedLocal, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    logoUrl,
    siteUrl,
    createdAt,
    isSynced,
    isDeletedLocal,
    isFavorite,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedBrand &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.logoUrl == this.logoUrl &&
          other.siteUrl == this.siteUrl &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced &&
          other.isDeletedLocal == this.isDeletedLocal &&
          other.isFavorite == this.isFavorite &&
          other.isArchived == this.isArchived);
}

class LocalizedBrandsCompanion extends UpdateCompanion<LocalizedBrand> {
  final Value<int> id;
  final Value<String?> userId;
  final Value<String> name;
  final Value<String?> logoUrl;
  final Value<String?> siteUrl;
  final Value<DateTime?> createdAt;
  final Value<bool> isSynced;
  final Value<bool> isDeletedLocal;
  final Value<bool> isFavorite;
  final Value<bool> isArchived;
  const LocalizedBrandsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeletedLocal = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isArchived = const Value.absent(),
  });
  LocalizedBrandsCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    required String name,
    this.logoUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeletedLocal = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isArchived = const Value.absent(),
  }) : name = Value(name);
  static Insertable<LocalizedBrand> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? logoUrl,
    Expression<String>? siteUrl,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<bool>? isDeletedLocal,
    Expression<bool>? isFavorite,
    Expression<bool>? isArchived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (siteUrl != null) 'site_url': siteUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeletedLocal != null) 'is_deleted_local': isDeletedLocal,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isArchived != null) 'is_archived': isArchived,
    });
  }

  LocalizedBrandsCompanion copyWith({
    Value<int>? id,
    Value<String?>? userId,
    Value<String>? name,
    Value<String?>? logoUrl,
    Value<String?>? siteUrl,
    Value<DateTime?>? createdAt,
    Value<bool>? isSynced,
    Value<bool>? isDeletedLocal,
    Value<bool>? isFavorite,
    Value<bool>? isArchived,
  }) {
    return LocalizedBrandsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      isDeletedLocal: isDeletedLocal ?? this.isDeletedLocal,
      isFavorite: isFavorite ?? this.isFavorite,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (siteUrl.present) {
      map['site_url'] = Variable<String>(siteUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeletedLocal.present) {
      map['is_deleted_local'] = Variable<bool>(isDeletedLocal.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBrandsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('siteUrl: $siteUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeletedLocal: $isDeletedLocal, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }
}

class $LocalizedFarmersTable extends LocalizedFarmers
    with TableInfo<$LocalizedFarmersTable, LocalizedFarmer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedFarmersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _flagUrlMeta = const VerificationMeta(
    'flagUrl',
  );
  @override
  late final GeneratedColumn<String> flagUrl = GeneratedColumn<String>(
    'flag_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imageUrl,
    flagUrl,
    latitude,
    longitude,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_farmers';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedFarmer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('flag_url')) {
      context.handle(
        _flagUrlMeta,
        flagUrl.isAcceptableOrUnknown(data['flag_url']!, _flagUrlMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalizedFarmer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedFarmer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      flagUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flag_url'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $LocalizedFarmersTable createAlias(String alias) {
    return $LocalizedFarmersTable(attachedDatabase, alias);
  }
}

class LocalizedFarmer extends DataClass implements Insertable<LocalizedFarmer> {
  final int id;
  final String imageUrl;
  final String flagUrl;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  const LocalizedFarmer({
    required this.id,
    required this.imageUrl,
    required this.flagUrl,
    this.latitude,
    this.longitude,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['flag_url'] = Variable<String>(flagUrl);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  LocalizedFarmersCompanion toCompanion(bool nullToAbsent) {
    return LocalizedFarmersCompanion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      flagUrl: Value(flagUrl),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory LocalizedFarmer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedFarmer(
      id: serializer.fromJson<int>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      flagUrl: serializer.fromJson<String>(json['flagUrl']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'flagUrl': serializer.toJson<String>(flagUrl),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  LocalizedFarmer copyWith({
    int? id,
    String? imageUrl,
    String? flagUrl,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
  }) => LocalizedFarmer(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    flagUrl: flagUrl ?? this.flagUrl,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  LocalizedFarmer copyWithCompanion(LocalizedFarmersCompanion data) {
    return LocalizedFarmer(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      flagUrl: data.flagUrl.present ? data.flagUrl.value : this.flagUrl,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmer(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, imageUrl, flagUrl, latitude, longitude, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedFarmer &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.flagUrl == this.flagUrl &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.createdAt == this.createdAt);
}

class LocalizedFarmersCompanion extends UpdateCompanion<LocalizedFarmer> {
  final Value<int> id;
  final Value<String> imageUrl;
  final Value<String> flagUrl;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime?> createdAt;
  const LocalizedFarmersCompanion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocalizedFarmersCompanion.insert({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<LocalizedFarmer> custom({
    Expression<int>? id,
    Expression<String>? imageUrl,
    Expression<String>? flagUrl,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (flagUrl != null) 'flag_url': flagUrl,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocalizedFarmersCompanion copyWith({
    Value<int>? id,
    Value<String>? imageUrl,
    Value<String>? flagUrl,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime?>? createdAt,
  }) {
    return LocalizedFarmersCompanion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      flagUrl: flagUrl ?? this.flagUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (flagUrl.present) {
      map['flag_url'] = Variable<String>(flagUrl.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmersCompanion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LocalizedBeansTable extends LocalizedBeans
    with TableInfo<$LocalizedBeansTable, LocalizedBean> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedBeansTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES localized_brands (id)',
    ),
  );
  static const VerificationMeta _countryEmojiMeta = const VerificationMeta(
    'countryEmoji',
  );
  @override
  late final GeneratedColumn<String> countryEmoji = GeneratedColumn<String>(
    'country_emoji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMinMeta = const VerificationMeta(
    'altitudeMin',
  );
  @override
  late final GeneratedColumn<int> altitudeMin = GeneratedColumn<int>(
    'altitude_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMaxMeta = const VerificationMeta(
    'altitudeMax',
  );
  @override
  late final GeneratedColumn<int> altitudeMax = GeneratedColumn<int>(
    'altitude_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _scaScoreMeta = const VerificationMeta(
    'scaScore',
  );
  @override
  late final GeneratedColumn<String> scaScore = GeneratedColumn<String>(
    'sca_score',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('80-84'),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(82.0),
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
  static const VerificationMeta _priceJsonMeta = const VerificationMeta(
    'priceJson',
  );
  @override
  late final GeneratedColumn<String> priceJson = GeneratedColumn<String>(
    'price_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
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
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _harvestSeasonMeta = const VerificationMeta(
    'harvestSeason',
  );
  @override
  late final GeneratedColumn<String> harvestSeason = GeneratedColumn<String>(
    'harvest_season',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<String> price = GeneratedColumn<String>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<String> weight = GeneratedColumn<String>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastDateMeta = const VerificationMeta(
    'roastDate',
  );
  @override
  late final GeneratedColumn<String> roastDate = GeneratedColumn<String>(
    'roast_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<int> farmerId = GeneratedColumn<int>(
    'farmer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES localized_farmers (id)',
    ),
  );
  static const VerificationMeta _isDecafMeta = const VerificationMeta(
    'isDecaf',
  );
  @override
  late final GeneratedColumn<bool> isDecaf = GeneratedColumn<bool>(
    'is_decaf',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_decaf" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _farmMeta = const VerificationMeta('farm');
  @override
  late final GeneratedColumn<String> farm = GeneratedColumn<String>(
    'farm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmPhotosUrlCoverMeta =
      const VerificationMeta('farmPhotosUrlCover');
  @override
  late final GeneratedColumn<String> farmPhotosUrlCover =
      GeneratedColumn<String>(
        'farm_photos_url_cover',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _washStationMeta = const VerificationMeta(
    'washStation',
  );
  @override
  late final GeneratedColumn<String> washStation = GeneratedColumn<String>(
    'wash_station',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retailPriceMeta = const VerificationMeta(
    'retailPrice',
  );
  @override
  late final GeneratedColumn<String> retailPrice = GeneratedColumn<String>(
    'retail_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wholesalePriceMeta = const VerificationMeta(
    'wholesalePrice',
  );
  @override
  late final GeneratedColumn<String> wholesalePrice = GeneratedColumn<String>(
    'wholesale_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brandId,
    countryEmoji,
    altitudeMin,
    altitudeMax,
    lotNumber,
    scaScore,
    cupsScore,
    sensoryJson,
    priceJson,
    plantationPhotosUrl,
    harvestSeason,
    price,
    weight,
    roastDate,
    processingMethodsJson,
    isPremium,
    detailedProcessMarkdown,
    url,
    farmerId,
    isDecaf,
    farm,
    farmPhotosUrlCover,
    washStation,
    retailPrice,
    wholesalePrice,
    isFavorite,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_beans';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedBean> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    }
    if (data.containsKey('country_emoji')) {
      context.handle(
        _countryEmojiMeta,
        countryEmoji.isAcceptableOrUnknown(
          data['country_emoji']!,
          _countryEmojiMeta,
        ),
      );
    }
    if (data.containsKey('altitude_min')) {
      context.handle(
        _altitudeMinMeta,
        altitudeMin.isAcceptableOrUnknown(
          data['altitude_min']!,
          _altitudeMinMeta,
        ),
      );
    }
    if (data.containsKey('altitude_max')) {
      context.handle(
        _altitudeMaxMeta,
        altitudeMax.isAcceptableOrUnknown(
          data['altitude_max']!,
          _altitudeMaxMeta,
        ),
      );
    }
    if (data.containsKey('lot_number')) {
      context.handle(
        _lotNumberMeta,
        lotNumber.isAcceptableOrUnknown(data['lot_number']!, _lotNumberMeta),
      );
    }
    if (data.containsKey('sca_score')) {
      context.handle(
        _scaScoreMeta,
        scaScore.isAcceptableOrUnknown(data['sca_score']!, _scaScoreMeta),
      );
    }
    if (data.containsKey('cups_score')) {
      context.handle(
        _cupsScoreMeta,
        cupsScore.isAcceptableOrUnknown(data['cups_score']!, _cupsScoreMeta),
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
    if (data.containsKey('price_json')) {
      context.handle(
        _priceJsonMeta,
        priceJson.isAcceptableOrUnknown(data['price_json']!, _priceJsonMeta),
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
    if (data.containsKey('harvest_season')) {
      context.handle(
        _harvestSeasonMeta,
        harvestSeason.isAcceptableOrUnknown(
          data['harvest_season']!,
          _harvestSeasonMeta,
        ),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('roast_date')) {
      context.handle(
        _roastDateMeta,
        roastDate.isAcceptableOrUnknown(data['roast_date']!, _roastDateMeta),
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
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    }
    if (data.containsKey('is_decaf')) {
      context.handle(
        _isDecafMeta,
        isDecaf.isAcceptableOrUnknown(data['is_decaf']!, _isDecafMeta),
      );
    }
    if (data.containsKey('farm')) {
      context.handle(
        _farmMeta,
        farm.isAcceptableOrUnknown(data['farm']!, _farmMeta),
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
    if (data.containsKey('wash_station')) {
      context.handle(
        _washStationMeta,
        washStation.isAcceptableOrUnknown(
          data['wash_station']!,
          _washStationMeta,
        ),
      );
    }
    if (data.containsKey('retail_price')) {
      context.handle(
        _retailPriceMeta,
        retailPrice.isAcceptableOrUnknown(
          data['retail_price']!,
          _retailPriceMeta,
        ),
      );
    }
    if (data.containsKey('wholesale_price')) {
      context.handle(
        _wholesalePriceMeta,
        wholesalePrice.isAcceptableOrUnknown(
          data['wholesale_price']!,
          _wholesalePriceMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalizedBean map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedBean(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brand_id'],
      ),
      countryEmoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_emoji'],
      ),
      altitudeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_min'],
      ),
      altitudeMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_max'],
      ),
      lotNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_number'],
      )!,
      scaScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sca_score'],
      )!,
      cupsScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cups_score'],
      )!,
      sensoryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensory_json'],
      )!,
      priceJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_json'],
      )!,
      plantationPhotosUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plantation_photos_url'],
      )!,
      harvestSeason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}harvest_season'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weight'],
      ),
      roastDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_date'],
      ),
      processingMethodsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_methods_json'],
      )!,
      isPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_premium'],
      )!,
      detailedProcessMarkdown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detailed_process_markdown'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}farmer_id'],
      ),
      isDecaf: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_decaf'],
      )!,
      farm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm'],
      ),
      farmPhotosUrlCover: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_photos_url_cover'],
      ),
      washStation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wash_station'],
      ),
      retailPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}retail_price'],
      ),
      wholesalePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wholesale_price'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $LocalizedBeansTable createAlias(String alias) {
    return $LocalizedBeansTable(attachedDatabase, alias);
  }
}

class LocalizedBean extends DataClass implements Insertable<LocalizedBean> {
  final int id;
  final int? brandId;
  final String? countryEmoji;
  final int? altitudeMin;
  final int? altitudeMax;
  final String lotNumber;
  final String scaScore;
  final double cupsScore;
  final String sensoryJson;
  final String priceJson;
  final String plantationPhotosUrl;
  final String? harvestSeason;
  final String? price;
  final String? weight;
  final String? roastDate;
  final String processingMethodsJson;
  final bool isPremium;
  final String detailedProcessMarkdown;
  final String url;
  final int? farmerId;
  final bool isDecaf;
  final String? farm;
  final String? farmPhotosUrlCover;
  final String? washStation;
  final String? retailPrice;
  final String? wholesalePrice;
  final bool isFavorite;
  final DateTime? createdAt;
  const LocalizedBean({
    required this.id,
    this.brandId,
    this.countryEmoji,
    this.altitudeMin,
    this.altitudeMax,
    required this.lotNumber,
    required this.scaScore,
    required this.cupsScore,
    required this.sensoryJson,
    required this.priceJson,
    required this.plantationPhotosUrl,
    this.harvestSeason,
    this.price,
    this.weight,
    this.roastDate,
    required this.processingMethodsJson,
    required this.isPremium,
    required this.detailedProcessMarkdown,
    required this.url,
    this.farmerId,
    required this.isDecaf,
    this.farm,
    this.farmPhotosUrlCover,
    this.washStation,
    this.retailPrice,
    this.wholesalePrice,
    required this.isFavorite,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || brandId != null) {
      map['brand_id'] = Variable<int>(brandId);
    }
    if (!nullToAbsent || countryEmoji != null) {
      map['country_emoji'] = Variable<String>(countryEmoji);
    }
    if (!nullToAbsent || altitudeMin != null) {
      map['altitude_min'] = Variable<int>(altitudeMin);
    }
    if (!nullToAbsent || altitudeMax != null) {
      map['altitude_max'] = Variable<int>(altitudeMax);
    }
    map['lot_number'] = Variable<String>(lotNumber);
    map['sca_score'] = Variable<String>(scaScore);
    map['cups_score'] = Variable<double>(cupsScore);
    map['sensory_json'] = Variable<String>(sensoryJson);
    map['price_json'] = Variable<String>(priceJson);
    map['plantation_photos_url'] = Variable<String>(plantationPhotosUrl);
    if (!nullToAbsent || harvestSeason != null) {
      map['harvest_season'] = Variable<String>(harvestSeason);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<String>(price);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<String>(weight);
    }
    if (!nullToAbsent || roastDate != null) {
      map['roast_date'] = Variable<String>(roastDate);
    }
    map['processing_methods_json'] = Variable<String>(processingMethodsJson);
    map['is_premium'] = Variable<bool>(isPremium);
    map['detailed_process_markdown'] = Variable<String>(
      detailedProcessMarkdown,
    );
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || farmerId != null) {
      map['farmer_id'] = Variable<int>(farmerId);
    }
    map['is_decaf'] = Variable<bool>(isDecaf);
    if (!nullToAbsent || farm != null) {
      map['farm'] = Variable<String>(farm);
    }
    if (!nullToAbsent || farmPhotosUrlCover != null) {
      map['farm_photos_url_cover'] = Variable<String>(farmPhotosUrlCover);
    }
    if (!nullToAbsent || washStation != null) {
      map['wash_station'] = Variable<String>(washStation);
    }
    if (!nullToAbsent || retailPrice != null) {
      map['retail_price'] = Variable<String>(retailPrice);
    }
    if (!nullToAbsent || wholesalePrice != null) {
      map['wholesale_price'] = Variable<String>(wholesalePrice);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  LocalizedBeansCompanion toCompanion(bool nullToAbsent) {
    return LocalizedBeansCompanion(
      id: Value(id),
      brandId: brandId == null && nullToAbsent
          ? const Value.absent()
          : Value(brandId),
      countryEmoji: countryEmoji == null && nullToAbsent
          ? const Value.absent()
          : Value(countryEmoji),
      altitudeMin: altitudeMin == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMin),
      altitudeMax: altitudeMax == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMax),
      lotNumber: Value(lotNumber),
      scaScore: Value(scaScore),
      cupsScore: Value(cupsScore),
      sensoryJson: Value(sensoryJson),
      priceJson: Value(priceJson),
      plantationPhotosUrl: Value(plantationPhotosUrl),
      harvestSeason: harvestSeason == null && nullToAbsent
          ? const Value.absent()
          : Value(harvestSeason),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      roastDate: roastDate == null && nullToAbsent
          ? const Value.absent()
          : Value(roastDate),
      processingMethodsJson: Value(processingMethodsJson),
      isPremium: Value(isPremium),
      detailedProcessMarkdown: Value(detailedProcessMarkdown),
      url: Value(url),
      farmerId: farmerId == null && nullToAbsent
          ? const Value.absent()
          : Value(farmerId),
      isDecaf: Value(isDecaf),
      farm: farm == null && nullToAbsent ? const Value.absent() : Value(farm),
      farmPhotosUrlCover: farmPhotosUrlCover == null && nullToAbsent
          ? const Value.absent()
          : Value(farmPhotosUrlCover),
      washStation: washStation == null && nullToAbsent
          ? const Value.absent()
          : Value(washStation),
      retailPrice: retailPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(retailPrice),
      wholesalePrice: wholesalePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(wholesalePrice),
      isFavorite: Value(isFavorite),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory LocalizedBean.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedBean(
      id: serializer.fromJson<int>(json['id']),
      brandId: serializer.fromJson<int?>(json['brandId']),
      countryEmoji: serializer.fromJson<String?>(json['countryEmoji']),
      altitudeMin: serializer.fromJson<int?>(json['altitudeMin']),
      altitudeMax: serializer.fromJson<int?>(json['altitudeMax']),
      lotNumber: serializer.fromJson<String>(json['lotNumber']),
      scaScore: serializer.fromJson<String>(json['scaScore']),
      cupsScore: serializer.fromJson<double>(json['cupsScore']),
      sensoryJson: serializer.fromJson<String>(json['sensoryJson']),
      priceJson: serializer.fromJson<String>(json['priceJson']),
      plantationPhotosUrl: serializer.fromJson<String>(
        json['plantationPhotosUrl'],
      ),
      harvestSeason: serializer.fromJson<String?>(json['harvestSeason']),
      price: serializer.fromJson<String?>(json['price']),
      weight: serializer.fromJson<String?>(json['weight']),
      roastDate: serializer.fromJson<String?>(json['roastDate']),
      processingMethodsJson: serializer.fromJson<String>(
        json['processingMethodsJson'],
      ),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
      detailedProcessMarkdown: serializer.fromJson<String>(
        json['detailedProcessMarkdown'],
      ),
      url: serializer.fromJson<String>(json['url']),
      farmerId: serializer.fromJson<int?>(json['farmerId']),
      isDecaf: serializer.fromJson<bool>(json['isDecaf']),
      farm: serializer.fromJson<String?>(json['farm']),
      farmPhotosUrlCover: serializer.fromJson<String?>(
        json['farmPhotosUrlCover'],
      ),
      washStation: serializer.fromJson<String?>(json['washStation']),
      retailPrice: serializer.fromJson<String?>(json['retailPrice']),
      wholesalePrice: serializer.fromJson<String?>(json['wholesalePrice']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brandId': serializer.toJson<int?>(brandId),
      'countryEmoji': serializer.toJson<String?>(countryEmoji),
      'altitudeMin': serializer.toJson<int?>(altitudeMin),
      'altitudeMax': serializer.toJson<int?>(altitudeMax),
      'lotNumber': serializer.toJson<String>(lotNumber),
      'scaScore': serializer.toJson<String>(scaScore),
      'cupsScore': serializer.toJson<double>(cupsScore),
      'sensoryJson': serializer.toJson<String>(sensoryJson),
      'priceJson': serializer.toJson<String>(priceJson),
      'plantationPhotosUrl': serializer.toJson<String>(plantationPhotosUrl),
      'harvestSeason': serializer.toJson<String?>(harvestSeason),
      'price': serializer.toJson<String?>(price),
      'weight': serializer.toJson<String?>(weight),
      'roastDate': serializer.toJson<String?>(roastDate),
      'processingMethodsJson': serializer.toJson<String>(processingMethodsJson),
      'isPremium': serializer.toJson<bool>(isPremium),
      'detailedProcessMarkdown': serializer.toJson<String>(
        detailedProcessMarkdown,
      ),
      'url': serializer.toJson<String>(url),
      'farmerId': serializer.toJson<int?>(farmerId),
      'isDecaf': serializer.toJson<bool>(isDecaf),
      'farm': serializer.toJson<String?>(farm),
      'farmPhotosUrlCover': serializer.toJson<String?>(farmPhotosUrlCover),
      'washStation': serializer.toJson<String?>(washStation),
      'retailPrice': serializer.toJson<String?>(retailPrice),
      'wholesalePrice': serializer.toJson<String?>(wholesalePrice),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  LocalizedBean copyWith({
    int? id,
    Value<int?> brandId = const Value.absent(),
    Value<String?> countryEmoji = const Value.absent(),
    Value<int?> altitudeMin = const Value.absent(),
    Value<int?> altitudeMax = const Value.absent(),
    String? lotNumber,
    String? scaScore,
    double? cupsScore,
    String? sensoryJson,
    String? priceJson,
    String? plantationPhotosUrl,
    Value<String?> harvestSeason = const Value.absent(),
    Value<String?> price = const Value.absent(),
    Value<String?> weight = const Value.absent(),
    Value<String?> roastDate = const Value.absent(),
    String? processingMethodsJson,
    bool? isPremium,
    String? detailedProcessMarkdown,
    String? url,
    Value<int?> farmerId = const Value.absent(),
    bool? isDecaf,
    Value<String?> farm = const Value.absent(),
    Value<String?> farmPhotosUrlCover = const Value.absent(),
    Value<String?> washStation = const Value.absent(),
    Value<String?> retailPrice = const Value.absent(),
    Value<String?> wholesalePrice = const Value.absent(),
    bool? isFavorite,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => LocalizedBean(
    id: id ?? this.id,
    brandId: brandId.present ? brandId.value : this.brandId,
    countryEmoji: countryEmoji.present ? countryEmoji.value : this.countryEmoji,
    altitudeMin: altitudeMin.present ? altitudeMin.value : this.altitudeMin,
    altitudeMax: altitudeMax.present ? altitudeMax.value : this.altitudeMax,
    lotNumber: lotNumber ?? this.lotNumber,
    scaScore: scaScore ?? this.scaScore,
    cupsScore: cupsScore ?? this.cupsScore,
    sensoryJson: sensoryJson ?? this.sensoryJson,
    priceJson: priceJson ?? this.priceJson,
    plantationPhotosUrl: plantationPhotosUrl ?? this.plantationPhotosUrl,
    harvestSeason: harvestSeason.present
        ? harvestSeason.value
        : this.harvestSeason,
    price: price.present ? price.value : this.price,
    weight: weight.present ? weight.value : this.weight,
    roastDate: roastDate.present ? roastDate.value : this.roastDate,
    processingMethodsJson: processingMethodsJson ?? this.processingMethodsJson,
    isPremium: isPremium ?? this.isPremium,
    detailedProcessMarkdown:
        detailedProcessMarkdown ?? this.detailedProcessMarkdown,
    url: url ?? this.url,
    farmerId: farmerId.present ? farmerId.value : this.farmerId,
    isDecaf: isDecaf ?? this.isDecaf,
    farm: farm.present ? farm.value : this.farm,
    farmPhotosUrlCover: farmPhotosUrlCover.present
        ? farmPhotosUrlCover.value
        : this.farmPhotosUrlCover,
    washStation: washStation.present ? washStation.value : this.washStation,
    retailPrice: retailPrice.present ? retailPrice.value : this.retailPrice,
    wholesalePrice: wholesalePrice.present
        ? wholesalePrice.value
        : this.wholesalePrice,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  LocalizedBean copyWithCompanion(LocalizedBeansCompanion data) {
    return LocalizedBean(
      id: data.id.present ? data.id.value : this.id,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      countryEmoji: data.countryEmoji.present
          ? data.countryEmoji.value
          : this.countryEmoji,
      altitudeMin: data.altitudeMin.present
          ? data.altitudeMin.value
          : this.altitudeMin,
      altitudeMax: data.altitudeMax.present
          ? data.altitudeMax.value
          : this.altitudeMax,
      lotNumber: data.lotNumber.present ? data.lotNumber.value : this.lotNumber,
      scaScore: data.scaScore.present ? data.scaScore.value : this.scaScore,
      cupsScore: data.cupsScore.present ? data.cupsScore.value : this.cupsScore,
      sensoryJson: data.sensoryJson.present
          ? data.sensoryJson.value
          : this.sensoryJson,
      priceJson: data.priceJson.present ? data.priceJson.value : this.priceJson,
      plantationPhotosUrl: data.plantationPhotosUrl.present
          ? data.plantationPhotosUrl.value
          : this.plantationPhotosUrl,
      harvestSeason: data.harvestSeason.present
          ? data.harvestSeason.value
          : this.harvestSeason,
      price: data.price.present ? data.price.value : this.price,
      weight: data.weight.present ? data.weight.value : this.weight,
      roastDate: data.roastDate.present ? data.roastDate.value : this.roastDate,
      processingMethodsJson: data.processingMethodsJson.present
          ? data.processingMethodsJson.value
          : this.processingMethodsJson,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
      detailedProcessMarkdown: data.detailedProcessMarkdown.present
          ? data.detailedProcessMarkdown.value
          : this.detailedProcessMarkdown,
      url: data.url.present ? data.url.value : this.url,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      isDecaf: data.isDecaf.present ? data.isDecaf.value : this.isDecaf,
      farm: data.farm.present ? data.farm.value : this.farm,
      farmPhotosUrlCover: data.farmPhotosUrlCover.present
          ? data.farmPhotosUrlCover.value
          : this.farmPhotosUrlCover,
      washStation: data.washStation.present
          ? data.washStation.value
          : this.washStation,
      retailPrice: data.retailPrice.present
          ? data.retailPrice.value
          : this.retailPrice,
      wholesalePrice: data.wholesalePrice.present
          ? data.wholesalePrice.value
          : this.wholesalePrice,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBean(')
          ..write('id: $id, ')
          ..write('brandId: $brandId, ')
          ..write('countryEmoji: $countryEmoji, ')
          ..write('altitudeMin: $altitudeMin, ')
          ..write('altitudeMax: $altitudeMax, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('scaScore: $scaScore, ')
          ..write('cupsScore: $cupsScore, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('priceJson: $priceJson, ')
          ..write('plantationPhotosUrl: $plantationPhotosUrl, ')
          ..write('harvestSeason: $harvestSeason, ')
          ..write('price: $price, ')
          ..write('weight: $weight, ')
          ..write('roastDate: $roastDate, ')
          ..write('processingMethodsJson: $processingMethodsJson, ')
          ..write('isPremium: $isPremium, ')
          ..write('detailedProcessMarkdown: $detailedProcessMarkdown, ')
          ..write('url: $url, ')
          ..write('farmerId: $farmerId, ')
          ..write('isDecaf: $isDecaf, ')
          ..write('farm: $farm, ')
          ..write('farmPhotosUrlCover: $farmPhotosUrlCover, ')
          ..write('washStation: $washStation, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    brandId,
    countryEmoji,
    altitudeMin,
    altitudeMax,
    lotNumber,
    scaScore,
    cupsScore,
    sensoryJson,
    priceJson,
    plantationPhotosUrl,
    harvestSeason,
    price,
    weight,
    roastDate,
    processingMethodsJson,
    isPremium,
    detailedProcessMarkdown,
    url,
    farmerId,
    isDecaf,
    farm,
    farmPhotosUrlCover,
    washStation,
    retailPrice,
    wholesalePrice,
    isFavorite,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedBean &&
          other.id == this.id &&
          other.brandId == this.brandId &&
          other.countryEmoji == this.countryEmoji &&
          other.altitudeMin == this.altitudeMin &&
          other.altitudeMax == this.altitudeMax &&
          other.lotNumber == this.lotNumber &&
          other.scaScore == this.scaScore &&
          other.cupsScore == this.cupsScore &&
          other.sensoryJson == this.sensoryJson &&
          other.priceJson == this.priceJson &&
          other.plantationPhotosUrl == this.plantationPhotosUrl &&
          other.harvestSeason == this.harvestSeason &&
          other.price == this.price &&
          other.weight == this.weight &&
          other.roastDate == this.roastDate &&
          other.processingMethodsJson == this.processingMethodsJson &&
          other.isPremium == this.isPremium &&
          other.detailedProcessMarkdown == this.detailedProcessMarkdown &&
          other.url == this.url &&
          other.farmerId == this.farmerId &&
          other.isDecaf == this.isDecaf &&
          other.farm == this.farm &&
          other.farmPhotosUrlCover == this.farmPhotosUrlCover &&
          other.washStation == this.washStation &&
          other.retailPrice == this.retailPrice &&
          other.wholesalePrice == this.wholesalePrice &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt);
}

class LocalizedBeansCompanion extends UpdateCompanion<LocalizedBean> {
  final Value<int> id;
  final Value<int?> brandId;
  final Value<String?> countryEmoji;
  final Value<int?> altitudeMin;
  final Value<int?> altitudeMax;
  final Value<String> lotNumber;
  final Value<String> scaScore;
  final Value<double> cupsScore;
  final Value<String> sensoryJson;
  final Value<String> priceJson;
  final Value<String> plantationPhotosUrl;
  final Value<String?> harvestSeason;
  final Value<String?> price;
  final Value<String?> weight;
  final Value<String?> roastDate;
  final Value<String> processingMethodsJson;
  final Value<bool> isPremium;
  final Value<String> detailedProcessMarkdown;
  final Value<String> url;
  final Value<int?> farmerId;
  final Value<bool> isDecaf;
  final Value<String?> farm;
  final Value<String?> farmPhotosUrlCover;
  final Value<String?> washStation;
  final Value<String?> retailPrice;
  final Value<String?> wholesalePrice;
  final Value<bool> isFavorite;
  final Value<DateTime?> createdAt;
  const LocalizedBeansCompanion({
    this.id = const Value.absent(),
    this.brandId = const Value.absent(),
    this.countryEmoji = const Value.absent(),
    this.altitudeMin = const Value.absent(),
    this.altitudeMax = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.scaScore = const Value.absent(),
    this.cupsScore = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.priceJson = const Value.absent(),
    this.plantationPhotosUrl = const Value.absent(),
    this.harvestSeason = const Value.absent(),
    this.price = const Value.absent(),
    this.weight = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.processingMethodsJson = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.detailedProcessMarkdown = const Value.absent(),
    this.url = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.isDecaf = const Value.absent(),
    this.farm = const Value.absent(),
    this.farmPhotosUrlCover = const Value.absent(),
    this.washStation = const Value.absent(),
    this.retailPrice = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocalizedBeansCompanion.insert({
    this.id = const Value.absent(),
    this.brandId = const Value.absent(),
    this.countryEmoji = const Value.absent(),
    this.altitudeMin = const Value.absent(),
    this.altitudeMax = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.scaScore = const Value.absent(),
    this.cupsScore = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.priceJson = const Value.absent(),
    this.plantationPhotosUrl = const Value.absent(),
    this.harvestSeason = const Value.absent(),
    this.price = const Value.absent(),
    this.weight = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.processingMethodsJson = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.detailedProcessMarkdown = const Value.absent(),
    this.url = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.isDecaf = const Value.absent(),
    this.farm = const Value.absent(),
    this.farmPhotosUrlCover = const Value.absent(),
    this.washStation = const Value.absent(),
    this.retailPrice = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<LocalizedBean> custom({
    Expression<int>? id,
    Expression<int>? brandId,
    Expression<String>? countryEmoji,
    Expression<int>? altitudeMin,
    Expression<int>? altitudeMax,
    Expression<String>? lotNumber,
    Expression<String>? scaScore,
    Expression<double>? cupsScore,
    Expression<String>? sensoryJson,
    Expression<String>? priceJson,
    Expression<String>? plantationPhotosUrl,
    Expression<String>? harvestSeason,
    Expression<String>? price,
    Expression<String>? weight,
    Expression<String>? roastDate,
    Expression<String>? processingMethodsJson,
    Expression<bool>? isPremium,
    Expression<String>? detailedProcessMarkdown,
    Expression<String>? url,
    Expression<int>? farmerId,
    Expression<bool>? isDecaf,
    Expression<String>? farm,
    Expression<String>? farmPhotosUrlCover,
    Expression<String>? washStation,
    Expression<String>? retailPrice,
    Expression<String>? wholesalePrice,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brandId != null) 'brand_id': brandId,
      if (countryEmoji != null) 'country_emoji': countryEmoji,
      if (altitudeMin != null) 'altitude_min': altitudeMin,
      if (altitudeMax != null) 'altitude_max': altitudeMax,
      if (lotNumber != null) 'lot_number': lotNumber,
      if (scaScore != null) 'sca_score': scaScore,
      if (cupsScore != null) 'cups_score': cupsScore,
      if (sensoryJson != null) 'sensory_json': sensoryJson,
      if (priceJson != null) 'price_json': priceJson,
      if (plantationPhotosUrl != null)
        'plantation_photos_url': plantationPhotosUrl,
      if (harvestSeason != null) 'harvest_season': harvestSeason,
      if (price != null) 'price': price,
      if (weight != null) 'weight': weight,
      if (roastDate != null) 'roast_date': roastDate,
      if (processingMethodsJson != null)
        'processing_methods_json': processingMethodsJson,
      if (isPremium != null) 'is_premium': isPremium,
      if (detailedProcessMarkdown != null)
        'detailed_process_markdown': detailedProcessMarkdown,
      if (url != null) 'url': url,
      if (farmerId != null) 'farmer_id': farmerId,
      if (isDecaf != null) 'is_decaf': isDecaf,
      if (farm != null) 'farm': farm,
      if (farmPhotosUrlCover != null)
        'farm_photos_url_cover': farmPhotosUrlCover,
      if (washStation != null) 'wash_station': washStation,
      if (retailPrice != null) 'retail_price': retailPrice,
      if (wholesalePrice != null) 'wholesale_price': wholesalePrice,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocalizedBeansCompanion copyWith({
    Value<int>? id,
    Value<int?>? brandId,
    Value<String?>? countryEmoji,
    Value<int?>? altitudeMin,
    Value<int?>? altitudeMax,
    Value<String>? lotNumber,
    Value<String>? scaScore,
    Value<double>? cupsScore,
    Value<String>? sensoryJson,
    Value<String>? priceJson,
    Value<String>? plantationPhotosUrl,
    Value<String?>? harvestSeason,
    Value<String?>? price,
    Value<String?>? weight,
    Value<String?>? roastDate,
    Value<String>? processingMethodsJson,
    Value<bool>? isPremium,
    Value<String>? detailedProcessMarkdown,
    Value<String>? url,
    Value<int?>? farmerId,
    Value<bool>? isDecaf,
    Value<String?>? farm,
    Value<String?>? farmPhotosUrlCover,
    Value<String?>? washStation,
    Value<String?>? retailPrice,
    Value<String?>? wholesalePrice,
    Value<bool>? isFavorite,
    Value<DateTime?>? createdAt,
  }) {
    return LocalizedBeansCompanion(
      id: id ?? this.id,
      brandId: brandId ?? this.brandId,
      countryEmoji: countryEmoji ?? this.countryEmoji,
      altitudeMin: altitudeMin ?? this.altitudeMin,
      altitudeMax: altitudeMax ?? this.altitudeMax,
      lotNumber: lotNumber ?? this.lotNumber,
      scaScore: scaScore ?? this.scaScore,
      cupsScore: cupsScore ?? this.cupsScore,
      sensoryJson: sensoryJson ?? this.sensoryJson,
      priceJson: priceJson ?? this.priceJson,
      plantationPhotosUrl: plantationPhotosUrl ?? this.plantationPhotosUrl,
      harvestSeason: harvestSeason ?? this.harvestSeason,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      roastDate: roastDate ?? this.roastDate,
      processingMethodsJson:
          processingMethodsJson ?? this.processingMethodsJson,
      isPremium: isPremium ?? this.isPremium,
      detailedProcessMarkdown:
          detailedProcessMarkdown ?? this.detailedProcessMarkdown,
      url: url ?? this.url,
      farmerId: farmerId ?? this.farmerId,
      isDecaf: isDecaf ?? this.isDecaf,
      farm: farm ?? this.farm,
      farmPhotosUrlCover: farmPhotosUrlCover ?? this.farmPhotosUrlCover,
      washStation: washStation ?? this.washStation,
      retailPrice: retailPrice ?? this.retailPrice,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brandId.present) {
      map['brand_id'] = Variable<int>(brandId.value);
    }
    if (countryEmoji.present) {
      map['country_emoji'] = Variable<String>(countryEmoji.value);
    }
    if (altitudeMin.present) {
      map['altitude_min'] = Variable<int>(altitudeMin.value);
    }
    if (altitudeMax.present) {
      map['altitude_max'] = Variable<int>(altitudeMax.value);
    }
    if (lotNumber.present) {
      map['lot_number'] = Variable<String>(lotNumber.value);
    }
    if (scaScore.present) {
      map['sca_score'] = Variable<String>(scaScore.value);
    }
    if (cupsScore.present) {
      map['cups_score'] = Variable<double>(cupsScore.value);
    }
    if (sensoryJson.present) {
      map['sensory_json'] = Variable<String>(sensoryJson.value);
    }
    if (priceJson.present) {
      map['price_json'] = Variable<String>(priceJson.value);
    }
    if (plantationPhotosUrl.present) {
      map['plantation_photos_url'] = Variable<String>(
        plantationPhotosUrl.value,
      );
    }
    if (harvestSeason.present) {
      map['harvest_season'] = Variable<String>(harvestSeason.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (weight.present) {
      map['weight'] = Variable<String>(weight.value);
    }
    if (roastDate.present) {
      map['roast_date'] = Variable<String>(roastDate.value);
    }
    if (processingMethodsJson.present) {
      map['processing_methods_json'] = Variable<String>(
        processingMethodsJson.value,
      );
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    if (detailedProcessMarkdown.present) {
      map['detailed_process_markdown'] = Variable<String>(
        detailedProcessMarkdown.value,
      );
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<int>(farmerId.value);
    }
    if (isDecaf.present) {
      map['is_decaf'] = Variable<bool>(isDecaf.value);
    }
    if (farm.present) {
      map['farm'] = Variable<String>(farm.value);
    }
    if (farmPhotosUrlCover.present) {
      map['farm_photos_url_cover'] = Variable<String>(farmPhotosUrlCover.value);
    }
    if (washStation.present) {
      map['wash_station'] = Variable<String>(washStation.value);
    }
    if (retailPrice.present) {
      map['retail_price'] = Variable<String>(retailPrice.value);
    }
    if (wholesalePrice.present) {
      map['wholesale_price'] = Variable<String>(wholesalePrice.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBeansCompanion(')
          ..write('id: $id, ')
          ..write('brandId: $brandId, ')
          ..write('countryEmoji: $countryEmoji, ')
          ..write('altitudeMin: $altitudeMin, ')
          ..write('altitudeMax: $altitudeMax, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('scaScore: $scaScore, ')
          ..write('cupsScore: $cupsScore, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('priceJson: $priceJson, ')
          ..write('plantationPhotosUrl: $plantationPhotosUrl, ')
          ..write('harvestSeason: $harvestSeason, ')
          ..write('price: $price, ')
          ..write('weight: $weight, ')
          ..write('roastDate: $roastDate, ')
          ..write('processingMethodsJson: $processingMethodsJson, ')
          ..write('isPremium: $isPremium, ')
          ..write('detailedProcessMarkdown: $detailedProcessMarkdown, ')
          ..write('url: $url, ')
          ..write('farmerId: $farmerId, ')
          ..write('isDecaf: $isDecaf, ')
          ..write('farm: $farm, ')
          ..write('farmPhotosUrlCover: $farmPhotosUrlCover, ')
          ..write('washStation: $washStation, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LocalizedBeanTranslationsTable extends LocalizedBeanTranslations
    with TableInfo<$LocalizedBeanTranslationsTable, LocalizedBeanTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedBeanTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _beanIdMeta = const VerificationMeta('beanId');
  @override
  late final GeneratedColumn<int> beanId = GeneratedColumn<int>(
    'bean_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES localized_beans (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _varietiesMeta = const VerificationMeta(
    'varieties',
  );
  @override
  late final GeneratedColumn<String> varieties = GeneratedColumn<String>(
    'varieties',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _processMethodMeta = const VerificationMeta(
    'processMethod',
  );
  @override
  late final GeneratedColumn<String> processMethod = GeneratedColumn<String>(
    'process_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmDescriptionMeta = const VerificationMeta(
    'farmDescription',
  );
  @override
  late final GeneratedColumn<String> farmDescription = GeneratedColumn<String>(
    'farm_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastLevelMeta = const VerificationMeta(
    'roastLevel',
  );
  @override
  late final GeneratedColumn<String> roastLevel = GeneratedColumn<String>(
    'roast_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    beanId,
    languageCode,
    country,
    region,
    varieties,
    flavorNotes,
    processMethod,
    description,
    farmDescription,
    roastLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_bean_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedBeanTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bean_id')) {
      context.handle(
        _beanIdMeta,
        beanId.isAcceptableOrUnknown(data['bean_id']!, _beanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beanIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('varieties')) {
      context.handle(
        _varietiesMeta,
        varieties.isAcceptableOrUnknown(data['varieties']!, _varietiesMeta),
      );
    }
    if (data.containsKey('flavor_notes')) {
      context.handle(
        _flavorNotesMeta,
        flavorNotes.isAcceptableOrUnknown(
          data['flavor_notes']!,
          _flavorNotesMeta,
        ),
      );
    }
    if (data.containsKey('process_method')) {
      context.handle(
        _processMethodMeta,
        processMethod.isAcceptableOrUnknown(
          data['process_method']!,
          _processMethodMeta,
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
    if (data.containsKey('roast_level')) {
      context.handle(
        _roastLevelMeta,
        roastLevel.isAcceptableOrUnknown(data['roast_level']!, _roastLevelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {beanId, languageCode};
  @override
  LocalizedBeanTranslation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedBeanTranslation(
      beanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bean_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      varieties: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}varieties'],
      ),
      flavorNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_notes'],
      )!,
      processMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process_method'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      farmDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_description'],
      ),
      roastLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_level'],
      ),
    );
  }

  @override
  $LocalizedBeanTranslationsTable createAlias(String alias) {
    return $LocalizedBeanTranslationsTable(attachedDatabase, alias);
  }
}

class LocalizedBeanTranslation extends DataClass
    implements Insertable<LocalizedBeanTranslation> {
  final int beanId;
  final String languageCode;
  final String? country;
  final String? region;
  final String? varieties;
  final String flavorNotes;
  final String? processMethod;
  final String? description;
  final String? farmDescription;
  final String? roastLevel;
  const LocalizedBeanTranslation({
    required this.beanId,
    required this.languageCode,
    this.country,
    this.region,
    this.varieties,
    required this.flavorNotes,
    this.processMethod,
    this.description,
    this.farmDescription,
    this.roastLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bean_id'] = Variable<int>(beanId);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || varieties != null) {
      map['varieties'] = Variable<String>(varieties);
    }
    map['flavor_notes'] = Variable<String>(flavorNotes);
    if (!nullToAbsent || processMethod != null) {
      map['process_method'] = Variable<String>(processMethod);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || farmDescription != null) {
      map['farm_description'] = Variable<String>(farmDescription);
    }
    if (!nullToAbsent || roastLevel != null) {
      map['roast_level'] = Variable<String>(roastLevel);
    }
    return map;
  }

  LocalizedBeanTranslationsCompanion toCompanion(bool nullToAbsent) {
    return LocalizedBeanTranslationsCompanion(
      beanId: Value(beanId),
      languageCode: Value(languageCode),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      varieties: varieties == null && nullToAbsent
          ? const Value.absent()
          : Value(varieties),
      flavorNotes: Value(flavorNotes),
      processMethod: processMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(processMethod),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      farmDescription: farmDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(farmDescription),
      roastLevel: roastLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(roastLevel),
    );
  }

  factory LocalizedBeanTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedBeanTranslation(
      beanId: serializer.fromJson<int>(json['beanId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      country: serializer.fromJson<String?>(json['country']),
      region: serializer.fromJson<String?>(json['region']),
      varieties: serializer.fromJson<String?>(json['varieties']),
      flavorNotes: serializer.fromJson<String>(json['flavorNotes']),
      processMethod: serializer.fromJson<String?>(json['processMethod']),
      description: serializer.fromJson<String?>(json['description']),
      farmDescription: serializer.fromJson<String?>(json['farmDescription']),
      roastLevel: serializer.fromJson<String?>(json['roastLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'beanId': serializer.toJson<int>(beanId),
      'languageCode': serializer.toJson<String>(languageCode),
      'country': serializer.toJson<String?>(country),
      'region': serializer.toJson<String?>(region),
      'varieties': serializer.toJson<String?>(varieties),
      'flavorNotes': serializer.toJson<String>(flavorNotes),
      'processMethod': serializer.toJson<String?>(processMethod),
      'description': serializer.toJson<String?>(description),
      'farmDescription': serializer.toJson<String?>(farmDescription),
      'roastLevel': serializer.toJson<String?>(roastLevel),
    };
  }

  LocalizedBeanTranslation copyWith({
    int? beanId,
    String? languageCode,
    Value<String?> country = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> varieties = const Value.absent(),
    String? flavorNotes,
    Value<String?> processMethod = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> farmDescription = const Value.absent(),
    Value<String?> roastLevel = const Value.absent(),
  }) => LocalizedBeanTranslation(
    beanId: beanId ?? this.beanId,
    languageCode: languageCode ?? this.languageCode,
    country: country.present ? country.value : this.country,
    region: region.present ? region.value : this.region,
    varieties: varieties.present ? varieties.value : this.varieties,
    flavorNotes: flavorNotes ?? this.flavorNotes,
    processMethod: processMethod.present
        ? processMethod.value
        : this.processMethod,
    description: description.present ? description.value : this.description,
    farmDescription: farmDescription.present
        ? farmDescription.value
        : this.farmDescription,
    roastLevel: roastLevel.present ? roastLevel.value : this.roastLevel,
  );
  LocalizedBeanTranslation copyWithCompanion(
    LocalizedBeanTranslationsCompanion data,
  ) {
    return LocalizedBeanTranslation(
      beanId: data.beanId.present ? data.beanId.value : this.beanId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      country: data.country.present ? data.country.value : this.country,
      region: data.region.present ? data.region.value : this.region,
      varieties: data.varieties.present ? data.varieties.value : this.varieties,
      flavorNotes: data.flavorNotes.present
          ? data.flavorNotes.value
          : this.flavorNotes,
      processMethod: data.processMethod.present
          ? data.processMethod.value
          : this.processMethod,
      description: data.description.present
          ? data.description.value
          : this.description,
      farmDescription: data.farmDescription.present
          ? data.farmDescription.value
          : this.farmDescription,
      roastLevel: data.roastLevel.present
          ? data.roastLevel.value
          : this.roastLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBeanTranslation(')
          ..write('beanId: $beanId, ')
          ..write('languageCode: $languageCode, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('varieties: $varieties, ')
          ..write('flavorNotes: $flavorNotes, ')
          ..write('processMethod: $processMethod, ')
          ..write('description: $description, ')
          ..write('farmDescription: $farmDescription, ')
          ..write('roastLevel: $roastLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    beanId,
    languageCode,
    country,
    region,
    varieties,
    flavorNotes,
    processMethod,
    description,
    farmDescription,
    roastLevel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedBeanTranslation &&
          other.beanId == this.beanId &&
          other.languageCode == this.languageCode &&
          other.country == this.country &&
          other.region == this.region &&
          other.varieties == this.varieties &&
          other.flavorNotes == this.flavorNotes &&
          other.processMethod == this.processMethod &&
          other.description == this.description &&
          other.farmDescription == this.farmDescription &&
          other.roastLevel == this.roastLevel);
}

class LocalizedBeanTranslationsCompanion
    extends UpdateCompanion<LocalizedBeanTranslation> {
  final Value<int> beanId;
  final Value<String> languageCode;
  final Value<String?> country;
  final Value<String?> region;
  final Value<String?> varieties;
  final Value<String> flavorNotes;
  final Value<String?> processMethod;
  final Value<String?> description;
  final Value<String?> farmDescription;
  final Value<String?> roastLevel;
  final Value<int> rowid;
  const LocalizedBeanTranslationsCompanion({
    this.beanId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.varieties = const Value.absent(),
    this.flavorNotes = const Value.absent(),
    this.processMethod = const Value.absent(),
    this.description = const Value.absent(),
    this.farmDescription = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalizedBeanTranslationsCompanion.insert({
    required int beanId,
    required String languageCode,
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.varieties = const Value.absent(),
    this.flavorNotes = const Value.absent(),
    this.processMethod = const Value.absent(),
    this.description = const Value.absent(),
    this.farmDescription = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : beanId = Value(beanId),
       languageCode = Value(languageCode);
  static Insertable<LocalizedBeanTranslation> custom({
    Expression<int>? beanId,
    Expression<String>? languageCode,
    Expression<String>? country,
    Expression<String>? region,
    Expression<String>? varieties,
    Expression<String>? flavorNotes,
    Expression<String>? processMethod,
    Expression<String>? description,
    Expression<String>? farmDescription,
    Expression<String>? roastLevel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (beanId != null) 'bean_id': beanId,
      if (languageCode != null) 'language_code': languageCode,
      if (country != null) 'country': country,
      if (region != null) 'region': region,
      if (varieties != null) 'varieties': varieties,
      if (flavorNotes != null) 'flavor_notes': flavorNotes,
      if (processMethod != null) 'process_method': processMethod,
      if (description != null) 'description': description,
      if (farmDescription != null) 'farm_description': farmDescription,
      if (roastLevel != null) 'roast_level': roastLevel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalizedBeanTranslationsCompanion copyWith({
    Value<int>? beanId,
    Value<String>? languageCode,
    Value<String?>? country,
    Value<String?>? region,
    Value<String?>? varieties,
    Value<String>? flavorNotes,
    Value<String?>? processMethod,
    Value<String?>? description,
    Value<String?>? farmDescription,
    Value<String?>? roastLevel,
    Value<int>? rowid,
  }) {
    return LocalizedBeanTranslationsCompanion(
      beanId: beanId ?? this.beanId,
      languageCode: languageCode ?? this.languageCode,
      country: country ?? this.country,
      region: region ?? this.region,
      varieties: varieties ?? this.varieties,
      flavorNotes: flavorNotes ?? this.flavorNotes,
      processMethod: processMethod ?? this.processMethod,
      description: description ?? this.description,
      farmDescription: farmDescription ?? this.farmDescription,
      roastLevel: roastLevel ?? this.roastLevel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (beanId.present) {
      map['bean_id'] = Variable<int>(beanId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (farmDescription.present) {
      map['farm_description'] = Variable<String>(farmDescription.value);
    }
    if (roastLevel.present) {
      map['roast_level'] = Variable<String>(roastLevel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBeanTranslationsCompanion(')
          ..write('beanId: $beanId, ')
          ..write('languageCode: $languageCode, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('varieties: $varieties, ')
          ..write('flavorNotes: $flavorNotes, ')
          ..write('processMethod: $processMethod, ')
          ..write('description: $description, ')
          ..write('farmDescription: $farmDescription, ')
          ..write('roastLevel: $roastLevel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalizedBrandTranslationsTable extends LocalizedBrandTranslations
    with
        TableInfo<$LocalizedBrandTranslationsTable, LocalizedBrandTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedBrandTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _brandIdMeta = const VerificationMeta(
    'brandId',
  );
  @override
  late final GeneratedColumn<int> brandId = GeneratedColumn<int>(
    'brand_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES localized_brands (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fullDescMeta = const VerificationMeta(
    'fullDesc',
  );
  @override
  late final GeneratedColumn<String> fullDesc = GeneratedColumn<String>(
    'full_desc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    brandId,
    languageCode,
    shortDesc,
    fullDesc,
    location,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_brand_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedBrandTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    } else if (isInserting) {
      context.missing(_brandIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('short_desc')) {
      context.handle(
        _shortDescMeta,
        shortDesc.isAcceptableOrUnknown(data['short_desc']!, _shortDescMeta),
      );
    }
    if (data.containsKey('full_desc')) {
      context.handle(
        _fullDescMeta,
        fullDesc.isAcceptableOrUnknown(data['full_desc']!, _fullDescMeta),
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
  Set<GeneratedColumn> get $primaryKey => {brandId, languageCode};
  @override
  LocalizedBrandTranslation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedBrandTranslation(
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brand_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      shortDesc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_desc'],
      ),
      fullDesc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_desc'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
    );
  }

  @override
  $LocalizedBrandTranslationsTable createAlias(String alias) {
    return $LocalizedBrandTranslationsTable(attachedDatabase, alias);
  }
}

class LocalizedBrandTranslation extends DataClass
    implements Insertable<LocalizedBrandTranslation> {
  final int brandId;
  final String languageCode;
  final String? shortDesc;
  final String? fullDesc;
  final String? location;
  const LocalizedBrandTranslation({
    required this.brandId,
    required this.languageCode,
    this.shortDesc,
    this.fullDesc,
    this.location,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['brand_id'] = Variable<int>(brandId);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || shortDesc != null) {
      map['short_desc'] = Variable<String>(shortDesc);
    }
    if (!nullToAbsent || fullDesc != null) {
      map['full_desc'] = Variable<String>(fullDesc);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    return map;
  }

  LocalizedBrandTranslationsCompanion toCompanion(bool nullToAbsent) {
    return LocalizedBrandTranslationsCompanion(
      brandId: Value(brandId),
      languageCode: Value(languageCode),
      shortDesc: shortDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(shortDesc),
      fullDesc: fullDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(fullDesc),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
    );
  }

  factory LocalizedBrandTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedBrandTranslation(
      brandId: serializer.fromJson<int>(json['brandId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      shortDesc: serializer.fromJson<String?>(json['shortDesc']),
      fullDesc: serializer.fromJson<String?>(json['fullDesc']),
      location: serializer.fromJson<String?>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'brandId': serializer.toJson<int>(brandId),
      'languageCode': serializer.toJson<String>(languageCode),
      'shortDesc': serializer.toJson<String?>(shortDesc),
      'fullDesc': serializer.toJson<String?>(fullDesc),
      'location': serializer.toJson<String?>(location),
    };
  }

  LocalizedBrandTranslation copyWith({
    int? brandId,
    String? languageCode,
    Value<String?> shortDesc = const Value.absent(),
    Value<String?> fullDesc = const Value.absent(),
    Value<String?> location = const Value.absent(),
  }) => LocalizedBrandTranslation(
    brandId: brandId ?? this.brandId,
    languageCode: languageCode ?? this.languageCode,
    shortDesc: shortDesc.present ? shortDesc.value : this.shortDesc,
    fullDesc: fullDesc.present ? fullDesc.value : this.fullDesc,
    location: location.present ? location.value : this.location,
  );
  LocalizedBrandTranslation copyWithCompanion(
    LocalizedBrandTranslationsCompanion data,
  ) {
    return LocalizedBrandTranslation(
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      shortDesc: data.shortDesc.present ? data.shortDesc.value : this.shortDesc,
      fullDesc: data.fullDesc.present ? data.fullDesc.value : this.fullDesc,
      location: data.location.present ? data.location.value : this.location,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBrandTranslation(')
          ..write('brandId: $brandId, ')
          ..write('languageCode: $languageCode, ')
          ..write('shortDesc: $shortDesc, ')
          ..write('fullDesc: $fullDesc, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(brandId, languageCode, shortDesc, fullDesc, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedBrandTranslation &&
          other.brandId == this.brandId &&
          other.languageCode == this.languageCode &&
          other.shortDesc == this.shortDesc &&
          other.fullDesc == this.fullDesc &&
          other.location == this.location);
}

class LocalizedBrandTranslationsCompanion
    extends UpdateCompanion<LocalizedBrandTranslation> {
  final Value<int> brandId;
  final Value<String> languageCode;
  final Value<String?> shortDesc;
  final Value<String?> fullDesc;
  final Value<String?> location;
  final Value<int> rowid;
  const LocalizedBrandTranslationsCompanion({
    this.brandId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.shortDesc = const Value.absent(),
    this.fullDesc = const Value.absent(),
    this.location = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalizedBrandTranslationsCompanion.insert({
    required int brandId,
    required String languageCode,
    this.shortDesc = const Value.absent(),
    this.fullDesc = const Value.absent(),
    this.location = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : brandId = Value(brandId),
       languageCode = Value(languageCode);
  static Insertable<LocalizedBrandTranslation> custom({
    Expression<int>? brandId,
    Expression<String>? languageCode,
    Expression<String>? shortDesc,
    Expression<String>? fullDesc,
    Expression<String>? location,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (brandId != null) 'brand_id': brandId,
      if (languageCode != null) 'language_code': languageCode,
      if (shortDesc != null) 'short_desc': shortDesc,
      if (fullDesc != null) 'full_desc': fullDesc,
      if (location != null) 'location': location,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalizedBrandTranslationsCompanion copyWith({
    Value<int>? brandId,
    Value<String>? languageCode,
    Value<String?>? shortDesc,
    Value<String?>? fullDesc,
    Value<String?>? location,
    Value<int>? rowid,
  }) {
    return LocalizedBrandTranslationsCompanion(
      brandId: brandId ?? this.brandId,
      languageCode: languageCode ?? this.languageCode,
      shortDesc: shortDesc ?? this.shortDesc,
      fullDesc: fullDesc ?? this.fullDesc,
      location: location ?? this.location,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (brandId.present) {
      map['brand_id'] = Variable<int>(brandId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (shortDesc.present) {
      map['short_desc'] = Variable<String>(shortDesc.value);
    }
    if (fullDesc.present) {
      map['full_desc'] = Variable<String>(fullDesc.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBrandTranslationsCompanion(')
          ..write('brandId: $brandId, ')
          ..write('languageCode: $languageCode, ')
          ..write('shortDesc: $shortDesc, ')
          ..write('fullDesc: $fullDesc, ')
          ..write('location: $location, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalizedFarmerTranslationsTable extends LocalizedFarmerTranslations
    with
        TableInfo<
          $LocalizedFarmerTranslationsTable,
          LocalizedFarmerTranslation
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedFarmerTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<int> farmerId = GeneratedColumn<int>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES localized_farmers (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlMeta = const VerificationMeta(
    'descriptionHtml',
  );
  @override
  late final GeneratedColumn<String> descriptionHtml = GeneratedColumn<String>(
    'description_html',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storyMeta = const VerificationMeta('story');
  @override
  late final GeneratedColumn<String> story = GeneratedColumn<String>(
    'story',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    farmerId,
    languageCode,
    name,
    descriptionHtml,
    story,
    region,
    country,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_farmer_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedFarmerTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmerIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('description_html')) {
      context.handle(
        _descriptionHtmlMeta,
        descriptionHtml.isAcceptableOrUnknown(
          data['description_html']!,
          _descriptionHtmlMeta,
        ),
      );
    }
    if (data.containsKey('story')) {
      context.handle(
        _storyMeta,
        story.isAcceptableOrUnknown(data['story']!, _storyMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {farmerId, languageCode};
  @override
  LocalizedFarmerTranslation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedFarmerTranslation(
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}farmer_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      descriptionHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html'],
      ),
      story: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}story'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
    );
  }

  @override
  $LocalizedFarmerTranslationsTable createAlias(String alias) {
    return $LocalizedFarmerTranslationsTable(attachedDatabase, alias);
  }
}

class LocalizedFarmerTranslation extends DataClass
    implements Insertable<LocalizedFarmerTranslation> {
  final int farmerId;
  final String languageCode;
  final String? name;
  final String? descriptionHtml;
  final String? story;
  final String? region;
  final String? country;
  const LocalizedFarmerTranslation({
    required this.farmerId,
    required this.languageCode,
    this.name,
    this.descriptionHtml,
    this.story,
    this.region,
    this.country,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['farmer_id'] = Variable<int>(farmerId);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || descriptionHtml != null) {
      map['description_html'] = Variable<String>(descriptionHtml);
    }
    if (!nullToAbsent || story != null) {
      map['story'] = Variable<String>(story);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    return map;
  }

  LocalizedFarmerTranslationsCompanion toCompanion(bool nullToAbsent) {
    return LocalizedFarmerTranslationsCompanion(
      farmerId: Value(farmerId),
      languageCode: Value(languageCode),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      descriptionHtml: descriptionHtml == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtml),
      story: story == null && nullToAbsent
          ? const Value.absent()
          : Value(story),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
    );
  }

  factory LocalizedFarmerTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedFarmerTranslation(
      farmerId: serializer.fromJson<int>(json['farmerId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String?>(json['name']),
      descriptionHtml: serializer.fromJson<String?>(json['descriptionHtml']),
      story: serializer.fromJson<String?>(json['story']),
      region: serializer.fromJson<String?>(json['region']),
      country: serializer.fromJson<String?>(json['country']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'farmerId': serializer.toJson<int>(farmerId),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String?>(name),
      'descriptionHtml': serializer.toJson<String?>(descriptionHtml),
      'story': serializer.toJson<String?>(story),
      'region': serializer.toJson<String?>(region),
      'country': serializer.toJson<String?>(country),
    };
  }

  LocalizedFarmerTranslation copyWith({
    int? farmerId,
    String? languageCode,
    Value<String?> name = const Value.absent(),
    Value<String?> descriptionHtml = const Value.absent(),
    Value<String?> story = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> country = const Value.absent(),
  }) => LocalizedFarmerTranslation(
    farmerId: farmerId ?? this.farmerId,
    languageCode: languageCode ?? this.languageCode,
    name: name.present ? name.value : this.name,
    descriptionHtml: descriptionHtml.present
        ? descriptionHtml.value
        : this.descriptionHtml,
    story: story.present ? story.value : this.story,
    region: region.present ? region.value : this.region,
    country: country.present ? country.value : this.country,
  );
  LocalizedFarmerTranslation copyWithCompanion(
    LocalizedFarmerTranslationsCompanion data,
  ) {
    return LocalizedFarmerTranslation(
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      name: data.name.present ? data.name.value : this.name,
      descriptionHtml: data.descriptionHtml.present
          ? data.descriptionHtml.value
          : this.descriptionHtml,
      story: data.story.present ? data.story.value : this.story,
      region: data.region.present ? data.region.value : this.region,
      country: data.country.present ? data.country.value : this.country,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmerTranslation(')
          ..write('farmerId: $farmerId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('descriptionHtml: $descriptionHtml, ')
          ..write('story: $story, ')
          ..write('region: $region, ')
          ..write('country: $country')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    farmerId,
    languageCode,
    name,
    descriptionHtml,
    story,
    region,
    country,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedFarmerTranslation &&
          other.farmerId == this.farmerId &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.descriptionHtml == this.descriptionHtml &&
          other.story == this.story &&
          other.region == this.region &&
          other.country == this.country);
}

class LocalizedFarmerTranslationsCompanion
    extends UpdateCompanion<LocalizedFarmerTranslation> {
  final Value<int> farmerId;
  final Value<String> languageCode;
  final Value<String?> name;
  final Value<String?> descriptionHtml;
  final Value<String?> story;
  final Value<String?> region;
  final Value<String?> country;
  final Value<int> rowid;
  const LocalizedFarmerTranslationsCompanion({
    this.farmerId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.descriptionHtml = const Value.absent(),
    this.story = const Value.absent(),
    this.region = const Value.absent(),
    this.country = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalizedFarmerTranslationsCompanion.insert({
    required int farmerId,
    required String languageCode,
    this.name = const Value.absent(),
    this.descriptionHtml = const Value.absent(),
    this.story = const Value.absent(),
    this.region = const Value.absent(),
    this.country = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : farmerId = Value(farmerId),
       languageCode = Value(languageCode);
  static Insertable<LocalizedFarmerTranslation> custom({
    Expression<int>? farmerId,
    Expression<String>? languageCode,
    Expression<String>? name,
    Expression<String>? descriptionHtml,
    Expression<String>? story,
    Expression<String>? region,
    Expression<String>? country,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (farmerId != null) 'farmer_id': farmerId,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (descriptionHtml != null) 'description_html': descriptionHtml,
      if (story != null) 'story': story,
      if (region != null) 'region': region,
      if (country != null) 'country': country,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalizedFarmerTranslationsCompanion copyWith({
    Value<int>? farmerId,
    Value<String>? languageCode,
    Value<String?>? name,
    Value<String?>? descriptionHtml,
    Value<String?>? story,
    Value<String?>? region,
    Value<String?>? country,
    Value<int>? rowid,
  }) {
    return LocalizedFarmerTranslationsCompanion(
      farmerId: farmerId ?? this.farmerId,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      descriptionHtml: descriptionHtml ?? this.descriptionHtml,
      story: story ?? this.story,
      region: region ?? this.region,
      country: country ?? this.country,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (farmerId.present) {
      map['farmer_id'] = Variable<int>(farmerId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (descriptionHtml.present) {
      map['description_html'] = Variable<String>(descriptionHtml.value);
    }
    if (story.present) {
      map['story'] = Variable<String>(story.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmerTranslationsCompanion(')
          ..write('farmerId: $farmerId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('descriptionHtml: $descriptionHtml, ')
          ..write('story: $story, ')
          ..write('region: $region, ')
          ..write('country: $country, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SphereRegionsTable extends SphereRegions
    with TableInfo<$SphereRegionsTable, SphereRegion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SphereRegionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markerColorMeta = const VerificationMeta(
    'markerColor',
  );
  @override
  late final GeneratedColumn<String> markerColor = GeneratedColumn<String>(
    'marker_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#C8A96E'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    latitude,
    longitude,
    markerColor,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sphere_regions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SphereRegion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('marker_color')) {
      context.handle(
        _markerColorMeta,
        markerColor.isAcceptableOrUnknown(
          data['marker_color']!,
          _markerColorMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SphereRegion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SphereRegion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      markerColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marker_color'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $SphereRegionsTable createAlias(String alias) {
    return $SphereRegionsTable(attachedDatabase, alias);
  }
}

class SphereRegion extends DataClass implements Insertable<SphereRegion> {
  final String id;
  final String key;
  final double latitude;
  final double longitude;
  final String markerColor;
  final bool isActive;
  final DateTime? createdAt;
  const SphereRegion({
    required this.id,
    required this.key,
    required this.latitude,
    required this.longitude,
    required this.markerColor,
    required this.isActive,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['key'] = Variable<String>(key);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['marker_color'] = Variable<String>(markerColor);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  SphereRegionsCompanion toCompanion(bool nullToAbsent) {
    return SphereRegionsCompanion(
      id: Value(id),
      key: Value(key),
      latitude: Value(latitude),
      longitude: Value(longitude),
      markerColor: Value(markerColor),
      isActive: Value(isActive),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory SphereRegion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SphereRegion(
      id: serializer.fromJson<String>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      markerColor: serializer.fromJson<String>(json['markerColor']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'key': serializer.toJson<String>(key),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'markerColor': serializer.toJson<String>(markerColor),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  SphereRegion copyWith({
    String? id,
    String? key,
    double? latitude,
    double? longitude,
    String? markerColor,
    bool? isActive,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => SphereRegion(
    id: id ?? this.id,
    key: key ?? this.key,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    markerColor: markerColor ?? this.markerColor,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  SphereRegion copyWithCompanion(SphereRegionsCompanion data) {
    return SphereRegion(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      markerColor: data.markerColor.present
          ? data.markerColor.value
          : this.markerColor,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SphereRegion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('markerColor: $markerColor, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    latitude,
    longitude,
    markerColor,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SphereRegion &&
          other.id == this.id &&
          other.key == this.key &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.markerColor == this.markerColor &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class SphereRegionsCompanion extends UpdateCompanion<SphereRegion> {
  final Value<String> id;
  final Value<String> key;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> markerColor;
  final Value<bool> isActive;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const SphereRegionsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.markerColor = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SphereRegionsCompanion.insert({
    required String id,
    required String key,
    required double latitude,
    required double longitude,
    this.markerColor = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       key = Value(key),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<SphereRegion> custom({
    Expression<String>? id,
    Expression<String>? key,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? markerColor,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (markerColor != null) 'marker_color': markerColor,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SphereRegionsCompanion copyWith({
    Value<String>? id,
    Value<String>? key,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? markerColor,
    Value<bool>? isActive,
    Value<DateTime?>? createdAt,
    Value<int>? rowid,
  }) {
    return SphereRegionsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      markerColor: markerColor ?? this.markerColor,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (markerColor.present) {
      map['marker_color'] = Variable<String>(markerColor.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SphereRegionsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('markerColor: $markerColor, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SphereRegionTranslationsTable extends SphereRegionTranslations
    with TableInfo<$SphereRegionTranslationsTable, SphereRegionTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SphereRegionTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _regionIdMeta = const VerificationMeta(
    'regionId',
  );
  @override
  late final GeneratedColumn<String> regionId = GeneratedColumn<String>(
    'region_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sphere_regions (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    regionId,
    languageCode,
    name,
    description,
    flavorProfile,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sphere_region_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SphereRegionTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('region_id')) {
      context.handle(
        _regionIdMeta,
        regionId.isAcceptableOrUnknown(data['region_id']!, _regionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_regionIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
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
    }
    if (data.containsKey('flavor_profile')) {
      context.handle(
        _flavorProfileMeta,
        flavorProfile.isAcceptableOrUnknown(
          data['flavor_profile']!,
          _flavorProfileMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {regionId, languageCode};
  @override
  SphereRegionTranslation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SphereRegionTranslation(
      regionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      flavorProfile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_profile'],
      )!,
    );
  }

  @override
  $SphereRegionTranslationsTable createAlias(String alias) {
    return $SphereRegionTranslationsTable(attachedDatabase, alias);
  }
}

class SphereRegionTranslation extends DataClass
    implements Insertable<SphereRegionTranslation> {
  final String regionId;
  final String languageCode;
  final String name;
  final String? description;
  final String flavorProfile;
  const SphereRegionTranslation({
    required this.regionId,
    required this.languageCode,
    required this.name,
    this.description,
    required this.flavorProfile,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['region_id'] = Variable<String>(regionId);
    map['language_code'] = Variable<String>(languageCode);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['flavor_profile'] = Variable<String>(flavorProfile);
    return map;
  }

  SphereRegionTranslationsCompanion toCompanion(bool nullToAbsent) {
    return SphereRegionTranslationsCompanion(
      regionId: Value(regionId),
      languageCode: Value(languageCode),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      flavorProfile: Value(flavorProfile),
    );
  }

  factory SphereRegionTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SphereRegionTranslation(
      regionId: serializer.fromJson<String>(json['regionId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      flavorProfile: serializer.fromJson<String>(json['flavorProfile']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'regionId': serializer.toJson<String>(regionId),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'flavorProfile': serializer.toJson<String>(flavorProfile),
    };
  }

  SphereRegionTranslation copyWith({
    String? regionId,
    String? languageCode,
    String? name,
    Value<String?> description = const Value.absent(),
    String? flavorProfile,
  }) => SphereRegionTranslation(
    regionId: regionId ?? this.regionId,
    languageCode: languageCode ?? this.languageCode,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    flavorProfile: flavorProfile ?? this.flavorProfile,
  );
  SphereRegionTranslation copyWithCompanion(
    SphereRegionTranslationsCompanion data,
  ) {
    return SphereRegionTranslation(
      regionId: data.regionId.present ? data.regionId.value : this.regionId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      flavorProfile: data.flavorProfile.present
          ? data.flavorProfile.value
          : this.flavorProfile,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SphereRegionTranslation(')
          ..write('regionId: $regionId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('flavorProfile: $flavorProfile')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(regionId, languageCode, name, description, flavorProfile);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SphereRegionTranslation &&
          other.regionId == this.regionId &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.description == this.description &&
          other.flavorProfile == this.flavorProfile);
}

class SphereRegionTranslationsCompanion
    extends UpdateCompanion<SphereRegionTranslation> {
  final Value<String> regionId;
  final Value<String> languageCode;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> flavorProfile;
  final Value<int> rowid;
  const SphereRegionTranslationsCompanion({
    this.regionId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SphereRegionTranslationsCompanion.insert({
    required String regionId,
    required String languageCode,
    required String name,
    this.description = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : regionId = Value(regionId),
       languageCode = Value(languageCode),
       name = Value(name);
  static Insertable<SphereRegionTranslation> custom({
    Expression<String>? regionId,
    Expression<String>? languageCode,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? flavorProfile,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (regionId != null) 'region_id': regionId,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (flavorProfile != null) 'flavor_profile': flavorProfile,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SphereRegionTranslationsCompanion copyWith({
    Value<String>? regionId,
    Value<String>? languageCode,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? flavorProfile,
    Value<int>? rowid,
  }) {
    return SphereRegionTranslationsCompanion(
      regionId: regionId ?? this.regionId,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      description: description ?? this.description,
      flavorProfile: flavorProfile ?? this.flavorProfile,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (regionId.present) {
      map['region_id'] = Variable<String>(regionId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (flavorProfile.present) {
      map['flavor_profile'] = Variable<String>(flavorProfile.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SphereRegionTranslationsCompanion(')
          ..write('regionId: $regionId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('flavorProfile: $flavorProfile, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _flagUrlMeta = const VerificationMeta(
    'flagUrl',
  );
  @override
  late final GeneratedColumn<String> flagUrl = GeneratedColumn<String>(
    'flag_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  @override
  List<GeneratedColumn> get $columns => [id, imageUrl, flagUrl, readTimeMin];
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
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('flag_url')) {
      context.handle(
        _flagUrlMeta,
        flagUrl.isAcceptableOrUnknown(data['flag_url']!, _flagUrlMeta),
      );
    }
    if (data.containsKey('read_time_min')) {
      context.handle(
        _readTimeMinMeta,
        readTimeMin.isAcceptableOrUnknown(
          data['read_time_min']!,
          _readTimeMinMeta,
        ),
      );
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
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      flagUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flag_url'],
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
  final String imageUrl;
  final String flagUrl;
  final int readTimeMin;
  const SpecialtyArticle({
    required this.id,
    required this.imageUrl,
    required this.flagUrl,
    required this.readTimeMin,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['flag_url'] = Variable<String>(flagUrl);
    map['read_time_min'] = Variable<int>(readTimeMin);
    return map;
  }

  SpecialtyArticlesCompanion toCompanion(bool nullToAbsent) {
    return SpecialtyArticlesCompanion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      flagUrl: Value(flagUrl),
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
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      flagUrl: serializer.fromJson<String>(json['flagUrl']),
      readTimeMin: serializer.fromJson<int>(json['readTimeMin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'flagUrl': serializer.toJson<String>(flagUrl),
      'readTimeMin': serializer.toJson<int>(readTimeMin),
    };
  }

  SpecialtyArticle copyWith({
    int? id,
    String? imageUrl,
    String? flagUrl,
    int? readTimeMin,
  }) => SpecialtyArticle(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    flagUrl: flagUrl ?? this.flagUrl,
    readTimeMin: readTimeMin ?? this.readTimeMin,
  );
  SpecialtyArticle copyWithCompanion(SpecialtyArticlesCompanion data) {
    return SpecialtyArticle(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      flagUrl: data.flagUrl.present ? data.flagUrl.value : this.flagUrl,
      readTimeMin: data.readTimeMin.present
          ? data.readTimeMin.value
          : this.readTimeMin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticle(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('readTimeMin: $readTimeMin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imageUrl, flagUrl, readTimeMin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecialtyArticle &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.flagUrl == this.flagUrl &&
          other.readTimeMin == this.readTimeMin);
}

class SpecialtyArticlesCompanion extends UpdateCompanion<SpecialtyArticle> {
  final Value<int> id;
  final Value<String> imageUrl;
  final Value<String> flagUrl;
  final Value<int> readTimeMin;
  const SpecialtyArticlesCompanion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.readTimeMin = const Value.absent(),
  });
  SpecialtyArticlesCompanion.insert({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.readTimeMin = const Value.absent(),
  });
  static Insertable<SpecialtyArticle> custom({
    Expression<int>? id,
    Expression<String>? imageUrl,
    Expression<String>? flagUrl,
    Expression<int>? readTimeMin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (flagUrl != null) 'flag_url': flagUrl,
      if (readTimeMin != null) 'read_time_min': readTimeMin,
    });
  }

  SpecialtyArticlesCompanion copyWith({
    Value<int>? id,
    Value<String>? imageUrl,
    Value<String>? flagUrl,
    Value<int>? readTimeMin,
  }) {
    return SpecialtyArticlesCompanion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      flagUrl: flagUrl ?? this.flagUrl,
      readTimeMin: readTimeMin ?? this.readTimeMin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (flagUrl.present) {
      map['flag_url'] = Variable<String>(flagUrl.value);
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
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('readTimeMin: $readTimeMin')
          ..write(')'))
        .toString();
  }
}

class $SpecialtyArticleTranslationsTable extends SpecialtyArticleTranslations
    with
        TableInfo<
          $SpecialtyArticleTranslationsTable,
          SpecialtyArticleTranslation
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpecialtyArticleTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<int> articleId = GeneratedColumn<int>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES specialty_articles (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlMeta = const VerificationMeta(
    'contentHtml',
  );
  @override
  late final GeneratedColumn<String> contentHtml = GeneratedColumn<String>(
    'content_html',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    articleId,
    languageCode,
    title,
    subtitle,
    contentHtml,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'specialty_article_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpecialtyArticleTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    }
    if (data.containsKey('content_html')) {
      context.handle(
        _contentHtmlMeta,
        contentHtml.isAcceptableOrUnknown(
          data['content_html']!,
          _contentHtmlMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {articleId, languageCode};
  @override
  SpecialtyArticleTranslation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpecialtyArticleTranslation(
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}article_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      ),
      contentHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html'],
      ),
    );
  }

  @override
  $SpecialtyArticleTranslationsTable createAlias(String alias) {
    return $SpecialtyArticleTranslationsTable(attachedDatabase, alias);
  }
}

class SpecialtyArticleTranslation extends DataClass
    implements Insertable<SpecialtyArticleTranslation> {
  final int articleId;
  final String languageCode;
  final String? title;
  final String? subtitle;
  final String? contentHtml;
  const SpecialtyArticleTranslation({
    required this.articleId,
    required this.languageCode,
    this.title,
    this.subtitle,
    this.contentHtml,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['article_id'] = Variable<int>(articleId);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || contentHtml != null) {
      map['content_html'] = Variable<String>(contentHtml);
    }
    return map;
  }

  SpecialtyArticleTranslationsCompanion toCompanion(bool nullToAbsent) {
    return SpecialtyArticleTranslationsCompanion(
      articleId: Value(articleId),
      languageCode: Value(languageCode),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      contentHtml: contentHtml == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtml),
    );
  }

  factory SpecialtyArticleTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecialtyArticleTranslation(
      articleId: serializer.fromJson<int>(json['articleId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      title: serializer.fromJson<String?>(json['title']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      contentHtml: serializer.fromJson<String?>(json['contentHtml']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'articleId': serializer.toJson<int>(articleId),
      'languageCode': serializer.toJson<String>(languageCode),
      'title': serializer.toJson<String?>(title),
      'subtitle': serializer.toJson<String?>(subtitle),
      'contentHtml': serializer.toJson<String?>(contentHtml),
    };
  }

  SpecialtyArticleTranslation copyWith({
    int? articleId,
    String? languageCode,
    Value<String?> title = const Value.absent(),
    Value<String?> subtitle = const Value.absent(),
    Value<String?> contentHtml = const Value.absent(),
  }) => SpecialtyArticleTranslation(
    articleId: articleId ?? this.articleId,
    languageCode: languageCode ?? this.languageCode,
    title: title.present ? title.value : this.title,
    subtitle: subtitle.present ? subtitle.value : this.subtitle,
    contentHtml: contentHtml.present ? contentHtml.value : this.contentHtml,
  );
  SpecialtyArticleTranslation copyWithCompanion(
    SpecialtyArticleTranslationsCompanion data,
  ) {
    return SpecialtyArticleTranslation(
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      title: data.title.present ? data.title.value : this.title,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      contentHtml: data.contentHtml.present
          ? data.contentHtml.value
          : this.contentHtml,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticleTranslation(')
          ..write('articleId: $articleId, ')
          ..write('languageCode: $languageCode, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('contentHtml: $contentHtml')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(articleId, languageCode, title, subtitle, contentHtml);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecialtyArticleTranslation &&
          other.articleId == this.articleId &&
          other.languageCode == this.languageCode &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.contentHtml == this.contentHtml);
}

class SpecialtyArticleTranslationsCompanion
    extends UpdateCompanion<SpecialtyArticleTranslation> {
  final Value<int> articleId;
  final Value<String> languageCode;
  final Value<String?> title;
  final Value<String?> subtitle;
  final Value<String?> contentHtml;
  final Value<int> rowid;
  const SpecialtyArticleTranslationsCompanion({
    this.articleId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpecialtyArticleTranslationsCompanion.insert({
    required int articleId,
    required String languageCode,
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : articleId = Value(articleId),
       languageCode = Value(languageCode);
  static Insertable<SpecialtyArticleTranslation> custom({
    Expression<int>? articleId,
    Expression<String>? languageCode,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? contentHtml,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (articleId != null) 'article_id': articleId,
      if (languageCode != null) 'language_code': languageCode,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (contentHtml != null) 'content_html': contentHtml,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpecialtyArticleTranslationsCompanion copyWith({
    Value<int>? articleId,
    Value<String>? languageCode,
    Value<String?>? title,
    Value<String?>? subtitle,
    Value<String?>? contentHtml,
    Value<int>? rowid,
  }) {
    return SpecialtyArticleTranslationsCompanion(
      articleId: articleId ?? this.articleId,
      languageCode: languageCode ?? this.languageCode,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      contentHtml: contentHtml ?? this.contentHtml,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (articleId.present) {
      map['article_id'] = Variable<int>(articleId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticleTranslationsCompanion(')
          ..write('articleId: $articleId, ')
          ..write('languageCode: $languageCode, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _roasteryNameMeta = const VerificationMeta(
    'roasteryName',
  );
  @override
  late final GeneratedColumn<String> roasteryName = GeneratedColumn<String>(
    'roastery_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roasteryCountryMeta = const VerificationMeta(
    'roasteryCountry',
  );
  @override
  late final GeneratedColumn<String> roasteryCountry = GeneratedColumn<String>(
    'roastery_country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
      'REFERENCES localized_brands (id)',
    ),
  );
  static const VerificationMeta _coffeeNameMeta = const VerificationMeta(
    'coffeeName',
  );
  @override
  late final GeneratedColumn<String> coffeeName = GeneratedColumn<String>(
    'coffee_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originCountryMeta = const VerificationMeta(
    'originCountry',
  );
  @override
  late final GeneratedColumn<String> originCountry = GeneratedColumn<String>(
    'origin_country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMeta = const VerificationMeta(
    'altitude',
  );
  @override
  late final GeneratedColumn<String> altitude = GeneratedColumn<String>(
    'altitude',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processMeta = const VerificationMeta(
    'process',
  );
  @override
  late final GeneratedColumn<String> process = GeneratedColumn<String>(
    'process',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastLevelMeta = const VerificationMeta(
    'roastLevel',
  );
  @override
  late final GeneratedColumn<String> roastLevel = GeneratedColumn<String>(
    'roast_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastDateMeta = const VerificationMeta(
    'roastDate',
  );
  @override
  late final GeneratedColumn<DateTime> roastDate = GeneratedColumn<DateTime>(
    'roast_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<String> weight = GeneratedColumn<String>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lotNumberMeta = const VerificationMeta(
    'lotNumber',
  );
  @override
  late final GeneratedColumn<String> lotNumber = GeneratedColumn<String>(
    'lot_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDecafMeta = const VerificationMeta(
    'isDecaf',
  );
  @override
  late final GeneratedColumn<bool> isDecaf = GeneratedColumn<bool>(
    'is_decaf',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_decaf" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _farmMeta = const VerificationMeta('farm');
  @override
  late final GeneratedColumn<String> farm = GeneratedColumn<String>(
    'farm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _washStationMeta = const VerificationMeta(
    'washStation',
  );
  @override
  late final GeneratedColumn<String> washStation = GeneratedColumn<String>(
    'wash_station',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmerMeta = const VerificationMeta('farmer');
  @override
  late final GeneratedColumn<String> farmer = GeneratedColumn<String>(
    'farmer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _varietiesMeta = const VerificationMeta(
    'varieties',
  );
  @override
  late final GeneratedColumn<String> varieties = GeneratedColumn<String>(
    'varieties',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flavorProfileMeta = const VerificationMeta(
    'flavorProfile',
  );
  @override
  late final GeneratedColumn<String> flavorProfile = GeneratedColumn<String>(
    'flavor_profile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scaScoreMeta = const VerificationMeta(
    'scaScore',
  );
  @override
  late final GeneratedColumn<String> scaScore = GeneratedColumn<String>(
    'sca_score',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retailPriceMeta = const VerificationMeta(
    'retailPrice',
  );
  @override
  late final GeneratedColumn<String> retailPrice = GeneratedColumn<String>(
    'retail_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wholesalePriceMeta = const VerificationMeta(
    'wholesalePrice',
  );
  @override
  late final GeneratedColumn<String> wholesalePrice = GeneratedColumn<String>(
    'wholesale_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _priceJsonMeta = const VerificationMeta(
    'priceJson',
  );
  @override
  late final GeneratedColumn<String> priceJson = GeneratedColumn<String>(
    'price_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _isGroundMeta = const VerificationMeta(
    'isGround',
  );
  @override
  late final GeneratedColumn<bool> isGround = GeneratedColumn<bool>(
    'is_ground',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_ground" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isOpenMeta = const VerificationMeta('isOpen');
  @override
  late final GeneratedColumn<bool> isOpen = GeneratedColumn<bool>(
    'is_open',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_open" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedLocalMeta = const VerificationMeta(
    'isDeletedLocal',
  );
  @override
  late final GeneratedColumn<bool> isDeletedLocal = GeneratedColumn<bool>(
    'is_deleted_local',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted_local" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    roasteryName,
    roasteryCountry,
    brandId,
    coffeeName,
    originCountry,
    region,
    altitude,
    process,
    roastLevel,
    roastDate,
    openedAt,
    weight,
    lotNumber,
    isDecaf,
    farm,
    washStation,
    farmer,
    varieties,
    flavorProfile,
    scaScore,
    retailPrice,
    wholesalePrice,
    sensoryJson,
    priceJson,
    isGround,
    isOpen,
    isFavorite,
    isArchived,
    isSynced,
    imageUrl,
    isDeletedLocal,
    createdAt,
    updatedAt,
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
    if (data.containsKey('roastery_name')) {
      context.handle(
        _roasteryNameMeta,
        roasteryName.isAcceptableOrUnknown(
          data['roastery_name']!,
          _roasteryNameMeta,
        ),
      );
    }
    if (data.containsKey('roastery_country')) {
      context.handle(
        _roasteryCountryMeta,
        roasteryCountry.isAcceptableOrUnknown(
          data['roastery_country']!,
          _roasteryCountryMeta,
        ),
      );
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    }
    if (data.containsKey('coffee_name')) {
      context.handle(
        _coffeeNameMeta,
        coffeeName.isAcceptableOrUnknown(data['coffee_name']!, _coffeeNameMeta),
      );
    }
    if (data.containsKey('origin_country')) {
      context.handle(
        _originCountryMeta,
        originCountry.isAcceptableOrUnknown(
          data['origin_country']!,
          _originCountryMeta,
        ),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('altitude')) {
      context.handle(
        _altitudeMeta,
        altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta),
      );
    }
    if (data.containsKey('process')) {
      context.handle(
        _processMeta,
        process.isAcceptableOrUnknown(data['process']!, _processMeta),
      );
    }
    if (data.containsKey('roast_level')) {
      context.handle(
        _roastLevelMeta,
        roastLevel.isAcceptableOrUnknown(data['roast_level']!, _roastLevelMeta),
      );
    }
    if (data.containsKey('roast_date')) {
      context.handle(
        _roastDateMeta,
        roastDate.isAcceptableOrUnknown(data['roast_date']!, _roastDateMeta),
      );
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('lot_number')) {
      context.handle(
        _lotNumberMeta,
        lotNumber.isAcceptableOrUnknown(data['lot_number']!, _lotNumberMeta),
      );
    }
    if (data.containsKey('is_decaf')) {
      context.handle(
        _isDecafMeta,
        isDecaf.isAcceptableOrUnknown(data['is_decaf']!, _isDecafMeta),
      );
    }
    if (data.containsKey('farm')) {
      context.handle(
        _farmMeta,
        farm.isAcceptableOrUnknown(data['farm']!, _farmMeta),
      );
    }
    if (data.containsKey('wash_station')) {
      context.handle(
        _washStationMeta,
        washStation.isAcceptableOrUnknown(
          data['wash_station']!,
          _washStationMeta,
        ),
      );
    }
    if (data.containsKey('farmer')) {
      context.handle(
        _farmerMeta,
        farmer.isAcceptableOrUnknown(data['farmer']!, _farmerMeta),
      );
    }
    if (data.containsKey('varieties')) {
      context.handle(
        _varietiesMeta,
        varieties.isAcceptableOrUnknown(data['varieties']!, _varietiesMeta),
      );
    }
    if (data.containsKey('flavor_profile')) {
      context.handle(
        _flavorProfileMeta,
        flavorProfile.isAcceptableOrUnknown(
          data['flavor_profile']!,
          _flavorProfileMeta,
        ),
      );
    }
    if (data.containsKey('sca_score')) {
      context.handle(
        _scaScoreMeta,
        scaScore.isAcceptableOrUnknown(data['sca_score']!, _scaScoreMeta),
      );
    }
    if (data.containsKey('retail_price')) {
      context.handle(
        _retailPriceMeta,
        retailPrice.isAcceptableOrUnknown(
          data['retail_price']!,
          _retailPriceMeta,
        ),
      );
    }
    if (data.containsKey('wholesale_price')) {
      context.handle(
        _wholesalePriceMeta,
        wholesalePrice.isAcceptableOrUnknown(
          data['wholesale_price']!,
          _wholesalePriceMeta,
        ),
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
    if (data.containsKey('price_json')) {
      context.handle(
        _priceJsonMeta,
        priceJson.isAcceptableOrUnknown(data['price_json']!, _priceJsonMeta),
      );
    }
    if (data.containsKey('is_ground')) {
      context.handle(
        _isGroundMeta,
        isGround.isAcceptableOrUnknown(data['is_ground']!, _isGroundMeta),
      );
    }
    if (data.containsKey('is_open')) {
      context.handle(
        _isOpenMeta,
        isOpen.isAcceptableOrUnknown(data['is_open']!, _isOpenMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('is_deleted_local')) {
      context.handle(
        _isDeletedLocalMeta,
        isDeletedLocal.isAcceptableOrUnknown(
          data['is_deleted_local']!,
          _isDeletedLocalMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
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
      roasteryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roastery_name'],
      ),
      roasteryCountry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roastery_country'],
      ),
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brand_id'],
      ),
      coffeeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_name'],
      ),
      originCountry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_country'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      altitude: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}altitude'],
      ),
      process: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process'],
      ),
      roastLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_level'],
      ),
      roastDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}roast_date'],
      ),
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weight'],
      ),
      lotNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_number'],
      ),
      isDecaf: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_decaf'],
      )!,
      farm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm'],
      ),
      washStation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wash_station'],
      ),
      farmer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer'],
      ),
      varieties: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}varieties'],
      ),
      flavorProfile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_profile'],
      ),
      scaScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sca_score'],
      ),
      retailPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}retail_price'],
      ),
      wholesalePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wholesale_price'],
      ),
      sensoryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensory_json'],
      )!,
      priceJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_json'],
      )!,
      isGround: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_ground'],
      )!,
      isOpen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_open'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      isDeletedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted_local'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
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
  final String? roasteryName;
  final String? roasteryCountry;
  final int? brandId;
  final String? coffeeName;
  final String? originCountry;
  final String? region;
  final String? altitude;
  final String? process;
  final String? roastLevel;
  final DateTime? roastDate;
  final DateTime? openedAt;
  final String? weight;
  final String? lotNumber;
  final bool isDecaf;
  final String? farm;
  final String? washStation;
  final String? farmer;
  final String? varieties;
  final String? flavorProfile;
  final String? scaScore;
  final String? retailPrice;
  final String? wholesalePrice;
  final String sensoryJson;
  final String priceJson;
  final bool isGround;
  final bool isOpen;
  final bool isFavorite;
  final bool isArchived;
  final bool isSynced;
  final String? imageUrl;
  final bool isDeletedLocal;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const CoffeeLot({
    required this.id,
    required this.userId,
    this.roasteryName,
    this.roasteryCountry,
    this.brandId,
    this.coffeeName,
    this.originCountry,
    this.region,
    this.altitude,
    this.process,
    this.roastLevel,
    this.roastDate,
    this.openedAt,
    this.weight,
    this.lotNumber,
    required this.isDecaf,
    this.farm,
    this.washStation,
    this.farmer,
    this.varieties,
    this.flavorProfile,
    this.scaScore,
    this.retailPrice,
    this.wholesalePrice,
    required this.sensoryJson,
    required this.priceJson,
    required this.isGround,
    required this.isOpen,
    required this.isFavorite,
    required this.isArchived,
    required this.isSynced,
    this.imageUrl,
    required this.isDeletedLocal,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || roasteryName != null) {
      map['roastery_name'] = Variable<String>(roasteryName);
    }
    if (!nullToAbsent || roasteryCountry != null) {
      map['roastery_country'] = Variable<String>(roasteryCountry);
    }
    if (!nullToAbsent || brandId != null) {
      map['brand_id'] = Variable<int>(brandId);
    }
    if (!nullToAbsent || coffeeName != null) {
      map['coffee_name'] = Variable<String>(coffeeName);
    }
    if (!nullToAbsent || originCountry != null) {
      map['origin_country'] = Variable<String>(originCountry);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<String>(altitude);
    }
    if (!nullToAbsent || process != null) {
      map['process'] = Variable<String>(process);
    }
    if (!nullToAbsent || roastLevel != null) {
      map['roast_level'] = Variable<String>(roastLevel);
    }
    if (!nullToAbsent || roastDate != null) {
      map['roast_date'] = Variable<DateTime>(roastDate);
    }
    if (!nullToAbsent || openedAt != null) {
      map['opened_at'] = Variable<DateTime>(openedAt);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<String>(weight);
    }
    if (!nullToAbsent || lotNumber != null) {
      map['lot_number'] = Variable<String>(lotNumber);
    }
    map['is_decaf'] = Variable<bool>(isDecaf);
    if (!nullToAbsent || farm != null) {
      map['farm'] = Variable<String>(farm);
    }
    if (!nullToAbsent || washStation != null) {
      map['wash_station'] = Variable<String>(washStation);
    }
    if (!nullToAbsent || farmer != null) {
      map['farmer'] = Variable<String>(farmer);
    }
    if (!nullToAbsent || varieties != null) {
      map['varieties'] = Variable<String>(varieties);
    }
    if (!nullToAbsent || flavorProfile != null) {
      map['flavor_profile'] = Variable<String>(flavorProfile);
    }
    if (!nullToAbsent || scaScore != null) {
      map['sca_score'] = Variable<String>(scaScore);
    }
    if (!nullToAbsent || retailPrice != null) {
      map['retail_price'] = Variable<String>(retailPrice);
    }
    if (!nullToAbsent || wholesalePrice != null) {
      map['wholesale_price'] = Variable<String>(wholesalePrice);
    }
    map['sensory_json'] = Variable<String>(sensoryJson);
    map['price_json'] = Variable<String>(priceJson);
    map['is_ground'] = Variable<bool>(isGround);
    map['is_open'] = Variable<bool>(isOpen);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['is_deleted_local'] = Variable<bool>(isDeletedLocal);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CoffeeLotsCompanion toCompanion(bool nullToAbsent) {
    return CoffeeLotsCompanion(
      id: Value(id),
      userId: Value(userId),
      roasteryName: roasteryName == null && nullToAbsent
          ? const Value.absent()
          : Value(roasteryName),
      roasteryCountry: roasteryCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(roasteryCountry),
      brandId: brandId == null && nullToAbsent
          ? const Value.absent()
          : Value(brandId),
      coffeeName: coffeeName == null && nullToAbsent
          ? const Value.absent()
          : Value(coffeeName),
      originCountry: originCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(originCountry),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      process: process == null && nullToAbsent
          ? const Value.absent()
          : Value(process),
      roastLevel: roastLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(roastLevel),
      roastDate: roastDate == null && nullToAbsent
          ? const Value.absent()
          : Value(roastDate),
      openedAt: openedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(openedAt),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      lotNumber: lotNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(lotNumber),
      isDecaf: Value(isDecaf),
      farm: farm == null && nullToAbsent ? const Value.absent() : Value(farm),
      washStation: washStation == null && nullToAbsent
          ? const Value.absent()
          : Value(washStation),
      farmer: farmer == null && nullToAbsent
          ? const Value.absent()
          : Value(farmer),
      varieties: varieties == null && nullToAbsent
          ? const Value.absent()
          : Value(varieties),
      flavorProfile: flavorProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(flavorProfile),
      scaScore: scaScore == null && nullToAbsent
          ? const Value.absent()
          : Value(scaScore),
      retailPrice: retailPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(retailPrice),
      wholesalePrice: wholesalePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(wholesalePrice),
      sensoryJson: Value(sensoryJson),
      priceJson: Value(priceJson),
      isGround: Value(isGround),
      isOpen: Value(isOpen),
      isFavorite: Value(isFavorite),
      isArchived: Value(isArchived),
      isSynced: Value(isSynced),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      isDeletedLocal: Value(isDeletedLocal),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
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
      roasteryName: serializer.fromJson<String?>(json['roasteryName']),
      roasteryCountry: serializer.fromJson<String?>(json['roasteryCountry']),
      brandId: serializer.fromJson<int?>(json['brandId']),
      coffeeName: serializer.fromJson<String?>(json['coffeeName']),
      originCountry: serializer.fromJson<String?>(json['originCountry']),
      region: serializer.fromJson<String?>(json['region']),
      altitude: serializer.fromJson<String?>(json['altitude']),
      process: serializer.fromJson<String?>(json['process']),
      roastLevel: serializer.fromJson<String?>(json['roastLevel']),
      roastDate: serializer.fromJson<DateTime?>(json['roastDate']),
      openedAt: serializer.fromJson<DateTime?>(json['openedAt']),
      weight: serializer.fromJson<String?>(json['weight']),
      lotNumber: serializer.fromJson<String?>(json['lotNumber']),
      isDecaf: serializer.fromJson<bool>(json['isDecaf']),
      farm: serializer.fromJson<String?>(json['farm']),
      washStation: serializer.fromJson<String?>(json['washStation']),
      farmer: serializer.fromJson<String?>(json['farmer']),
      varieties: serializer.fromJson<String?>(json['varieties']),
      flavorProfile: serializer.fromJson<String?>(json['flavorProfile']),
      scaScore: serializer.fromJson<String?>(json['scaScore']),
      retailPrice: serializer.fromJson<String?>(json['retailPrice']),
      wholesalePrice: serializer.fromJson<String?>(json['wholesalePrice']),
      sensoryJson: serializer.fromJson<String>(json['sensoryJson']),
      priceJson: serializer.fromJson<String>(json['priceJson']),
      isGround: serializer.fromJson<bool>(json['isGround']),
      isOpen: serializer.fromJson<bool>(json['isOpen']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      isDeletedLocal: serializer.fromJson<bool>(json['isDeletedLocal']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'roasteryName': serializer.toJson<String?>(roasteryName),
      'roasteryCountry': serializer.toJson<String?>(roasteryCountry),
      'brandId': serializer.toJson<int?>(brandId),
      'coffeeName': serializer.toJson<String?>(coffeeName),
      'originCountry': serializer.toJson<String?>(originCountry),
      'region': serializer.toJson<String?>(region),
      'altitude': serializer.toJson<String?>(altitude),
      'process': serializer.toJson<String?>(process),
      'roastLevel': serializer.toJson<String?>(roastLevel),
      'roastDate': serializer.toJson<DateTime?>(roastDate),
      'openedAt': serializer.toJson<DateTime?>(openedAt),
      'weight': serializer.toJson<String?>(weight),
      'lotNumber': serializer.toJson<String?>(lotNumber),
      'isDecaf': serializer.toJson<bool>(isDecaf),
      'farm': serializer.toJson<String?>(farm),
      'washStation': serializer.toJson<String?>(washStation),
      'farmer': serializer.toJson<String?>(farmer),
      'varieties': serializer.toJson<String?>(varieties),
      'flavorProfile': serializer.toJson<String?>(flavorProfile),
      'scaScore': serializer.toJson<String?>(scaScore),
      'retailPrice': serializer.toJson<String?>(retailPrice),
      'wholesalePrice': serializer.toJson<String?>(wholesalePrice),
      'sensoryJson': serializer.toJson<String>(sensoryJson),
      'priceJson': serializer.toJson<String>(priceJson),
      'isGround': serializer.toJson<bool>(isGround),
      'isOpen': serializer.toJson<bool>(isOpen),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isSynced': serializer.toJson<bool>(isSynced),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'isDeletedLocal': serializer.toJson<bool>(isDeletedLocal),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  CoffeeLot copyWith({
    String? id,
    String? userId,
    Value<String?> roasteryName = const Value.absent(),
    Value<String?> roasteryCountry = const Value.absent(),
    Value<int?> brandId = const Value.absent(),
    Value<String?> coffeeName = const Value.absent(),
    Value<String?> originCountry = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> altitude = const Value.absent(),
    Value<String?> process = const Value.absent(),
    Value<String?> roastLevel = const Value.absent(),
    Value<DateTime?> roastDate = const Value.absent(),
    Value<DateTime?> openedAt = const Value.absent(),
    Value<String?> weight = const Value.absent(),
    Value<String?> lotNumber = const Value.absent(),
    bool? isDecaf,
    Value<String?> farm = const Value.absent(),
    Value<String?> washStation = const Value.absent(),
    Value<String?> farmer = const Value.absent(),
    Value<String?> varieties = const Value.absent(),
    Value<String?> flavorProfile = const Value.absent(),
    Value<String?> scaScore = const Value.absent(),
    Value<String?> retailPrice = const Value.absent(),
    Value<String?> wholesalePrice = const Value.absent(),
    String? sensoryJson,
    String? priceJson,
    bool? isGround,
    bool? isOpen,
    bool? isFavorite,
    bool? isArchived,
    bool? isSynced,
    Value<String?> imageUrl = const Value.absent(),
    bool? isDeletedLocal,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => CoffeeLot(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    roasteryName: roasteryName.present ? roasteryName.value : this.roasteryName,
    roasteryCountry: roasteryCountry.present
        ? roasteryCountry.value
        : this.roasteryCountry,
    brandId: brandId.present ? brandId.value : this.brandId,
    coffeeName: coffeeName.present ? coffeeName.value : this.coffeeName,
    originCountry: originCountry.present
        ? originCountry.value
        : this.originCountry,
    region: region.present ? region.value : this.region,
    altitude: altitude.present ? altitude.value : this.altitude,
    process: process.present ? process.value : this.process,
    roastLevel: roastLevel.present ? roastLevel.value : this.roastLevel,
    roastDate: roastDate.present ? roastDate.value : this.roastDate,
    openedAt: openedAt.present ? openedAt.value : this.openedAt,
    weight: weight.present ? weight.value : this.weight,
    lotNumber: lotNumber.present ? lotNumber.value : this.lotNumber,
    isDecaf: isDecaf ?? this.isDecaf,
    farm: farm.present ? farm.value : this.farm,
    washStation: washStation.present ? washStation.value : this.washStation,
    farmer: farmer.present ? farmer.value : this.farmer,
    varieties: varieties.present ? varieties.value : this.varieties,
    flavorProfile: flavorProfile.present
        ? flavorProfile.value
        : this.flavorProfile,
    scaScore: scaScore.present ? scaScore.value : this.scaScore,
    retailPrice: retailPrice.present ? retailPrice.value : this.retailPrice,
    wholesalePrice: wholesalePrice.present
        ? wholesalePrice.value
        : this.wholesalePrice,
    sensoryJson: sensoryJson ?? this.sensoryJson,
    priceJson: priceJson ?? this.priceJson,
    isGround: isGround ?? this.isGround,
    isOpen: isOpen ?? this.isOpen,
    isFavorite: isFavorite ?? this.isFavorite,
    isArchived: isArchived ?? this.isArchived,
    isSynced: isSynced ?? this.isSynced,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    isDeletedLocal: isDeletedLocal ?? this.isDeletedLocal,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  CoffeeLot copyWithCompanion(CoffeeLotsCompanion data) {
    return CoffeeLot(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      roasteryName: data.roasteryName.present
          ? data.roasteryName.value
          : this.roasteryName,
      roasteryCountry: data.roasteryCountry.present
          ? data.roasteryCountry.value
          : this.roasteryCountry,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      coffeeName: data.coffeeName.present
          ? data.coffeeName.value
          : this.coffeeName,
      originCountry: data.originCountry.present
          ? data.originCountry.value
          : this.originCountry,
      region: data.region.present ? data.region.value : this.region,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      process: data.process.present ? data.process.value : this.process,
      roastLevel: data.roastLevel.present
          ? data.roastLevel.value
          : this.roastLevel,
      roastDate: data.roastDate.present ? data.roastDate.value : this.roastDate,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      weight: data.weight.present ? data.weight.value : this.weight,
      lotNumber: data.lotNumber.present ? data.lotNumber.value : this.lotNumber,
      isDecaf: data.isDecaf.present ? data.isDecaf.value : this.isDecaf,
      farm: data.farm.present ? data.farm.value : this.farm,
      washStation: data.washStation.present
          ? data.washStation.value
          : this.washStation,
      farmer: data.farmer.present ? data.farmer.value : this.farmer,
      varieties: data.varieties.present ? data.varieties.value : this.varieties,
      flavorProfile: data.flavorProfile.present
          ? data.flavorProfile.value
          : this.flavorProfile,
      scaScore: data.scaScore.present ? data.scaScore.value : this.scaScore,
      retailPrice: data.retailPrice.present
          ? data.retailPrice.value
          : this.retailPrice,
      wholesalePrice: data.wholesalePrice.present
          ? data.wholesalePrice.value
          : this.wholesalePrice,
      sensoryJson: data.sensoryJson.present
          ? data.sensoryJson.value
          : this.sensoryJson,
      priceJson: data.priceJson.present ? data.priceJson.value : this.priceJson,
      isGround: data.isGround.present ? data.isGround.value : this.isGround,
      isOpen: data.isOpen.present ? data.isOpen.value : this.isOpen,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isDeletedLocal: data.isDeletedLocal.present
          ? data.isDeletedLocal.value
          : this.isDeletedLocal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeLot(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('roasteryName: $roasteryName, ')
          ..write('roasteryCountry: $roasteryCountry, ')
          ..write('brandId: $brandId, ')
          ..write('coffeeName: $coffeeName, ')
          ..write('originCountry: $originCountry, ')
          ..write('region: $region, ')
          ..write('altitude: $altitude, ')
          ..write('process: $process, ')
          ..write('roastLevel: $roastLevel, ')
          ..write('roastDate: $roastDate, ')
          ..write('openedAt: $openedAt, ')
          ..write('weight: $weight, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('isDecaf: $isDecaf, ')
          ..write('farm: $farm, ')
          ..write('washStation: $washStation, ')
          ..write('farmer: $farmer, ')
          ..write('varieties: $varieties, ')
          ..write('flavorProfile: $flavorProfile, ')
          ..write('scaScore: $scaScore, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('priceJson: $priceJson, ')
          ..write('isGround: $isGround, ')
          ..write('isOpen: $isOpen, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isArchived: $isArchived, ')
          ..write('isSynced: $isSynced, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isDeletedLocal: $isDeletedLocal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    userId,
    roasteryName,
    roasteryCountry,
    brandId,
    coffeeName,
    originCountry,
    region,
    altitude,
    process,
    roastLevel,
    roastDate,
    openedAt,
    weight,
    lotNumber,
    isDecaf,
    farm,
    washStation,
    farmer,
    varieties,
    flavorProfile,
    scaScore,
    retailPrice,
    wholesalePrice,
    sensoryJson,
    priceJson,
    isGround,
    isOpen,
    isFavorite,
    isArchived,
    isSynced,
    imageUrl,
    isDeletedLocal,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeeLot &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.roasteryName == this.roasteryName &&
          other.roasteryCountry == this.roasteryCountry &&
          other.brandId == this.brandId &&
          other.coffeeName == this.coffeeName &&
          other.originCountry == this.originCountry &&
          other.region == this.region &&
          other.altitude == this.altitude &&
          other.process == this.process &&
          other.roastLevel == this.roastLevel &&
          other.roastDate == this.roastDate &&
          other.openedAt == this.openedAt &&
          other.weight == this.weight &&
          other.lotNumber == this.lotNumber &&
          other.isDecaf == this.isDecaf &&
          other.farm == this.farm &&
          other.washStation == this.washStation &&
          other.farmer == this.farmer &&
          other.varieties == this.varieties &&
          other.flavorProfile == this.flavorProfile &&
          other.scaScore == this.scaScore &&
          other.retailPrice == this.retailPrice &&
          other.wholesalePrice == this.wholesalePrice &&
          other.sensoryJson == this.sensoryJson &&
          other.priceJson == this.priceJson &&
          other.isGround == this.isGround &&
          other.isOpen == this.isOpen &&
          other.isFavorite == this.isFavorite &&
          other.isArchived == this.isArchived &&
          other.isSynced == this.isSynced &&
          other.imageUrl == this.imageUrl &&
          other.isDeletedLocal == this.isDeletedLocal &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CoffeeLotsCompanion extends UpdateCompanion<CoffeeLot> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String?> roasteryName;
  final Value<String?> roasteryCountry;
  final Value<int?> brandId;
  final Value<String?> coffeeName;
  final Value<String?> originCountry;
  final Value<String?> region;
  final Value<String?> altitude;
  final Value<String?> process;
  final Value<String?> roastLevel;
  final Value<DateTime?> roastDate;
  final Value<DateTime?> openedAt;
  final Value<String?> weight;
  final Value<String?> lotNumber;
  final Value<bool> isDecaf;
  final Value<String?> farm;
  final Value<String?> washStation;
  final Value<String?> farmer;
  final Value<String?> varieties;
  final Value<String?> flavorProfile;
  final Value<String?> scaScore;
  final Value<String?> retailPrice;
  final Value<String?> wholesalePrice;
  final Value<String> sensoryJson;
  final Value<String> priceJson;
  final Value<bool> isGround;
  final Value<bool> isOpen;
  final Value<bool> isFavorite;
  final Value<bool> isArchived;
  final Value<bool> isSynced;
  final Value<String?> imageUrl;
  final Value<bool> isDeletedLocal;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const CoffeeLotsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.roasteryName = const Value.absent(),
    this.roasteryCountry = const Value.absent(),
    this.brandId = const Value.absent(),
    this.coffeeName = const Value.absent(),
    this.originCountry = const Value.absent(),
    this.region = const Value.absent(),
    this.altitude = const Value.absent(),
    this.process = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.weight = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.isDecaf = const Value.absent(),
    this.farm = const Value.absent(),
    this.washStation = const Value.absent(),
    this.farmer = const Value.absent(),
    this.varieties = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.scaScore = const Value.absent(),
    this.retailPrice = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.priceJson = const Value.absent(),
    this.isGround = const Value.absent(),
    this.isOpen = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isDeletedLocal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeeLotsCompanion.insert({
    required String id,
    required String userId,
    this.roasteryName = const Value.absent(),
    this.roasteryCountry = const Value.absent(),
    this.brandId = const Value.absent(),
    this.coffeeName = const Value.absent(),
    this.originCountry = const Value.absent(),
    this.region = const Value.absent(),
    this.altitude = const Value.absent(),
    this.process = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.weight = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.isDecaf = const Value.absent(),
    this.farm = const Value.absent(),
    this.washStation = const Value.absent(),
    this.farmer = const Value.absent(),
    this.varieties = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.scaScore = const Value.absent(),
    this.retailPrice = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.priceJson = const Value.absent(),
    this.isGround = const Value.absent(),
    this.isOpen = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isDeletedLocal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId);
  static Insertable<CoffeeLot> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? roasteryName,
    Expression<String>? roasteryCountry,
    Expression<int>? brandId,
    Expression<String>? coffeeName,
    Expression<String>? originCountry,
    Expression<String>? region,
    Expression<String>? altitude,
    Expression<String>? process,
    Expression<String>? roastLevel,
    Expression<DateTime>? roastDate,
    Expression<DateTime>? openedAt,
    Expression<String>? weight,
    Expression<String>? lotNumber,
    Expression<bool>? isDecaf,
    Expression<String>? farm,
    Expression<String>? washStation,
    Expression<String>? farmer,
    Expression<String>? varieties,
    Expression<String>? flavorProfile,
    Expression<String>? scaScore,
    Expression<String>? retailPrice,
    Expression<String>? wholesalePrice,
    Expression<String>? sensoryJson,
    Expression<String>? priceJson,
    Expression<bool>? isGround,
    Expression<bool>? isOpen,
    Expression<bool>? isFavorite,
    Expression<bool>? isArchived,
    Expression<bool>? isSynced,
    Expression<String>? imageUrl,
    Expression<bool>? isDeletedLocal,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (roasteryName != null) 'roastery_name': roasteryName,
      if (roasteryCountry != null) 'roastery_country': roasteryCountry,
      if (brandId != null) 'brand_id': brandId,
      if (coffeeName != null) 'coffee_name': coffeeName,
      if (originCountry != null) 'origin_country': originCountry,
      if (region != null) 'region': region,
      if (altitude != null) 'altitude': altitude,
      if (process != null) 'process': process,
      if (roastLevel != null) 'roast_level': roastLevel,
      if (roastDate != null) 'roast_date': roastDate,
      if (openedAt != null) 'opened_at': openedAt,
      if (weight != null) 'weight': weight,
      if (lotNumber != null) 'lot_number': lotNumber,
      if (isDecaf != null) 'is_decaf': isDecaf,
      if (farm != null) 'farm': farm,
      if (washStation != null) 'wash_station': washStation,
      if (farmer != null) 'farmer': farmer,
      if (varieties != null) 'varieties': varieties,
      if (flavorProfile != null) 'flavor_profile': flavorProfile,
      if (scaScore != null) 'sca_score': scaScore,
      if (retailPrice != null) 'retail_price': retailPrice,
      if (wholesalePrice != null) 'wholesale_price': wholesalePrice,
      if (sensoryJson != null) 'sensory_json': sensoryJson,
      if (priceJson != null) 'price_json': priceJson,
      if (isGround != null) 'is_ground': isGround,
      if (isOpen != null) 'is_open': isOpen,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isArchived != null) 'is_archived': isArchived,
      if (isSynced != null) 'is_synced': isSynced,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isDeletedLocal != null) 'is_deleted_local': isDeletedLocal,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeeLotsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String?>? roasteryName,
    Value<String?>? roasteryCountry,
    Value<int?>? brandId,
    Value<String?>? coffeeName,
    Value<String?>? originCountry,
    Value<String?>? region,
    Value<String?>? altitude,
    Value<String?>? process,
    Value<String?>? roastLevel,
    Value<DateTime?>? roastDate,
    Value<DateTime?>? openedAt,
    Value<String?>? weight,
    Value<String?>? lotNumber,
    Value<bool>? isDecaf,
    Value<String?>? farm,
    Value<String?>? washStation,
    Value<String?>? farmer,
    Value<String?>? varieties,
    Value<String?>? flavorProfile,
    Value<String?>? scaScore,
    Value<String?>? retailPrice,
    Value<String?>? wholesalePrice,
    Value<String>? sensoryJson,
    Value<String>? priceJson,
    Value<bool>? isGround,
    Value<bool>? isOpen,
    Value<bool>? isFavorite,
    Value<bool>? isArchived,
    Value<bool>? isSynced,
    Value<String?>? imageUrl,
    Value<bool>? isDeletedLocal,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return CoffeeLotsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roasteryName: roasteryName ?? this.roasteryName,
      roasteryCountry: roasteryCountry ?? this.roasteryCountry,
      brandId: brandId ?? this.brandId,
      coffeeName: coffeeName ?? this.coffeeName,
      originCountry: originCountry ?? this.originCountry,
      region: region ?? this.region,
      altitude: altitude ?? this.altitude,
      process: process ?? this.process,
      roastLevel: roastLevel ?? this.roastLevel,
      roastDate: roastDate ?? this.roastDate,
      openedAt: openedAt ?? this.openedAt,
      weight: weight ?? this.weight,
      lotNumber: lotNumber ?? this.lotNumber,
      isDecaf: isDecaf ?? this.isDecaf,
      farm: farm ?? this.farm,
      washStation: washStation ?? this.washStation,
      farmer: farmer ?? this.farmer,
      varieties: varieties ?? this.varieties,
      flavorProfile: flavorProfile ?? this.flavorProfile,
      scaScore: scaScore ?? this.scaScore,
      retailPrice: retailPrice ?? this.retailPrice,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      sensoryJson: sensoryJson ?? this.sensoryJson,
      priceJson: priceJson ?? this.priceJson,
      isGround: isGround ?? this.isGround,
      isOpen: isOpen ?? this.isOpen,
      isFavorite: isFavorite ?? this.isFavorite,
      isArchived: isArchived ?? this.isArchived,
      isSynced: isSynced ?? this.isSynced,
      imageUrl: imageUrl ?? this.imageUrl,
      isDeletedLocal: isDeletedLocal ?? this.isDeletedLocal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (roasteryName.present) {
      map['roastery_name'] = Variable<String>(roasteryName.value);
    }
    if (roasteryCountry.present) {
      map['roastery_country'] = Variable<String>(roasteryCountry.value);
    }
    if (brandId.present) {
      map['brand_id'] = Variable<int>(brandId.value);
    }
    if (coffeeName.present) {
      map['coffee_name'] = Variable<String>(coffeeName.value);
    }
    if (originCountry.present) {
      map['origin_country'] = Variable<String>(originCountry.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<String>(altitude.value);
    }
    if (process.present) {
      map['process'] = Variable<String>(process.value);
    }
    if (roastLevel.present) {
      map['roast_level'] = Variable<String>(roastLevel.value);
    }
    if (roastDate.present) {
      map['roast_date'] = Variable<DateTime>(roastDate.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (weight.present) {
      map['weight'] = Variable<String>(weight.value);
    }
    if (lotNumber.present) {
      map['lot_number'] = Variable<String>(lotNumber.value);
    }
    if (isDecaf.present) {
      map['is_decaf'] = Variable<bool>(isDecaf.value);
    }
    if (farm.present) {
      map['farm'] = Variable<String>(farm.value);
    }
    if (washStation.present) {
      map['wash_station'] = Variable<String>(washStation.value);
    }
    if (farmer.present) {
      map['farmer'] = Variable<String>(farmer.value);
    }
    if (varieties.present) {
      map['varieties'] = Variable<String>(varieties.value);
    }
    if (flavorProfile.present) {
      map['flavor_profile'] = Variable<String>(flavorProfile.value);
    }
    if (scaScore.present) {
      map['sca_score'] = Variable<String>(scaScore.value);
    }
    if (retailPrice.present) {
      map['retail_price'] = Variable<String>(retailPrice.value);
    }
    if (wholesalePrice.present) {
      map['wholesale_price'] = Variable<String>(wholesalePrice.value);
    }
    if (sensoryJson.present) {
      map['sensory_json'] = Variable<String>(sensoryJson.value);
    }
    if (priceJson.present) {
      map['price_json'] = Variable<String>(priceJson.value);
    }
    if (isGround.present) {
      map['is_ground'] = Variable<bool>(isGround.value);
    }
    if (isOpen.present) {
      map['is_open'] = Variable<bool>(isOpen.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isDeletedLocal.present) {
      map['is_deleted_local'] = Variable<bool>(isDeletedLocal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
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
          ..write('roasteryName: $roasteryName, ')
          ..write('roasteryCountry: $roasteryCountry, ')
          ..write('brandId: $brandId, ')
          ..write('coffeeName: $coffeeName, ')
          ..write('originCountry: $originCountry, ')
          ..write('region: $region, ')
          ..write('altitude: $altitude, ')
          ..write('process: $process, ')
          ..write('roastLevel: $roastLevel, ')
          ..write('roastDate: $roastDate, ')
          ..write('openedAt: $openedAt, ')
          ..write('weight: $weight, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('isDecaf: $isDecaf, ')
          ..write('farm: $farm, ')
          ..write('washStation: $washStation, ')
          ..write('farmer: $farmer, ')
          ..write('varieties: $varieties, ')
          ..write('flavorProfile: $flavorProfile, ')
          ..write('scaScore: $scaScore, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('priceJson: $priceJson, ')
          ..write('isGround: $isGround, ')
          ..write('isOpen: $isOpen, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isArchived: $isArchived, ')
          ..write('isSynced: $isSynced, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isDeletedLocal: $isDeletedLocal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0.066),
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<double> tempC = GeneratedColumn<double>(
    'temp_c',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(93.0),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(180),
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
    requiredDuringInsert: false,
    defaultValue: const Constant('Intermediate'),
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
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
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
    requiredDuringInsert: false,
    defaultValue: const Constant('Balanced'),
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    methodKey,
    imageUrl,
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
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('ratio_grams_per_ml')) {
      context.handle(
        _ratioGramsPerMlMeta,
        ratioGramsPerMl.isAcceptableOrUnknown(
          data['ratio_grams_per_ml']!,
          _ratioGramsPerMlMeta,
        ),
      );
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    }
    if (data.containsKey('total_time_sec')) {
      context.handle(
        _totalTimeSecMeta,
        totalTimeSec.isAcceptableOrUnknown(
          data['total_time_sec']!,
          _totalTimeSecMeta,
        ),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('steps_json')) {
      context.handle(
        _stepsJsonMeta,
        stepsJson.isAcceptableOrUnknown(data['steps_json']!, _stepsJsonMeta),
      );
    }
    if (data.containsKey('flavor_profile')) {
      context.handle(
        _flavorProfileMeta,
        flavorProfile.isAcceptableOrUnknown(
          data['flavor_profile']!,
          _flavorProfileMeta,
        ),
      );
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
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
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
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
      ),
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
  final String imageUrl;
  final double ratioGramsPerMl;
  final double tempC;
  final int totalTimeSec;
  final String difficulty;
  final String stepsJson;
  final String flavorProfile;
  final String? iconName;
  const BrewingRecipe({
    required this.id,
    required this.methodKey,
    required this.imageUrl,
    required this.ratioGramsPerMl,
    required this.tempC,
    required this.totalTimeSec,
    required this.difficulty,
    required this.stepsJson,
    required this.flavorProfile,
    this.iconName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['method_key'] = Variable<String>(methodKey);
    map['image_url'] = Variable<String>(imageUrl);
    map['ratio_grams_per_ml'] = Variable<double>(ratioGramsPerMl);
    map['temp_c'] = Variable<double>(tempC);
    map['total_time_sec'] = Variable<int>(totalTimeSec);
    map['difficulty'] = Variable<String>(difficulty);
    map['steps_json'] = Variable<String>(stepsJson);
    map['flavor_profile'] = Variable<String>(flavorProfile);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    return map;
  }

  BrewingRecipesCompanion toCompanion(bool nullToAbsent) {
    return BrewingRecipesCompanion(
      id: Value(id),
      methodKey: Value(methodKey),
      imageUrl: Value(imageUrl),
      ratioGramsPerMl: Value(ratioGramsPerMl),
      tempC: Value(tempC),
      totalTimeSec: Value(totalTimeSec),
      difficulty: Value(difficulty),
      stepsJson: Value(stepsJson),
      flavorProfile: Value(flavorProfile),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
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
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      ratioGramsPerMl: serializer.fromJson<double>(json['ratioGramsPerMl']),
      tempC: serializer.fromJson<double>(json['tempC']),
      totalTimeSec: serializer.fromJson<int>(json['totalTimeSec']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      stepsJson: serializer.fromJson<String>(json['stepsJson']),
      flavorProfile: serializer.fromJson<String>(json['flavorProfile']),
      iconName: serializer.fromJson<String?>(json['iconName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'methodKey': serializer.toJson<String>(methodKey),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'ratioGramsPerMl': serializer.toJson<double>(ratioGramsPerMl),
      'tempC': serializer.toJson<double>(tempC),
      'totalTimeSec': serializer.toJson<int>(totalTimeSec),
      'difficulty': serializer.toJson<String>(difficulty),
      'stepsJson': serializer.toJson<String>(stepsJson),
      'flavorProfile': serializer.toJson<String>(flavorProfile),
      'iconName': serializer.toJson<String?>(iconName),
    };
  }

  BrewingRecipe copyWith({
    int? id,
    String? methodKey,
    String? imageUrl,
    double? ratioGramsPerMl,
    double? tempC,
    int? totalTimeSec,
    String? difficulty,
    String? stepsJson,
    String? flavorProfile,
    Value<String?> iconName = const Value.absent(),
  }) => BrewingRecipe(
    id: id ?? this.id,
    methodKey: methodKey ?? this.methodKey,
    imageUrl: imageUrl ?? this.imageUrl,
    ratioGramsPerMl: ratioGramsPerMl ?? this.ratioGramsPerMl,
    tempC: tempC ?? this.tempC,
    totalTimeSec: totalTimeSec ?? this.totalTimeSec,
    difficulty: difficulty ?? this.difficulty,
    stepsJson: stepsJson ?? this.stepsJson,
    flavorProfile: flavorProfile ?? this.flavorProfile,
    iconName: iconName.present ? iconName.value : this.iconName,
  );
  BrewingRecipe copyWithCompanion(BrewingRecipesCompanion data) {
    return BrewingRecipe(
      id: data.id.present ? data.id.value : this.id,
      methodKey: data.methodKey.present ? data.methodKey.value : this.methodKey,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
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
          ..write('imageUrl: $imageUrl, ')
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
    imageUrl,
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
          other.imageUrl == this.imageUrl &&
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
  final Value<String> imageUrl;
  final Value<double> ratioGramsPerMl;
  final Value<double> tempC;
  final Value<int> totalTimeSec;
  final Value<String> difficulty;
  final Value<String> stepsJson;
  final Value<String> flavorProfile;
  final Value<String?> iconName;
  const BrewingRecipesCompanion({
    this.id = const Value.absent(),
    this.methodKey = const Value.absent(),
    this.imageUrl = const Value.absent(),
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
    this.imageUrl = const Value.absent(),
    this.ratioGramsPerMl = const Value.absent(),
    this.tempC = const Value.absent(),
    this.totalTimeSec = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.stepsJson = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.iconName = const Value.absent(),
  }) : methodKey = Value(methodKey);
  static Insertable<BrewingRecipe> custom({
    Expression<int>? id,
    Expression<String>? methodKey,
    Expression<String>? imageUrl,
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
      if (imageUrl != null) 'image_url': imageUrl,
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
    Value<String>? imageUrl,
    Value<double>? ratioGramsPerMl,
    Value<double>? tempC,
    Value<int>? totalTimeSec,
    Value<String>? difficulty,
    Value<String>? stepsJson,
    Value<String>? flavorProfile,
    Value<String?>? iconName,
  }) {
    return BrewingRecipesCompanion(
      id: id ?? this.id,
      methodKey: methodKey ?? this.methodKey,
      imageUrl: imageUrl ?? this.imageUrl,
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
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
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
          ..write('imageUrl: $imageUrl, ')
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

class $BrewingRecipeTranslationsTable extends BrewingRecipeTranslations
    with TableInfo<$BrewingRecipeTranslationsTable, BrewingRecipeTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrewingRecipeTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeKeyMeta = const VerificationMeta(
    'recipeKey',
  );
  @override
  late final GeneratedColumn<String> recipeKey = GeneratedColumn<String>(
    'recipe_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES brewing_recipes (method_key)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    recipeKey,
    languageCode,
    name,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brewing_recipe_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrewingRecipeTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_key')) {
      context.handle(
        _recipeKeyMeta,
        recipeKey.isAcceptableOrUnknown(data['recipe_key']!, _recipeKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeKeyMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeKey, languageCode};
  @override
  BrewingRecipeTranslation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrewingRecipeTranslation(
      recipeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_key'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $BrewingRecipeTranslationsTable createAlias(String alias) {
    return $BrewingRecipeTranslationsTable(attachedDatabase, alias);
  }
}

class BrewingRecipeTranslation extends DataClass
    implements Insertable<BrewingRecipeTranslation> {
  final String recipeKey;
  final String languageCode;
  final String? name;
  final String? description;
  const BrewingRecipeTranslation({
    required this.recipeKey,
    required this.languageCode,
    this.name,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_key'] = Variable<String>(recipeKey);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  BrewingRecipeTranslationsCompanion toCompanion(bool nullToAbsent) {
    return BrewingRecipeTranslationsCompanion(
      recipeKey: Value(recipeKey),
      languageCode: Value(languageCode),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory BrewingRecipeTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrewingRecipeTranslation(
      recipeKey: serializer.fromJson<String>(json['recipeKey']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String?>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeKey': serializer.toJson<String>(recipeKey),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String?>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  BrewingRecipeTranslation copyWith({
    String? recipeKey,
    String? languageCode,
    Value<String?> name = const Value.absent(),
    Value<String?> description = const Value.absent(),
  }) => BrewingRecipeTranslation(
    recipeKey: recipeKey ?? this.recipeKey,
    languageCode: languageCode ?? this.languageCode,
    name: name.present ? name.value : this.name,
    description: description.present ? description.value : this.description,
  );
  BrewingRecipeTranslation copyWithCompanion(
    BrewingRecipeTranslationsCompanion data,
  ) {
    return BrewingRecipeTranslation(
      recipeKey: data.recipeKey.present ? data.recipeKey.value : this.recipeKey,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrewingRecipeTranslation(')
          ..write('recipeKey: $recipeKey, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recipeKey, languageCode, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrewingRecipeTranslation &&
          other.recipeKey == this.recipeKey &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.description == this.description);
}

class BrewingRecipeTranslationsCompanion
    extends UpdateCompanion<BrewingRecipeTranslation> {
  final Value<String> recipeKey;
  final Value<String> languageCode;
  final Value<String?> name;
  final Value<String?> description;
  final Value<int> rowid;
  const BrewingRecipeTranslationsCompanion({
    this.recipeKey = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrewingRecipeTranslationsCompanion.insert({
    required String recipeKey,
    required String languageCode,
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : recipeKey = Value(recipeKey),
       languageCode = Value(languageCode);
  static Insertable<BrewingRecipeTranslation> custom({
    Expression<String>? recipeKey,
    Expression<String>? languageCode,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recipeKey != null) 'recipe_key': recipeKey,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BrewingRecipeTranslationsCompanion copyWith({
    Value<String>? recipeKey,
    Value<String>? languageCode,
    Value<String?>? name,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return BrewingRecipeTranslationsCompanion(
      recipeKey: recipeKey ?? this.recipeKey,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeKey.present) {
      map['recipe_key'] = Variable<String>(recipeKey.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrewingRecipeTranslationsCompanion(')
          ..write('recipeKey: $recipeKey, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
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
      'REFERENCES localized_beans (id)',
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

class $CustomRecipesTable extends CustomRecipes
    with TableInfo<$CustomRecipesTable, CustomRecipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
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
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<String> lotId = GeneratedColumn<String>(
    'lot_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
  static const VerificationMeta _micronsMeta = const VerificationMeta(
    'microns',
  );
  @override
  late final GeneratedColumn<int> microns = GeneratedColumn<int>(
    'microns',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recipeTypeMeta = const VerificationMeta(
    'recipeType',
  );
  @override
  late final GeneratedColumn<String> recipeType = GeneratedColumn<String>(
    'recipe_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('filter'),
  );
  static const VerificationMeta _brewRatioMeta = const VerificationMeta(
    'brewRatio',
  );
  @override
  late final GeneratedColumn<double> brewRatio = GeneratedColumn<double>(
    'brew_ratio',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grinderNameMeta = const VerificationMeta(
    'grinderName',
  );
  @override
  late final GeneratedColumn<String> grinderName = GeneratedColumn<String>(
    'grinder_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedLocalMeta = const VerificationMeta(
    'isDeletedLocal',
  );
  @override
  late final GeneratedColumn<bool> isDeletedLocal = GeneratedColumn<bool>(
    'is_deleted_local',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted_local" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    lotId,
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
    microns,
    recipeType,
    brewRatio,
    grinderName,
    isSynced,
    isDeletedLocal,
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
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('lot_id')) {
      context.handle(
        _lotIdMeta,
        lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta),
      );
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
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
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
    if (data.containsKey('microns')) {
      context.handle(
        _micronsMeta,
        microns.isAcceptableOrUnknown(data['microns']!, _micronsMeta),
      );
    }
    if (data.containsKey('recipe_type')) {
      context.handle(
        _recipeTypeMeta,
        recipeType.isAcceptableOrUnknown(data['recipe_type']!, _recipeTypeMeta),
      );
    }
    if (data.containsKey('brew_ratio')) {
      context.handle(
        _brewRatioMeta,
        brewRatio.isAcceptableOrUnknown(data['brew_ratio']!, _brewRatioMeta),
      );
    }
    if (data.containsKey('grinder_name')) {
      context.handle(
        _grinderNameMeta,
        grinderName.isAcceptableOrUnknown(
          data['grinder_name']!,
          _grinderNameMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_deleted_local')) {
      context.handle(
        _isDeletedLocalMeta,
        isDeletedLocal.isAcceptableOrUnknown(
          data['is_deleted_local']!,
          _isDeletedLocalMeta,
        ),
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      lotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_id'],
      ),
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
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
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
      microns: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}microns'],
      ),
      recipeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_type'],
      )!,
      brewRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}brew_ratio'],
      ),
      grinderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grinder_name'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      isDeletedLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted_local'],
      )!,
    );
  }

  @override
  $CustomRecipesTable createAlias(String alias) {
    return $CustomRecipesTable(attachedDatabase, alias);
  }
}

class CustomRecipe extends DataClass implements Insertable<CustomRecipe> {
  final String id;
  final String userId;
  final String? lotId;
  final String methodKey;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
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
  final int? microns;
  final String recipeType;
  final double? brewRatio;
  final String? grinderName;
  final bool isSynced;
  final bool isDeletedLocal;
  const CustomRecipe({
    required this.id,
    required this.userId,
    this.lotId,
    required this.methodKey,
    required this.name,
    this.createdAt,
    this.updatedAt,
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
    this.microns,
    required this.recipeType,
    this.brewRatio,
    this.grinderName,
    required this.isSynced,
    required this.isDeletedLocal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || lotId != null) {
      map['lot_id'] = Variable<String>(lotId);
    }
    map['method_key'] = Variable<String>(methodKey);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
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
    if (!nullToAbsent || microns != null) {
      map['microns'] = Variable<int>(microns);
    }
    map['recipe_type'] = Variable<String>(recipeType);
    if (!nullToAbsent || brewRatio != null) {
      map['brew_ratio'] = Variable<double>(brewRatio);
    }
    if (!nullToAbsent || grinderName != null) {
      map['grinder_name'] = Variable<String>(grinderName);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_deleted_local'] = Variable<bool>(isDeletedLocal);
    return map;
  }

  CustomRecipesCompanion toCompanion(bool nullToAbsent) {
    return CustomRecipesCompanion(
      id: Value(id),
      userId: Value(userId),
      lotId: lotId == null && nullToAbsent
          ? const Value.absent()
          : Value(lotId),
      methodKey: Value(methodKey),
      name: Value(name),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
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
      microns: microns == null && nullToAbsent
          ? const Value.absent()
          : Value(microns),
      recipeType: Value(recipeType),
      brewRatio: brewRatio == null && nullToAbsent
          ? const Value.absent()
          : Value(brewRatio),
      grinderName: grinderName == null && nullToAbsent
          ? const Value.absent()
          : Value(grinderName),
      isSynced: Value(isSynced),
      isDeletedLocal: Value(isDeletedLocal),
    );
  }

  factory CustomRecipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomRecipe(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      lotId: serializer.fromJson<String?>(json['lotId']),
      methodKey: serializer.fromJson<String>(json['methodKey']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
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
      microns: serializer.fromJson<int?>(json['microns']),
      recipeType: serializer.fromJson<String>(json['recipeType']),
      brewRatio: serializer.fromJson<double?>(json['brewRatio']),
      grinderName: serializer.fromJson<String?>(json['grinderName']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isDeletedLocal: serializer.fromJson<bool>(json['isDeletedLocal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'lotId': serializer.toJson<String?>(lotId),
      'methodKey': serializer.toJson<String>(methodKey),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
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
      'microns': serializer.toJson<int?>(microns),
      'recipeType': serializer.toJson<String>(recipeType),
      'brewRatio': serializer.toJson<double?>(brewRatio),
      'grinderName': serializer.toJson<String?>(grinderName),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isDeletedLocal': serializer.toJson<bool>(isDeletedLocal),
    };
  }

  CustomRecipe copyWith({
    String? id,
    String? userId,
    Value<String?> lotId = const Value.absent(),
    String? methodKey,
    String? name,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
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
    Value<int?> microns = const Value.absent(),
    String? recipeType,
    Value<double?> brewRatio = const Value.absent(),
    Value<String?> grinderName = const Value.absent(),
    bool? isSynced,
    bool? isDeletedLocal,
  }) => CustomRecipe(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    lotId: lotId.present ? lotId.value : this.lotId,
    methodKey: methodKey ?? this.methodKey,
    name: name ?? this.name,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
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
    microns: microns.present ? microns.value : this.microns,
    recipeType: recipeType ?? this.recipeType,
    brewRatio: brewRatio.present ? brewRatio.value : this.brewRatio,
    grinderName: grinderName.present ? grinderName.value : this.grinderName,
    isSynced: isSynced ?? this.isSynced,
    isDeletedLocal: isDeletedLocal ?? this.isDeletedLocal,
  );
  CustomRecipe copyWithCompanion(CustomRecipesCompanion data) {
    return CustomRecipe(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
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
      microns: data.microns.present ? data.microns.value : this.microns,
      recipeType: data.recipeType.present
          ? data.recipeType.value
          : this.recipeType,
      brewRatio: data.brewRatio.present ? data.brewRatio.value : this.brewRatio,
      grinderName: data.grinderName.present
          ? data.grinderName.value
          : this.grinderName,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isDeletedLocal: data.isDeletedLocal.present
          ? data.isDeletedLocal.value
          : this.isDeletedLocal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomRecipe(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('lotId: $lotId, ')
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
          ..write('rating: $rating, ')
          ..write('microns: $microns, ')
          ..write('recipeType: $recipeType, ')
          ..write('brewRatio: $brewRatio, ')
          ..write('grinderName: $grinderName, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeletedLocal: $isDeletedLocal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    userId,
    lotId,
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
    microns,
    recipeType,
    brewRatio,
    grinderName,
    isSynced,
    isDeletedLocal,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomRecipe &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.lotId == this.lotId &&
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
          other.rating == this.rating &&
          other.microns == this.microns &&
          other.recipeType == this.recipeType &&
          other.brewRatio == this.brewRatio &&
          other.grinderName == this.grinderName &&
          other.isSynced == this.isSynced &&
          other.isDeletedLocal == this.isDeletedLocal);
}

class CustomRecipesCompanion extends UpdateCompanion<CustomRecipe> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String?> lotId;
  final Value<String> methodKey;
  final Value<String> name;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
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
  final Value<int?> microns;
  final Value<String> recipeType;
  final Value<double?> brewRatio;
  final Value<String?> grinderName;
  final Value<bool> isSynced;
  final Value<bool> isDeletedLocal;
  final Value<int> rowid;
  const CustomRecipesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.lotId = const Value.absent(),
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
    this.microns = const Value.absent(),
    this.recipeType = const Value.absent(),
    this.brewRatio = const Value.absent(),
    this.grinderName = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeletedLocal = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomRecipesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.lotId = const Value.absent(),
    required String methodKey,
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
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
    this.microns = const Value.absent(),
    this.recipeType = const Value.absent(),
    this.brewRatio = const Value.absent(),
    this.grinderName = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isDeletedLocal = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       methodKey = Value(methodKey),
       name = Value(name),
       coffeeGrams = Value(coffeeGrams),
       totalWaterMl = Value(totalWaterMl);
  static Insertable<CustomRecipe> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? lotId,
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
    Expression<int>? microns,
    Expression<String>? recipeType,
    Expression<double>? brewRatio,
    Expression<String>? grinderName,
    Expression<bool>? isSynced,
    Expression<bool>? isDeletedLocal,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (lotId != null) 'lot_id': lotId,
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
      if (microns != null) 'microns': microns,
      if (recipeType != null) 'recipe_type': recipeType,
      if (brewRatio != null) 'brew_ratio': brewRatio,
      if (grinderName != null) 'grinder_name': grinderName,
      if (isSynced != null) 'is_synced': isSynced,
      if (isDeletedLocal != null) 'is_deleted_local': isDeletedLocal,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomRecipesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String?>? lotId,
    Value<String>? methodKey,
    Value<String>? name,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
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
    Value<int?>? microns,
    Value<String>? recipeType,
    Value<double?>? brewRatio,
    Value<String?>? grinderName,
    Value<bool>? isSynced,
    Value<bool>? isDeletedLocal,
    Value<int>? rowid,
  }) {
    return CustomRecipesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lotId: lotId ?? this.lotId,
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
      microns: microns ?? this.microns,
      recipeType: recipeType ?? this.recipeType,
      brewRatio: brewRatio ?? this.brewRatio,
      grinderName: grinderName ?? this.grinderName,
      isSynced: isSynced ?? this.isSynced,
      isDeletedLocal: isDeletedLocal ?? this.isDeletedLocal,
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
    if (lotId.present) {
      map['lot_id'] = Variable<String>(lotId.value);
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
    if (microns.present) {
      map['microns'] = Variable<int>(microns.value);
    }
    if (recipeType.present) {
      map['recipe_type'] = Variable<String>(recipeType.value);
    }
    if (brewRatio.present) {
      map['brew_ratio'] = Variable<double>(brewRatio.value);
    }
    if (grinderName.present) {
      map['grinder_name'] = Variable<String>(grinderName.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isDeletedLocal.present) {
      map['is_deleted_local'] = Variable<bool>(isDeletedLocal.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomRecipesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('lotId: $lotId, ')
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
          ..write('rating: $rating, ')
          ..write('microns: $microns, ')
          ..write('recipeType: $recipeType, ')
          ..write('brewRatio: $brewRatio, ')
          ..write('grinderName: $grinderName, ')
          ..write('isSynced: $isSynced, ')
          ..write('isDeletedLocal: $isDeletedLocal, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalizedFarmersV2Table extends LocalizedFarmersV2
    with TableInfo<$LocalizedFarmersV2Table, LocalizedFarmersV2Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedFarmersV2Table(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _flagUrlMeta = const VerificationMeta(
    'flagUrl',
  );
  @override
  late final GeneratedColumn<String> flagUrl = GeneratedColumn<String>(
    'flag_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imageUrl,
    flagUrl,
    latitude,
    longitude,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_farmers_v2';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedFarmersV2Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('flag_url')) {
      context.handle(
        _flagUrlMeta,
        flagUrl.isAcceptableOrUnknown(data['flag_url']!, _flagUrlMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalizedFarmersV2Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedFarmersV2Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      flagUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flag_url'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $LocalizedFarmersV2Table createAlias(String alias) {
    return $LocalizedFarmersV2Table(attachedDatabase, alias);
  }
}

class LocalizedFarmersV2Data extends DataClass
    implements Insertable<LocalizedFarmersV2Data> {
  final int id;
  final String imageUrl;
  final String flagUrl;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  const LocalizedFarmersV2Data({
    required this.id,
    required this.imageUrl,
    required this.flagUrl,
    this.latitude,
    this.longitude,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['flag_url'] = Variable<String>(flagUrl);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  LocalizedFarmersV2Companion toCompanion(bool nullToAbsent) {
    return LocalizedFarmersV2Companion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      flagUrl: Value(flagUrl),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory LocalizedFarmersV2Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedFarmersV2Data(
      id: serializer.fromJson<int>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      flagUrl: serializer.fromJson<String>(json['flagUrl']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'flagUrl': serializer.toJson<String>(flagUrl),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  LocalizedFarmersV2Data copyWith({
    int? id,
    String? imageUrl,
    String? flagUrl,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
  }) => LocalizedFarmersV2Data(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    flagUrl: flagUrl ?? this.flagUrl,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  LocalizedFarmersV2Data copyWithCompanion(LocalizedFarmersV2Companion data) {
    return LocalizedFarmersV2Data(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      flagUrl: data.flagUrl.present ? data.flagUrl.value : this.flagUrl,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmersV2Data(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, imageUrl, flagUrl, latitude, longitude, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedFarmersV2Data &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.flagUrl == this.flagUrl &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.createdAt == this.createdAt);
}

class LocalizedFarmersV2Companion
    extends UpdateCompanion<LocalizedFarmersV2Data> {
  final Value<int> id;
  final Value<String> imageUrl;
  final Value<String> flagUrl;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime?> createdAt;
  const LocalizedFarmersV2Companion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocalizedFarmersV2Companion.insert({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<LocalizedFarmersV2Data> custom({
    Expression<int>? id,
    Expression<String>? imageUrl,
    Expression<String>? flagUrl,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (flagUrl != null) 'flag_url': flagUrl,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocalizedFarmersV2Companion copyWith({
    Value<int>? id,
    Value<String>? imageUrl,
    Value<String>? flagUrl,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime?>? createdAt,
  }) {
    return LocalizedFarmersV2Companion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      flagUrl: flagUrl ?? this.flagUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (flagUrl.present) {
      map['flag_url'] = Variable<String>(flagUrl.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmersV2Companion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LocalizedFarmerTranslationsV2Table extends LocalizedFarmerTranslationsV2
    with
        TableInfo<
          $LocalizedFarmerTranslationsV2Table,
          LocalizedFarmerTranslationsV2Data
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedFarmerTranslationsV2Table(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<int> farmerId = GeneratedColumn<int>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES localized_farmers_v2 (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlMeta = const VerificationMeta(
    'descriptionHtml',
  );
  @override
  late final GeneratedColumn<String> descriptionHtml = GeneratedColumn<String>(
    'description_html',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _storyMeta = const VerificationMeta('story');
  @override
  late final GeneratedColumn<String> story = GeneratedColumn<String>(
    'story',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    farmerId,
    languageCode,
    name,
    descriptionHtml,
    story,
    region,
    country,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_farmer_translations_v2';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedFarmerTranslationsV2Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmerIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('description_html')) {
      context.handle(
        _descriptionHtmlMeta,
        descriptionHtml.isAcceptableOrUnknown(
          data['description_html']!,
          _descriptionHtmlMeta,
        ),
      );
    }
    if (data.containsKey('story')) {
      context.handle(
        _storyMeta,
        story.isAcceptableOrUnknown(data['story']!, _storyMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {farmerId, languageCode};
  @override
  LocalizedFarmerTranslationsV2Data map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedFarmerTranslationsV2Data(
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}farmer_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      descriptionHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html'],
      ),
      story: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}story'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
    );
  }

  @override
  $LocalizedFarmerTranslationsV2Table createAlias(String alias) {
    return $LocalizedFarmerTranslationsV2Table(attachedDatabase, alias);
  }
}

class LocalizedFarmerTranslationsV2Data extends DataClass
    implements Insertable<LocalizedFarmerTranslationsV2Data> {
  final int farmerId;
  final String languageCode;
  final String? name;
  final String? descriptionHtml;
  final String? story;
  final String? region;
  final String? country;
  const LocalizedFarmerTranslationsV2Data({
    required this.farmerId,
    required this.languageCode,
    this.name,
    this.descriptionHtml,
    this.story,
    this.region,
    this.country,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['farmer_id'] = Variable<int>(farmerId);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || descriptionHtml != null) {
      map['description_html'] = Variable<String>(descriptionHtml);
    }
    if (!nullToAbsent || story != null) {
      map['story'] = Variable<String>(story);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    return map;
  }

  LocalizedFarmerTranslationsV2Companion toCompanion(bool nullToAbsent) {
    return LocalizedFarmerTranslationsV2Companion(
      farmerId: Value(farmerId),
      languageCode: Value(languageCode),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      descriptionHtml: descriptionHtml == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtml),
      story: story == null && nullToAbsent
          ? const Value.absent()
          : Value(story),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
    );
  }

  factory LocalizedFarmerTranslationsV2Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedFarmerTranslationsV2Data(
      farmerId: serializer.fromJson<int>(json['farmerId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String?>(json['name']),
      descriptionHtml: serializer.fromJson<String?>(json['descriptionHtml']),
      story: serializer.fromJson<String?>(json['story']),
      region: serializer.fromJson<String?>(json['region']),
      country: serializer.fromJson<String?>(json['country']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'farmerId': serializer.toJson<int>(farmerId),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String?>(name),
      'descriptionHtml': serializer.toJson<String?>(descriptionHtml),
      'story': serializer.toJson<String?>(story),
      'region': serializer.toJson<String?>(region),
      'country': serializer.toJson<String?>(country),
    };
  }

  LocalizedFarmerTranslationsV2Data copyWith({
    int? farmerId,
    String? languageCode,
    Value<String?> name = const Value.absent(),
    Value<String?> descriptionHtml = const Value.absent(),
    Value<String?> story = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> country = const Value.absent(),
  }) => LocalizedFarmerTranslationsV2Data(
    farmerId: farmerId ?? this.farmerId,
    languageCode: languageCode ?? this.languageCode,
    name: name.present ? name.value : this.name,
    descriptionHtml: descriptionHtml.present
        ? descriptionHtml.value
        : this.descriptionHtml,
    story: story.present ? story.value : this.story,
    region: region.present ? region.value : this.region,
    country: country.present ? country.value : this.country,
  );
  LocalizedFarmerTranslationsV2Data copyWithCompanion(
    LocalizedFarmerTranslationsV2Companion data,
  ) {
    return LocalizedFarmerTranslationsV2Data(
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      name: data.name.present ? data.name.value : this.name,
      descriptionHtml: data.descriptionHtml.present
          ? data.descriptionHtml.value
          : this.descriptionHtml,
      story: data.story.present ? data.story.value : this.story,
      region: data.region.present ? data.region.value : this.region,
      country: data.country.present ? data.country.value : this.country,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmerTranslationsV2Data(')
          ..write('farmerId: $farmerId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('descriptionHtml: $descriptionHtml, ')
          ..write('story: $story, ')
          ..write('region: $region, ')
          ..write('country: $country')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    farmerId,
    languageCode,
    name,
    descriptionHtml,
    story,
    region,
    country,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedFarmerTranslationsV2Data &&
          other.farmerId == this.farmerId &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.descriptionHtml == this.descriptionHtml &&
          other.story == this.story &&
          other.region == this.region &&
          other.country == this.country);
}

class LocalizedFarmerTranslationsV2Companion
    extends UpdateCompanion<LocalizedFarmerTranslationsV2Data> {
  final Value<int> farmerId;
  final Value<String> languageCode;
  final Value<String?> name;
  final Value<String?> descriptionHtml;
  final Value<String?> story;
  final Value<String?> region;
  final Value<String?> country;
  final Value<int> rowid;
  const LocalizedFarmerTranslationsV2Companion({
    this.farmerId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.descriptionHtml = const Value.absent(),
    this.story = const Value.absent(),
    this.region = const Value.absent(),
    this.country = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalizedFarmerTranslationsV2Companion.insert({
    required int farmerId,
    required String languageCode,
    this.name = const Value.absent(),
    this.descriptionHtml = const Value.absent(),
    this.story = const Value.absent(),
    this.region = const Value.absent(),
    this.country = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : farmerId = Value(farmerId),
       languageCode = Value(languageCode);
  static Insertable<LocalizedFarmerTranslationsV2Data> custom({
    Expression<int>? farmerId,
    Expression<String>? languageCode,
    Expression<String>? name,
    Expression<String>? descriptionHtml,
    Expression<String>? story,
    Expression<String>? region,
    Expression<String>? country,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (farmerId != null) 'farmer_id': farmerId,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (descriptionHtml != null) 'description_html': descriptionHtml,
      if (story != null) 'story': story,
      if (region != null) 'region': region,
      if (country != null) 'country': country,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalizedFarmerTranslationsV2Companion copyWith({
    Value<int>? farmerId,
    Value<String>? languageCode,
    Value<String?>? name,
    Value<String?>? descriptionHtml,
    Value<String?>? story,
    Value<String?>? region,
    Value<String?>? country,
    Value<int>? rowid,
  }) {
    return LocalizedFarmerTranslationsV2Companion(
      farmerId: farmerId ?? this.farmerId,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      descriptionHtml: descriptionHtml ?? this.descriptionHtml,
      story: story ?? this.story,
      region: region ?? this.region,
      country: country ?? this.country,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (farmerId.present) {
      map['farmer_id'] = Variable<int>(farmerId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (descriptionHtml.present) {
      map['description_html'] = Variable<String>(descriptionHtml.value);
    }
    if (story.present) {
      map['story'] = Variable<String>(story.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmerTranslationsV2Companion(')
          ..write('farmerId: $farmerId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('descriptionHtml: $descriptionHtml, ')
          ..write('story: $story, ')
          ..write('region: $region, ')
          ..write('country: $country, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpecialtyArticlesV2Table extends SpecialtyArticlesV2
    with TableInfo<$SpecialtyArticlesV2Table, SpecialtyArticlesV2Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpecialtyArticlesV2Table(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _flagUrlMeta = const VerificationMeta(
    'flagUrl',
  );
  @override
  late final GeneratedColumn<String> flagUrl = GeneratedColumn<String>(
    'flag_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imageUrl,
    flagUrl,
    readTimeMin,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'specialty_articles_v2';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpecialtyArticlesV2Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('flag_url')) {
      context.handle(
        _flagUrlMeta,
        flagUrl.isAcceptableOrUnknown(data['flag_url']!, _flagUrlMeta),
      );
    }
    if (data.containsKey('read_time_min')) {
      context.handle(
        _readTimeMinMeta,
        readTimeMin.isAcceptableOrUnknown(
          data['read_time_min']!,
          _readTimeMinMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpecialtyArticlesV2Data map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpecialtyArticlesV2Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      flagUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flag_url'],
      )!,
      readTimeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}read_time_min'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $SpecialtyArticlesV2Table createAlias(String alias) {
    return $SpecialtyArticlesV2Table(attachedDatabase, alias);
  }
}

class SpecialtyArticlesV2Data extends DataClass
    implements Insertable<SpecialtyArticlesV2Data> {
  final int id;
  final String imageUrl;
  final String flagUrl;
  final int readTimeMin;
  final DateTime? createdAt;
  const SpecialtyArticlesV2Data({
    required this.id,
    required this.imageUrl,
    required this.flagUrl,
    required this.readTimeMin,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['flag_url'] = Variable<String>(flagUrl);
    map['read_time_min'] = Variable<int>(readTimeMin);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  SpecialtyArticlesV2Companion toCompanion(bool nullToAbsent) {
    return SpecialtyArticlesV2Companion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      flagUrl: Value(flagUrl),
      readTimeMin: Value(readTimeMin),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory SpecialtyArticlesV2Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecialtyArticlesV2Data(
      id: serializer.fromJson<int>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      flagUrl: serializer.fromJson<String>(json['flagUrl']),
      readTimeMin: serializer.fromJson<int>(json['readTimeMin']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'flagUrl': serializer.toJson<String>(flagUrl),
      'readTimeMin': serializer.toJson<int>(readTimeMin),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  SpecialtyArticlesV2Data copyWith({
    int? id,
    String? imageUrl,
    String? flagUrl,
    int? readTimeMin,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => SpecialtyArticlesV2Data(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    flagUrl: flagUrl ?? this.flagUrl,
    readTimeMin: readTimeMin ?? this.readTimeMin,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  SpecialtyArticlesV2Data copyWithCompanion(SpecialtyArticlesV2Companion data) {
    return SpecialtyArticlesV2Data(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      flagUrl: data.flagUrl.present ? data.flagUrl.value : this.flagUrl,
      readTimeMin: data.readTimeMin.present
          ? data.readTimeMin.value
          : this.readTimeMin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticlesV2Data(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('readTimeMin: $readTimeMin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, imageUrl, flagUrl, readTimeMin, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecialtyArticlesV2Data &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.flagUrl == this.flagUrl &&
          other.readTimeMin == this.readTimeMin &&
          other.createdAt == this.createdAt);
}

class SpecialtyArticlesV2Companion
    extends UpdateCompanion<SpecialtyArticlesV2Data> {
  final Value<int> id;
  final Value<String> imageUrl;
  final Value<String> flagUrl;
  final Value<int> readTimeMin;
  final Value<DateTime?> createdAt;
  const SpecialtyArticlesV2Companion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.readTimeMin = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SpecialtyArticlesV2Companion.insert({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.readTimeMin = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<SpecialtyArticlesV2Data> custom({
    Expression<int>? id,
    Expression<String>? imageUrl,
    Expression<String>? flagUrl,
    Expression<int>? readTimeMin,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (flagUrl != null) 'flag_url': flagUrl,
      if (readTimeMin != null) 'read_time_min': readTimeMin,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SpecialtyArticlesV2Companion copyWith({
    Value<int>? id,
    Value<String>? imageUrl,
    Value<String>? flagUrl,
    Value<int>? readTimeMin,
    Value<DateTime?>? createdAt,
  }) {
    return SpecialtyArticlesV2Companion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      flagUrl: flagUrl ?? this.flagUrl,
      readTimeMin: readTimeMin ?? this.readTimeMin,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (flagUrl.present) {
      map['flag_url'] = Variable<String>(flagUrl.value);
    }
    if (readTimeMin.present) {
      map['read_time_min'] = Variable<int>(readTimeMin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticlesV2Companion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('readTimeMin: $readTimeMin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SpecialtyArticleTranslationsV2Table
    extends SpecialtyArticleTranslationsV2
    with
        TableInfo<
          $SpecialtyArticleTranslationsV2Table,
          SpecialtyArticleTranslationsV2Data
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpecialtyArticleTranslationsV2Table(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<int> articleId = GeneratedColumn<int>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES specialty_articles_v2 (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlMeta = const VerificationMeta(
    'contentHtml',
  );
  @override
  late final GeneratedColumn<String> contentHtml = GeneratedColumn<String>(
    'content_html',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    articleId,
    languageCode,
    title,
    subtitle,
    contentHtml,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'specialty_article_translations_v2';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpecialtyArticleTranslationsV2Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    }
    if (data.containsKey('content_html')) {
      context.handle(
        _contentHtmlMeta,
        contentHtml.isAcceptableOrUnknown(
          data['content_html']!,
          _contentHtmlMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {articleId, languageCode};
  @override
  SpecialtyArticleTranslationsV2Data map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpecialtyArticleTranslationsV2Data(
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}article_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      ),
      contentHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html'],
      ),
    );
  }

  @override
  $SpecialtyArticleTranslationsV2Table createAlias(String alias) {
    return $SpecialtyArticleTranslationsV2Table(attachedDatabase, alias);
  }
}

class SpecialtyArticleTranslationsV2Data extends DataClass
    implements Insertable<SpecialtyArticleTranslationsV2Data> {
  final int articleId;
  final String languageCode;
  final String? title;
  final String? subtitle;
  final String? contentHtml;
  const SpecialtyArticleTranslationsV2Data({
    required this.articleId,
    required this.languageCode,
    this.title,
    this.subtitle,
    this.contentHtml,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['article_id'] = Variable<int>(articleId);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || contentHtml != null) {
      map['content_html'] = Variable<String>(contentHtml);
    }
    return map;
  }

  SpecialtyArticleTranslationsV2Companion toCompanion(bool nullToAbsent) {
    return SpecialtyArticleTranslationsV2Companion(
      articleId: Value(articleId),
      languageCode: Value(languageCode),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      contentHtml: contentHtml == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtml),
    );
  }

  factory SpecialtyArticleTranslationsV2Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecialtyArticleTranslationsV2Data(
      articleId: serializer.fromJson<int>(json['articleId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      title: serializer.fromJson<String?>(json['title']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      contentHtml: serializer.fromJson<String?>(json['contentHtml']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'articleId': serializer.toJson<int>(articleId),
      'languageCode': serializer.toJson<String>(languageCode),
      'title': serializer.toJson<String?>(title),
      'subtitle': serializer.toJson<String?>(subtitle),
      'contentHtml': serializer.toJson<String?>(contentHtml),
    };
  }

  SpecialtyArticleTranslationsV2Data copyWith({
    int? articleId,
    String? languageCode,
    Value<String?> title = const Value.absent(),
    Value<String?> subtitle = const Value.absent(),
    Value<String?> contentHtml = const Value.absent(),
  }) => SpecialtyArticleTranslationsV2Data(
    articleId: articleId ?? this.articleId,
    languageCode: languageCode ?? this.languageCode,
    title: title.present ? title.value : this.title,
    subtitle: subtitle.present ? subtitle.value : this.subtitle,
    contentHtml: contentHtml.present ? contentHtml.value : this.contentHtml,
  );
  SpecialtyArticleTranslationsV2Data copyWithCompanion(
    SpecialtyArticleTranslationsV2Companion data,
  ) {
    return SpecialtyArticleTranslationsV2Data(
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      title: data.title.present ? data.title.value : this.title,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      contentHtml: data.contentHtml.present
          ? data.contentHtml.value
          : this.contentHtml,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticleTranslationsV2Data(')
          ..write('articleId: $articleId, ')
          ..write('languageCode: $languageCode, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('contentHtml: $contentHtml')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(articleId, languageCode, title, subtitle, contentHtml);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecialtyArticleTranslationsV2Data &&
          other.articleId == this.articleId &&
          other.languageCode == this.languageCode &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.contentHtml == this.contentHtml);
}

class SpecialtyArticleTranslationsV2Companion
    extends UpdateCompanion<SpecialtyArticleTranslationsV2Data> {
  final Value<int> articleId;
  final Value<String> languageCode;
  final Value<String?> title;
  final Value<String?> subtitle;
  final Value<String?> contentHtml;
  final Value<int> rowid;
  const SpecialtyArticleTranslationsV2Companion({
    this.articleId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpecialtyArticleTranslationsV2Companion.insert({
    required int articleId,
    required String languageCode,
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.contentHtml = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : articleId = Value(articleId),
       languageCode = Value(languageCode);
  static Insertable<SpecialtyArticleTranslationsV2Data> custom({
    Expression<int>? articleId,
    Expression<String>? languageCode,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? contentHtml,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (articleId != null) 'article_id': articleId,
      if (languageCode != null) 'language_code': languageCode,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (contentHtml != null) 'content_html': contentHtml,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpecialtyArticleTranslationsV2Companion copyWith({
    Value<int>? articleId,
    Value<String>? languageCode,
    Value<String?>? title,
    Value<String?>? subtitle,
    Value<String?>? contentHtml,
    Value<int>? rowid,
  }) {
    return SpecialtyArticleTranslationsV2Companion(
      articleId: articleId ?? this.articleId,
      languageCode: languageCode ?? this.languageCode,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      contentHtml: contentHtml ?? this.contentHtml,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (articleId.present) {
      map['article_id'] = Variable<int>(articleId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticleTranslationsV2Companion(')
          ..write('articleId: $articleId, ')
          ..write('languageCode: $languageCode, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('contentHtml: $contentHtml, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalizedBeansV2Table extends LocalizedBeansV2
    with TableInfo<$LocalizedBeansV2Table, LocalizedBeansV2Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedBeansV2Table(this.attachedDatabase, [this._alias]);
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
      'REFERENCES localized_brands (id)',
    ),
  );
  static const VerificationMeta _countryEmojiMeta = const VerificationMeta(
    'countryEmoji',
  );
  @override
  late final GeneratedColumn<String> countryEmoji = GeneratedColumn<String>(
    'country_emoji',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMinMeta = const VerificationMeta(
    'altitudeMin',
  );
  @override
  late final GeneratedColumn<int> altitudeMin = GeneratedColumn<int>(
    'altitude_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMaxMeta = const VerificationMeta(
    'altitudeMax',
  );
  @override
  late final GeneratedColumn<int> altitudeMax = GeneratedColumn<int>(
    'altitude_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _scaScoreMeta = const VerificationMeta(
    'scaScore',
  );
  @override
  late final GeneratedColumn<String> scaScore = GeneratedColumn<String>(
    'sca_score',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('80-84'),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(82.0),
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
  static const VerificationMeta _priceJsonMeta = const VerificationMeta(
    'priceJson',
  );
  @override
  late final GeneratedColumn<String> priceJson = GeneratedColumn<String>(
    'price_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
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
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _harvestSeasonMeta = const VerificationMeta(
    'harvestSeason',
  );
  @override
  late final GeneratedColumn<String> harvestSeason = GeneratedColumn<String>(
    'harvest_season',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<String> price = GeneratedColumn<String>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<String> weight = GeneratedColumn<String>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastDateMeta = const VerificationMeta(
    'roastDate',
  );
  @override
  late final GeneratedColumn<String> roastDate = GeneratedColumn<String>(
    'roast_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<int> farmerId = GeneratedColumn<int>(
    'farmer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES localized_farmers_v2 (id)',
    ),
  );
  static const VerificationMeta _isDecafMeta = const VerificationMeta(
    'isDecaf',
  );
  @override
  late final GeneratedColumn<bool> isDecaf = GeneratedColumn<bool>(
    'is_decaf',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_decaf" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _farmMeta = const VerificationMeta('farm');
  @override
  late final GeneratedColumn<String> farm = GeneratedColumn<String>(
    'farm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmPhotosUrlCoverMeta =
      const VerificationMeta('farmPhotosUrlCover');
  @override
  late final GeneratedColumn<String> farmPhotosUrlCover =
      GeneratedColumn<String>(
        'farm_photos_url_cover',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _washStationMeta = const VerificationMeta(
    'washStation',
  );
  @override
  late final GeneratedColumn<String> washStation = GeneratedColumn<String>(
    'wash_station',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retailPriceMeta = const VerificationMeta(
    'retailPrice',
  );
  @override
  late final GeneratedColumn<String> retailPrice = GeneratedColumn<String>(
    'retail_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wholesalePriceMeta = const VerificationMeta(
    'wholesalePrice',
  );
  @override
  late final GeneratedColumn<String> wholesalePrice = GeneratedColumn<String>(
    'wholesale_price',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _flagUrlMeta = const VerificationMeta(
    'flagUrl',
  );
  @override
  late final GeneratedColumn<String> flagUrl = GeneratedColumn<String>(
    'flag_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _radarJsonMeta = const VerificationMeta(
    'radarJson',
  );
  @override
  late final GeneratedColumn<String> radarJson = GeneratedColumn<String>(
    'radar_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brandId,
    countryEmoji,
    altitudeMin,
    altitudeMax,
    lotNumber,
    scaScore,
    cupsScore,
    sensoryJson,
    priceJson,
    plantationPhotosUrl,
    harvestSeason,
    price,
    weight,
    roastDate,
    processingMethodsJson,
    isPremium,
    detailedProcessMarkdown,
    url,
    farmerId,
    isDecaf,
    farm,
    farmPhotosUrlCover,
    washStation,
    retailPrice,
    wholesalePrice,
    isFavorite,
    flagUrl,
    radarJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_beans_v2';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedBeansV2Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    }
    if (data.containsKey('country_emoji')) {
      context.handle(
        _countryEmojiMeta,
        countryEmoji.isAcceptableOrUnknown(
          data['country_emoji']!,
          _countryEmojiMeta,
        ),
      );
    }
    if (data.containsKey('altitude_min')) {
      context.handle(
        _altitudeMinMeta,
        altitudeMin.isAcceptableOrUnknown(
          data['altitude_min']!,
          _altitudeMinMeta,
        ),
      );
    }
    if (data.containsKey('altitude_max')) {
      context.handle(
        _altitudeMaxMeta,
        altitudeMax.isAcceptableOrUnknown(
          data['altitude_max']!,
          _altitudeMaxMeta,
        ),
      );
    }
    if (data.containsKey('lot_number')) {
      context.handle(
        _lotNumberMeta,
        lotNumber.isAcceptableOrUnknown(data['lot_number']!, _lotNumberMeta),
      );
    }
    if (data.containsKey('sca_score')) {
      context.handle(
        _scaScoreMeta,
        scaScore.isAcceptableOrUnknown(data['sca_score']!, _scaScoreMeta),
      );
    }
    if (data.containsKey('cups_score')) {
      context.handle(
        _cupsScoreMeta,
        cupsScore.isAcceptableOrUnknown(data['cups_score']!, _cupsScoreMeta),
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
    if (data.containsKey('price_json')) {
      context.handle(
        _priceJsonMeta,
        priceJson.isAcceptableOrUnknown(data['price_json']!, _priceJsonMeta),
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
    if (data.containsKey('harvest_season')) {
      context.handle(
        _harvestSeasonMeta,
        harvestSeason.isAcceptableOrUnknown(
          data['harvest_season']!,
          _harvestSeasonMeta,
        ),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('roast_date')) {
      context.handle(
        _roastDateMeta,
        roastDate.isAcceptableOrUnknown(data['roast_date']!, _roastDateMeta),
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
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    }
    if (data.containsKey('is_decaf')) {
      context.handle(
        _isDecafMeta,
        isDecaf.isAcceptableOrUnknown(data['is_decaf']!, _isDecafMeta),
      );
    }
    if (data.containsKey('farm')) {
      context.handle(
        _farmMeta,
        farm.isAcceptableOrUnknown(data['farm']!, _farmMeta),
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
    if (data.containsKey('wash_station')) {
      context.handle(
        _washStationMeta,
        washStation.isAcceptableOrUnknown(
          data['wash_station']!,
          _washStationMeta,
        ),
      );
    }
    if (data.containsKey('retail_price')) {
      context.handle(
        _retailPriceMeta,
        retailPrice.isAcceptableOrUnknown(
          data['retail_price']!,
          _retailPriceMeta,
        ),
      );
    }
    if (data.containsKey('wholesale_price')) {
      context.handle(
        _wholesalePriceMeta,
        wholesalePrice.isAcceptableOrUnknown(
          data['wholesale_price']!,
          _wholesalePriceMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('flag_url')) {
      context.handle(
        _flagUrlMeta,
        flagUrl.isAcceptableOrUnknown(data['flag_url']!, _flagUrlMeta),
      );
    }
    if (data.containsKey('radar_json')) {
      context.handle(
        _radarJsonMeta,
        radarJson.isAcceptableOrUnknown(data['radar_json']!, _radarJsonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalizedBeansV2Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedBeansV2Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brand_id'],
      ),
      countryEmoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_emoji'],
      ),
      altitudeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_min'],
      ),
      altitudeMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_max'],
      ),
      lotNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_number'],
      )!,
      scaScore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sca_score'],
      )!,
      cupsScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cups_score'],
      )!,
      sensoryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensory_json'],
      )!,
      priceJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_json'],
      )!,
      plantationPhotosUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plantation_photos_url'],
      )!,
      harvestSeason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}harvest_season'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weight'],
      ),
      roastDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_date'],
      ),
      processingMethodsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_methods_json'],
      )!,
      isPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_premium'],
      )!,
      detailedProcessMarkdown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detailed_process_markdown'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}farmer_id'],
      ),
      isDecaf: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_decaf'],
      )!,
      farm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm'],
      ),
      farmPhotosUrlCover: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_photos_url_cover'],
      ),
      washStation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wash_station'],
      ),
      retailPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}retail_price'],
      ),
      wholesalePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wholesale_price'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      flagUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flag_url'],
      )!,
      radarJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}radar_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $LocalizedBeansV2Table createAlias(String alias) {
    return $LocalizedBeansV2Table(attachedDatabase, alias);
  }
}

class LocalizedBeansV2Data extends DataClass
    implements Insertable<LocalizedBeansV2Data> {
  final int id;
  final int? brandId;
  final String? countryEmoji;
  final int? altitudeMin;
  final int? altitudeMax;
  final String lotNumber;
  final String scaScore;
  final double cupsScore;
  final String sensoryJson;
  final String priceJson;
  final String plantationPhotosUrl;
  final String? harvestSeason;
  final String? price;
  final String? weight;
  final String? roastDate;
  final String processingMethodsJson;
  final bool isPremium;
  final String detailedProcessMarkdown;
  final String url;
  final int? farmerId;
  final bool isDecaf;
  final String? farm;
  final String? farmPhotosUrlCover;
  final String? washStation;
  final String? retailPrice;
  final String? wholesalePrice;
  final bool isFavorite;
  final String flagUrl;
  final String radarJson;
  final DateTime? createdAt;
  const LocalizedBeansV2Data({
    required this.id,
    this.brandId,
    this.countryEmoji,
    this.altitudeMin,
    this.altitudeMax,
    required this.lotNumber,
    required this.scaScore,
    required this.cupsScore,
    required this.sensoryJson,
    required this.priceJson,
    required this.plantationPhotosUrl,
    this.harvestSeason,
    this.price,
    this.weight,
    this.roastDate,
    required this.processingMethodsJson,
    required this.isPremium,
    required this.detailedProcessMarkdown,
    required this.url,
    this.farmerId,
    required this.isDecaf,
    this.farm,
    this.farmPhotosUrlCover,
    this.washStation,
    this.retailPrice,
    this.wholesalePrice,
    required this.isFavorite,
    required this.flagUrl,
    required this.radarJson,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || brandId != null) {
      map['brand_id'] = Variable<int>(brandId);
    }
    if (!nullToAbsent || countryEmoji != null) {
      map['country_emoji'] = Variable<String>(countryEmoji);
    }
    if (!nullToAbsent || altitudeMin != null) {
      map['altitude_min'] = Variable<int>(altitudeMin);
    }
    if (!nullToAbsent || altitudeMax != null) {
      map['altitude_max'] = Variable<int>(altitudeMax);
    }
    map['lot_number'] = Variable<String>(lotNumber);
    map['sca_score'] = Variable<String>(scaScore);
    map['cups_score'] = Variable<double>(cupsScore);
    map['sensory_json'] = Variable<String>(sensoryJson);
    map['price_json'] = Variable<String>(priceJson);
    map['plantation_photos_url'] = Variable<String>(plantationPhotosUrl);
    if (!nullToAbsent || harvestSeason != null) {
      map['harvest_season'] = Variable<String>(harvestSeason);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<String>(price);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<String>(weight);
    }
    if (!nullToAbsent || roastDate != null) {
      map['roast_date'] = Variable<String>(roastDate);
    }
    map['processing_methods_json'] = Variable<String>(processingMethodsJson);
    map['is_premium'] = Variable<bool>(isPremium);
    map['detailed_process_markdown'] = Variable<String>(
      detailedProcessMarkdown,
    );
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || farmerId != null) {
      map['farmer_id'] = Variable<int>(farmerId);
    }
    map['is_decaf'] = Variable<bool>(isDecaf);
    if (!nullToAbsent || farm != null) {
      map['farm'] = Variable<String>(farm);
    }
    if (!nullToAbsent || farmPhotosUrlCover != null) {
      map['farm_photos_url_cover'] = Variable<String>(farmPhotosUrlCover);
    }
    if (!nullToAbsent || washStation != null) {
      map['wash_station'] = Variable<String>(washStation);
    }
    if (!nullToAbsent || retailPrice != null) {
      map['retail_price'] = Variable<String>(retailPrice);
    }
    if (!nullToAbsent || wholesalePrice != null) {
      map['wholesale_price'] = Variable<String>(wholesalePrice);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['flag_url'] = Variable<String>(flagUrl);
    map['radar_json'] = Variable<String>(radarJson);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  LocalizedBeansV2Companion toCompanion(bool nullToAbsent) {
    return LocalizedBeansV2Companion(
      id: Value(id),
      brandId: brandId == null && nullToAbsent
          ? const Value.absent()
          : Value(brandId),
      countryEmoji: countryEmoji == null && nullToAbsent
          ? const Value.absent()
          : Value(countryEmoji),
      altitudeMin: altitudeMin == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMin),
      altitudeMax: altitudeMax == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMax),
      lotNumber: Value(lotNumber),
      scaScore: Value(scaScore),
      cupsScore: Value(cupsScore),
      sensoryJson: Value(sensoryJson),
      priceJson: Value(priceJson),
      plantationPhotosUrl: Value(plantationPhotosUrl),
      harvestSeason: harvestSeason == null && nullToAbsent
          ? const Value.absent()
          : Value(harvestSeason),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      roastDate: roastDate == null && nullToAbsent
          ? const Value.absent()
          : Value(roastDate),
      processingMethodsJson: Value(processingMethodsJson),
      isPremium: Value(isPremium),
      detailedProcessMarkdown: Value(detailedProcessMarkdown),
      url: Value(url),
      farmerId: farmerId == null && nullToAbsent
          ? const Value.absent()
          : Value(farmerId),
      isDecaf: Value(isDecaf),
      farm: farm == null && nullToAbsent ? const Value.absent() : Value(farm),
      farmPhotosUrlCover: farmPhotosUrlCover == null && nullToAbsent
          ? const Value.absent()
          : Value(farmPhotosUrlCover),
      washStation: washStation == null && nullToAbsent
          ? const Value.absent()
          : Value(washStation),
      retailPrice: retailPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(retailPrice),
      wholesalePrice: wholesalePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(wholesalePrice),
      isFavorite: Value(isFavorite),
      flagUrl: Value(flagUrl),
      radarJson: Value(radarJson),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory LocalizedBeansV2Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedBeansV2Data(
      id: serializer.fromJson<int>(json['id']),
      brandId: serializer.fromJson<int?>(json['brandId']),
      countryEmoji: serializer.fromJson<String?>(json['countryEmoji']),
      altitudeMin: serializer.fromJson<int?>(json['altitudeMin']),
      altitudeMax: serializer.fromJson<int?>(json['altitudeMax']),
      lotNumber: serializer.fromJson<String>(json['lotNumber']),
      scaScore: serializer.fromJson<String>(json['scaScore']),
      cupsScore: serializer.fromJson<double>(json['cupsScore']),
      sensoryJson: serializer.fromJson<String>(json['sensoryJson']),
      priceJson: serializer.fromJson<String>(json['priceJson']),
      plantationPhotosUrl: serializer.fromJson<String>(
        json['plantationPhotosUrl'],
      ),
      harvestSeason: serializer.fromJson<String?>(json['harvestSeason']),
      price: serializer.fromJson<String?>(json['price']),
      weight: serializer.fromJson<String?>(json['weight']),
      roastDate: serializer.fromJson<String?>(json['roastDate']),
      processingMethodsJson: serializer.fromJson<String>(
        json['processingMethodsJson'],
      ),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
      detailedProcessMarkdown: serializer.fromJson<String>(
        json['detailedProcessMarkdown'],
      ),
      url: serializer.fromJson<String>(json['url']),
      farmerId: serializer.fromJson<int?>(json['farmerId']),
      isDecaf: serializer.fromJson<bool>(json['isDecaf']),
      farm: serializer.fromJson<String?>(json['farm']),
      farmPhotosUrlCover: serializer.fromJson<String?>(
        json['farmPhotosUrlCover'],
      ),
      washStation: serializer.fromJson<String?>(json['washStation']),
      retailPrice: serializer.fromJson<String?>(json['retailPrice']),
      wholesalePrice: serializer.fromJson<String?>(json['wholesalePrice']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      flagUrl: serializer.fromJson<String>(json['flagUrl']),
      radarJson: serializer.fromJson<String>(json['radarJson']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brandId': serializer.toJson<int?>(brandId),
      'countryEmoji': serializer.toJson<String?>(countryEmoji),
      'altitudeMin': serializer.toJson<int?>(altitudeMin),
      'altitudeMax': serializer.toJson<int?>(altitudeMax),
      'lotNumber': serializer.toJson<String>(lotNumber),
      'scaScore': serializer.toJson<String>(scaScore),
      'cupsScore': serializer.toJson<double>(cupsScore),
      'sensoryJson': serializer.toJson<String>(sensoryJson),
      'priceJson': serializer.toJson<String>(priceJson),
      'plantationPhotosUrl': serializer.toJson<String>(plantationPhotosUrl),
      'harvestSeason': serializer.toJson<String?>(harvestSeason),
      'price': serializer.toJson<String?>(price),
      'weight': serializer.toJson<String?>(weight),
      'roastDate': serializer.toJson<String?>(roastDate),
      'processingMethodsJson': serializer.toJson<String>(processingMethodsJson),
      'isPremium': serializer.toJson<bool>(isPremium),
      'detailedProcessMarkdown': serializer.toJson<String>(
        detailedProcessMarkdown,
      ),
      'url': serializer.toJson<String>(url),
      'farmerId': serializer.toJson<int?>(farmerId),
      'isDecaf': serializer.toJson<bool>(isDecaf),
      'farm': serializer.toJson<String?>(farm),
      'farmPhotosUrlCover': serializer.toJson<String?>(farmPhotosUrlCover),
      'washStation': serializer.toJson<String?>(washStation),
      'retailPrice': serializer.toJson<String?>(retailPrice),
      'wholesalePrice': serializer.toJson<String?>(wholesalePrice),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'flagUrl': serializer.toJson<String>(flagUrl),
      'radarJson': serializer.toJson<String>(radarJson),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  LocalizedBeansV2Data copyWith({
    int? id,
    Value<int?> brandId = const Value.absent(),
    Value<String?> countryEmoji = const Value.absent(),
    Value<int?> altitudeMin = const Value.absent(),
    Value<int?> altitudeMax = const Value.absent(),
    String? lotNumber,
    String? scaScore,
    double? cupsScore,
    String? sensoryJson,
    String? priceJson,
    String? plantationPhotosUrl,
    Value<String?> harvestSeason = const Value.absent(),
    Value<String?> price = const Value.absent(),
    Value<String?> weight = const Value.absent(),
    Value<String?> roastDate = const Value.absent(),
    String? processingMethodsJson,
    bool? isPremium,
    String? detailedProcessMarkdown,
    String? url,
    Value<int?> farmerId = const Value.absent(),
    bool? isDecaf,
    Value<String?> farm = const Value.absent(),
    Value<String?> farmPhotosUrlCover = const Value.absent(),
    Value<String?> washStation = const Value.absent(),
    Value<String?> retailPrice = const Value.absent(),
    Value<String?> wholesalePrice = const Value.absent(),
    bool? isFavorite,
    String? flagUrl,
    String? radarJson,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => LocalizedBeansV2Data(
    id: id ?? this.id,
    brandId: brandId.present ? brandId.value : this.brandId,
    countryEmoji: countryEmoji.present ? countryEmoji.value : this.countryEmoji,
    altitudeMin: altitudeMin.present ? altitudeMin.value : this.altitudeMin,
    altitudeMax: altitudeMax.present ? altitudeMax.value : this.altitudeMax,
    lotNumber: lotNumber ?? this.lotNumber,
    scaScore: scaScore ?? this.scaScore,
    cupsScore: cupsScore ?? this.cupsScore,
    sensoryJson: sensoryJson ?? this.sensoryJson,
    priceJson: priceJson ?? this.priceJson,
    plantationPhotosUrl: plantationPhotosUrl ?? this.plantationPhotosUrl,
    harvestSeason: harvestSeason.present
        ? harvestSeason.value
        : this.harvestSeason,
    price: price.present ? price.value : this.price,
    weight: weight.present ? weight.value : this.weight,
    roastDate: roastDate.present ? roastDate.value : this.roastDate,
    processingMethodsJson: processingMethodsJson ?? this.processingMethodsJson,
    isPremium: isPremium ?? this.isPremium,
    detailedProcessMarkdown:
        detailedProcessMarkdown ?? this.detailedProcessMarkdown,
    url: url ?? this.url,
    farmerId: farmerId.present ? farmerId.value : this.farmerId,
    isDecaf: isDecaf ?? this.isDecaf,
    farm: farm.present ? farm.value : this.farm,
    farmPhotosUrlCover: farmPhotosUrlCover.present
        ? farmPhotosUrlCover.value
        : this.farmPhotosUrlCover,
    washStation: washStation.present ? washStation.value : this.washStation,
    retailPrice: retailPrice.present ? retailPrice.value : this.retailPrice,
    wholesalePrice: wholesalePrice.present
        ? wholesalePrice.value
        : this.wholesalePrice,
    isFavorite: isFavorite ?? this.isFavorite,
    flagUrl: flagUrl ?? this.flagUrl,
    radarJson: radarJson ?? this.radarJson,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  LocalizedBeansV2Data copyWithCompanion(LocalizedBeansV2Companion data) {
    return LocalizedBeansV2Data(
      id: data.id.present ? data.id.value : this.id,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      countryEmoji: data.countryEmoji.present
          ? data.countryEmoji.value
          : this.countryEmoji,
      altitudeMin: data.altitudeMin.present
          ? data.altitudeMin.value
          : this.altitudeMin,
      altitudeMax: data.altitudeMax.present
          ? data.altitudeMax.value
          : this.altitudeMax,
      lotNumber: data.lotNumber.present ? data.lotNumber.value : this.lotNumber,
      scaScore: data.scaScore.present ? data.scaScore.value : this.scaScore,
      cupsScore: data.cupsScore.present ? data.cupsScore.value : this.cupsScore,
      sensoryJson: data.sensoryJson.present
          ? data.sensoryJson.value
          : this.sensoryJson,
      priceJson: data.priceJson.present ? data.priceJson.value : this.priceJson,
      plantationPhotosUrl: data.plantationPhotosUrl.present
          ? data.plantationPhotosUrl.value
          : this.plantationPhotosUrl,
      harvestSeason: data.harvestSeason.present
          ? data.harvestSeason.value
          : this.harvestSeason,
      price: data.price.present ? data.price.value : this.price,
      weight: data.weight.present ? data.weight.value : this.weight,
      roastDate: data.roastDate.present ? data.roastDate.value : this.roastDate,
      processingMethodsJson: data.processingMethodsJson.present
          ? data.processingMethodsJson.value
          : this.processingMethodsJson,
      isPremium: data.isPremium.present ? data.isPremium.value : this.isPremium,
      detailedProcessMarkdown: data.detailedProcessMarkdown.present
          ? data.detailedProcessMarkdown.value
          : this.detailedProcessMarkdown,
      url: data.url.present ? data.url.value : this.url,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      isDecaf: data.isDecaf.present ? data.isDecaf.value : this.isDecaf,
      farm: data.farm.present ? data.farm.value : this.farm,
      farmPhotosUrlCover: data.farmPhotosUrlCover.present
          ? data.farmPhotosUrlCover.value
          : this.farmPhotosUrlCover,
      washStation: data.washStation.present
          ? data.washStation.value
          : this.washStation,
      retailPrice: data.retailPrice.present
          ? data.retailPrice.value
          : this.retailPrice,
      wholesalePrice: data.wholesalePrice.present
          ? data.wholesalePrice.value
          : this.wholesalePrice,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      flagUrl: data.flagUrl.present ? data.flagUrl.value : this.flagUrl,
      radarJson: data.radarJson.present ? data.radarJson.value : this.radarJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBeansV2Data(')
          ..write('id: $id, ')
          ..write('brandId: $brandId, ')
          ..write('countryEmoji: $countryEmoji, ')
          ..write('altitudeMin: $altitudeMin, ')
          ..write('altitudeMax: $altitudeMax, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('scaScore: $scaScore, ')
          ..write('cupsScore: $cupsScore, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('priceJson: $priceJson, ')
          ..write('plantationPhotosUrl: $plantationPhotosUrl, ')
          ..write('harvestSeason: $harvestSeason, ')
          ..write('price: $price, ')
          ..write('weight: $weight, ')
          ..write('roastDate: $roastDate, ')
          ..write('processingMethodsJson: $processingMethodsJson, ')
          ..write('isPremium: $isPremium, ')
          ..write('detailedProcessMarkdown: $detailedProcessMarkdown, ')
          ..write('url: $url, ')
          ..write('farmerId: $farmerId, ')
          ..write('isDecaf: $isDecaf, ')
          ..write('farm: $farm, ')
          ..write('farmPhotosUrlCover: $farmPhotosUrlCover, ')
          ..write('washStation: $washStation, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('radarJson: $radarJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    brandId,
    countryEmoji,
    altitudeMin,
    altitudeMax,
    lotNumber,
    scaScore,
    cupsScore,
    sensoryJson,
    priceJson,
    plantationPhotosUrl,
    harvestSeason,
    price,
    weight,
    roastDate,
    processingMethodsJson,
    isPremium,
    detailedProcessMarkdown,
    url,
    farmerId,
    isDecaf,
    farm,
    farmPhotosUrlCover,
    washStation,
    retailPrice,
    wholesalePrice,
    isFavorite,
    flagUrl,
    radarJson,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedBeansV2Data &&
          other.id == this.id &&
          other.brandId == this.brandId &&
          other.countryEmoji == this.countryEmoji &&
          other.altitudeMin == this.altitudeMin &&
          other.altitudeMax == this.altitudeMax &&
          other.lotNumber == this.lotNumber &&
          other.scaScore == this.scaScore &&
          other.cupsScore == this.cupsScore &&
          other.sensoryJson == this.sensoryJson &&
          other.priceJson == this.priceJson &&
          other.plantationPhotosUrl == this.plantationPhotosUrl &&
          other.harvestSeason == this.harvestSeason &&
          other.price == this.price &&
          other.weight == this.weight &&
          other.roastDate == this.roastDate &&
          other.processingMethodsJson == this.processingMethodsJson &&
          other.isPremium == this.isPremium &&
          other.detailedProcessMarkdown == this.detailedProcessMarkdown &&
          other.url == this.url &&
          other.farmerId == this.farmerId &&
          other.isDecaf == this.isDecaf &&
          other.farm == this.farm &&
          other.farmPhotosUrlCover == this.farmPhotosUrlCover &&
          other.washStation == this.washStation &&
          other.retailPrice == this.retailPrice &&
          other.wholesalePrice == this.wholesalePrice &&
          other.isFavorite == this.isFavorite &&
          other.flagUrl == this.flagUrl &&
          other.radarJson == this.radarJson &&
          other.createdAt == this.createdAt);
}

class LocalizedBeansV2Companion extends UpdateCompanion<LocalizedBeansV2Data> {
  final Value<int> id;
  final Value<int?> brandId;
  final Value<String?> countryEmoji;
  final Value<int?> altitudeMin;
  final Value<int?> altitudeMax;
  final Value<String> lotNumber;
  final Value<String> scaScore;
  final Value<double> cupsScore;
  final Value<String> sensoryJson;
  final Value<String> priceJson;
  final Value<String> plantationPhotosUrl;
  final Value<String?> harvestSeason;
  final Value<String?> price;
  final Value<String?> weight;
  final Value<String?> roastDate;
  final Value<String> processingMethodsJson;
  final Value<bool> isPremium;
  final Value<String> detailedProcessMarkdown;
  final Value<String> url;
  final Value<int?> farmerId;
  final Value<bool> isDecaf;
  final Value<String?> farm;
  final Value<String?> farmPhotosUrlCover;
  final Value<String?> washStation;
  final Value<String?> retailPrice;
  final Value<String?> wholesalePrice;
  final Value<bool> isFavorite;
  final Value<String> flagUrl;
  final Value<String> radarJson;
  final Value<DateTime?> createdAt;
  const LocalizedBeansV2Companion({
    this.id = const Value.absent(),
    this.brandId = const Value.absent(),
    this.countryEmoji = const Value.absent(),
    this.altitudeMin = const Value.absent(),
    this.altitudeMax = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.scaScore = const Value.absent(),
    this.cupsScore = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.priceJson = const Value.absent(),
    this.plantationPhotosUrl = const Value.absent(),
    this.harvestSeason = const Value.absent(),
    this.price = const Value.absent(),
    this.weight = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.processingMethodsJson = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.detailedProcessMarkdown = const Value.absent(),
    this.url = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.isDecaf = const Value.absent(),
    this.farm = const Value.absent(),
    this.farmPhotosUrlCover = const Value.absent(),
    this.washStation = const Value.absent(),
    this.retailPrice = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.radarJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocalizedBeansV2Companion.insert({
    this.id = const Value.absent(),
    this.brandId = const Value.absent(),
    this.countryEmoji = const Value.absent(),
    this.altitudeMin = const Value.absent(),
    this.altitudeMax = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.scaScore = const Value.absent(),
    this.cupsScore = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.priceJson = const Value.absent(),
    this.plantationPhotosUrl = const Value.absent(),
    this.harvestSeason = const Value.absent(),
    this.price = const Value.absent(),
    this.weight = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.processingMethodsJson = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.detailedProcessMarkdown = const Value.absent(),
    this.url = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.isDecaf = const Value.absent(),
    this.farm = const Value.absent(),
    this.farmPhotosUrlCover = const Value.absent(),
    this.washStation = const Value.absent(),
    this.retailPrice = const Value.absent(),
    this.wholesalePrice = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.radarJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<LocalizedBeansV2Data> custom({
    Expression<int>? id,
    Expression<int>? brandId,
    Expression<String>? countryEmoji,
    Expression<int>? altitudeMin,
    Expression<int>? altitudeMax,
    Expression<String>? lotNumber,
    Expression<String>? scaScore,
    Expression<double>? cupsScore,
    Expression<String>? sensoryJson,
    Expression<String>? priceJson,
    Expression<String>? plantationPhotosUrl,
    Expression<String>? harvestSeason,
    Expression<String>? price,
    Expression<String>? weight,
    Expression<String>? roastDate,
    Expression<String>? processingMethodsJson,
    Expression<bool>? isPremium,
    Expression<String>? detailedProcessMarkdown,
    Expression<String>? url,
    Expression<int>? farmerId,
    Expression<bool>? isDecaf,
    Expression<String>? farm,
    Expression<String>? farmPhotosUrlCover,
    Expression<String>? washStation,
    Expression<String>? retailPrice,
    Expression<String>? wholesalePrice,
    Expression<bool>? isFavorite,
    Expression<String>? flagUrl,
    Expression<String>? radarJson,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brandId != null) 'brand_id': brandId,
      if (countryEmoji != null) 'country_emoji': countryEmoji,
      if (altitudeMin != null) 'altitude_min': altitudeMin,
      if (altitudeMax != null) 'altitude_max': altitudeMax,
      if (lotNumber != null) 'lot_number': lotNumber,
      if (scaScore != null) 'sca_score': scaScore,
      if (cupsScore != null) 'cups_score': cupsScore,
      if (sensoryJson != null) 'sensory_json': sensoryJson,
      if (priceJson != null) 'price_json': priceJson,
      if (plantationPhotosUrl != null)
        'plantation_photos_url': plantationPhotosUrl,
      if (harvestSeason != null) 'harvest_season': harvestSeason,
      if (price != null) 'price': price,
      if (weight != null) 'weight': weight,
      if (roastDate != null) 'roast_date': roastDate,
      if (processingMethodsJson != null)
        'processing_methods_json': processingMethodsJson,
      if (isPremium != null) 'is_premium': isPremium,
      if (detailedProcessMarkdown != null)
        'detailed_process_markdown': detailedProcessMarkdown,
      if (url != null) 'url': url,
      if (farmerId != null) 'farmer_id': farmerId,
      if (isDecaf != null) 'is_decaf': isDecaf,
      if (farm != null) 'farm': farm,
      if (farmPhotosUrlCover != null)
        'farm_photos_url_cover': farmPhotosUrlCover,
      if (washStation != null) 'wash_station': washStation,
      if (retailPrice != null) 'retail_price': retailPrice,
      if (wholesalePrice != null) 'wholesale_price': wholesalePrice,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (flagUrl != null) 'flag_url': flagUrl,
      if (radarJson != null) 'radar_json': radarJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocalizedBeansV2Companion copyWith({
    Value<int>? id,
    Value<int?>? brandId,
    Value<String?>? countryEmoji,
    Value<int?>? altitudeMin,
    Value<int?>? altitudeMax,
    Value<String>? lotNumber,
    Value<String>? scaScore,
    Value<double>? cupsScore,
    Value<String>? sensoryJson,
    Value<String>? priceJson,
    Value<String>? plantationPhotosUrl,
    Value<String?>? harvestSeason,
    Value<String?>? price,
    Value<String?>? weight,
    Value<String?>? roastDate,
    Value<String>? processingMethodsJson,
    Value<bool>? isPremium,
    Value<String>? detailedProcessMarkdown,
    Value<String>? url,
    Value<int?>? farmerId,
    Value<bool>? isDecaf,
    Value<String?>? farm,
    Value<String?>? farmPhotosUrlCover,
    Value<String?>? washStation,
    Value<String?>? retailPrice,
    Value<String?>? wholesalePrice,
    Value<bool>? isFavorite,
    Value<String>? flagUrl,
    Value<String>? radarJson,
    Value<DateTime?>? createdAt,
  }) {
    return LocalizedBeansV2Companion(
      id: id ?? this.id,
      brandId: brandId ?? this.brandId,
      countryEmoji: countryEmoji ?? this.countryEmoji,
      altitudeMin: altitudeMin ?? this.altitudeMin,
      altitudeMax: altitudeMax ?? this.altitudeMax,
      lotNumber: lotNumber ?? this.lotNumber,
      scaScore: scaScore ?? this.scaScore,
      cupsScore: cupsScore ?? this.cupsScore,
      sensoryJson: sensoryJson ?? this.sensoryJson,
      priceJson: priceJson ?? this.priceJson,
      plantationPhotosUrl: plantationPhotosUrl ?? this.plantationPhotosUrl,
      harvestSeason: harvestSeason ?? this.harvestSeason,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      roastDate: roastDate ?? this.roastDate,
      processingMethodsJson:
          processingMethodsJson ?? this.processingMethodsJson,
      isPremium: isPremium ?? this.isPremium,
      detailedProcessMarkdown:
          detailedProcessMarkdown ?? this.detailedProcessMarkdown,
      url: url ?? this.url,
      farmerId: farmerId ?? this.farmerId,
      isDecaf: isDecaf ?? this.isDecaf,
      farm: farm ?? this.farm,
      farmPhotosUrlCover: farmPhotosUrlCover ?? this.farmPhotosUrlCover,
      washStation: washStation ?? this.washStation,
      retailPrice: retailPrice ?? this.retailPrice,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
      isFavorite: isFavorite ?? this.isFavorite,
      flagUrl: flagUrl ?? this.flagUrl,
      radarJson: radarJson ?? this.radarJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brandId.present) {
      map['brand_id'] = Variable<int>(brandId.value);
    }
    if (countryEmoji.present) {
      map['country_emoji'] = Variable<String>(countryEmoji.value);
    }
    if (altitudeMin.present) {
      map['altitude_min'] = Variable<int>(altitudeMin.value);
    }
    if (altitudeMax.present) {
      map['altitude_max'] = Variable<int>(altitudeMax.value);
    }
    if (lotNumber.present) {
      map['lot_number'] = Variable<String>(lotNumber.value);
    }
    if (scaScore.present) {
      map['sca_score'] = Variable<String>(scaScore.value);
    }
    if (cupsScore.present) {
      map['cups_score'] = Variable<double>(cupsScore.value);
    }
    if (sensoryJson.present) {
      map['sensory_json'] = Variable<String>(sensoryJson.value);
    }
    if (priceJson.present) {
      map['price_json'] = Variable<String>(priceJson.value);
    }
    if (plantationPhotosUrl.present) {
      map['plantation_photos_url'] = Variable<String>(
        plantationPhotosUrl.value,
      );
    }
    if (harvestSeason.present) {
      map['harvest_season'] = Variable<String>(harvestSeason.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (weight.present) {
      map['weight'] = Variable<String>(weight.value);
    }
    if (roastDate.present) {
      map['roast_date'] = Variable<String>(roastDate.value);
    }
    if (processingMethodsJson.present) {
      map['processing_methods_json'] = Variable<String>(
        processingMethodsJson.value,
      );
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    if (detailedProcessMarkdown.present) {
      map['detailed_process_markdown'] = Variable<String>(
        detailedProcessMarkdown.value,
      );
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<int>(farmerId.value);
    }
    if (isDecaf.present) {
      map['is_decaf'] = Variable<bool>(isDecaf.value);
    }
    if (farm.present) {
      map['farm'] = Variable<String>(farm.value);
    }
    if (farmPhotosUrlCover.present) {
      map['farm_photos_url_cover'] = Variable<String>(farmPhotosUrlCover.value);
    }
    if (washStation.present) {
      map['wash_station'] = Variable<String>(washStation.value);
    }
    if (retailPrice.present) {
      map['retail_price'] = Variable<String>(retailPrice.value);
    }
    if (wholesalePrice.present) {
      map['wholesale_price'] = Variable<String>(wholesalePrice.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (flagUrl.present) {
      map['flag_url'] = Variable<String>(flagUrl.value);
    }
    if (radarJson.present) {
      map['radar_json'] = Variable<String>(radarJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBeansV2Companion(')
          ..write('id: $id, ')
          ..write('brandId: $brandId, ')
          ..write('countryEmoji: $countryEmoji, ')
          ..write('altitudeMin: $altitudeMin, ')
          ..write('altitudeMax: $altitudeMax, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('scaScore: $scaScore, ')
          ..write('cupsScore: $cupsScore, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('priceJson: $priceJson, ')
          ..write('plantationPhotosUrl: $plantationPhotosUrl, ')
          ..write('harvestSeason: $harvestSeason, ')
          ..write('price: $price, ')
          ..write('weight: $weight, ')
          ..write('roastDate: $roastDate, ')
          ..write('processingMethodsJson: $processingMethodsJson, ')
          ..write('isPremium: $isPremium, ')
          ..write('detailedProcessMarkdown: $detailedProcessMarkdown, ')
          ..write('url: $url, ')
          ..write('farmerId: $farmerId, ')
          ..write('isDecaf: $isDecaf, ')
          ..write('farm: $farm, ')
          ..write('farmPhotosUrlCover: $farmPhotosUrlCover, ')
          ..write('washStation: $washStation, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('wholesalePrice: $wholesalePrice, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('radarJson: $radarJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LocalizedBeanTranslationsV2Table extends LocalizedBeanTranslationsV2
    with
        TableInfo<
          $LocalizedBeanTranslationsV2Table,
          LocalizedBeanTranslationsV2Data
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizedBeanTranslationsV2Table(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _beanIdMeta = const VerificationMeta('beanId');
  @override
  late final GeneratedColumn<int> beanId = GeneratedColumn<int>(
    'bean_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES localized_beans_v2 (id)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _varietiesMeta = const VerificationMeta(
    'varieties',
  );
  @override
  late final GeneratedColumn<String> varieties = GeneratedColumn<String>(
    'varieties',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _processMethodMeta = const VerificationMeta(
    'processMethod',
  );
  @override
  late final GeneratedColumn<String> processMethod = GeneratedColumn<String>(
    'process_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmDescriptionMeta = const VerificationMeta(
    'farmDescription',
  );
  @override
  late final GeneratedColumn<String> farmDescription = GeneratedColumn<String>(
    'farm_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastLevelMeta = const VerificationMeta(
    'roastLevel',
  );
  @override
  late final GeneratedColumn<String> roastLevel = GeneratedColumn<String>(
    'roast_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    beanId,
    languageCode,
    country,
    region,
    varieties,
    flavorNotes,
    processMethod,
    description,
    farmDescription,
    roastLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localized_bean_translations_v2';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalizedBeanTranslationsV2Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bean_id')) {
      context.handle(
        _beanIdMeta,
        beanId.isAcceptableOrUnknown(data['bean_id']!, _beanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_beanIdMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('varieties')) {
      context.handle(
        _varietiesMeta,
        varieties.isAcceptableOrUnknown(data['varieties']!, _varietiesMeta),
      );
    }
    if (data.containsKey('flavor_notes')) {
      context.handle(
        _flavorNotesMeta,
        flavorNotes.isAcceptableOrUnknown(
          data['flavor_notes']!,
          _flavorNotesMeta,
        ),
      );
    }
    if (data.containsKey('process_method')) {
      context.handle(
        _processMethodMeta,
        processMethod.isAcceptableOrUnknown(
          data['process_method']!,
          _processMethodMeta,
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
    if (data.containsKey('roast_level')) {
      context.handle(
        _roastLevelMeta,
        roastLevel.isAcceptableOrUnknown(data['roast_level']!, _roastLevelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {beanId, languageCode};
  @override
  LocalizedBeanTranslationsV2Data map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizedBeanTranslationsV2Data(
      beanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bean_id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      varieties: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}varieties'],
      ),
      flavorNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavor_notes'],
      )!,
      processMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process_method'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      farmDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_description'],
      ),
      roastLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roast_level'],
      ),
    );
  }

  @override
  $LocalizedBeanTranslationsV2Table createAlias(String alias) {
    return $LocalizedBeanTranslationsV2Table(attachedDatabase, alias);
  }
}

class LocalizedBeanTranslationsV2Data extends DataClass
    implements Insertable<LocalizedBeanTranslationsV2Data> {
  final int beanId;
  final String languageCode;
  final String? country;
  final String? region;
  final String? varieties;
  final String flavorNotes;
  final String? processMethod;
  final String? description;
  final String? farmDescription;
  final String? roastLevel;
  const LocalizedBeanTranslationsV2Data({
    required this.beanId,
    required this.languageCode,
    this.country,
    this.region,
    this.varieties,
    required this.flavorNotes,
    this.processMethod,
    this.description,
    this.farmDescription,
    this.roastLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bean_id'] = Variable<int>(beanId);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || varieties != null) {
      map['varieties'] = Variable<String>(varieties);
    }
    map['flavor_notes'] = Variable<String>(flavorNotes);
    if (!nullToAbsent || processMethod != null) {
      map['process_method'] = Variable<String>(processMethod);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || farmDescription != null) {
      map['farm_description'] = Variable<String>(farmDescription);
    }
    if (!nullToAbsent || roastLevel != null) {
      map['roast_level'] = Variable<String>(roastLevel);
    }
    return map;
  }

  LocalizedBeanTranslationsV2Companion toCompanion(bool nullToAbsent) {
    return LocalizedBeanTranslationsV2Companion(
      beanId: Value(beanId),
      languageCode: Value(languageCode),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      varieties: varieties == null && nullToAbsent
          ? const Value.absent()
          : Value(varieties),
      flavorNotes: Value(flavorNotes),
      processMethod: processMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(processMethod),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      farmDescription: farmDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(farmDescription),
      roastLevel: roastLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(roastLevel),
    );
  }

  factory LocalizedBeanTranslationsV2Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizedBeanTranslationsV2Data(
      beanId: serializer.fromJson<int>(json['beanId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      country: serializer.fromJson<String?>(json['country']),
      region: serializer.fromJson<String?>(json['region']),
      varieties: serializer.fromJson<String?>(json['varieties']),
      flavorNotes: serializer.fromJson<String>(json['flavorNotes']),
      processMethod: serializer.fromJson<String?>(json['processMethod']),
      description: serializer.fromJson<String?>(json['description']),
      farmDescription: serializer.fromJson<String?>(json['farmDescription']),
      roastLevel: serializer.fromJson<String?>(json['roastLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'beanId': serializer.toJson<int>(beanId),
      'languageCode': serializer.toJson<String>(languageCode),
      'country': serializer.toJson<String?>(country),
      'region': serializer.toJson<String?>(region),
      'varieties': serializer.toJson<String?>(varieties),
      'flavorNotes': serializer.toJson<String>(flavorNotes),
      'processMethod': serializer.toJson<String?>(processMethod),
      'description': serializer.toJson<String?>(description),
      'farmDescription': serializer.toJson<String?>(farmDescription),
      'roastLevel': serializer.toJson<String?>(roastLevel),
    };
  }

  LocalizedBeanTranslationsV2Data copyWith({
    int? beanId,
    String? languageCode,
    Value<String?> country = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> varieties = const Value.absent(),
    String? flavorNotes,
    Value<String?> processMethod = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> farmDescription = const Value.absent(),
    Value<String?> roastLevel = const Value.absent(),
  }) => LocalizedBeanTranslationsV2Data(
    beanId: beanId ?? this.beanId,
    languageCode: languageCode ?? this.languageCode,
    country: country.present ? country.value : this.country,
    region: region.present ? region.value : this.region,
    varieties: varieties.present ? varieties.value : this.varieties,
    flavorNotes: flavorNotes ?? this.flavorNotes,
    processMethod: processMethod.present
        ? processMethod.value
        : this.processMethod,
    description: description.present ? description.value : this.description,
    farmDescription: farmDescription.present
        ? farmDescription.value
        : this.farmDescription,
    roastLevel: roastLevel.present ? roastLevel.value : this.roastLevel,
  );
  LocalizedBeanTranslationsV2Data copyWithCompanion(
    LocalizedBeanTranslationsV2Companion data,
  ) {
    return LocalizedBeanTranslationsV2Data(
      beanId: data.beanId.present ? data.beanId.value : this.beanId,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      country: data.country.present ? data.country.value : this.country,
      region: data.region.present ? data.region.value : this.region,
      varieties: data.varieties.present ? data.varieties.value : this.varieties,
      flavorNotes: data.flavorNotes.present
          ? data.flavorNotes.value
          : this.flavorNotes,
      processMethod: data.processMethod.present
          ? data.processMethod.value
          : this.processMethod,
      description: data.description.present
          ? data.description.value
          : this.description,
      farmDescription: data.farmDescription.present
          ? data.farmDescription.value
          : this.farmDescription,
      roastLevel: data.roastLevel.present
          ? data.roastLevel.value
          : this.roastLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBeanTranslationsV2Data(')
          ..write('beanId: $beanId, ')
          ..write('languageCode: $languageCode, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('varieties: $varieties, ')
          ..write('flavorNotes: $flavorNotes, ')
          ..write('processMethod: $processMethod, ')
          ..write('description: $description, ')
          ..write('farmDescription: $farmDescription, ')
          ..write('roastLevel: $roastLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    beanId,
    languageCode,
    country,
    region,
    varieties,
    flavorNotes,
    processMethod,
    description,
    farmDescription,
    roastLevel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedBeanTranslationsV2Data &&
          other.beanId == this.beanId &&
          other.languageCode == this.languageCode &&
          other.country == this.country &&
          other.region == this.region &&
          other.varieties == this.varieties &&
          other.flavorNotes == this.flavorNotes &&
          other.processMethod == this.processMethod &&
          other.description == this.description &&
          other.farmDescription == this.farmDescription &&
          other.roastLevel == this.roastLevel);
}

class LocalizedBeanTranslationsV2Companion
    extends UpdateCompanion<LocalizedBeanTranslationsV2Data> {
  final Value<int> beanId;
  final Value<String> languageCode;
  final Value<String?> country;
  final Value<String?> region;
  final Value<String?> varieties;
  final Value<String> flavorNotes;
  final Value<String?> processMethod;
  final Value<String?> description;
  final Value<String?> farmDescription;
  final Value<String?> roastLevel;
  final Value<int> rowid;
  const LocalizedBeanTranslationsV2Companion({
    this.beanId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.varieties = const Value.absent(),
    this.flavorNotes = const Value.absent(),
    this.processMethod = const Value.absent(),
    this.description = const Value.absent(),
    this.farmDescription = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalizedBeanTranslationsV2Companion.insert({
    required int beanId,
    required String languageCode,
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.varieties = const Value.absent(),
    this.flavorNotes = const Value.absent(),
    this.processMethod = const Value.absent(),
    this.description = const Value.absent(),
    this.farmDescription = const Value.absent(),
    this.roastLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : beanId = Value(beanId),
       languageCode = Value(languageCode);
  static Insertable<LocalizedBeanTranslationsV2Data> custom({
    Expression<int>? beanId,
    Expression<String>? languageCode,
    Expression<String>? country,
    Expression<String>? region,
    Expression<String>? varieties,
    Expression<String>? flavorNotes,
    Expression<String>? processMethod,
    Expression<String>? description,
    Expression<String>? farmDescription,
    Expression<String>? roastLevel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (beanId != null) 'bean_id': beanId,
      if (languageCode != null) 'language_code': languageCode,
      if (country != null) 'country': country,
      if (region != null) 'region': region,
      if (varieties != null) 'varieties': varieties,
      if (flavorNotes != null) 'flavor_notes': flavorNotes,
      if (processMethod != null) 'process_method': processMethod,
      if (description != null) 'description': description,
      if (farmDescription != null) 'farm_description': farmDescription,
      if (roastLevel != null) 'roast_level': roastLevel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalizedBeanTranslationsV2Companion copyWith({
    Value<int>? beanId,
    Value<String>? languageCode,
    Value<String?>? country,
    Value<String?>? region,
    Value<String?>? varieties,
    Value<String>? flavorNotes,
    Value<String?>? processMethod,
    Value<String?>? description,
    Value<String?>? farmDescription,
    Value<String?>? roastLevel,
    Value<int>? rowid,
  }) {
    return LocalizedBeanTranslationsV2Companion(
      beanId: beanId ?? this.beanId,
      languageCode: languageCode ?? this.languageCode,
      country: country ?? this.country,
      region: region ?? this.region,
      varieties: varieties ?? this.varieties,
      flavorNotes: flavorNotes ?? this.flavorNotes,
      processMethod: processMethod ?? this.processMethod,
      description: description ?? this.description,
      farmDescription: farmDescription ?? this.farmDescription,
      roastLevel: roastLevel ?? this.roastLevel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (beanId.present) {
      map['bean_id'] = Variable<int>(beanId.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (farmDescription.present) {
      map['farm_description'] = Variable<String>(farmDescription.value);
    }
    if (roastLevel.present) {
      map['roast_level'] = Variable<String>(roastLevel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedBeanTranslationsV2Companion(')
          ..write('beanId: $beanId, ')
          ..write('languageCode: $languageCode, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('varieties: $varieties, ')
          ..write('flavorNotes: $flavorNotes, ')
          ..write('processMethod: $processMethod, ')
          ..write('description: $description, ')
          ..write('farmDescription: $farmDescription, ')
          ..write('roastLevel: $roastLevel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrewingRecipesV2Table extends BrewingRecipesV2
    with TableInfo<$BrewingRecipesV2Table, BrewingRecipesV2Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrewingRecipesV2Table(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0.066),
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<double> tempC = GeneratedColumn<double>(
    'temp_c',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(93.0),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(180),
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
    requiredDuringInsert: false,
    defaultValue: const Constant('Intermediate'),
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
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
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
    requiredDuringInsert: false,
    defaultValue: const Constant('Balanced'),
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    methodKey,
    imageUrl,
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
  static const String $name = 'brewing_recipes_v2';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrewingRecipesV2Data> instance, {
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
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('ratio_grams_per_ml')) {
      context.handle(
        _ratioGramsPerMlMeta,
        ratioGramsPerMl.isAcceptableOrUnknown(
          data['ratio_grams_per_ml']!,
          _ratioGramsPerMlMeta,
        ),
      );
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    }
    if (data.containsKey('total_time_sec')) {
      context.handle(
        _totalTimeSecMeta,
        totalTimeSec.isAcceptableOrUnknown(
          data['total_time_sec']!,
          _totalTimeSecMeta,
        ),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('steps_json')) {
      context.handle(
        _stepsJsonMeta,
        stepsJson.isAcceptableOrUnknown(data['steps_json']!, _stepsJsonMeta),
      );
    }
    if (data.containsKey('flavor_profile')) {
      context.handle(
        _flavorProfileMeta,
        flavorProfile.isAcceptableOrUnknown(
          data['flavor_profile']!,
          _flavorProfileMeta,
        ),
      );
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BrewingRecipesV2Data map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrewingRecipesV2Data(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      methodKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method_key'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
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
      ),
    );
  }

  @override
  $BrewingRecipesV2Table createAlias(String alias) {
    return $BrewingRecipesV2Table(attachedDatabase, alias);
  }
}

class BrewingRecipesV2Data extends DataClass
    implements Insertable<BrewingRecipesV2Data> {
  final int id;
  final String methodKey;
  final String imageUrl;
  final double ratioGramsPerMl;
  final double tempC;
  final int totalTimeSec;
  final String difficulty;
  final String stepsJson;
  final String flavorProfile;
  final String? iconName;
  const BrewingRecipesV2Data({
    required this.id,
    required this.methodKey,
    required this.imageUrl,
    required this.ratioGramsPerMl,
    required this.tempC,
    required this.totalTimeSec,
    required this.difficulty,
    required this.stepsJson,
    required this.flavorProfile,
    this.iconName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['method_key'] = Variable<String>(methodKey);
    map['image_url'] = Variable<String>(imageUrl);
    map['ratio_grams_per_ml'] = Variable<double>(ratioGramsPerMl);
    map['temp_c'] = Variable<double>(tempC);
    map['total_time_sec'] = Variable<int>(totalTimeSec);
    map['difficulty'] = Variable<String>(difficulty);
    map['steps_json'] = Variable<String>(stepsJson);
    map['flavor_profile'] = Variable<String>(flavorProfile);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    return map;
  }

  BrewingRecipesV2Companion toCompanion(bool nullToAbsent) {
    return BrewingRecipesV2Companion(
      id: Value(id),
      methodKey: Value(methodKey),
      imageUrl: Value(imageUrl),
      ratioGramsPerMl: Value(ratioGramsPerMl),
      tempC: Value(tempC),
      totalTimeSec: Value(totalTimeSec),
      difficulty: Value(difficulty),
      stepsJson: Value(stepsJson),
      flavorProfile: Value(flavorProfile),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
    );
  }

  factory BrewingRecipesV2Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrewingRecipesV2Data(
      id: serializer.fromJson<int>(json['id']),
      methodKey: serializer.fromJson<String>(json['methodKey']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      ratioGramsPerMl: serializer.fromJson<double>(json['ratioGramsPerMl']),
      tempC: serializer.fromJson<double>(json['tempC']),
      totalTimeSec: serializer.fromJson<int>(json['totalTimeSec']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      stepsJson: serializer.fromJson<String>(json['stepsJson']),
      flavorProfile: serializer.fromJson<String>(json['flavorProfile']),
      iconName: serializer.fromJson<String?>(json['iconName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'methodKey': serializer.toJson<String>(methodKey),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'ratioGramsPerMl': serializer.toJson<double>(ratioGramsPerMl),
      'tempC': serializer.toJson<double>(tempC),
      'totalTimeSec': serializer.toJson<int>(totalTimeSec),
      'difficulty': serializer.toJson<String>(difficulty),
      'stepsJson': serializer.toJson<String>(stepsJson),
      'flavorProfile': serializer.toJson<String>(flavorProfile),
      'iconName': serializer.toJson<String?>(iconName),
    };
  }

  BrewingRecipesV2Data copyWith({
    int? id,
    String? methodKey,
    String? imageUrl,
    double? ratioGramsPerMl,
    double? tempC,
    int? totalTimeSec,
    String? difficulty,
    String? stepsJson,
    String? flavorProfile,
    Value<String?> iconName = const Value.absent(),
  }) => BrewingRecipesV2Data(
    id: id ?? this.id,
    methodKey: methodKey ?? this.methodKey,
    imageUrl: imageUrl ?? this.imageUrl,
    ratioGramsPerMl: ratioGramsPerMl ?? this.ratioGramsPerMl,
    tempC: tempC ?? this.tempC,
    totalTimeSec: totalTimeSec ?? this.totalTimeSec,
    difficulty: difficulty ?? this.difficulty,
    stepsJson: stepsJson ?? this.stepsJson,
    flavorProfile: flavorProfile ?? this.flavorProfile,
    iconName: iconName.present ? iconName.value : this.iconName,
  );
  BrewingRecipesV2Data copyWithCompanion(BrewingRecipesV2Companion data) {
    return BrewingRecipesV2Data(
      id: data.id.present ? data.id.value : this.id,
      methodKey: data.methodKey.present ? data.methodKey.value : this.methodKey,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
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
    return (StringBuffer('BrewingRecipesV2Data(')
          ..write('id: $id, ')
          ..write('methodKey: $methodKey, ')
          ..write('imageUrl: $imageUrl, ')
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
    imageUrl,
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
      (other is BrewingRecipesV2Data &&
          other.id == this.id &&
          other.methodKey == this.methodKey &&
          other.imageUrl == this.imageUrl &&
          other.ratioGramsPerMl == this.ratioGramsPerMl &&
          other.tempC == this.tempC &&
          other.totalTimeSec == this.totalTimeSec &&
          other.difficulty == this.difficulty &&
          other.stepsJson == this.stepsJson &&
          other.flavorProfile == this.flavorProfile &&
          other.iconName == this.iconName);
}

class BrewingRecipesV2Companion extends UpdateCompanion<BrewingRecipesV2Data> {
  final Value<int> id;
  final Value<String> methodKey;
  final Value<String> imageUrl;
  final Value<double> ratioGramsPerMl;
  final Value<double> tempC;
  final Value<int> totalTimeSec;
  final Value<String> difficulty;
  final Value<String> stepsJson;
  final Value<String> flavorProfile;
  final Value<String?> iconName;
  const BrewingRecipesV2Companion({
    this.id = const Value.absent(),
    this.methodKey = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.ratioGramsPerMl = const Value.absent(),
    this.tempC = const Value.absent(),
    this.totalTimeSec = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.stepsJson = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.iconName = const Value.absent(),
  });
  BrewingRecipesV2Companion.insert({
    this.id = const Value.absent(),
    required String methodKey,
    this.imageUrl = const Value.absent(),
    this.ratioGramsPerMl = const Value.absent(),
    this.tempC = const Value.absent(),
    this.totalTimeSec = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.stepsJson = const Value.absent(),
    this.flavorProfile = const Value.absent(),
    this.iconName = const Value.absent(),
  }) : methodKey = Value(methodKey);
  static Insertable<BrewingRecipesV2Data> custom({
    Expression<int>? id,
    Expression<String>? methodKey,
    Expression<String>? imageUrl,
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
      if (imageUrl != null) 'image_url': imageUrl,
      if (ratioGramsPerMl != null) 'ratio_grams_per_ml': ratioGramsPerMl,
      if (tempC != null) 'temp_c': tempC,
      if (totalTimeSec != null) 'total_time_sec': totalTimeSec,
      if (difficulty != null) 'difficulty': difficulty,
      if (stepsJson != null) 'steps_json': stepsJson,
      if (flavorProfile != null) 'flavor_profile': flavorProfile,
      if (iconName != null) 'icon_name': iconName,
    });
  }

  BrewingRecipesV2Companion copyWith({
    Value<int>? id,
    Value<String>? methodKey,
    Value<String>? imageUrl,
    Value<double>? ratioGramsPerMl,
    Value<double>? tempC,
    Value<int>? totalTimeSec,
    Value<String>? difficulty,
    Value<String>? stepsJson,
    Value<String>? flavorProfile,
    Value<String?>? iconName,
  }) {
    return BrewingRecipesV2Companion(
      id: id ?? this.id,
      methodKey: methodKey ?? this.methodKey,
      imageUrl: imageUrl ?? this.imageUrl,
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
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
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
    return (StringBuffer('BrewingRecipesV2Companion(')
          ..write('id: $id, ')
          ..write('methodKey: $methodKey, ')
          ..write('imageUrl: $imageUrl, ')
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

class $BrewingRecipeTranslationsV2Table extends BrewingRecipeTranslationsV2
    with
        TableInfo<
          $BrewingRecipeTranslationsV2Table,
          BrewingRecipeTranslationsV2Data
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrewingRecipeTranslationsV2Table(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeKeyMeta = const VerificationMeta(
    'recipeKey',
  );
  @override
  late final GeneratedColumn<String> recipeKey = GeneratedColumn<String>(
    'recipe_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES brewing_recipes_v2 (method_key)',
    ),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    recipeKey,
    languageCode,
    name,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brewing_recipe_translations_v2';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrewingRecipeTranslationsV2Data> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_key')) {
      context.handle(
        _recipeKeyMeta,
        recipeKey.isAcceptableOrUnknown(data['recipe_key']!, _recipeKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeKeyMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
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
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeKey, languageCode};
  @override
  BrewingRecipeTranslationsV2Data map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrewingRecipeTranslationsV2Data(
      recipeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_key'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $BrewingRecipeTranslationsV2Table createAlias(String alias) {
    return $BrewingRecipeTranslationsV2Table(attachedDatabase, alias);
  }
}

class BrewingRecipeTranslationsV2Data extends DataClass
    implements Insertable<BrewingRecipeTranslationsV2Data> {
  final String recipeKey;
  final String languageCode;
  final String? name;
  final String? description;
  const BrewingRecipeTranslationsV2Data({
    required this.recipeKey,
    required this.languageCode,
    this.name,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_key'] = Variable<String>(recipeKey);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  BrewingRecipeTranslationsV2Companion toCompanion(bool nullToAbsent) {
    return BrewingRecipeTranslationsV2Companion(
      recipeKey: Value(recipeKey),
      languageCode: Value(languageCode),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory BrewingRecipeTranslationsV2Data.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrewingRecipeTranslationsV2Data(
      recipeKey: serializer.fromJson<String>(json['recipeKey']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String?>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeKey': serializer.toJson<String>(recipeKey),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String?>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  BrewingRecipeTranslationsV2Data copyWith({
    String? recipeKey,
    String? languageCode,
    Value<String?> name = const Value.absent(),
    Value<String?> description = const Value.absent(),
  }) => BrewingRecipeTranslationsV2Data(
    recipeKey: recipeKey ?? this.recipeKey,
    languageCode: languageCode ?? this.languageCode,
    name: name.present ? name.value : this.name,
    description: description.present ? description.value : this.description,
  );
  BrewingRecipeTranslationsV2Data copyWithCompanion(
    BrewingRecipeTranslationsV2Companion data,
  ) {
    return BrewingRecipeTranslationsV2Data(
      recipeKey: data.recipeKey.present ? data.recipeKey.value : this.recipeKey,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrewingRecipeTranslationsV2Data(')
          ..write('recipeKey: $recipeKey, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recipeKey, languageCode, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrewingRecipeTranslationsV2Data &&
          other.recipeKey == this.recipeKey &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.description == this.description);
}

class BrewingRecipeTranslationsV2Companion
    extends UpdateCompanion<BrewingRecipeTranslationsV2Data> {
  final Value<String> recipeKey;
  final Value<String> languageCode;
  final Value<String?> name;
  final Value<String?> description;
  final Value<int> rowid;
  const BrewingRecipeTranslationsV2Companion({
    this.recipeKey = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrewingRecipeTranslationsV2Companion.insert({
    required String recipeKey,
    required String languageCode,
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : recipeKey = Value(recipeKey),
       languageCode = Value(languageCode);
  static Insertable<BrewingRecipeTranslationsV2Data> custom({
    Expression<String>? recipeKey,
    Expression<String>? languageCode,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recipeKey != null) 'recipe_key': recipeKey,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BrewingRecipeTranslationsV2Companion copyWith({
    Value<String>? recipeKey,
    Value<String>? languageCode,
    Value<String?>? name,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return BrewingRecipeTranslationsV2Companion(
      recipeKey: recipeKey ?? this.recipeKey,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeKey.present) {
      map['recipe_key'] = Variable<String>(recipeKey.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrewingRecipeTranslationsV2Companion(')
          ..write('recipeKey: $recipeKey, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalizedBrandsTable localizedBrands = $LocalizedBrandsTable(
    this,
  );
  late final $LocalizedFarmersTable localizedFarmers = $LocalizedFarmersTable(
    this,
  );
  late final $LocalizedBeansTable localizedBeans = $LocalizedBeansTable(this);
  late final $LocalizedBeanTranslationsTable localizedBeanTranslations =
      $LocalizedBeanTranslationsTable(this);
  late final $LocalizedBrandTranslationsTable localizedBrandTranslations =
      $LocalizedBrandTranslationsTable(this);
  late final $LocalizedFarmerTranslationsTable localizedFarmerTranslations =
      $LocalizedFarmerTranslationsTable(this);
  late final $SphereRegionsTable sphereRegions = $SphereRegionsTable(this);
  late final $SphereRegionTranslationsTable sphereRegionTranslations =
      $SphereRegionTranslationsTable(this);
  late final $SpecialtyArticlesTable specialtyArticles =
      $SpecialtyArticlesTable(this);
  late final $SpecialtyArticleTranslationsTable specialtyArticleTranslations =
      $SpecialtyArticleTranslationsTable(this);
  late final $CoffeeLotsTable coffeeLots = $CoffeeLotsTable(this);
  late final $FermentationLogsTable fermentationLogs = $FermentationLogsTable(
    this,
  );
  late final $BrewingRecipesTable brewingRecipes = $BrewingRecipesTable(this);
  late final $BrewingRecipeTranslationsTable brewingRecipeTranslations =
      $BrewingRecipeTranslationsTable(this);
  late final $RecommendedRecipesTable recommendedRecipes =
      $RecommendedRecipesTable(this);
  late final $CustomRecipesTable customRecipes = $CustomRecipesTable(this);
  late final $LocalizedFarmersV2Table localizedFarmersV2 =
      $LocalizedFarmersV2Table(this);
  late final $LocalizedFarmerTranslationsV2Table localizedFarmerTranslationsV2 =
      $LocalizedFarmerTranslationsV2Table(this);
  late final $SpecialtyArticlesV2Table specialtyArticlesV2 =
      $SpecialtyArticlesV2Table(this);
  late final $SpecialtyArticleTranslationsV2Table
  specialtyArticleTranslationsV2 = $SpecialtyArticleTranslationsV2Table(this);
  late final $LocalizedBeansV2Table localizedBeansV2 = $LocalizedBeansV2Table(
    this,
  );
  late final $LocalizedBeanTranslationsV2Table localizedBeanTranslationsV2 =
      $LocalizedBeanTranslationsV2Table(this);
  late final $BrewingRecipesV2Table brewingRecipesV2 = $BrewingRecipesV2Table(
    this,
  );
  late final $BrewingRecipeTranslationsV2Table brewingRecipeTranslationsV2 =
      $BrewingRecipeTranslationsV2Table(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localizedBrands,
    localizedFarmers,
    localizedBeans,
    localizedBeanTranslations,
    localizedBrandTranslations,
    localizedFarmerTranslations,
    sphereRegions,
    sphereRegionTranslations,
    specialtyArticles,
    specialtyArticleTranslations,
    coffeeLots,
    fermentationLogs,
    brewingRecipes,
    brewingRecipeTranslations,
    recommendedRecipes,
    customRecipes,
    localizedFarmersV2,
    localizedFarmerTranslationsV2,
    specialtyArticlesV2,
    specialtyArticleTranslationsV2,
    localizedBeansV2,
    localizedBeanTranslationsV2,
    brewingRecipesV2,
    brewingRecipeTranslationsV2,
  ];
}

typedef $$LocalizedBrandsTableCreateCompanionBuilder =
    LocalizedBrandsCompanion Function({
      Value<int> id,
      Value<String?> userId,
      required String name,
      Value<String?> logoUrl,
      Value<String?> siteUrl,
      Value<DateTime?> createdAt,
      Value<bool> isSynced,
      Value<bool> isDeletedLocal,
      Value<bool> isFavorite,
      Value<bool> isArchived,
    });
typedef $$LocalizedBrandsTableUpdateCompanionBuilder =
    LocalizedBrandsCompanion Function({
      Value<int> id,
      Value<String?> userId,
      Value<String> name,
      Value<String?> logoUrl,
      Value<String?> siteUrl,
      Value<DateTime?> createdAt,
      Value<bool> isSynced,
      Value<bool> isDeletedLocal,
      Value<bool> isFavorite,
      Value<bool> isArchived,
    });

final class $$LocalizedBrandsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocalizedBrandsTable, LocalizedBrand> {
  $$LocalizedBrandsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$LocalizedBeansTable, List<LocalizedBean>>
  _localizedBeansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localizedBeans,
    aliasName: $_aliasNameGenerator(
      db.localizedBrands.id,
      db.localizedBeans.brandId,
    ),
  );

  $$LocalizedBeansTableProcessedTableManager get localizedBeansRefs {
    final manager = $$LocalizedBeansTableTableManager(
      $_db,
      $_db.localizedBeans,
    ).filter((f) => f.brandId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_localizedBeansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalizedBrandTranslationsTable,
    List<LocalizedBrandTranslation>
  >
  _localizedBrandTranslationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localizedBrandTranslations,
        aliasName: $_aliasNameGenerator(
          db.localizedBrands.id,
          db.localizedBrandTranslations.brandId,
        ),
      );

  $$LocalizedBrandTranslationsTableProcessedTableManager
  get localizedBrandTranslationsRefs {
    final manager = $$LocalizedBrandTranslationsTableTableManager(
      $_db,
      $_db.localizedBrandTranslations,
    ).filter((f) => f.brandId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localizedBrandTranslationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoffeeLotsTable, List<CoffeeLot>>
  _coffeeLotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coffeeLots,
    aliasName: $_aliasNameGenerator(
      db.localizedBrands.id,
      db.coffeeLots.brandId,
    ),
  );

  $$CoffeeLotsTableProcessedTableManager get coffeeLotsRefs {
    final manager = $$CoffeeLotsTableTableManager(
      $_db,
      $_db.coffeeLots,
    ).filter((f) => f.brandId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_coffeeLotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalizedBeansV2Table, List<LocalizedBeansV2Data>>
  _localizedBeansV2RefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localizedBeansV2,
    aliasName: $_aliasNameGenerator(
      db.localizedBrands.id,
      db.localizedBeansV2.brandId,
    ),
  );

  $$LocalizedBeansV2TableProcessedTableManager get localizedBeansV2Refs {
    final manager = $$LocalizedBeansV2TableTableManager(
      $_db,
      $_db.localizedBeansV2,
    ).filter((f) => f.brandId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localizedBeansV2RefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalizedBrandsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedBrandsTable> {
  $$LocalizedBrandsTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localizedBeansRefs(
    Expression<bool> Function($$LocalizedBeansTableFilterComposer f) f,
  ) {
    final $$LocalizedBeansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableFilterComposer(
            $db: $db,
            $table: $db.localizedBeans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localizedBrandTranslationsRefs(
    Expression<bool> Function($$LocalizedBrandTranslationsTableFilterComposer f)
    f,
  ) {
    final $$LocalizedBrandTranslationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedBrandTranslations,
          getReferencedColumn: (t) => t.brandId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedBrandTranslationsTableFilterComposer(
                $db: $db,
                $table: $db.localizedBrandTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> coffeeLotsRefs(
    Expression<bool> Function($$CoffeeLotsTableFilterComposer f) f,
  ) {
    final $$CoffeeLotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeLots,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeLotsTableFilterComposer(
            $db: $db,
            $table: $db.coffeeLots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localizedBeansV2Refs(
    Expression<bool> Function($$LocalizedBeansV2TableFilterComposer f) f,
  ) {
    final $$LocalizedBeansV2TableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localizedBeansV2,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansV2TableFilterComposer(
            $db: $db,
            $table: $db.localizedBeansV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalizedBrandsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedBrandsTable> {
  $$LocalizedBrandsTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalizedBrandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedBrandsTable> {
  $$LocalizedBrandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get siteUrl =>
      $composableBuilder(column: $table.siteUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  Expression<T> localizedBeansRefs<T extends Object>(
    Expression<T> Function($$LocalizedBeansTableAnnotationComposer a) f,
  ) {
    final $$LocalizedBeansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBeans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localizedBrandTranslationsRefs<T extends Object>(
    Expression<T> Function(
      $$LocalizedBrandTranslationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$LocalizedBrandTranslationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedBrandTranslations,
          getReferencedColumn: (t) => t.brandId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedBrandTranslationsTableAnnotationComposer(
                $db: $db,
                $table: $db.localizedBrandTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> coffeeLotsRefs<T extends Object>(
    Expression<T> Function($$CoffeeLotsTableAnnotationComposer a) f,
  ) {
    final $$CoffeeLotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeLots,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeLotsTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeeLots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localizedBeansV2Refs<T extends Object>(
    Expression<T> Function($$LocalizedBeansV2TableAnnotationComposer a) f,
  ) {
    final $$LocalizedBeansV2TableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localizedBeansV2,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansV2TableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBeansV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalizedBrandsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedBrandsTable,
          LocalizedBrand,
          $$LocalizedBrandsTableFilterComposer,
          $$LocalizedBrandsTableOrderingComposer,
          $$LocalizedBrandsTableAnnotationComposer,
          $$LocalizedBrandsTableCreateCompanionBuilder,
          $$LocalizedBrandsTableUpdateCompanionBuilder,
          (LocalizedBrand, $$LocalizedBrandsTableReferences),
          LocalizedBrand,
          PrefetchHooks Function({
            bool localizedBeansRefs,
            bool localizedBrandTranslationsRefs,
            bool coffeeLotsRefs,
            bool localizedBeansV2Refs,
          })
        > {
  $$LocalizedBrandsTableTableManager(
    _$AppDatabase db,
    $LocalizedBrandsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedBrandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalizedBrandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalizedBrandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> siteUrl = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeletedLocal = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => LocalizedBrandsCompanion(
                id: id,
                userId: userId,
                name: name,
                logoUrl: logoUrl,
                siteUrl: siteUrl,
                createdAt: createdAt,
                isSynced: isSynced,
                isDeletedLocal: isDeletedLocal,
                isFavorite: isFavorite,
                isArchived: isArchived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                required String name,
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> siteUrl = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeletedLocal = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => LocalizedBrandsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                logoUrl: logoUrl,
                siteUrl: siteUrl,
                createdAt: createdAt,
                isSynced: isSynced,
                isDeletedLocal: isDeletedLocal,
                isFavorite: isFavorite,
                isArchived: isArchived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedBrandsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                localizedBeansRefs = false,
                localizedBrandTranslationsRefs = false,
                coffeeLotsRefs = false,
                localizedBeansV2Refs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localizedBeansRefs) db.localizedBeans,
                    if (localizedBrandTranslationsRefs)
                      db.localizedBrandTranslations,
                    if (coffeeLotsRefs) db.coffeeLots,
                    if (localizedBeansV2Refs) db.localizedBeansV2,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localizedBeansRefs)
                        await $_getPrefetchedData<
                          LocalizedBrand,
                          $LocalizedBrandsTable,
                          LocalizedBean
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedBrandsTableReferences
                              ._localizedBeansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedBrandsTableReferences(
                                db,
                                table,
                                p0,
                              ).localizedBeansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.brandId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localizedBrandTranslationsRefs)
                        await $_getPrefetchedData<
                          LocalizedBrand,
                          $LocalizedBrandsTable,
                          LocalizedBrandTranslation
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedBrandsTableReferences
                              ._localizedBrandTranslationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedBrandsTableReferences(
                                db,
                                table,
                                p0,
                              ).localizedBrandTranslationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.brandId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coffeeLotsRefs)
                        await $_getPrefetchedData<
                          LocalizedBrand,
                          $LocalizedBrandsTable,
                          CoffeeLot
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedBrandsTableReferences
                              ._coffeeLotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedBrandsTableReferences(
                                db,
                                table,
                                p0,
                              ).coffeeLotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.brandId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localizedBeansV2Refs)
                        await $_getPrefetchedData<
                          LocalizedBrand,
                          $LocalizedBrandsTable,
                          LocalizedBeansV2Data
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedBrandsTableReferences
                              ._localizedBeansV2RefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedBrandsTableReferences(
                                db,
                                table,
                                p0,
                              ).localizedBeansV2Refs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.brandId == item.id,
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

typedef $$LocalizedBrandsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedBrandsTable,
      LocalizedBrand,
      $$LocalizedBrandsTableFilterComposer,
      $$LocalizedBrandsTableOrderingComposer,
      $$LocalizedBrandsTableAnnotationComposer,
      $$LocalizedBrandsTableCreateCompanionBuilder,
      $$LocalizedBrandsTableUpdateCompanionBuilder,
      (LocalizedBrand, $$LocalizedBrandsTableReferences),
      LocalizedBrand,
      PrefetchHooks Function({
        bool localizedBeansRefs,
        bool localizedBrandTranslationsRefs,
        bool coffeeLotsRefs,
        bool localizedBeansV2Refs,
      })
    >;
typedef $$LocalizedFarmersTableCreateCompanionBuilder =
    LocalizedFarmersCompanion Function({
      Value<int> id,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> createdAt,
    });
typedef $$LocalizedFarmersTableUpdateCompanionBuilder =
    LocalizedFarmersCompanion Function({
      Value<int> id,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> createdAt,
    });

final class $$LocalizedFarmersTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocalizedFarmersTable, LocalizedFarmer> {
  $$LocalizedFarmersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$LocalizedBeansTable, List<LocalizedBean>>
  _localizedBeansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localizedBeans,
    aliasName: $_aliasNameGenerator(
      db.localizedFarmers.id,
      db.localizedBeans.farmerId,
    ),
  );

  $$LocalizedBeansTableProcessedTableManager get localizedBeansRefs {
    final manager = $$LocalizedBeansTableTableManager(
      $_db,
      $_db.localizedBeans,
    ).filter((f) => f.farmerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_localizedBeansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalizedFarmerTranslationsTable,
    List<LocalizedFarmerTranslation>
  >
  _localizedFarmerTranslationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localizedFarmerTranslations,
        aliasName: $_aliasNameGenerator(
          db.localizedFarmers.id,
          db.localizedFarmerTranslations.farmerId,
        ),
      );

  $$LocalizedFarmerTranslationsTableProcessedTableManager
  get localizedFarmerTranslationsRefs {
    final manager = $$LocalizedFarmerTranslationsTableTableManager(
      $_db,
      $_db.localizedFarmerTranslations,
    ).filter((f) => f.farmerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localizedFarmerTranslationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalizedFarmersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedFarmersTable> {
  $$LocalizedFarmersTableFilterComposer({
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

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localizedBeansRefs(
    Expression<bool> Function($$LocalizedBeansTableFilterComposer f) f,
  ) {
    final $$LocalizedBeansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.farmerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableFilterComposer(
            $db: $db,
            $table: $db.localizedBeans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localizedFarmerTranslationsRefs(
    Expression<bool> Function(
      $$LocalizedFarmerTranslationsTableFilterComposer f,
    )
    f,
  ) {
    final $$LocalizedFarmerTranslationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedFarmerTranslations,
          getReferencedColumn: (t) => t.farmerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedFarmerTranslationsTableFilterComposer(
                $db: $db,
                $table: $db.localizedFarmerTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalizedFarmersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedFarmersTable> {
  $$LocalizedFarmersTableOrderingComposer({
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

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalizedFarmersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedFarmersTable> {
  $$LocalizedFarmersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get flagUrl =>
      $composableBuilder(column: $table.flagUrl, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> localizedBeansRefs<T extends Object>(
    Expression<T> Function($$LocalizedBeansTableAnnotationComposer a) f,
  ) {
    final $$LocalizedBeansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.farmerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBeans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localizedFarmerTranslationsRefs<T extends Object>(
    Expression<T> Function(
      $$LocalizedFarmerTranslationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$LocalizedFarmerTranslationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedFarmerTranslations,
          getReferencedColumn: (t) => t.farmerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedFarmerTranslationsTableAnnotationComposer(
                $db: $db,
                $table: $db.localizedFarmerTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalizedFarmersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedFarmersTable,
          LocalizedFarmer,
          $$LocalizedFarmersTableFilterComposer,
          $$LocalizedFarmersTableOrderingComposer,
          $$LocalizedFarmersTableAnnotationComposer,
          $$LocalizedFarmersTableCreateCompanionBuilder,
          $$LocalizedFarmersTableUpdateCompanionBuilder,
          (LocalizedFarmer, $$LocalizedFarmersTableReferences),
          LocalizedFarmer,
          PrefetchHooks Function({
            bool localizedBeansRefs,
            bool localizedFarmerTranslationsRefs,
          })
        > {
  $$LocalizedFarmersTableTableManager(
    _$AppDatabase db,
    $LocalizedFarmersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedFarmersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalizedFarmersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalizedFarmersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedFarmersCompanion(
                id: id,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedFarmersCompanion.insert(
                id: id,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedFarmersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                localizedBeansRefs = false,
                localizedFarmerTranslationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localizedBeansRefs) db.localizedBeans,
                    if (localizedFarmerTranslationsRefs)
                      db.localizedFarmerTranslations,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localizedBeansRefs)
                        await $_getPrefetchedData<
                          LocalizedFarmer,
                          $LocalizedFarmersTable,
                          LocalizedBean
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedFarmersTableReferences
                              ._localizedBeansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedFarmersTableReferences(
                                db,
                                table,
                                p0,
                              ).localizedBeansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.farmerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localizedFarmerTranslationsRefs)
                        await $_getPrefetchedData<
                          LocalizedFarmer,
                          $LocalizedFarmersTable,
                          LocalizedFarmerTranslation
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedFarmersTableReferences
                              ._localizedFarmerTranslationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedFarmersTableReferences(
                                db,
                                table,
                                p0,
                              ).localizedFarmerTranslationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.farmerId == item.id,
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

typedef $$LocalizedFarmersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedFarmersTable,
      LocalizedFarmer,
      $$LocalizedFarmersTableFilterComposer,
      $$LocalizedFarmersTableOrderingComposer,
      $$LocalizedFarmersTableAnnotationComposer,
      $$LocalizedFarmersTableCreateCompanionBuilder,
      $$LocalizedFarmersTableUpdateCompanionBuilder,
      (LocalizedFarmer, $$LocalizedFarmersTableReferences),
      LocalizedFarmer,
      PrefetchHooks Function({
        bool localizedBeansRefs,
        bool localizedFarmerTranslationsRefs,
      })
    >;
typedef $$LocalizedBeansTableCreateCompanionBuilder =
    LocalizedBeansCompanion Function({
      Value<int> id,
      Value<int?> brandId,
      Value<String?> countryEmoji,
      Value<int?> altitudeMin,
      Value<int?> altitudeMax,
      Value<String> lotNumber,
      Value<String> scaScore,
      Value<double> cupsScore,
      Value<String> sensoryJson,
      Value<String> priceJson,
      Value<String> plantationPhotosUrl,
      Value<String?> harvestSeason,
      Value<String?> price,
      Value<String?> weight,
      Value<String?> roastDate,
      Value<String> processingMethodsJson,
      Value<bool> isPremium,
      Value<String> detailedProcessMarkdown,
      Value<String> url,
      Value<int?> farmerId,
      Value<bool> isDecaf,
      Value<String?> farm,
      Value<String?> farmPhotosUrlCover,
      Value<String?> washStation,
      Value<String?> retailPrice,
      Value<String?> wholesalePrice,
      Value<bool> isFavorite,
      Value<DateTime?> createdAt,
    });
typedef $$LocalizedBeansTableUpdateCompanionBuilder =
    LocalizedBeansCompanion Function({
      Value<int> id,
      Value<int?> brandId,
      Value<String?> countryEmoji,
      Value<int?> altitudeMin,
      Value<int?> altitudeMax,
      Value<String> lotNumber,
      Value<String> scaScore,
      Value<double> cupsScore,
      Value<String> sensoryJson,
      Value<String> priceJson,
      Value<String> plantationPhotosUrl,
      Value<String?> harvestSeason,
      Value<String?> price,
      Value<String?> weight,
      Value<String?> roastDate,
      Value<String> processingMethodsJson,
      Value<bool> isPremium,
      Value<String> detailedProcessMarkdown,
      Value<String> url,
      Value<int?> farmerId,
      Value<bool> isDecaf,
      Value<String?> farm,
      Value<String?> farmPhotosUrlCover,
      Value<String?> washStation,
      Value<String?> retailPrice,
      Value<String?> wholesalePrice,
      Value<bool> isFavorite,
      Value<DateTime?> createdAt,
    });

final class $$LocalizedBeansTableReferences
    extends BaseReferences<_$AppDatabase, $LocalizedBeansTable, LocalizedBean> {
  $$LocalizedBeansTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalizedBrandsTable _brandIdTable(_$AppDatabase db) =>
      db.localizedBrands.createAlias(
        $_aliasNameGenerator(db.localizedBeans.brandId, db.localizedBrands.id),
      );

  $$LocalizedBrandsTableProcessedTableManager? get brandId {
    final $_column = $_itemColumn<int>('brand_id');
    if ($_column == null) return null;
    final manager = $$LocalizedBrandsTableTableManager(
      $_db,
      $_db.localizedBrands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalizedFarmersTable _farmerIdTable(_$AppDatabase db) =>
      db.localizedFarmers.createAlias(
        $_aliasNameGenerator(
          db.localizedBeans.farmerId,
          db.localizedFarmers.id,
        ),
      );

  $$LocalizedFarmersTableProcessedTableManager? get farmerId {
    final $_column = $_itemColumn<int>('farmer_id');
    if ($_column == null) return null;
    final manager = $$LocalizedFarmersTableTableManager(
      $_db,
      $_db.localizedFarmers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LocalizedBeanTranslationsTable,
    List<LocalizedBeanTranslation>
  >
  _localizedBeanTranslationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localizedBeanTranslations,
        aliasName: $_aliasNameGenerator(
          db.localizedBeans.id,
          db.localizedBeanTranslations.beanId,
        ),
      );

  $$LocalizedBeanTranslationsTableProcessedTableManager
  get localizedBeanTranslationsRefs {
    final manager = $$LocalizedBeanTranslationsTableTableManager(
      $_db,
      $_db.localizedBeanTranslations,
    ).filter((f) => f.beanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localizedBeanTranslationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecommendedRecipesTable, List<RecommendedRecipe>>
  _recommendedRecipesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recommendedRecipes,
        aliasName: $_aliasNameGenerator(
          db.localizedBeans.id,
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

class $$LocalizedBeansTableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedBeansTable> {
  $$LocalizedBeansTableFilterComposer({
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

  ColumnFilters<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scaScore => $composableBuilder(
    column: $table.scaScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cupsScore => $composableBuilder(
    column: $table.cupsScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priceJson => $composableBuilder(
    column: $table.priceJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
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

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDecaf => $composableBuilder(
    column: $table.isDecaf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farm => $composableBuilder(
    column: $table.farm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalizedBrandsTableFilterComposer get brandId {
    final $$LocalizedBrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableFilterComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalizedFarmersTableFilterComposer get farmerId {
    final $$LocalizedFarmersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersTableFilterComposer(
            $db: $db,
            $table: $db.localizedFarmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localizedBeanTranslationsRefs(
    Expression<bool> Function($$LocalizedBeanTranslationsTableFilterComposer f)
    f,
  ) {
    final $$LocalizedBeanTranslationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedBeanTranslations,
          getReferencedColumn: (t) => t.beanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedBeanTranslationsTableFilterComposer(
                $db: $db,
                $table: $db.localizedBeanTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
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

class $$LocalizedBeansTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedBeansTable> {
  $$LocalizedBeansTableOrderingComposer({
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

  ColumnOrderings<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scaScore => $composableBuilder(
    column: $table.scaScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cupsScore => $composableBuilder(
    column: $table.cupsScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceJson => $composableBuilder(
    column: $table.priceJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
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

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDecaf => $composableBuilder(
    column: $table.isDecaf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farm => $composableBuilder(
    column: $table.farm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalizedBrandsTableOrderingComposer get brandId {
    final $$LocalizedBrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableOrderingComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalizedFarmersTableOrderingComposer get farmerId {
    final $$LocalizedFarmersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersTableOrderingComposer(
            $db: $db,
            $table: $db.localizedFarmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBeansTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedBeansTable> {
  $$LocalizedBeansTableAnnotationComposer({
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

  GeneratedColumn<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lotNumber =>
      $composableBuilder(column: $table.lotNumber, builder: (column) => column);

  GeneratedColumn<String> get scaScore =>
      $composableBuilder(column: $table.scaScore, builder: (column) => column);

  GeneratedColumn<double> get cupsScore =>
      $composableBuilder(column: $table.cupsScore, builder: (column) => column);

  GeneratedColumn<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priceJson =>
      $composableBuilder(column: $table.priceJson, builder: (column) => column);

  GeneratedColumn<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get roastDate =>
      $composableBuilder(column: $table.roastDate, builder: (column) => column);

  GeneratedColumn<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);

  GeneratedColumn<String> get detailedProcessMarkdown => $composableBuilder(
    column: $table.detailedProcessMarkdown,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<bool> get isDecaf =>
      $composableBuilder(column: $table.isDecaf, builder: (column) => column);

  GeneratedColumn<String> get farm =>
      $composableBuilder(column: $table.farm, builder: (column) => column);

  GeneratedColumn<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => column,
  );

  GeneratedColumn<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalizedBrandsTableAnnotationComposer get brandId {
    final $$LocalizedBrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalizedFarmersTableAnnotationComposer get farmerId {
    final $$LocalizedFarmersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedFarmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localizedBeanTranslationsRefs<T extends Object>(
    Expression<T> Function($$LocalizedBeanTranslationsTableAnnotationComposer a)
    f,
  ) {
    final $$LocalizedBeanTranslationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedBeanTranslations,
          getReferencedColumn: (t) => t.beanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedBeanTranslationsTableAnnotationComposer(
                $db: $db,
                $table: $db.localizedBeanTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
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

class $$LocalizedBeansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedBeansTable,
          LocalizedBean,
          $$LocalizedBeansTableFilterComposer,
          $$LocalizedBeansTableOrderingComposer,
          $$LocalizedBeansTableAnnotationComposer,
          $$LocalizedBeansTableCreateCompanionBuilder,
          $$LocalizedBeansTableUpdateCompanionBuilder,
          (LocalizedBean, $$LocalizedBeansTableReferences),
          LocalizedBean,
          PrefetchHooks Function({
            bool brandId,
            bool farmerId,
            bool localizedBeanTranslationsRefs,
            bool recommendedRecipesRefs,
          })
        > {
  $$LocalizedBeansTableTableManager(
    _$AppDatabase db,
    $LocalizedBeansTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedBeansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalizedBeansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalizedBeansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String?> countryEmoji = const Value.absent(),
                Value<int?> altitudeMin = const Value.absent(),
                Value<int?> altitudeMax = const Value.absent(),
                Value<String> lotNumber = const Value.absent(),
                Value<String> scaScore = const Value.absent(),
                Value<double> cupsScore = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> priceJson = const Value.absent(),
                Value<String> plantationPhotosUrl = const Value.absent(),
                Value<String?> harvestSeason = const Value.absent(),
                Value<String?> price = const Value.absent(),
                Value<String?> weight = const Value.absent(),
                Value<String?> roastDate = const Value.absent(),
                Value<String> processingMethodsJson = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<String> detailedProcessMarkdown = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int?> farmerId = const Value.absent(),
                Value<bool> isDecaf = const Value.absent(),
                Value<String?> farm = const Value.absent(),
                Value<String?> farmPhotosUrlCover = const Value.absent(),
                Value<String?> washStation = const Value.absent(),
                Value<String?> retailPrice = const Value.absent(),
                Value<String?> wholesalePrice = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedBeansCompanion(
                id: id,
                brandId: brandId,
                countryEmoji: countryEmoji,
                altitudeMin: altitudeMin,
                altitudeMax: altitudeMax,
                lotNumber: lotNumber,
                scaScore: scaScore,
                cupsScore: cupsScore,
                sensoryJson: sensoryJson,
                priceJson: priceJson,
                plantationPhotosUrl: plantationPhotosUrl,
                harvestSeason: harvestSeason,
                price: price,
                weight: weight,
                roastDate: roastDate,
                processingMethodsJson: processingMethodsJson,
                isPremium: isPremium,
                detailedProcessMarkdown: detailedProcessMarkdown,
                url: url,
                farmerId: farmerId,
                isDecaf: isDecaf,
                farm: farm,
                farmPhotosUrlCover: farmPhotosUrlCover,
                washStation: washStation,
                retailPrice: retailPrice,
                wholesalePrice: wholesalePrice,
                isFavorite: isFavorite,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String?> countryEmoji = const Value.absent(),
                Value<int?> altitudeMin = const Value.absent(),
                Value<int?> altitudeMax = const Value.absent(),
                Value<String> lotNumber = const Value.absent(),
                Value<String> scaScore = const Value.absent(),
                Value<double> cupsScore = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> priceJson = const Value.absent(),
                Value<String> plantationPhotosUrl = const Value.absent(),
                Value<String?> harvestSeason = const Value.absent(),
                Value<String?> price = const Value.absent(),
                Value<String?> weight = const Value.absent(),
                Value<String?> roastDate = const Value.absent(),
                Value<String> processingMethodsJson = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<String> detailedProcessMarkdown = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int?> farmerId = const Value.absent(),
                Value<bool> isDecaf = const Value.absent(),
                Value<String?> farm = const Value.absent(),
                Value<String?> farmPhotosUrlCover = const Value.absent(),
                Value<String?> washStation = const Value.absent(),
                Value<String?> retailPrice = const Value.absent(),
                Value<String?> wholesalePrice = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedBeansCompanion.insert(
                id: id,
                brandId: brandId,
                countryEmoji: countryEmoji,
                altitudeMin: altitudeMin,
                altitudeMax: altitudeMax,
                lotNumber: lotNumber,
                scaScore: scaScore,
                cupsScore: cupsScore,
                sensoryJson: sensoryJson,
                priceJson: priceJson,
                plantationPhotosUrl: plantationPhotosUrl,
                harvestSeason: harvestSeason,
                price: price,
                weight: weight,
                roastDate: roastDate,
                processingMethodsJson: processingMethodsJson,
                isPremium: isPremium,
                detailedProcessMarkdown: detailedProcessMarkdown,
                url: url,
                farmerId: farmerId,
                isDecaf: isDecaf,
                farm: farm,
                farmPhotosUrlCover: farmPhotosUrlCover,
                washStation: washStation,
                retailPrice: retailPrice,
                wholesalePrice: wholesalePrice,
                isFavorite: isFavorite,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedBeansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                brandId = false,
                farmerId = false,
                localizedBeanTranslationsRefs = false,
                recommendedRecipesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localizedBeanTranslationsRefs)
                      db.localizedBeanTranslations,
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
                                        $$LocalizedBeansTableReferences
                                            ._brandIdTable(db),
                                    referencedColumn:
                                        $$LocalizedBeansTableReferences
                                            ._brandIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (farmerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.farmerId,
                                    referencedTable:
                                        $$LocalizedBeansTableReferences
                                            ._farmerIdTable(db),
                                    referencedColumn:
                                        $$LocalizedBeansTableReferences
                                            ._farmerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localizedBeanTranslationsRefs)
                        await $_getPrefetchedData<
                          LocalizedBean,
                          $LocalizedBeansTable,
                          LocalizedBeanTranslation
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedBeansTableReferences
                              ._localizedBeanTranslationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedBeansTableReferences(
                                db,
                                table,
                                p0,
                              ).localizedBeanTranslationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beanId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recommendedRecipesRefs)
                        await $_getPrefetchedData<
                          LocalizedBean,
                          $LocalizedBeansTable,
                          RecommendedRecipe
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedBeansTableReferences
                              ._recommendedRecipesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedBeansTableReferences(
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

typedef $$LocalizedBeansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedBeansTable,
      LocalizedBean,
      $$LocalizedBeansTableFilterComposer,
      $$LocalizedBeansTableOrderingComposer,
      $$LocalizedBeansTableAnnotationComposer,
      $$LocalizedBeansTableCreateCompanionBuilder,
      $$LocalizedBeansTableUpdateCompanionBuilder,
      (LocalizedBean, $$LocalizedBeansTableReferences),
      LocalizedBean,
      PrefetchHooks Function({
        bool brandId,
        bool farmerId,
        bool localizedBeanTranslationsRefs,
        bool recommendedRecipesRefs,
      })
    >;
typedef $$LocalizedBeanTranslationsTableCreateCompanionBuilder =
    LocalizedBeanTranslationsCompanion Function({
      required int beanId,
      required String languageCode,
      Value<String?> country,
      Value<String?> region,
      Value<String?> varieties,
      Value<String> flavorNotes,
      Value<String?> processMethod,
      Value<String?> description,
      Value<String?> farmDescription,
      Value<String?> roastLevel,
      Value<int> rowid,
    });
typedef $$LocalizedBeanTranslationsTableUpdateCompanionBuilder =
    LocalizedBeanTranslationsCompanion Function({
      Value<int> beanId,
      Value<String> languageCode,
      Value<String?> country,
      Value<String?> region,
      Value<String?> varieties,
      Value<String> flavorNotes,
      Value<String?> processMethod,
      Value<String?> description,
      Value<String?> farmDescription,
      Value<String?> roastLevel,
      Value<int> rowid,
    });

final class $$LocalizedBeanTranslationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalizedBeanTranslationsTable,
          LocalizedBeanTranslation
        > {
  $$LocalizedBeanTranslationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalizedBeansTable _beanIdTable(_$AppDatabase db) =>
      db.localizedBeans.createAlias(
        $_aliasNameGenerator(
          db.localizedBeanTranslations.beanId,
          db.localizedBeans.id,
        ),
      );

  $$LocalizedBeansTableProcessedTableManager get beanId {
    final $_column = $_itemColumn<int>('bean_id')!;

    final manager = $$LocalizedBeansTableTableManager(
      $_db,
      $_db.localizedBeans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalizedBeanTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedBeanTranslationsTable> {
  $$LocalizedBeanTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalizedBeansTableFilterComposer get beanId {
    final $$LocalizedBeansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beanId,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableFilterComposer(
            $db: $db,
            $table: $db.localizedBeans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBeanTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedBeanTranslationsTable> {
  $$LocalizedBeanTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalizedBeansTableOrderingComposer get beanId {
    final $$LocalizedBeansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beanId,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableOrderingComposer(
            $db: $db,
            $table: $db.localizedBeans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBeanTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedBeanTranslationsTable> {
  $$LocalizedBeanTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => column,
  );

  $$LocalizedBeansTableAnnotationComposer get beanId {
    final $$LocalizedBeansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beanId,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBeans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBeanTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedBeanTranslationsTable,
          LocalizedBeanTranslation,
          $$LocalizedBeanTranslationsTableFilterComposer,
          $$LocalizedBeanTranslationsTableOrderingComposer,
          $$LocalizedBeanTranslationsTableAnnotationComposer,
          $$LocalizedBeanTranslationsTableCreateCompanionBuilder,
          $$LocalizedBeanTranslationsTableUpdateCompanionBuilder,
          (
            LocalizedBeanTranslation,
            $$LocalizedBeanTranslationsTableReferences,
          ),
          LocalizedBeanTranslation,
          PrefetchHooks Function({bool beanId})
        > {
  $$LocalizedBeanTranslationsTableTableManager(
    _$AppDatabase db,
    $LocalizedBeanTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedBeanTranslationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalizedBeanTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalizedBeanTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> beanId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> varieties = const Value.absent(),
                Value<String> flavorNotes = const Value.absent(),
                Value<String?> processMethod = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> farmDescription = const Value.absent(),
                Value<String?> roastLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedBeanTranslationsCompanion(
                beanId: beanId,
                languageCode: languageCode,
                country: country,
                region: region,
                varieties: varieties,
                flavorNotes: flavorNotes,
                processMethod: processMethod,
                description: description,
                farmDescription: farmDescription,
                roastLevel: roastLevel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int beanId,
                required String languageCode,
                Value<String?> country = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> varieties = const Value.absent(),
                Value<String> flavorNotes = const Value.absent(),
                Value<String?> processMethod = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> farmDescription = const Value.absent(),
                Value<String?> roastLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedBeanTranslationsCompanion.insert(
                beanId: beanId,
                languageCode: languageCode,
                country: country,
                region: region,
                varieties: varieties,
                flavorNotes: flavorNotes,
                processMethod: processMethod,
                description: description,
                farmDescription: farmDescription,
                roastLevel: roastLevel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedBeanTranslationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({beanId = false}) {
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
                    if (beanId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beanId,
                                referencedTable:
                                    $$LocalizedBeanTranslationsTableReferences
                                        ._beanIdTable(db),
                                referencedColumn:
                                    $$LocalizedBeanTranslationsTableReferences
                                        ._beanIdTable(db)
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

typedef $$LocalizedBeanTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedBeanTranslationsTable,
      LocalizedBeanTranslation,
      $$LocalizedBeanTranslationsTableFilterComposer,
      $$LocalizedBeanTranslationsTableOrderingComposer,
      $$LocalizedBeanTranslationsTableAnnotationComposer,
      $$LocalizedBeanTranslationsTableCreateCompanionBuilder,
      $$LocalizedBeanTranslationsTableUpdateCompanionBuilder,
      (LocalizedBeanTranslation, $$LocalizedBeanTranslationsTableReferences),
      LocalizedBeanTranslation,
      PrefetchHooks Function({bool beanId})
    >;
typedef $$LocalizedBrandTranslationsTableCreateCompanionBuilder =
    LocalizedBrandTranslationsCompanion Function({
      required int brandId,
      required String languageCode,
      Value<String?> shortDesc,
      Value<String?> fullDesc,
      Value<String?> location,
      Value<int> rowid,
    });
typedef $$LocalizedBrandTranslationsTableUpdateCompanionBuilder =
    LocalizedBrandTranslationsCompanion Function({
      Value<int> brandId,
      Value<String> languageCode,
      Value<String?> shortDesc,
      Value<String?> fullDesc,
      Value<String?> location,
      Value<int> rowid,
    });

final class $$LocalizedBrandTranslationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalizedBrandTranslationsTable,
          LocalizedBrandTranslation
        > {
  $$LocalizedBrandTranslationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalizedBrandsTable _brandIdTable(_$AppDatabase db) =>
      db.localizedBrands.createAlias(
        $_aliasNameGenerator(
          db.localizedBrandTranslations.brandId,
          db.localizedBrands.id,
        ),
      );

  $$LocalizedBrandsTableProcessedTableManager get brandId {
    final $_column = $_itemColumn<int>('brand_id')!;

    final manager = $$LocalizedBrandsTableTableManager(
      $_db,
      $_db.localizedBrands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalizedBrandTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedBrandTranslationsTable> {
  $$LocalizedBrandTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalizedBrandsTableFilterComposer get brandId {
    final $$LocalizedBrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableFilterComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBrandTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedBrandTranslationsTable> {
  $$LocalizedBrandTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalizedBrandsTableOrderingComposer get brandId {
    final $$LocalizedBrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableOrderingComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBrandTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedBrandTranslationsTable> {
  $$LocalizedBrandTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shortDesc =>
      $composableBuilder(column: $table.shortDesc, builder: (column) => column);

  GeneratedColumn<String> get fullDesc =>
      $composableBuilder(column: $table.fullDesc, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  $$LocalizedBrandsTableAnnotationComposer get brandId {
    final $$LocalizedBrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBrandTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedBrandTranslationsTable,
          LocalizedBrandTranslation,
          $$LocalizedBrandTranslationsTableFilterComposer,
          $$LocalizedBrandTranslationsTableOrderingComposer,
          $$LocalizedBrandTranslationsTableAnnotationComposer,
          $$LocalizedBrandTranslationsTableCreateCompanionBuilder,
          $$LocalizedBrandTranslationsTableUpdateCompanionBuilder,
          (
            LocalizedBrandTranslation,
            $$LocalizedBrandTranslationsTableReferences,
          ),
          LocalizedBrandTranslation,
          PrefetchHooks Function({bool brandId})
        > {
  $$LocalizedBrandTranslationsTableTableManager(
    _$AppDatabase db,
    $LocalizedBrandTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedBrandTranslationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalizedBrandTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalizedBrandTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> brandId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> shortDesc = const Value.absent(),
                Value<String?> fullDesc = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedBrandTranslationsCompanion(
                brandId: brandId,
                languageCode: languageCode,
                shortDesc: shortDesc,
                fullDesc: fullDesc,
                location: location,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int brandId,
                required String languageCode,
                Value<String?> shortDesc = const Value.absent(),
                Value<String?> fullDesc = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedBrandTranslationsCompanion.insert(
                brandId: brandId,
                languageCode: languageCode,
                shortDesc: shortDesc,
                fullDesc: fullDesc,
                location: location,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedBrandTranslationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({brandId = false}) {
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
                    if (brandId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.brandId,
                                referencedTable:
                                    $$LocalizedBrandTranslationsTableReferences
                                        ._brandIdTable(db),
                                referencedColumn:
                                    $$LocalizedBrandTranslationsTableReferences
                                        ._brandIdTable(db)
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

typedef $$LocalizedBrandTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedBrandTranslationsTable,
      LocalizedBrandTranslation,
      $$LocalizedBrandTranslationsTableFilterComposer,
      $$LocalizedBrandTranslationsTableOrderingComposer,
      $$LocalizedBrandTranslationsTableAnnotationComposer,
      $$LocalizedBrandTranslationsTableCreateCompanionBuilder,
      $$LocalizedBrandTranslationsTableUpdateCompanionBuilder,
      (LocalizedBrandTranslation, $$LocalizedBrandTranslationsTableReferences),
      LocalizedBrandTranslation,
      PrefetchHooks Function({bool brandId})
    >;
typedef $$LocalizedFarmerTranslationsTableCreateCompanionBuilder =
    LocalizedFarmerTranslationsCompanion Function({
      required int farmerId,
      required String languageCode,
      Value<String?> name,
      Value<String?> descriptionHtml,
      Value<String?> story,
      Value<String?> region,
      Value<String?> country,
      Value<int> rowid,
    });
typedef $$LocalizedFarmerTranslationsTableUpdateCompanionBuilder =
    LocalizedFarmerTranslationsCompanion Function({
      Value<int> farmerId,
      Value<String> languageCode,
      Value<String?> name,
      Value<String?> descriptionHtml,
      Value<String?> story,
      Value<String?> region,
      Value<String?> country,
      Value<int> rowid,
    });

final class $$LocalizedFarmerTranslationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalizedFarmerTranslationsTable,
          LocalizedFarmerTranslation
        > {
  $$LocalizedFarmerTranslationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalizedFarmersTable _farmerIdTable(_$AppDatabase db) =>
      db.localizedFarmers.createAlias(
        $_aliasNameGenerator(
          db.localizedFarmerTranslations.farmerId,
          db.localizedFarmers.id,
        ),
      );

  $$LocalizedFarmersTableProcessedTableManager get farmerId {
    final $_column = $_itemColumn<int>('farmer_id')!;

    final manager = $$LocalizedFarmersTableTableManager(
      $_db,
      $_db.localizedFarmers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalizedFarmerTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedFarmerTranslationsTable> {
  $$LocalizedFarmerTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtml => $composableBuilder(
    column: $table.descriptionHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get story => $composableBuilder(
    column: $table.story,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalizedFarmersTableFilterComposer get farmerId {
    final $$LocalizedFarmersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersTableFilterComposer(
            $db: $db,
            $table: $db.localizedFarmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedFarmerTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedFarmerTranslationsTable> {
  $$LocalizedFarmerTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtml => $composableBuilder(
    column: $table.descriptionHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get story => $composableBuilder(
    column: $table.story,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalizedFarmersTableOrderingComposer get farmerId {
    final $$LocalizedFarmersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersTableOrderingComposer(
            $db: $db,
            $table: $db.localizedFarmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedFarmerTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedFarmerTranslationsTable> {
  $$LocalizedFarmerTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtml => $composableBuilder(
    column: $table.descriptionHtml,
    builder: (column) => column,
  );

  GeneratedColumn<String> get story =>
      $composableBuilder(column: $table.story, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  $$LocalizedFarmersTableAnnotationComposer get farmerId {
    final $$LocalizedFarmersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedFarmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedFarmerTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedFarmerTranslationsTable,
          LocalizedFarmerTranslation,
          $$LocalizedFarmerTranslationsTableFilterComposer,
          $$LocalizedFarmerTranslationsTableOrderingComposer,
          $$LocalizedFarmerTranslationsTableAnnotationComposer,
          $$LocalizedFarmerTranslationsTableCreateCompanionBuilder,
          $$LocalizedFarmerTranslationsTableUpdateCompanionBuilder,
          (
            LocalizedFarmerTranslation,
            $$LocalizedFarmerTranslationsTableReferences,
          ),
          LocalizedFarmerTranslation,
          PrefetchHooks Function({bool farmerId})
        > {
  $$LocalizedFarmerTranslationsTableTableManager(
    _$AppDatabase db,
    $LocalizedFarmerTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedFarmerTranslationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalizedFarmerTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalizedFarmerTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> farmerId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> descriptionHtml = const Value.absent(),
                Value<String?> story = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedFarmerTranslationsCompanion(
                farmerId: farmerId,
                languageCode: languageCode,
                name: name,
                descriptionHtml: descriptionHtml,
                story: story,
                region: region,
                country: country,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int farmerId,
                required String languageCode,
                Value<String?> name = const Value.absent(),
                Value<String?> descriptionHtml = const Value.absent(),
                Value<String?> story = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedFarmerTranslationsCompanion.insert(
                farmerId: farmerId,
                languageCode: languageCode,
                name: name,
                descriptionHtml: descriptionHtml,
                story: story,
                region: region,
                country: country,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedFarmerTranslationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({farmerId = false}) {
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
                    if (farmerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.farmerId,
                                referencedTable:
                                    $$LocalizedFarmerTranslationsTableReferences
                                        ._farmerIdTable(db),
                                referencedColumn:
                                    $$LocalizedFarmerTranslationsTableReferences
                                        ._farmerIdTable(db)
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

typedef $$LocalizedFarmerTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedFarmerTranslationsTable,
      LocalizedFarmerTranslation,
      $$LocalizedFarmerTranslationsTableFilterComposer,
      $$LocalizedFarmerTranslationsTableOrderingComposer,
      $$LocalizedFarmerTranslationsTableAnnotationComposer,
      $$LocalizedFarmerTranslationsTableCreateCompanionBuilder,
      $$LocalizedFarmerTranslationsTableUpdateCompanionBuilder,
      (
        LocalizedFarmerTranslation,
        $$LocalizedFarmerTranslationsTableReferences,
      ),
      LocalizedFarmerTranslation,
      PrefetchHooks Function({bool farmerId})
    >;
typedef $$SphereRegionsTableCreateCompanionBuilder =
    SphereRegionsCompanion Function({
      required String id,
      required String key,
      required double latitude,
      required double longitude,
      Value<String> markerColor,
      Value<bool> isActive,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });
typedef $$SphereRegionsTableUpdateCompanionBuilder =
    SphereRegionsCompanion Function({
      Value<String> id,
      Value<String> key,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> markerColor,
      Value<bool> isActive,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });

final class $$SphereRegionsTableReferences
    extends BaseReferences<_$AppDatabase, $SphereRegionsTable, SphereRegion> {
  $$SphereRegionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SphereRegionTranslationsTable,
    List<SphereRegionTranslation>
  >
  _sphereRegionTranslationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sphereRegionTranslations,
        aliasName: $_aliasNameGenerator(
          db.sphereRegions.id,
          db.sphereRegionTranslations.regionId,
        ),
      );

  $$SphereRegionTranslationsTableProcessedTableManager
  get sphereRegionTranslationsRefs {
    final manager = $$SphereRegionTranslationsTableTableManager(
      $_db,
      $_db.sphereRegionTranslations,
    ).filter((f) => f.regionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sphereRegionTranslationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SphereRegionsTableFilterComposer
    extends Composer<_$AppDatabase, $SphereRegionsTable> {
  $$SphereRegionsTableFilterComposer({
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

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markerColor => $composableBuilder(
    column: $table.markerColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sphereRegionTranslationsRefs(
    Expression<bool> Function($$SphereRegionTranslationsTableFilterComposer f)
    f,
  ) {
    final $$SphereRegionTranslationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sphereRegionTranslations,
          getReferencedColumn: (t) => t.regionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SphereRegionTranslationsTableFilterComposer(
                $db: $db,
                $table: $db.sphereRegionTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SphereRegionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SphereRegionsTable> {
  $$SphereRegionsTableOrderingComposer({
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

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markerColor => $composableBuilder(
    column: $table.markerColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SphereRegionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SphereRegionsTable> {
  $$SphereRegionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get markerColor => $composableBuilder(
    column: $table.markerColor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> sphereRegionTranslationsRefs<T extends Object>(
    Expression<T> Function($$SphereRegionTranslationsTableAnnotationComposer a)
    f,
  ) {
    final $$SphereRegionTranslationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sphereRegionTranslations,
          getReferencedColumn: (t) => t.regionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SphereRegionTranslationsTableAnnotationComposer(
                $db: $db,
                $table: $db.sphereRegionTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SphereRegionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SphereRegionsTable,
          SphereRegion,
          $$SphereRegionsTableFilterComposer,
          $$SphereRegionsTableOrderingComposer,
          $$SphereRegionsTableAnnotationComposer,
          $$SphereRegionsTableCreateCompanionBuilder,
          $$SphereRegionsTableUpdateCompanionBuilder,
          (SphereRegion, $$SphereRegionsTableReferences),
          SphereRegion,
          PrefetchHooks Function({bool sphereRegionTranslationsRefs})
        > {
  $$SphereRegionsTableTableManager(_$AppDatabase db, $SphereRegionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SphereRegionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SphereRegionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SphereRegionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> markerColor = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SphereRegionsCompanion(
                id: id,
                key: key,
                latitude: latitude,
                longitude: longitude,
                markerColor: markerColor,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String key,
                required double latitude,
                required double longitude,
                Value<String> markerColor = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SphereRegionsCompanion.insert(
                id: id,
                key: key,
                latitude: latitude,
                longitude: longitude,
                markerColor: markerColor,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SphereRegionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sphereRegionTranslationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sphereRegionTranslationsRefs) db.sphereRegionTranslations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sphereRegionTranslationsRefs)
                    await $_getPrefetchedData<
                      SphereRegion,
                      $SphereRegionsTable,
                      SphereRegionTranslation
                    >(
                      currentTable: table,
                      referencedTable: $$SphereRegionsTableReferences
                          ._sphereRegionTranslationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SphereRegionsTableReferences(
                            db,
                            table,
                            p0,
                          ).sphereRegionTranslationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.regionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SphereRegionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SphereRegionsTable,
      SphereRegion,
      $$SphereRegionsTableFilterComposer,
      $$SphereRegionsTableOrderingComposer,
      $$SphereRegionsTableAnnotationComposer,
      $$SphereRegionsTableCreateCompanionBuilder,
      $$SphereRegionsTableUpdateCompanionBuilder,
      (SphereRegion, $$SphereRegionsTableReferences),
      SphereRegion,
      PrefetchHooks Function({bool sphereRegionTranslationsRefs})
    >;
typedef $$SphereRegionTranslationsTableCreateCompanionBuilder =
    SphereRegionTranslationsCompanion Function({
      required String regionId,
      required String languageCode,
      required String name,
      Value<String?> description,
      Value<String> flavorProfile,
      Value<int> rowid,
    });
typedef $$SphereRegionTranslationsTableUpdateCompanionBuilder =
    SphereRegionTranslationsCompanion Function({
      Value<String> regionId,
      Value<String> languageCode,
      Value<String> name,
      Value<String?> description,
      Value<String> flavorProfile,
      Value<int> rowid,
    });

final class $$SphereRegionTranslationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SphereRegionTranslationsTable,
          SphereRegionTranslation
        > {
  $$SphereRegionTranslationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SphereRegionsTable _regionIdTable(_$AppDatabase db) =>
      db.sphereRegions.createAlias(
        $_aliasNameGenerator(
          db.sphereRegionTranslations.regionId,
          db.sphereRegions.id,
        ),
      );

  $$SphereRegionsTableProcessedTableManager get regionId {
    final $_column = $_itemColumn<String>('region_id')!;

    final manager = $$SphereRegionsTableTableManager(
      $_db,
      $_db.sphereRegions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_regionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SphereRegionTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $SphereRegionTranslationsTable> {
  $$SphereRegionTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  ColumnFilters<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => ColumnFilters(column),
  );

  $$SphereRegionsTableFilterComposer get regionId {
    final $$SphereRegionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.sphereRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SphereRegionsTableFilterComposer(
            $db: $db,
            $table: $db.sphereRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SphereRegionTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $SphereRegionTranslationsTable> {
  $$SphereRegionTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  ColumnOrderings<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => ColumnOrderings(column),
  );

  $$SphereRegionsTableOrderingComposer get regionId {
    final $$SphereRegionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.sphereRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SphereRegionsTableOrderingComposer(
            $db: $db,
            $table: $db.sphereRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SphereRegionTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SphereRegionTranslationsTable> {
  $$SphereRegionTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => column,
  );

  $$SphereRegionsTableAnnotationComposer get regionId {
    final $$SphereRegionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.sphereRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SphereRegionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sphereRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SphereRegionTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SphereRegionTranslationsTable,
          SphereRegionTranslation,
          $$SphereRegionTranslationsTableFilterComposer,
          $$SphereRegionTranslationsTableOrderingComposer,
          $$SphereRegionTranslationsTableAnnotationComposer,
          $$SphereRegionTranslationsTableCreateCompanionBuilder,
          $$SphereRegionTranslationsTableUpdateCompanionBuilder,
          (SphereRegionTranslation, $$SphereRegionTranslationsTableReferences),
          SphereRegionTranslation,
          PrefetchHooks Function({bool regionId})
        > {
  $$SphereRegionTranslationsTableTableManager(
    _$AppDatabase db,
    $SphereRegionTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SphereRegionTranslationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SphereRegionTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SphereRegionTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> regionId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> flavorProfile = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SphereRegionTranslationsCompanion(
                regionId: regionId,
                languageCode: languageCode,
                name: name,
                description: description,
                flavorProfile: flavorProfile,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String regionId,
                required String languageCode,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String> flavorProfile = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SphereRegionTranslationsCompanion.insert(
                regionId: regionId,
                languageCode: languageCode,
                name: name,
                description: description,
                flavorProfile: flavorProfile,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SphereRegionTranslationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({regionId = false}) {
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
                    if (regionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.regionId,
                                referencedTable:
                                    $$SphereRegionTranslationsTableReferences
                                        ._regionIdTable(db),
                                referencedColumn:
                                    $$SphereRegionTranslationsTableReferences
                                        ._regionIdTable(db)
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

typedef $$SphereRegionTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SphereRegionTranslationsTable,
      SphereRegionTranslation,
      $$SphereRegionTranslationsTableFilterComposer,
      $$SphereRegionTranslationsTableOrderingComposer,
      $$SphereRegionTranslationsTableAnnotationComposer,
      $$SphereRegionTranslationsTableCreateCompanionBuilder,
      $$SphereRegionTranslationsTableUpdateCompanionBuilder,
      (SphereRegionTranslation, $$SphereRegionTranslationsTableReferences),
      SphereRegionTranslation,
      PrefetchHooks Function({bool regionId})
    >;
typedef $$SpecialtyArticlesTableCreateCompanionBuilder =
    SpecialtyArticlesCompanion Function({
      Value<int> id,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<int> readTimeMin,
    });
typedef $$SpecialtyArticlesTableUpdateCompanionBuilder =
    SpecialtyArticlesCompanion Function({
      Value<int> id,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<int> readTimeMin,
    });

final class $$SpecialtyArticlesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpecialtyArticlesTable,
          SpecialtyArticle
        > {
  $$SpecialtyArticlesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SpecialtyArticleTranslationsTable,
    List<SpecialtyArticleTranslation>
  >
  _specialtyArticleTranslationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.specialtyArticleTranslations,
        aliasName: $_aliasNameGenerator(
          db.specialtyArticles.id,
          db.specialtyArticleTranslations.articleId,
        ),
      );

  $$SpecialtyArticleTranslationsTableProcessedTableManager
  get specialtyArticleTranslationsRefs {
    final manager = $$SpecialtyArticleTranslationsTableTableManager(
      $_db,
      $_db.specialtyArticleTranslations,
    ).filter((f) => f.articleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _specialtyArticleTranslationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> specialtyArticleTranslationsRefs(
    Expression<bool> Function(
      $$SpecialtyArticleTranslationsTableFilterComposer f,
    )
    f,
  ) {
    final $$SpecialtyArticleTranslationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.specialtyArticleTranslations,
          getReferencedColumn: (t) => t.articleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpecialtyArticleTranslationsTableFilterComposer(
                $db: $db,
                $table: $db.specialtyArticleTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
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

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get flagUrl =>
      $composableBuilder(column: $table.flagUrl, builder: (column) => column);

  GeneratedColumn<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => column,
  );

  Expression<T> specialtyArticleTranslationsRefs<T extends Object>(
    Expression<T> Function(
      $$SpecialtyArticleTranslationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$SpecialtyArticleTranslationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.specialtyArticleTranslations,
          getReferencedColumn: (t) => t.articleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpecialtyArticleTranslationsTableAnnotationComposer(
                $db: $db,
                $table: $db.specialtyArticleTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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
          (SpecialtyArticle, $$SpecialtyArticlesTableReferences),
          SpecialtyArticle,
          PrefetchHooks Function({bool specialtyArticleTranslationsRefs})
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
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<int> readTimeMin = const Value.absent(),
              }) => SpecialtyArticlesCompanion(
                id: id,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                readTimeMin: readTimeMin,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<int> readTimeMin = const Value.absent(),
              }) => SpecialtyArticlesCompanion.insert(
                id: id,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                readTimeMin: readTimeMin,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpecialtyArticlesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({specialtyArticleTranslationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (specialtyArticleTranslationsRefs)
                  db.specialtyArticleTranslations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (specialtyArticleTranslationsRefs)
                    await $_getPrefetchedData<
                      SpecialtyArticle,
                      $SpecialtyArticlesTable,
                      SpecialtyArticleTranslation
                    >(
                      currentTable: table,
                      referencedTable: $$SpecialtyArticlesTableReferences
                          ._specialtyArticleTranslationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SpecialtyArticlesTableReferences(
                            db,
                            table,
                            p0,
                          ).specialtyArticleTranslationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.articleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (SpecialtyArticle, $$SpecialtyArticlesTableReferences),
      SpecialtyArticle,
      PrefetchHooks Function({bool specialtyArticleTranslationsRefs})
    >;
typedef $$SpecialtyArticleTranslationsTableCreateCompanionBuilder =
    SpecialtyArticleTranslationsCompanion Function({
      required int articleId,
      required String languageCode,
      Value<String?> title,
      Value<String?> subtitle,
      Value<String?> contentHtml,
      Value<int> rowid,
    });
typedef $$SpecialtyArticleTranslationsTableUpdateCompanionBuilder =
    SpecialtyArticleTranslationsCompanion Function({
      Value<int> articleId,
      Value<String> languageCode,
      Value<String?> title,
      Value<String?> subtitle,
      Value<String?> contentHtml,
      Value<int> rowid,
    });

final class $$SpecialtyArticleTranslationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpecialtyArticleTranslationsTable,
          SpecialtyArticleTranslation
        > {
  $$SpecialtyArticleTranslationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SpecialtyArticlesTable _articleIdTable(_$AppDatabase db) =>
      db.specialtyArticles.createAlias(
        $_aliasNameGenerator(
          db.specialtyArticleTranslations.articleId,
          db.specialtyArticles.id,
        ),
      );

  $$SpecialtyArticlesTableProcessedTableManager get articleId {
    final $_column = $_itemColumn<int>('article_id')!;

    final manager = $$SpecialtyArticlesTableTableManager(
      $_db,
      $_db.specialtyArticles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_articleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpecialtyArticleTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $SpecialtyArticleTranslationsTable> {
  $$SpecialtyArticleTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  $$SpecialtyArticlesTableFilterComposer get articleId {
    final $$SpecialtyArticlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.articleId,
      referencedTable: $db.specialtyArticles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpecialtyArticlesTableFilterComposer(
            $db: $db,
            $table: $db.specialtyArticles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpecialtyArticleTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $SpecialtyArticleTranslationsTable> {
  $$SpecialtyArticleTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  $$SpecialtyArticlesTableOrderingComposer get articleId {
    final $$SpecialtyArticlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.articleId,
      referencedTable: $db.specialtyArticles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpecialtyArticlesTableOrderingComposer(
            $db: $db,
            $table: $db.specialtyArticles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpecialtyArticleTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpecialtyArticleTranslationsTable> {
  $$SpecialtyArticleTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get contentHtml => $composableBuilder(
    column: $table.contentHtml,
    builder: (column) => column,
  );

  $$SpecialtyArticlesTableAnnotationComposer get articleId {
    final $$SpecialtyArticlesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.articleId,
          referencedTable: $db.specialtyArticles,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpecialtyArticlesTableAnnotationComposer(
                $db: $db,
                $table: $db.specialtyArticles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SpecialtyArticleTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpecialtyArticleTranslationsTable,
          SpecialtyArticleTranslation,
          $$SpecialtyArticleTranslationsTableFilterComposer,
          $$SpecialtyArticleTranslationsTableOrderingComposer,
          $$SpecialtyArticleTranslationsTableAnnotationComposer,
          $$SpecialtyArticleTranslationsTableCreateCompanionBuilder,
          $$SpecialtyArticleTranslationsTableUpdateCompanionBuilder,
          (
            SpecialtyArticleTranslation,
            $$SpecialtyArticleTranslationsTableReferences,
          ),
          SpecialtyArticleTranslation,
          PrefetchHooks Function({bool articleId})
        > {
  $$SpecialtyArticleTranslationsTableTableManager(
    _$AppDatabase db,
    $SpecialtyArticleTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpecialtyArticleTranslationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SpecialtyArticleTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SpecialtyArticleTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> articleId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String?> contentHtml = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpecialtyArticleTranslationsCompanion(
                articleId: articleId,
                languageCode: languageCode,
                title: title,
                subtitle: subtitle,
                contentHtml: contentHtml,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int articleId,
                required String languageCode,
                Value<String?> title = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String?> contentHtml = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpecialtyArticleTranslationsCompanion.insert(
                articleId: articleId,
                languageCode: languageCode,
                title: title,
                subtitle: subtitle,
                contentHtml: contentHtml,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpecialtyArticleTranslationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({articleId = false}) {
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
                    if (articleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.articleId,
                                referencedTable:
                                    $$SpecialtyArticleTranslationsTableReferences
                                        ._articleIdTable(db),
                                referencedColumn:
                                    $$SpecialtyArticleTranslationsTableReferences
                                        ._articleIdTable(db)
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

typedef $$SpecialtyArticleTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpecialtyArticleTranslationsTable,
      SpecialtyArticleTranslation,
      $$SpecialtyArticleTranslationsTableFilterComposer,
      $$SpecialtyArticleTranslationsTableOrderingComposer,
      $$SpecialtyArticleTranslationsTableAnnotationComposer,
      $$SpecialtyArticleTranslationsTableCreateCompanionBuilder,
      $$SpecialtyArticleTranslationsTableUpdateCompanionBuilder,
      (
        SpecialtyArticleTranslation,
        $$SpecialtyArticleTranslationsTableReferences,
      ),
      SpecialtyArticleTranslation,
      PrefetchHooks Function({bool articleId})
    >;
typedef $$CoffeeLotsTableCreateCompanionBuilder =
    CoffeeLotsCompanion Function({
      required String id,
      required String userId,
      Value<String?> roasteryName,
      Value<String?> roasteryCountry,
      Value<int?> brandId,
      Value<String?> coffeeName,
      Value<String?> originCountry,
      Value<String?> region,
      Value<String?> altitude,
      Value<String?> process,
      Value<String?> roastLevel,
      Value<DateTime?> roastDate,
      Value<DateTime?> openedAt,
      Value<String?> weight,
      Value<String?> lotNumber,
      Value<bool> isDecaf,
      Value<String?> farm,
      Value<String?> washStation,
      Value<String?> farmer,
      Value<String?> varieties,
      Value<String?> flavorProfile,
      Value<String?> scaScore,
      Value<String?> retailPrice,
      Value<String?> wholesalePrice,
      Value<String> sensoryJson,
      Value<String> priceJson,
      Value<bool> isGround,
      Value<bool> isOpen,
      Value<bool> isFavorite,
      Value<bool> isArchived,
      Value<bool> isSynced,
      Value<String?> imageUrl,
      Value<bool> isDeletedLocal,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$CoffeeLotsTableUpdateCompanionBuilder =
    CoffeeLotsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String?> roasteryName,
      Value<String?> roasteryCountry,
      Value<int?> brandId,
      Value<String?> coffeeName,
      Value<String?> originCountry,
      Value<String?> region,
      Value<String?> altitude,
      Value<String?> process,
      Value<String?> roastLevel,
      Value<DateTime?> roastDate,
      Value<DateTime?> openedAt,
      Value<String?> weight,
      Value<String?> lotNumber,
      Value<bool> isDecaf,
      Value<String?> farm,
      Value<String?> washStation,
      Value<String?> farmer,
      Value<String?> varieties,
      Value<String?> flavorProfile,
      Value<String?> scaScore,
      Value<String?> retailPrice,
      Value<String?> wholesalePrice,
      Value<String> sensoryJson,
      Value<String> priceJson,
      Value<bool> isGround,
      Value<bool> isOpen,
      Value<bool> isFavorite,
      Value<bool> isArchived,
      Value<bool> isSynced,
      Value<String?> imageUrl,
      Value<bool> isDeletedLocal,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

final class $$CoffeeLotsTableReferences
    extends BaseReferences<_$AppDatabase, $CoffeeLotsTable, CoffeeLot> {
  $$CoffeeLotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalizedBrandsTable _brandIdTable(_$AppDatabase db) =>
      db.localizedBrands.createAlias(
        $_aliasNameGenerator(db.coffeeLots.brandId, db.localizedBrands.id),
      );

  $$LocalizedBrandsTableProcessedTableManager? get brandId {
    final $_column = $_itemColumn<int>('brand_id');
    if ($_column == null) return null;
    final manager = $$LocalizedBrandsTableTableManager(
      $_db,
      $_db.localizedBrands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

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

  ColumnFilters<String> get roasteryName => $composableBuilder(
    column: $table.roasteryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roasteryCountry => $composableBuilder(
    column: $table.roasteryCountry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coffeeName => $composableBuilder(
    column: $table.coffeeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get process => $composableBuilder(
    column: $table.process,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDecaf => $composableBuilder(
    column: $table.isDecaf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farm => $composableBuilder(
    column: $table.farm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmer => $composableBuilder(
    column: $table.farmer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get varieties => $composableBuilder(
    column: $table.varieties,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scaScore => $composableBuilder(
    column: $table.scaScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priceJson => $composableBuilder(
    column: $table.priceJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGround => $composableBuilder(
    column: $table.isGround,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOpen => $composableBuilder(
    column: $table.isOpen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
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

  $$LocalizedBrandsTableFilterComposer get brandId {
    final $$LocalizedBrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableFilterComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  ColumnOrderings<String> get roasteryName => $composableBuilder(
    column: $table.roasteryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roasteryCountry => $composableBuilder(
    column: $table.roasteryCountry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coffeeName => $composableBuilder(
    column: $table.coffeeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get process => $composableBuilder(
    column: $table.process,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDecaf => $composableBuilder(
    column: $table.isDecaf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farm => $composableBuilder(
    column: $table.farm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmer => $composableBuilder(
    column: $table.farmer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get varieties => $composableBuilder(
    column: $table.varieties,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scaScore => $composableBuilder(
    column: $table.scaScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceJson => $composableBuilder(
    column: $table.priceJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGround => $composableBuilder(
    column: $table.isGround,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOpen => $composableBuilder(
    column: $table.isOpen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
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

  $$LocalizedBrandsTableOrderingComposer get brandId {
    final $$LocalizedBrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableOrderingComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  GeneratedColumn<String> get roasteryName => $composableBuilder(
    column: $table.roasteryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roasteryCountry => $composableBuilder(
    column: $table.roasteryCountry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coffeeName => $composableBuilder(
    column: $table.coffeeName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originCountry => $composableBuilder(
    column: $table.originCountry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<String> get process =>
      $composableBuilder(column: $table.process, builder: (column) => column);

  GeneratedColumn<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get roastDate =>
      $composableBuilder(column: $table.roastDate, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<String> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get lotNumber =>
      $composableBuilder(column: $table.lotNumber, builder: (column) => column);

  GeneratedColumn<bool> get isDecaf =>
      $composableBuilder(column: $table.isDecaf, builder: (column) => column);

  GeneratedColumn<String> get farm =>
      $composableBuilder(column: $table.farm, builder: (column) => column);

  GeneratedColumn<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get farmer =>
      $composableBuilder(column: $table.farmer, builder: (column) => column);

  GeneratedColumn<String> get varieties =>
      $composableBuilder(column: $table.varieties, builder: (column) => column);

  GeneratedColumn<String> get flavorProfile => $composableBuilder(
    column: $table.flavorProfile,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scaScore =>
      $composableBuilder(column: $table.scaScore, builder: (column) => column);

  GeneratedColumn<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priceJson =>
      $composableBuilder(column: $table.priceJson, builder: (column) => column);

  GeneratedColumn<bool> get isGround =>
      $composableBuilder(column: $table.isGround, builder: (column) => column);

  GeneratedColumn<bool> get isOpen =>
      $composableBuilder(column: $table.isOpen, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalizedBrandsTableAnnotationComposer get brandId {
    final $$LocalizedBrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
          (CoffeeLot, $$CoffeeLotsTableReferences),
          CoffeeLot,
          PrefetchHooks Function({bool brandId})
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
                Value<String?> roasteryName = const Value.absent(),
                Value<String?> roasteryCountry = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String?> coffeeName = const Value.absent(),
                Value<String?> originCountry = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> altitude = const Value.absent(),
                Value<String?> process = const Value.absent(),
                Value<String?> roastLevel = const Value.absent(),
                Value<DateTime?> roastDate = const Value.absent(),
                Value<DateTime?> openedAt = const Value.absent(),
                Value<String?> weight = const Value.absent(),
                Value<String?> lotNumber = const Value.absent(),
                Value<bool> isDecaf = const Value.absent(),
                Value<String?> farm = const Value.absent(),
                Value<String?> washStation = const Value.absent(),
                Value<String?> farmer = const Value.absent(),
                Value<String?> varieties = const Value.absent(),
                Value<String?> flavorProfile = const Value.absent(),
                Value<String?> scaScore = const Value.absent(),
                Value<String?> retailPrice = const Value.absent(),
                Value<String?> wholesalePrice = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> priceJson = const Value.absent(),
                Value<bool> isGround = const Value.absent(),
                Value<bool> isOpen = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<bool> isDeletedLocal = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeLotsCompanion(
                id: id,
                userId: userId,
                roasteryName: roasteryName,
                roasteryCountry: roasteryCountry,
                brandId: brandId,
                coffeeName: coffeeName,
                originCountry: originCountry,
                region: region,
                altitude: altitude,
                process: process,
                roastLevel: roastLevel,
                roastDate: roastDate,
                openedAt: openedAt,
                weight: weight,
                lotNumber: lotNumber,
                isDecaf: isDecaf,
                farm: farm,
                washStation: washStation,
                farmer: farmer,
                varieties: varieties,
                flavorProfile: flavorProfile,
                scaScore: scaScore,
                retailPrice: retailPrice,
                wholesalePrice: wholesalePrice,
                sensoryJson: sensoryJson,
                priceJson: priceJson,
                isGround: isGround,
                isOpen: isOpen,
                isFavorite: isFavorite,
                isArchived: isArchived,
                isSynced: isSynced,
                imageUrl: imageUrl,
                isDeletedLocal: isDeletedLocal,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                Value<String?> roasteryName = const Value.absent(),
                Value<String?> roasteryCountry = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String?> coffeeName = const Value.absent(),
                Value<String?> originCountry = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> altitude = const Value.absent(),
                Value<String?> process = const Value.absent(),
                Value<String?> roastLevel = const Value.absent(),
                Value<DateTime?> roastDate = const Value.absent(),
                Value<DateTime?> openedAt = const Value.absent(),
                Value<String?> weight = const Value.absent(),
                Value<String?> lotNumber = const Value.absent(),
                Value<bool> isDecaf = const Value.absent(),
                Value<String?> farm = const Value.absent(),
                Value<String?> washStation = const Value.absent(),
                Value<String?> farmer = const Value.absent(),
                Value<String?> varieties = const Value.absent(),
                Value<String?> flavorProfile = const Value.absent(),
                Value<String?> scaScore = const Value.absent(),
                Value<String?> retailPrice = const Value.absent(),
                Value<String?> wholesalePrice = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> priceJson = const Value.absent(),
                Value<bool> isGround = const Value.absent(),
                Value<bool> isOpen = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<bool> isDeletedLocal = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeLotsCompanion.insert(
                id: id,
                userId: userId,
                roasteryName: roasteryName,
                roasteryCountry: roasteryCountry,
                brandId: brandId,
                coffeeName: coffeeName,
                originCountry: originCountry,
                region: region,
                altitude: altitude,
                process: process,
                roastLevel: roastLevel,
                roastDate: roastDate,
                openedAt: openedAt,
                weight: weight,
                lotNumber: lotNumber,
                isDecaf: isDecaf,
                farm: farm,
                washStation: washStation,
                farmer: farmer,
                varieties: varieties,
                flavorProfile: flavorProfile,
                scaScore: scaScore,
                retailPrice: retailPrice,
                wholesalePrice: wholesalePrice,
                sensoryJson: sensoryJson,
                priceJson: priceJson,
                isGround: isGround,
                isOpen: isOpen,
                isFavorite: isFavorite,
                isArchived: isArchived,
                isSynced: isSynced,
                imageUrl: imageUrl,
                isDeletedLocal: isDeletedLocal,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoffeeLotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({brandId = false}) {
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
                    if (brandId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.brandId,
                                referencedTable: $$CoffeeLotsTableReferences
                                    ._brandIdTable(db),
                                referencedColumn: $$CoffeeLotsTableReferences
                                    ._brandIdTable(db)
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
      (CoffeeLot, $$CoffeeLotsTableReferences),
      CoffeeLot,
      PrefetchHooks Function({bool brandId})
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
      Value<String> imageUrl,
      Value<double> ratioGramsPerMl,
      Value<double> tempC,
      Value<int> totalTimeSec,
      Value<String> difficulty,
      Value<String> stepsJson,
      Value<String> flavorProfile,
      Value<String?> iconName,
    });
typedef $$BrewingRecipesTableUpdateCompanionBuilder =
    BrewingRecipesCompanion Function({
      Value<int> id,
      Value<String> methodKey,
      Value<String> imageUrl,
      Value<double> ratioGramsPerMl,
      Value<double> tempC,
      Value<int> totalTimeSec,
      Value<String> difficulty,
      Value<String> stepsJson,
      Value<String> flavorProfile,
      Value<String?> iconName,
    });

final class $$BrewingRecipesTableReferences
    extends BaseReferences<_$AppDatabase, $BrewingRecipesTable, BrewingRecipe> {
  $$BrewingRecipesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $BrewingRecipeTranslationsTable,
    List<BrewingRecipeTranslation>
  >
  _brewingRecipeTranslationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.brewingRecipeTranslations,
        aliasName: $_aliasNameGenerator(
          db.brewingRecipes.methodKey,
          db.brewingRecipeTranslations.recipeKey,
        ),
      );

  $$BrewingRecipeTranslationsTableProcessedTableManager
  get brewingRecipeTranslationsRefs {
    final manager =
        $$BrewingRecipeTranslationsTableTableManager(
          $_db,
          $_db.brewingRecipeTranslations,
        ).filter(
          (f) => f.recipeKey.methodKey.sqlEquals(
            $_itemColumn<String>('method_key')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _brewingRecipeTranslationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
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

  Expression<bool> brewingRecipeTranslationsRefs(
    Expression<bool> Function($$BrewingRecipeTranslationsTableFilterComposer f)
    f,
  ) {
    final $$BrewingRecipeTranslationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.methodKey,
          referencedTable: $db.brewingRecipeTranslations,
          getReferencedColumn: (t) => t.recipeKey,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BrewingRecipeTranslationsTableFilterComposer(
                $db: $db,
                $table: $db.brewingRecipeTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
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

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

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

  Expression<T> brewingRecipeTranslationsRefs<T extends Object>(
    Expression<T> Function($$BrewingRecipeTranslationsTableAnnotationComposer a)
    f,
  ) {
    final $$BrewingRecipeTranslationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.methodKey,
          referencedTable: $db.brewingRecipeTranslations,
          getReferencedColumn: (t) => t.recipeKey,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BrewingRecipeTranslationsTableAnnotationComposer(
                $db: $db,
                $table: $db.brewingRecipeTranslations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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
          (BrewingRecipe, $$BrewingRecipesTableReferences),
          BrewingRecipe,
          PrefetchHooks Function({bool brewingRecipeTranslationsRefs})
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
                Value<String> imageUrl = const Value.absent(),
                Value<double> ratioGramsPerMl = const Value.absent(),
                Value<double> tempC = const Value.absent(),
                Value<int> totalTimeSec = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> stepsJson = const Value.absent(),
                Value<String> flavorProfile = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
              }) => BrewingRecipesCompanion(
                id: id,
                methodKey: methodKey,
                imageUrl: imageUrl,
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
                Value<String> imageUrl = const Value.absent(),
                Value<double> ratioGramsPerMl = const Value.absent(),
                Value<double> tempC = const Value.absent(),
                Value<int> totalTimeSec = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> stepsJson = const Value.absent(),
                Value<String> flavorProfile = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
              }) => BrewingRecipesCompanion.insert(
                id: id,
                methodKey: methodKey,
                imageUrl: imageUrl,
                ratioGramsPerMl: ratioGramsPerMl,
                tempC: tempC,
                totalTimeSec: totalTimeSec,
                difficulty: difficulty,
                stepsJson: stepsJson,
                flavorProfile: flavorProfile,
                iconName: iconName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BrewingRecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({brewingRecipeTranslationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (brewingRecipeTranslationsRefs) db.brewingRecipeTranslations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (brewingRecipeTranslationsRefs)
                    await $_getPrefetchedData<
                      BrewingRecipe,
                      $BrewingRecipesTable,
                      BrewingRecipeTranslation
                    >(
                      currentTable: table,
                      referencedTable: $$BrewingRecipesTableReferences
                          ._brewingRecipeTranslationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BrewingRecipesTableReferences(
                            db,
                            table,
                            p0,
                          ).brewingRecipeTranslationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.recipeKey == item.methodKey,
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
      (BrewingRecipe, $$BrewingRecipesTableReferences),
      BrewingRecipe,
      PrefetchHooks Function({bool brewingRecipeTranslationsRefs})
    >;
typedef $$BrewingRecipeTranslationsTableCreateCompanionBuilder =
    BrewingRecipeTranslationsCompanion Function({
      required String recipeKey,
      required String languageCode,
      Value<String?> name,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$BrewingRecipeTranslationsTableUpdateCompanionBuilder =
    BrewingRecipeTranslationsCompanion Function({
      Value<String> recipeKey,
      Value<String> languageCode,
      Value<String?> name,
      Value<String?> description,
      Value<int> rowid,
    });

final class $$BrewingRecipeTranslationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BrewingRecipeTranslationsTable,
          BrewingRecipeTranslation
        > {
  $$BrewingRecipeTranslationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BrewingRecipesTable _recipeKeyTable(_$AppDatabase db) =>
      db.brewingRecipes.createAlias(
        $_aliasNameGenerator(
          db.brewingRecipeTranslations.recipeKey,
          db.brewingRecipes.methodKey,
        ),
      );

  $$BrewingRecipesTableProcessedTableManager get recipeKey {
    final $_column = $_itemColumn<String>('recipe_key')!;

    final manager = $$BrewingRecipesTableTableManager(
      $_db,
      $_db.brewingRecipes,
    ).filter((f) => f.methodKey.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeKeyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BrewingRecipeTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $BrewingRecipeTranslationsTable> {
  $$BrewingRecipeTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  $$BrewingRecipesTableFilterComposer get recipeKey {
    final $$BrewingRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeKey,
      referencedTable: $db.brewingRecipes,
      getReferencedColumn: (t) => t.methodKey,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrewingRecipesTableFilterComposer(
            $db: $db,
            $table: $db.brewingRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BrewingRecipeTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $BrewingRecipeTranslationsTable> {
  $$BrewingRecipeTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  $$BrewingRecipesTableOrderingComposer get recipeKey {
    final $$BrewingRecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeKey,
      referencedTable: $db.brewingRecipes,
      getReferencedColumn: (t) => t.methodKey,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrewingRecipesTableOrderingComposer(
            $db: $db,
            $table: $db.brewingRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BrewingRecipeTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrewingRecipeTranslationsTable> {
  $$BrewingRecipeTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$BrewingRecipesTableAnnotationComposer get recipeKey {
    final $$BrewingRecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeKey,
      referencedTable: $db.brewingRecipes,
      getReferencedColumn: (t) => t.methodKey,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrewingRecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.brewingRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BrewingRecipeTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrewingRecipeTranslationsTable,
          BrewingRecipeTranslation,
          $$BrewingRecipeTranslationsTableFilterComposer,
          $$BrewingRecipeTranslationsTableOrderingComposer,
          $$BrewingRecipeTranslationsTableAnnotationComposer,
          $$BrewingRecipeTranslationsTableCreateCompanionBuilder,
          $$BrewingRecipeTranslationsTableUpdateCompanionBuilder,
          (
            BrewingRecipeTranslation,
            $$BrewingRecipeTranslationsTableReferences,
          ),
          BrewingRecipeTranslation,
          PrefetchHooks Function({bool recipeKey})
        > {
  $$BrewingRecipeTranslationsTableTableManager(
    _$AppDatabase db,
    $BrewingRecipeTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrewingRecipeTranslationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BrewingRecipeTranslationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BrewingRecipeTranslationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> recipeKey = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrewingRecipeTranslationsCompanion(
                recipeKey: recipeKey,
                languageCode: languageCode,
                name: name,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String recipeKey,
                required String languageCode,
                Value<String?> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrewingRecipeTranslationsCompanion.insert(
                recipeKey: recipeKey,
                languageCode: languageCode,
                name: name,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BrewingRecipeTranslationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeKey = false}) {
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
                    if (recipeKey) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeKey,
                                referencedTable:
                                    $$BrewingRecipeTranslationsTableReferences
                                        ._recipeKeyTable(db),
                                referencedColumn:
                                    $$BrewingRecipeTranslationsTableReferences
                                        ._recipeKeyTable(db)
                                        .methodKey,
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

typedef $$BrewingRecipeTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrewingRecipeTranslationsTable,
      BrewingRecipeTranslation,
      $$BrewingRecipeTranslationsTableFilterComposer,
      $$BrewingRecipeTranslationsTableOrderingComposer,
      $$BrewingRecipeTranslationsTableAnnotationComposer,
      $$BrewingRecipeTranslationsTableCreateCompanionBuilder,
      $$BrewingRecipeTranslationsTableUpdateCompanionBuilder,
      (BrewingRecipeTranslation, $$BrewingRecipeTranslationsTableReferences),
      BrewingRecipeTranslation,
      PrefetchHooks Function({bool recipeKey})
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

  static $LocalizedBeansTable _lotIdTable(_$AppDatabase db) =>
      db.localizedBeans.createAlias(
        $_aliasNameGenerator(db.recommendedRecipes.lotId, db.localizedBeans.id),
      );

  $$LocalizedBeansTableProcessedTableManager get lotId {
    final $_column = $_itemColumn<int>('lot_id')!;

    final manager = $$LocalizedBeansTableTableManager(
      $_db,
      $_db.localizedBeans,
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

  $$LocalizedBeansTableFilterComposer get lotId {
    final $$LocalizedBeansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lotId,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableFilterComposer(
            $db: $db,
            $table: $db.localizedBeans,
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

  $$LocalizedBeansTableOrderingComposer get lotId {
    final $$LocalizedBeansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lotId,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableOrderingComposer(
            $db: $db,
            $table: $db.localizedBeans,
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

  $$LocalizedBeansTableAnnotationComposer get lotId {
    final $$LocalizedBeansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lotId,
      referencedTable: $db.localizedBeans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBeans,
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
typedef $$CustomRecipesTableCreateCompanionBuilder =
    CustomRecipesCompanion Function({
      Value<String> id,
      required String userId,
      Value<String?> lotId,
      required String methodKey,
      required String name,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
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
      Value<int?> microns,
      Value<String> recipeType,
      Value<double?> brewRatio,
      Value<String?> grinderName,
      Value<bool> isSynced,
      Value<bool> isDeletedLocal,
      Value<int> rowid,
    });
typedef $$CustomRecipesTableUpdateCompanionBuilder =
    CustomRecipesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String?> lotId,
      Value<String> methodKey,
      Value<String> name,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
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
      Value<int?> microns,
      Value<String> recipeType,
      Value<double?> brewRatio,
      Value<String?> grinderName,
      Value<bool> isSynced,
      Value<bool> isDeletedLocal,
      Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotId => $composableBuilder(
    column: $table.lotId,
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

  ColumnFilters<int> get microns => $composableBuilder(
    column: $table.microns,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipeType => $composableBuilder(
    column: $table.recipeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get brewRatio => $composableBuilder(
    column: $table.brewRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grinderName => $composableBuilder(
    column: $table.grinderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotId => $composableBuilder(
    column: $table.lotId,
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

  ColumnOrderings<int> get microns => $composableBuilder(
    column: $table.microns,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipeType => $composableBuilder(
    column: $table.recipeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get brewRatio => $composableBuilder(
    column: $table.brewRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grinderName => $composableBuilder(
    column: $table.grinderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get lotId =>
      $composableBuilder(column: $table.lotId, builder: (column) => column);

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

  GeneratedColumn<int> get microns =>
      $composableBuilder(column: $table.microns, builder: (column) => column);

  GeneratedColumn<String> get recipeType => $composableBuilder(
    column: $table.recipeType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get brewRatio =>
      $composableBuilder(column: $table.brewRatio, builder: (column) => column);

  GeneratedColumn<String> get grinderName => $composableBuilder(
    column: $table.grinderName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isDeletedLocal => $composableBuilder(
    column: $table.isDeletedLocal,
    builder: (column) => column,
  );
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
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> lotId = const Value.absent(),
                Value<String> methodKey = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
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
                Value<int?> microns = const Value.absent(),
                Value<String> recipeType = const Value.absent(),
                Value<double?> brewRatio = const Value.absent(),
                Value<String?> grinderName = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeletedLocal = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomRecipesCompanion(
                id: id,
                userId: userId,
                lotId: lotId,
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
                microns: microns,
                recipeType: recipeType,
                brewRatio: brewRatio,
                grinderName: grinderName,
                isSynced: isSynced,
                isDeletedLocal: isDeletedLocal,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String userId,
                Value<String?> lotId = const Value.absent(),
                required String methodKey,
                required String name,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
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
                Value<int?> microns = const Value.absent(),
                Value<String> recipeType = const Value.absent(),
                Value<double?> brewRatio = const Value.absent(),
                Value<String?> grinderName = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isDeletedLocal = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomRecipesCompanion.insert(
                id: id,
                userId: userId,
                lotId: lotId,
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
                microns: microns,
                recipeType: recipeType,
                brewRatio: brewRatio,
                grinderName: grinderName,
                isSynced: isSynced,
                isDeletedLocal: isDeletedLocal,
                rowid: rowid,
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
typedef $$LocalizedFarmersV2TableCreateCompanionBuilder =
    LocalizedFarmersV2Companion Function({
      Value<int> id,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> createdAt,
    });
typedef $$LocalizedFarmersV2TableUpdateCompanionBuilder =
    LocalizedFarmersV2Companion Function({
      Value<int> id,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> createdAt,
    });

final class $$LocalizedFarmersV2TableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalizedFarmersV2Table,
          LocalizedFarmersV2Data
        > {
  $$LocalizedFarmersV2TableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $LocalizedFarmerTranslationsV2Table,
    List<LocalizedFarmerTranslationsV2Data>
  >
  _localizedFarmerTranslationsV2RefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localizedFarmerTranslationsV2,
        aliasName: $_aliasNameGenerator(
          db.localizedFarmersV2.id,
          db.localizedFarmerTranslationsV2.farmerId,
        ),
      );

  $$LocalizedFarmerTranslationsV2TableProcessedTableManager
  get localizedFarmerTranslationsV2Refs {
    final manager = $$LocalizedFarmerTranslationsV2TableTableManager(
      $_db,
      $_db.localizedFarmerTranslationsV2,
    ).filter((f) => f.farmerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localizedFarmerTranslationsV2RefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalizedBeansV2Table, List<LocalizedBeansV2Data>>
  _localizedBeansV2RefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localizedBeansV2,
    aliasName: $_aliasNameGenerator(
      db.localizedFarmersV2.id,
      db.localizedBeansV2.farmerId,
    ),
  );

  $$LocalizedBeansV2TableProcessedTableManager get localizedBeansV2Refs {
    final manager = $$LocalizedBeansV2TableTableManager(
      $_db,
      $_db.localizedBeansV2,
    ).filter((f) => f.farmerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localizedBeansV2RefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalizedFarmersV2TableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedFarmersV2Table> {
  $$LocalizedFarmersV2TableFilterComposer({
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

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localizedFarmerTranslationsV2Refs(
    Expression<bool> Function(
      $$LocalizedFarmerTranslationsV2TableFilterComposer f,
    )
    f,
  ) {
    final $$LocalizedFarmerTranslationsV2TableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedFarmerTranslationsV2,
          getReferencedColumn: (t) => t.farmerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedFarmerTranslationsV2TableFilterComposer(
                $db: $db,
                $table: $db.localizedFarmerTranslationsV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> localizedBeansV2Refs(
    Expression<bool> Function($$LocalizedBeansV2TableFilterComposer f) f,
  ) {
    final $$LocalizedBeansV2TableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localizedBeansV2,
      getReferencedColumn: (t) => t.farmerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansV2TableFilterComposer(
            $db: $db,
            $table: $db.localizedBeansV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalizedFarmersV2TableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedFarmersV2Table> {
  $$LocalizedFarmersV2TableOrderingComposer({
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

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalizedFarmersV2TableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedFarmersV2Table> {
  $$LocalizedFarmersV2TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get flagUrl =>
      $composableBuilder(column: $table.flagUrl, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> localizedFarmerTranslationsV2Refs<T extends Object>(
    Expression<T> Function(
      $$LocalizedFarmerTranslationsV2TableAnnotationComposer a,
    )
    f,
  ) {
    final $$LocalizedFarmerTranslationsV2TableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedFarmerTranslationsV2,
          getReferencedColumn: (t) => t.farmerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedFarmerTranslationsV2TableAnnotationComposer(
                $db: $db,
                $table: $db.localizedFarmerTranslationsV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localizedBeansV2Refs<T extends Object>(
    Expression<T> Function($$LocalizedBeansV2TableAnnotationComposer a) f,
  ) {
    final $$LocalizedBeansV2TableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localizedBeansV2,
      getReferencedColumn: (t) => t.farmerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansV2TableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBeansV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalizedFarmersV2TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedFarmersV2Table,
          LocalizedFarmersV2Data,
          $$LocalizedFarmersV2TableFilterComposer,
          $$LocalizedFarmersV2TableOrderingComposer,
          $$LocalizedFarmersV2TableAnnotationComposer,
          $$LocalizedFarmersV2TableCreateCompanionBuilder,
          $$LocalizedFarmersV2TableUpdateCompanionBuilder,
          (LocalizedFarmersV2Data, $$LocalizedFarmersV2TableReferences),
          LocalizedFarmersV2Data,
          PrefetchHooks Function({
            bool localizedFarmerTranslationsV2Refs,
            bool localizedBeansV2Refs,
          })
        > {
  $$LocalizedFarmersV2TableTableManager(
    _$AppDatabase db,
    $LocalizedFarmersV2Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedFarmersV2TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalizedFarmersV2TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalizedFarmersV2TableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedFarmersV2Companion(
                id: id,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedFarmersV2Companion.insert(
                id: id,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedFarmersV2TableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                localizedFarmerTranslationsV2Refs = false,
                localizedBeansV2Refs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localizedFarmerTranslationsV2Refs)
                      db.localizedFarmerTranslationsV2,
                    if (localizedBeansV2Refs) db.localizedBeansV2,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localizedFarmerTranslationsV2Refs)
                        await $_getPrefetchedData<
                          LocalizedFarmersV2Data,
                          $LocalizedFarmersV2Table,
                          LocalizedFarmerTranslationsV2Data
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedFarmersV2TableReferences
                              ._localizedFarmerTranslationsV2RefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedFarmersV2TableReferences(
                                db,
                                table,
                                p0,
                              ).localizedFarmerTranslationsV2Refs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.farmerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localizedBeansV2Refs)
                        await $_getPrefetchedData<
                          LocalizedFarmersV2Data,
                          $LocalizedFarmersV2Table,
                          LocalizedBeansV2Data
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedFarmersV2TableReferences
                              ._localizedBeansV2RefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedFarmersV2TableReferences(
                                db,
                                table,
                                p0,
                              ).localizedBeansV2Refs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.farmerId == item.id,
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

typedef $$LocalizedFarmersV2TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedFarmersV2Table,
      LocalizedFarmersV2Data,
      $$LocalizedFarmersV2TableFilterComposer,
      $$LocalizedFarmersV2TableOrderingComposer,
      $$LocalizedFarmersV2TableAnnotationComposer,
      $$LocalizedFarmersV2TableCreateCompanionBuilder,
      $$LocalizedFarmersV2TableUpdateCompanionBuilder,
      (LocalizedFarmersV2Data, $$LocalizedFarmersV2TableReferences),
      LocalizedFarmersV2Data,
      PrefetchHooks Function({
        bool localizedFarmerTranslationsV2Refs,
        bool localizedBeansV2Refs,
      })
    >;
typedef $$LocalizedFarmerTranslationsV2TableCreateCompanionBuilder =
    LocalizedFarmerTranslationsV2Companion Function({
      required int farmerId,
      required String languageCode,
      Value<String?> name,
      Value<String?> descriptionHtml,
      Value<String?> story,
      Value<String?> region,
      Value<String?> country,
      Value<int> rowid,
    });
typedef $$LocalizedFarmerTranslationsV2TableUpdateCompanionBuilder =
    LocalizedFarmerTranslationsV2Companion Function({
      Value<int> farmerId,
      Value<String> languageCode,
      Value<String?> name,
      Value<String?> descriptionHtml,
      Value<String?> story,
      Value<String?> region,
      Value<String?> country,
      Value<int> rowid,
    });

final class $$LocalizedFarmerTranslationsV2TableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalizedFarmerTranslationsV2Table,
          LocalizedFarmerTranslationsV2Data
        > {
  $$LocalizedFarmerTranslationsV2TableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalizedFarmersV2Table _farmerIdTable(_$AppDatabase db) =>
      db.localizedFarmersV2.createAlias(
        $_aliasNameGenerator(
          db.localizedFarmerTranslationsV2.farmerId,
          db.localizedFarmersV2.id,
        ),
      );

  $$LocalizedFarmersV2TableProcessedTableManager get farmerId {
    final $_column = $_itemColumn<int>('farmer_id')!;

    final manager = $$LocalizedFarmersV2TableTableManager(
      $_db,
      $_db.localizedFarmersV2,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalizedFarmerTranslationsV2TableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedFarmerTranslationsV2Table> {
  $$LocalizedFarmerTranslationsV2TableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtml => $composableBuilder(
    column: $table.descriptionHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get story => $composableBuilder(
    column: $table.story,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalizedFarmersV2TableFilterComposer get farmerId {
    final $$LocalizedFarmersV2TableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmersV2,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersV2TableFilterComposer(
            $db: $db,
            $table: $db.localizedFarmersV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedFarmerTranslationsV2TableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedFarmerTranslationsV2Table> {
  $$LocalizedFarmerTranslationsV2TableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtml => $composableBuilder(
    column: $table.descriptionHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get story => $composableBuilder(
    column: $table.story,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalizedFarmersV2TableOrderingComposer get farmerId {
    final $$LocalizedFarmersV2TableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmersV2,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersV2TableOrderingComposer(
            $db: $db,
            $table: $db.localizedFarmersV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedFarmerTranslationsV2TableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedFarmerTranslationsV2Table> {
  $$LocalizedFarmerTranslationsV2TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtml => $composableBuilder(
    column: $table.descriptionHtml,
    builder: (column) => column,
  );

  GeneratedColumn<String> get story =>
      $composableBuilder(column: $table.story, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  $$LocalizedFarmersV2TableAnnotationComposer get farmerId {
    final $$LocalizedFarmersV2TableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.farmerId,
          referencedTable: $db.localizedFarmersV2,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedFarmersV2TableAnnotationComposer(
                $db: $db,
                $table: $db.localizedFarmersV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LocalizedFarmerTranslationsV2TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedFarmerTranslationsV2Table,
          LocalizedFarmerTranslationsV2Data,
          $$LocalizedFarmerTranslationsV2TableFilterComposer,
          $$LocalizedFarmerTranslationsV2TableOrderingComposer,
          $$LocalizedFarmerTranslationsV2TableAnnotationComposer,
          $$LocalizedFarmerTranslationsV2TableCreateCompanionBuilder,
          $$LocalizedFarmerTranslationsV2TableUpdateCompanionBuilder,
          (
            LocalizedFarmerTranslationsV2Data,
            $$LocalizedFarmerTranslationsV2TableReferences,
          ),
          LocalizedFarmerTranslationsV2Data,
          PrefetchHooks Function({bool farmerId})
        > {
  $$LocalizedFarmerTranslationsV2TableTableManager(
    _$AppDatabase db,
    $LocalizedFarmerTranslationsV2Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedFarmerTranslationsV2TableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalizedFarmerTranslationsV2TableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalizedFarmerTranslationsV2TableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> farmerId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> descriptionHtml = const Value.absent(),
                Value<String?> story = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedFarmerTranslationsV2Companion(
                farmerId: farmerId,
                languageCode: languageCode,
                name: name,
                descriptionHtml: descriptionHtml,
                story: story,
                region: region,
                country: country,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int farmerId,
                required String languageCode,
                Value<String?> name = const Value.absent(),
                Value<String?> descriptionHtml = const Value.absent(),
                Value<String?> story = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedFarmerTranslationsV2Companion.insert(
                farmerId: farmerId,
                languageCode: languageCode,
                name: name,
                descriptionHtml: descriptionHtml,
                story: story,
                region: region,
                country: country,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedFarmerTranslationsV2TableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({farmerId = false}) {
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
                    if (farmerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.farmerId,
                                referencedTable:
                                    $$LocalizedFarmerTranslationsV2TableReferences
                                        ._farmerIdTable(db),
                                referencedColumn:
                                    $$LocalizedFarmerTranslationsV2TableReferences
                                        ._farmerIdTable(db)
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

typedef $$LocalizedFarmerTranslationsV2TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedFarmerTranslationsV2Table,
      LocalizedFarmerTranslationsV2Data,
      $$LocalizedFarmerTranslationsV2TableFilterComposer,
      $$LocalizedFarmerTranslationsV2TableOrderingComposer,
      $$LocalizedFarmerTranslationsV2TableAnnotationComposer,
      $$LocalizedFarmerTranslationsV2TableCreateCompanionBuilder,
      $$LocalizedFarmerTranslationsV2TableUpdateCompanionBuilder,
      (
        LocalizedFarmerTranslationsV2Data,
        $$LocalizedFarmerTranslationsV2TableReferences,
      ),
      LocalizedFarmerTranslationsV2Data,
      PrefetchHooks Function({bool farmerId})
    >;
typedef $$SpecialtyArticlesV2TableCreateCompanionBuilder =
    SpecialtyArticlesV2Companion Function({
      Value<int> id,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<int> readTimeMin,
      Value<DateTime?> createdAt,
    });
typedef $$SpecialtyArticlesV2TableUpdateCompanionBuilder =
    SpecialtyArticlesV2Companion Function({
      Value<int> id,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<int> readTimeMin,
      Value<DateTime?> createdAt,
    });

final class $$SpecialtyArticlesV2TableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpecialtyArticlesV2Table,
          SpecialtyArticlesV2Data
        > {
  $$SpecialtyArticlesV2TableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SpecialtyArticleTranslationsV2Table,
    List<SpecialtyArticleTranslationsV2Data>
  >
  _specialtyArticleTranslationsV2RefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.specialtyArticleTranslationsV2,
        aliasName: $_aliasNameGenerator(
          db.specialtyArticlesV2.id,
          db.specialtyArticleTranslationsV2.articleId,
        ),
      );

  $$SpecialtyArticleTranslationsV2TableProcessedTableManager
  get specialtyArticleTranslationsV2Refs {
    final manager = $$SpecialtyArticleTranslationsV2TableTableManager(
      $_db,
      $_db.specialtyArticleTranslationsV2,
    ).filter((f) => f.articleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _specialtyArticleTranslationsV2RefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpecialtyArticlesV2TableFilterComposer
    extends Composer<_$AppDatabase, $SpecialtyArticlesV2Table> {
  $$SpecialtyArticlesV2TableFilterComposer({
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

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> specialtyArticleTranslationsV2Refs(
    Expression<bool> Function(
      $$SpecialtyArticleTranslationsV2TableFilterComposer f,
    )
    f,
  ) {
    final $$SpecialtyArticleTranslationsV2TableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.specialtyArticleTranslationsV2,
          getReferencedColumn: (t) => t.articleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpecialtyArticleTranslationsV2TableFilterComposer(
                $db: $db,
                $table: $db.specialtyArticleTranslationsV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SpecialtyArticlesV2TableOrderingComposer
    extends Composer<_$AppDatabase, $SpecialtyArticlesV2Table> {
  $$SpecialtyArticlesV2TableOrderingComposer({
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

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpecialtyArticlesV2TableAnnotationComposer
    extends Composer<_$AppDatabase, $SpecialtyArticlesV2Table> {
  $$SpecialtyArticlesV2TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get flagUrl =>
      $composableBuilder(column: $table.flagUrl, builder: (column) => column);

  GeneratedColumn<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> specialtyArticleTranslationsV2Refs<T extends Object>(
    Expression<T> Function(
      $$SpecialtyArticleTranslationsV2TableAnnotationComposer a,
    )
    f,
  ) {
    final $$SpecialtyArticleTranslationsV2TableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.specialtyArticleTranslationsV2,
          getReferencedColumn: (t) => t.articleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpecialtyArticleTranslationsV2TableAnnotationComposer(
                $db: $db,
                $table: $db.specialtyArticleTranslationsV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SpecialtyArticlesV2TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpecialtyArticlesV2Table,
          SpecialtyArticlesV2Data,
          $$SpecialtyArticlesV2TableFilterComposer,
          $$SpecialtyArticlesV2TableOrderingComposer,
          $$SpecialtyArticlesV2TableAnnotationComposer,
          $$SpecialtyArticlesV2TableCreateCompanionBuilder,
          $$SpecialtyArticlesV2TableUpdateCompanionBuilder,
          (SpecialtyArticlesV2Data, $$SpecialtyArticlesV2TableReferences),
          SpecialtyArticlesV2Data,
          PrefetchHooks Function({bool specialtyArticleTranslationsV2Refs})
        > {
  $$SpecialtyArticlesV2TableTableManager(
    _$AppDatabase db,
    $SpecialtyArticlesV2Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpecialtyArticlesV2TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpecialtyArticlesV2TableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SpecialtyArticlesV2TableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<int> readTimeMin = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => SpecialtyArticlesV2Companion(
                id: id,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                readTimeMin: readTimeMin,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<int> readTimeMin = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => SpecialtyArticlesV2Companion.insert(
                id: id,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                readTimeMin: readTimeMin,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpecialtyArticlesV2TableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({specialtyArticleTranslationsV2Refs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (specialtyArticleTranslationsV2Refs)
                      db.specialtyArticleTranslationsV2,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (specialtyArticleTranslationsV2Refs)
                        await $_getPrefetchedData<
                          SpecialtyArticlesV2Data,
                          $SpecialtyArticlesV2Table,
                          SpecialtyArticleTranslationsV2Data
                        >(
                          currentTable: table,
                          referencedTable: $$SpecialtyArticlesV2TableReferences
                              ._specialtyArticleTranslationsV2RefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpecialtyArticlesV2TableReferences(
                                db,
                                table,
                                p0,
                              ).specialtyArticleTranslationsV2Refs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.articleId == item.id,
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

typedef $$SpecialtyArticlesV2TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpecialtyArticlesV2Table,
      SpecialtyArticlesV2Data,
      $$SpecialtyArticlesV2TableFilterComposer,
      $$SpecialtyArticlesV2TableOrderingComposer,
      $$SpecialtyArticlesV2TableAnnotationComposer,
      $$SpecialtyArticlesV2TableCreateCompanionBuilder,
      $$SpecialtyArticlesV2TableUpdateCompanionBuilder,
      (SpecialtyArticlesV2Data, $$SpecialtyArticlesV2TableReferences),
      SpecialtyArticlesV2Data,
      PrefetchHooks Function({bool specialtyArticleTranslationsV2Refs})
    >;
typedef $$SpecialtyArticleTranslationsV2TableCreateCompanionBuilder =
    SpecialtyArticleTranslationsV2Companion Function({
      required int articleId,
      required String languageCode,
      Value<String?> title,
      Value<String?> subtitle,
      Value<String?> contentHtml,
      Value<int> rowid,
    });
typedef $$SpecialtyArticleTranslationsV2TableUpdateCompanionBuilder =
    SpecialtyArticleTranslationsV2Companion Function({
      Value<int> articleId,
      Value<String> languageCode,
      Value<String?> title,
      Value<String?> subtitle,
      Value<String?> contentHtml,
      Value<int> rowid,
    });

final class $$SpecialtyArticleTranslationsV2TableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpecialtyArticleTranslationsV2Table,
          SpecialtyArticleTranslationsV2Data
        > {
  $$SpecialtyArticleTranslationsV2TableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SpecialtyArticlesV2Table _articleIdTable(_$AppDatabase db) =>
      db.specialtyArticlesV2.createAlias(
        $_aliasNameGenerator(
          db.specialtyArticleTranslationsV2.articleId,
          db.specialtyArticlesV2.id,
        ),
      );

  $$SpecialtyArticlesV2TableProcessedTableManager get articleId {
    final $_column = $_itemColumn<int>('article_id')!;

    final manager = $$SpecialtyArticlesV2TableTableManager(
      $_db,
      $_db.specialtyArticlesV2,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_articleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpecialtyArticleTranslationsV2TableFilterComposer
    extends Composer<_$AppDatabase, $SpecialtyArticleTranslationsV2Table> {
  $$SpecialtyArticleTranslationsV2TableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  $$SpecialtyArticlesV2TableFilterComposer get articleId {
    final $$SpecialtyArticlesV2TableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.articleId,
      referencedTable: $db.specialtyArticlesV2,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpecialtyArticlesV2TableFilterComposer(
            $db: $db,
            $table: $db.specialtyArticlesV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpecialtyArticleTranslationsV2TableOrderingComposer
    extends Composer<_$AppDatabase, $SpecialtyArticleTranslationsV2Table> {
  $$SpecialtyArticleTranslationsV2TableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  $$SpecialtyArticlesV2TableOrderingComposer get articleId {
    final $$SpecialtyArticlesV2TableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.articleId,
          referencedTable: $db.specialtyArticlesV2,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpecialtyArticlesV2TableOrderingComposer(
                $db: $db,
                $table: $db.specialtyArticlesV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SpecialtyArticleTranslationsV2TableAnnotationComposer
    extends Composer<_$AppDatabase, $SpecialtyArticleTranslationsV2Table> {
  $$SpecialtyArticleTranslationsV2TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get contentHtml => $composableBuilder(
    column: $table.contentHtml,
    builder: (column) => column,
  );

  $$SpecialtyArticlesV2TableAnnotationComposer get articleId {
    final $$SpecialtyArticlesV2TableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.articleId,
          referencedTable: $db.specialtyArticlesV2,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpecialtyArticlesV2TableAnnotationComposer(
                $db: $db,
                $table: $db.specialtyArticlesV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$SpecialtyArticleTranslationsV2TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpecialtyArticleTranslationsV2Table,
          SpecialtyArticleTranslationsV2Data,
          $$SpecialtyArticleTranslationsV2TableFilterComposer,
          $$SpecialtyArticleTranslationsV2TableOrderingComposer,
          $$SpecialtyArticleTranslationsV2TableAnnotationComposer,
          $$SpecialtyArticleTranslationsV2TableCreateCompanionBuilder,
          $$SpecialtyArticleTranslationsV2TableUpdateCompanionBuilder,
          (
            SpecialtyArticleTranslationsV2Data,
            $$SpecialtyArticleTranslationsV2TableReferences,
          ),
          SpecialtyArticleTranslationsV2Data,
          PrefetchHooks Function({bool articleId})
        > {
  $$SpecialtyArticleTranslationsV2TableTableManager(
    _$AppDatabase db,
    $SpecialtyArticleTranslationsV2Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpecialtyArticleTranslationsV2TableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SpecialtyArticleTranslationsV2TableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SpecialtyArticleTranslationsV2TableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> articleId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String?> contentHtml = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpecialtyArticleTranslationsV2Companion(
                articleId: articleId,
                languageCode: languageCode,
                title: title,
                subtitle: subtitle,
                contentHtml: contentHtml,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int articleId,
                required String languageCode,
                Value<String?> title = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<String?> contentHtml = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpecialtyArticleTranslationsV2Companion.insert(
                articleId: articleId,
                languageCode: languageCode,
                title: title,
                subtitle: subtitle,
                contentHtml: contentHtml,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpecialtyArticleTranslationsV2TableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({articleId = false}) {
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
                    if (articleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.articleId,
                                referencedTable:
                                    $$SpecialtyArticleTranslationsV2TableReferences
                                        ._articleIdTable(db),
                                referencedColumn:
                                    $$SpecialtyArticleTranslationsV2TableReferences
                                        ._articleIdTable(db)
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

typedef $$SpecialtyArticleTranslationsV2TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpecialtyArticleTranslationsV2Table,
      SpecialtyArticleTranslationsV2Data,
      $$SpecialtyArticleTranslationsV2TableFilterComposer,
      $$SpecialtyArticleTranslationsV2TableOrderingComposer,
      $$SpecialtyArticleTranslationsV2TableAnnotationComposer,
      $$SpecialtyArticleTranslationsV2TableCreateCompanionBuilder,
      $$SpecialtyArticleTranslationsV2TableUpdateCompanionBuilder,
      (
        SpecialtyArticleTranslationsV2Data,
        $$SpecialtyArticleTranslationsV2TableReferences,
      ),
      SpecialtyArticleTranslationsV2Data,
      PrefetchHooks Function({bool articleId})
    >;
typedef $$LocalizedBeansV2TableCreateCompanionBuilder =
    LocalizedBeansV2Companion Function({
      Value<int> id,
      Value<int?> brandId,
      Value<String?> countryEmoji,
      Value<int?> altitudeMin,
      Value<int?> altitudeMax,
      Value<String> lotNumber,
      Value<String> scaScore,
      Value<double> cupsScore,
      Value<String> sensoryJson,
      Value<String> priceJson,
      Value<String> plantationPhotosUrl,
      Value<String?> harvestSeason,
      Value<String?> price,
      Value<String?> weight,
      Value<String?> roastDate,
      Value<String> processingMethodsJson,
      Value<bool> isPremium,
      Value<String> detailedProcessMarkdown,
      Value<String> url,
      Value<int?> farmerId,
      Value<bool> isDecaf,
      Value<String?> farm,
      Value<String?> farmPhotosUrlCover,
      Value<String?> washStation,
      Value<String?> retailPrice,
      Value<String?> wholesalePrice,
      Value<bool> isFavorite,
      Value<String> flagUrl,
      Value<String> radarJson,
      Value<DateTime?> createdAt,
    });
typedef $$LocalizedBeansV2TableUpdateCompanionBuilder =
    LocalizedBeansV2Companion Function({
      Value<int> id,
      Value<int?> brandId,
      Value<String?> countryEmoji,
      Value<int?> altitudeMin,
      Value<int?> altitudeMax,
      Value<String> lotNumber,
      Value<String> scaScore,
      Value<double> cupsScore,
      Value<String> sensoryJson,
      Value<String> priceJson,
      Value<String> plantationPhotosUrl,
      Value<String?> harvestSeason,
      Value<String?> price,
      Value<String?> weight,
      Value<String?> roastDate,
      Value<String> processingMethodsJson,
      Value<bool> isPremium,
      Value<String> detailedProcessMarkdown,
      Value<String> url,
      Value<int?> farmerId,
      Value<bool> isDecaf,
      Value<String?> farm,
      Value<String?> farmPhotosUrlCover,
      Value<String?> washStation,
      Value<String?> retailPrice,
      Value<String?> wholesalePrice,
      Value<bool> isFavorite,
      Value<String> flagUrl,
      Value<String> radarJson,
      Value<DateTime?> createdAt,
    });

final class $$LocalizedBeansV2TableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalizedBeansV2Table,
          LocalizedBeansV2Data
        > {
  $$LocalizedBeansV2TableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalizedBrandsTable _brandIdTable(_$AppDatabase db) =>
      db.localizedBrands.createAlias(
        $_aliasNameGenerator(
          db.localizedBeansV2.brandId,
          db.localizedBrands.id,
        ),
      );

  $$LocalizedBrandsTableProcessedTableManager? get brandId {
    final $_column = $_itemColumn<int>('brand_id');
    if ($_column == null) return null;
    final manager = $$LocalizedBrandsTableTableManager(
      $_db,
      $_db.localizedBrands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalizedFarmersV2Table _farmerIdTable(_$AppDatabase db) =>
      db.localizedFarmersV2.createAlias(
        $_aliasNameGenerator(
          db.localizedBeansV2.farmerId,
          db.localizedFarmersV2.id,
        ),
      );

  $$LocalizedFarmersV2TableProcessedTableManager? get farmerId {
    final $_column = $_itemColumn<int>('farmer_id');
    if ($_column == null) return null;
    final manager = $$LocalizedFarmersV2TableTableManager(
      $_db,
      $_db.localizedFarmersV2,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LocalizedBeanTranslationsV2Table,
    List<LocalizedBeanTranslationsV2Data>
  >
  _localizedBeanTranslationsV2RefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localizedBeanTranslationsV2,
        aliasName: $_aliasNameGenerator(
          db.localizedBeansV2.id,
          db.localizedBeanTranslationsV2.beanId,
        ),
      );

  $$LocalizedBeanTranslationsV2TableProcessedTableManager
  get localizedBeanTranslationsV2Refs {
    final manager = $$LocalizedBeanTranslationsV2TableTableManager(
      $_db,
      $_db.localizedBeanTranslationsV2,
    ).filter((f) => f.beanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localizedBeanTranslationsV2RefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalizedBeansV2TableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedBeansV2Table> {
  $$LocalizedBeansV2TableFilterComposer({
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

  ColumnFilters<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scaScore => $composableBuilder(
    column: $table.scaScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cupsScore => $composableBuilder(
    column: $table.cupsScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priceJson => $composableBuilder(
    column: $table.priceJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
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

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDecaf => $composableBuilder(
    column: $table.isDecaf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farm => $composableBuilder(
    column: $table.farm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get radarJson => $composableBuilder(
    column: $table.radarJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalizedBrandsTableFilterComposer get brandId {
    final $$LocalizedBrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableFilterComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalizedFarmersV2TableFilterComposer get farmerId {
    final $$LocalizedFarmersV2TableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmersV2,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersV2TableFilterComposer(
            $db: $db,
            $table: $db.localizedFarmersV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localizedBeanTranslationsV2Refs(
    Expression<bool> Function(
      $$LocalizedBeanTranslationsV2TableFilterComposer f,
    )
    f,
  ) {
    final $$LocalizedBeanTranslationsV2TableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedBeanTranslationsV2,
          getReferencedColumn: (t) => t.beanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedBeanTranslationsV2TableFilterComposer(
                $db: $db,
                $table: $db.localizedBeanTranslationsV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalizedBeansV2TableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedBeansV2Table> {
  $$LocalizedBeansV2TableOrderingComposer({
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

  ColumnOrderings<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scaScore => $composableBuilder(
    column: $table.scaScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cupsScore => $composableBuilder(
    column: $table.cupsScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceJson => $composableBuilder(
    column: $table.priceJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
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

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDecaf => $composableBuilder(
    column: $table.isDecaf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farm => $composableBuilder(
    column: $table.farm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flagUrl => $composableBuilder(
    column: $table.flagUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get radarJson => $composableBuilder(
    column: $table.radarJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalizedBrandsTableOrderingComposer get brandId {
    final $$LocalizedBrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableOrderingComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalizedFarmersV2TableOrderingComposer get farmerId {
    final $$LocalizedFarmersV2TableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.localizedFarmersV2,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedFarmersV2TableOrderingComposer(
            $db: $db,
            $table: $db.localizedFarmersV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBeansV2TableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedBeansV2Table> {
  $$LocalizedBeansV2TableAnnotationComposer({
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

  GeneratedColumn<int> get altitudeMin => $composableBuilder(
    column: $table.altitudeMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get altitudeMax => $composableBuilder(
    column: $table.altitudeMax,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lotNumber =>
      $composableBuilder(column: $table.lotNumber, builder: (column) => column);

  GeneratedColumn<String> get scaScore =>
      $composableBuilder(column: $table.scaScore, builder: (column) => column);

  GeneratedColumn<double> get cupsScore =>
      $composableBuilder(column: $table.cupsScore, builder: (column) => column);

  GeneratedColumn<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priceJson =>
      $composableBuilder(column: $table.priceJson, builder: (column) => column);

  GeneratedColumn<String> get plantationPhotosUrl => $composableBuilder(
    column: $table.plantationPhotosUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get harvestSeason => $composableBuilder(
    column: $table.harvestSeason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get roastDate =>
      $composableBuilder(column: $table.roastDate, builder: (column) => column);

  GeneratedColumn<String> get processingMethodsJson => $composableBuilder(
    column: $table.processingMethodsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPremium =>
      $composableBuilder(column: $table.isPremium, builder: (column) => column);

  GeneratedColumn<String> get detailedProcessMarkdown => $composableBuilder(
    column: $table.detailedProcessMarkdown,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<bool> get isDecaf =>
      $composableBuilder(column: $table.isDecaf, builder: (column) => column);

  GeneratedColumn<String> get farm =>
      $composableBuilder(column: $table.farm, builder: (column) => column);

  GeneratedColumn<String> get farmPhotosUrlCover => $composableBuilder(
    column: $table.farmPhotosUrlCover,
    builder: (column) => column,
  );

  GeneratedColumn<String> get washStation => $composableBuilder(
    column: $table.washStation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wholesalePrice => $composableBuilder(
    column: $table.wholesalePrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flagUrl =>
      $composableBuilder(column: $table.flagUrl, builder: (column) => column);

  GeneratedColumn<String> get radarJson =>
      $composableBuilder(column: $table.radarJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalizedBrandsTableAnnotationComposer get brandId {
    final $$LocalizedBrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.localizedBrands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBrands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalizedFarmersV2TableAnnotationComposer get farmerId {
    final $$LocalizedFarmersV2TableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.farmerId,
          referencedTable: $db.localizedFarmersV2,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedFarmersV2TableAnnotationComposer(
                $db: $db,
                $table: $db.localizedFarmersV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> localizedBeanTranslationsV2Refs<T extends Object>(
    Expression<T> Function(
      $$LocalizedBeanTranslationsV2TableAnnotationComposer a,
    )
    f,
  ) {
    final $$LocalizedBeanTranslationsV2TableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localizedBeanTranslationsV2,
          getReferencedColumn: (t) => t.beanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalizedBeanTranslationsV2TableAnnotationComposer(
                $db: $db,
                $table: $db.localizedBeanTranslationsV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalizedBeansV2TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedBeansV2Table,
          LocalizedBeansV2Data,
          $$LocalizedBeansV2TableFilterComposer,
          $$LocalizedBeansV2TableOrderingComposer,
          $$LocalizedBeansV2TableAnnotationComposer,
          $$LocalizedBeansV2TableCreateCompanionBuilder,
          $$LocalizedBeansV2TableUpdateCompanionBuilder,
          (LocalizedBeansV2Data, $$LocalizedBeansV2TableReferences),
          LocalizedBeansV2Data,
          PrefetchHooks Function({
            bool brandId,
            bool farmerId,
            bool localizedBeanTranslationsV2Refs,
          })
        > {
  $$LocalizedBeansV2TableTableManager(
    _$AppDatabase db,
    $LocalizedBeansV2Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedBeansV2TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalizedBeansV2TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalizedBeansV2TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String?> countryEmoji = const Value.absent(),
                Value<int?> altitudeMin = const Value.absent(),
                Value<int?> altitudeMax = const Value.absent(),
                Value<String> lotNumber = const Value.absent(),
                Value<String> scaScore = const Value.absent(),
                Value<double> cupsScore = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> priceJson = const Value.absent(),
                Value<String> plantationPhotosUrl = const Value.absent(),
                Value<String?> harvestSeason = const Value.absent(),
                Value<String?> price = const Value.absent(),
                Value<String?> weight = const Value.absent(),
                Value<String?> roastDate = const Value.absent(),
                Value<String> processingMethodsJson = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<String> detailedProcessMarkdown = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int?> farmerId = const Value.absent(),
                Value<bool> isDecaf = const Value.absent(),
                Value<String?> farm = const Value.absent(),
                Value<String?> farmPhotosUrlCover = const Value.absent(),
                Value<String?> washStation = const Value.absent(),
                Value<String?> retailPrice = const Value.absent(),
                Value<String?> wholesalePrice = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<String> radarJson = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedBeansV2Companion(
                id: id,
                brandId: brandId,
                countryEmoji: countryEmoji,
                altitudeMin: altitudeMin,
                altitudeMax: altitudeMax,
                lotNumber: lotNumber,
                scaScore: scaScore,
                cupsScore: cupsScore,
                sensoryJson: sensoryJson,
                priceJson: priceJson,
                plantationPhotosUrl: plantationPhotosUrl,
                harvestSeason: harvestSeason,
                price: price,
                weight: weight,
                roastDate: roastDate,
                processingMethodsJson: processingMethodsJson,
                isPremium: isPremium,
                detailedProcessMarkdown: detailedProcessMarkdown,
                url: url,
                farmerId: farmerId,
                isDecaf: isDecaf,
                farm: farm,
                farmPhotosUrlCover: farmPhotosUrlCover,
                washStation: washStation,
                retailPrice: retailPrice,
                wholesalePrice: wholesalePrice,
                isFavorite: isFavorite,
                flagUrl: flagUrl,
                radarJson: radarJson,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> brandId = const Value.absent(),
                Value<String?> countryEmoji = const Value.absent(),
                Value<int?> altitudeMin = const Value.absent(),
                Value<int?> altitudeMax = const Value.absent(),
                Value<String> lotNumber = const Value.absent(),
                Value<String> scaScore = const Value.absent(),
                Value<double> cupsScore = const Value.absent(),
                Value<String> sensoryJson = const Value.absent(),
                Value<String> priceJson = const Value.absent(),
                Value<String> plantationPhotosUrl = const Value.absent(),
                Value<String?> harvestSeason = const Value.absent(),
                Value<String?> price = const Value.absent(),
                Value<String?> weight = const Value.absent(),
                Value<String?> roastDate = const Value.absent(),
                Value<String> processingMethodsJson = const Value.absent(),
                Value<bool> isPremium = const Value.absent(),
                Value<String> detailedProcessMarkdown = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<int?> farmerId = const Value.absent(),
                Value<bool> isDecaf = const Value.absent(),
                Value<String?> farm = const Value.absent(),
                Value<String?> farmPhotosUrlCover = const Value.absent(),
                Value<String?> washStation = const Value.absent(),
                Value<String?> retailPrice = const Value.absent(),
                Value<String?> wholesalePrice = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<String> radarJson = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedBeansV2Companion.insert(
                id: id,
                brandId: brandId,
                countryEmoji: countryEmoji,
                altitudeMin: altitudeMin,
                altitudeMax: altitudeMax,
                lotNumber: lotNumber,
                scaScore: scaScore,
                cupsScore: cupsScore,
                sensoryJson: sensoryJson,
                priceJson: priceJson,
                plantationPhotosUrl: plantationPhotosUrl,
                harvestSeason: harvestSeason,
                price: price,
                weight: weight,
                roastDate: roastDate,
                processingMethodsJson: processingMethodsJson,
                isPremium: isPremium,
                detailedProcessMarkdown: detailedProcessMarkdown,
                url: url,
                farmerId: farmerId,
                isDecaf: isDecaf,
                farm: farm,
                farmPhotosUrlCover: farmPhotosUrlCover,
                washStation: washStation,
                retailPrice: retailPrice,
                wholesalePrice: wholesalePrice,
                isFavorite: isFavorite,
                flagUrl: flagUrl,
                radarJson: radarJson,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedBeansV2TableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                brandId = false,
                farmerId = false,
                localizedBeanTranslationsV2Refs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localizedBeanTranslationsV2Refs)
                      db.localizedBeanTranslationsV2,
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
                                        $$LocalizedBeansV2TableReferences
                                            ._brandIdTable(db),
                                    referencedColumn:
                                        $$LocalizedBeansV2TableReferences
                                            ._brandIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (farmerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.farmerId,
                                    referencedTable:
                                        $$LocalizedBeansV2TableReferences
                                            ._farmerIdTable(db),
                                    referencedColumn:
                                        $$LocalizedBeansV2TableReferences
                                            ._farmerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localizedBeanTranslationsV2Refs)
                        await $_getPrefetchedData<
                          LocalizedBeansV2Data,
                          $LocalizedBeansV2Table,
                          LocalizedBeanTranslationsV2Data
                        >(
                          currentTable: table,
                          referencedTable: $$LocalizedBeansV2TableReferences
                              ._localizedBeanTranslationsV2RefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalizedBeansV2TableReferences(
                                db,
                                table,
                                p0,
                              ).localizedBeanTranslationsV2Refs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beanId == item.id,
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

typedef $$LocalizedBeansV2TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedBeansV2Table,
      LocalizedBeansV2Data,
      $$LocalizedBeansV2TableFilterComposer,
      $$LocalizedBeansV2TableOrderingComposer,
      $$LocalizedBeansV2TableAnnotationComposer,
      $$LocalizedBeansV2TableCreateCompanionBuilder,
      $$LocalizedBeansV2TableUpdateCompanionBuilder,
      (LocalizedBeansV2Data, $$LocalizedBeansV2TableReferences),
      LocalizedBeansV2Data,
      PrefetchHooks Function({
        bool brandId,
        bool farmerId,
        bool localizedBeanTranslationsV2Refs,
      })
    >;
typedef $$LocalizedBeanTranslationsV2TableCreateCompanionBuilder =
    LocalizedBeanTranslationsV2Companion Function({
      required int beanId,
      required String languageCode,
      Value<String?> country,
      Value<String?> region,
      Value<String?> varieties,
      Value<String> flavorNotes,
      Value<String?> processMethod,
      Value<String?> description,
      Value<String?> farmDescription,
      Value<String?> roastLevel,
      Value<int> rowid,
    });
typedef $$LocalizedBeanTranslationsV2TableUpdateCompanionBuilder =
    LocalizedBeanTranslationsV2Companion Function({
      Value<int> beanId,
      Value<String> languageCode,
      Value<String?> country,
      Value<String?> region,
      Value<String?> varieties,
      Value<String> flavorNotes,
      Value<String?> processMethod,
      Value<String?> description,
      Value<String?> farmDescription,
      Value<String?> roastLevel,
      Value<int> rowid,
    });

final class $$LocalizedBeanTranslationsV2TableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalizedBeanTranslationsV2Table,
          LocalizedBeanTranslationsV2Data
        > {
  $$LocalizedBeanTranslationsV2TableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalizedBeansV2Table _beanIdTable(_$AppDatabase db) =>
      db.localizedBeansV2.createAlias(
        $_aliasNameGenerator(
          db.localizedBeanTranslationsV2.beanId,
          db.localizedBeansV2.id,
        ),
      );

  $$LocalizedBeansV2TableProcessedTableManager get beanId {
    final $_column = $_itemColumn<int>('bean_id')!;

    final manager = $$LocalizedBeansV2TableTableManager(
      $_db,
      $_db.localizedBeansV2,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalizedBeanTranslationsV2TableFilterComposer
    extends Composer<_$AppDatabase, $LocalizedBeanTranslationsV2Table> {
  $$LocalizedBeanTranslationsV2TableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalizedBeansV2TableFilterComposer get beanId {
    final $$LocalizedBeansV2TableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beanId,
      referencedTable: $db.localizedBeansV2,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansV2TableFilterComposer(
            $db: $db,
            $table: $db.localizedBeansV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBeanTranslationsV2TableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizedBeanTranslationsV2Table> {
  $$LocalizedBeanTranslationsV2TableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalizedBeansV2TableOrderingComposer get beanId {
    final $$LocalizedBeansV2TableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beanId,
      referencedTable: $db.localizedBeansV2,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansV2TableOrderingComposer(
            $db: $db,
            $table: $db.localizedBeansV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBeanTranslationsV2TableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizedBeanTranslationsV2Table> {
  $$LocalizedBeanTranslationsV2TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get farmDescription => $composableBuilder(
    column: $table.farmDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roastLevel => $composableBuilder(
    column: $table.roastLevel,
    builder: (column) => column,
  );

  $$LocalizedBeansV2TableAnnotationComposer get beanId {
    final $$LocalizedBeansV2TableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beanId,
      referencedTable: $db.localizedBeansV2,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalizedBeansV2TableAnnotationComposer(
            $db: $db,
            $table: $db.localizedBeansV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalizedBeanTranslationsV2TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalizedBeanTranslationsV2Table,
          LocalizedBeanTranslationsV2Data,
          $$LocalizedBeanTranslationsV2TableFilterComposer,
          $$LocalizedBeanTranslationsV2TableOrderingComposer,
          $$LocalizedBeanTranslationsV2TableAnnotationComposer,
          $$LocalizedBeanTranslationsV2TableCreateCompanionBuilder,
          $$LocalizedBeanTranslationsV2TableUpdateCompanionBuilder,
          (
            LocalizedBeanTranslationsV2Data,
            $$LocalizedBeanTranslationsV2TableReferences,
          ),
          LocalizedBeanTranslationsV2Data,
          PrefetchHooks Function({bool beanId})
        > {
  $$LocalizedBeanTranslationsV2TableTableManager(
    _$AppDatabase db,
    $LocalizedBeanTranslationsV2Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizedBeanTranslationsV2TableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalizedBeanTranslationsV2TableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalizedBeanTranslationsV2TableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> beanId = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> varieties = const Value.absent(),
                Value<String> flavorNotes = const Value.absent(),
                Value<String?> processMethod = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> farmDescription = const Value.absent(),
                Value<String?> roastLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedBeanTranslationsV2Companion(
                beanId: beanId,
                languageCode: languageCode,
                country: country,
                region: region,
                varieties: varieties,
                flavorNotes: flavorNotes,
                processMethod: processMethod,
                description: description,
                farmDescription: farmDescription,
                roastLevel: roastLevel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int beanId,
                required String languageCode,
                Value<String?> country = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> varieties = const Value.absent(),
                Value<String> flavorNotes = const Value.absent(),
                Value<String?> processMethod = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> farmDescription = const Value.absent(),
                Value<String?> roastLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalizedBeanTranslationsV2Companion.insert(
                beanId: beanId,
                languageCode: languageCode,
                country: country,
                region: region,
                varieties: varieties,
                flavorNotes: flavorNotes,
                processMethod: processMethod,
                description: description,
                farmDescription: farmDescription,
                roastLevel: roastLevel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalizedBeanTranslationsV2TableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({beanId = false}) {
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
                    if (beanId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.beanId,
                                referencedTable:
                                    $$LocalizedBeanTranslationsV2TableReferences
                                        ._beanIdTable(db),
                                referencedColumn:
                                    $$LocalizedBeanTranslationsV2TableReferences
                                        ._beanIdTable(db)
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

typedef $$LocalizedBeanTranslationsV2TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalizedBeanTranslationsV2Table,
      LocalizedBeanTranslationsV2Data,
      $$LocalizedBeanTranslationsV2TableFilterComposer,
      $$LocalizedBeanTranslationsV2TableOrderingComposer,
      $$LocalizedBeanTranslationsV2TableAnnotationComposer,
      $$LocalizedBeanTranslationsV2TableCreateCompanionBuilder,
      $$LocalizedBeanTranslationsV2TableUpdateCompanionBuilder,
      (
        LocalizedBeanTranslationsV2Data,
        $$LocalizedBeanTranslationsV2TableReferences,
      ),
      LocalizedBeanTranslationsV2Data,
      PrefetchHooks Function({bool beanId})
    >;
typedef $$BrewingRecipesV2TableCreateCompanionBuilder =
    BrewingRecipesV2Companion Function({
      Value<int> id,
      required String methodKey,
      Value<String> imageUrl,
      Value<double> ratioGramsPerMl,
      Value<double> tempC,
      Value<int> totalTimeSec,
      Value<String> difficulty,
      Value<String> stepsJson,
      Value<String> flavorProfile,
      Value<String?> iconName,
    });
typedef $$BrewingRecipesV2TableUpdateCompanionBuilder =
    BrewingRecipesV2Companion Function({
      Value<int> id,
      Value<String> methodKey,
      Value<String> imageUrl,
      Value<double> ratioGramsPerMl,
      Value<double> tempC,
      Value<int> totalTimeSec,
      Value<String> difficulty,
      Value<String> stepsJson,
      Value<String> flavorProfile,
      Value<String?> iconName,
    });

final class $$BrewingRecipesV2TableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BrewingRecipesV2Table,
          BrewingRecipesV2Data
        > {
  $$BrewingRecipesV2TableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $BrewingRecipeTranslationsV2Table,
    List<BrewingRecipeTranslationsV2Data>
  >
  _brewingRecipeTranslationsV2RefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.brewingRecipeTranslationsV2,
        aliasName: $_aliasNameGenerator(
          db.brewingRecipesV2.methodKey,
          db.brewingRecipeTranslationsV2.recipeKey,
        ),
      );

  $$BrewingRecipeTranslationsV2TableProcessedTableManager
  get brewingRecipeTranslationsV2Refs {
    final manager =
        $$BrewingRecipeTranslationsV2TableTableManager(
          $_db,
          $_db.brewingRecipeTranslationsV2,
        ).filter(
          (f) => f.recipeKey.methodKey.sqlEquals(
            $_itemColumn<String>('method_key')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _brewingRecipeTranslationsV2RefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BrewingRecipesV2TableFilterComposer
    extends Composer<_$AppDatabase, $BrewingRecipesV2Table> {
  $$BrewingRecipesV2TableFilterComposer({
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

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
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

  Expression<bool> brewingRecipeTranslationsV2Refs(
    Expression<bool> Function(
      $$BrewingRecipeTranslationsV2TableFilterComposer f,
    )
    f,
  ) {
    final $$BrewingRecipeTranslationsV2TableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.methodKey,
          referencedTable: $db.brewingRecipeTranslationsV2,
          getReferencedColumn: (t) => t.recipeKey,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BrewingRecipeTranslationsV2TableFilterComposer(
                $db: $db,
                $table: $db.brewingRecipeTranslationsV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BrewingRecipesV2TableOrderingComposer
    extends Composer<_$AppDatabase, $BrewingRecipesV2Table> {
  $$BrewingRecipesV2TableOrderingComposer({
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

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
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

class $$BrewingRecipesV2TableAnnotationComposer
    extends Composer<_$AppDatabase, $BrewingRecipesV2Table> {
  $$BrewingRecipesV2TableAnnotationComposer({
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

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

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

  Expression<T> brewingRecipeTranslationsV2Refs<T extends Object>(
    Expression<T> Function(
      $$BrewingRecipeTranslationsV2TableAnnotationComposer a,
    )
    f,
  ) {
    final $$BrewingRecipeTranslationsV2TableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.methodKey,
          referencedTable: $db.brewingRecipeTranslationsV2,
          getReferencedColumn: (t) => t.recipeKey,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BrewingRecipeTranslationsV2TableAnnotationComposer(
                $db: $db,
                $table: $db.brewingRecipeTranslationsV2,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BrewingRecipesV2TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrewingRecipesV2Table,
          BrewingRecipesV2Data,
          $$BrewingRecipesV2TableFilterComposer,
          $$BrewingRecipesV2TableOrderingComposer,
          $$BrewingRecipesV2TableAnnotationComposer,
          $$BrewingRecipesV2TableCreateCompanionBuilder,
          $$BrewingRecipesV2TableUpdateCompanionBuilder,
          (BrewingRecipesV2Data, $$BrewingRecipesV2TableReferences),
          BrewingRecipesV2Data,
          PrefetchHooks Function({bool brewingRecipeTranslationsV2Refs})
        > {
  $$BrewingRecipesV2TableTableManager(
    _$AppDatabase db,
    $BrewingRecipesV2Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrewingRecipesV2TableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrewingRecipesV2TableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrewingRecipesV2TableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> methodKey = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<double> ratioGramsPerMl = const Value.absent(),
                Value<double> tempC = const Value.absent(),
                Value<int> totalTimeSec = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> stepsJson = const Value.absent(),
                Value<String> flavorProfile = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
              }) => BrewingRecipesV2Companion(
                id: id,
                methodKey: methodKey,
                imageUrl: imageUrl,
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
                Value<String> imageUrl = const Value.absent(),
                Value<double> ratioGramsPerMl = const Value.absent(),
                Value<double> tempC = const Value.absent(),
                Value<int> totalTimeSec = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> stepsJson = const Value.absent(),
                Value<String> flavorProfile = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
              }) => BrewingRecipesV2Companion.insert(
                id: id,
                methodKey: methodKey,
                imageUrl: imageUrl,
                ratioGramsPerMl: ratioGramsPerMl,
                tempC: tempC,
                totalTimeSec: totalTimeSec,
                difficulty: difficulty,
                stepsJson: stepsJson,
                flavorProfile: flavorProfile,
                iconName: iconName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BrewingRecipesV2TableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({brewingRecipeTranslationsV2Refs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (brewingRecipeTranslationsV2Refs)
                  db.brewingRecipeTranslationsV2,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (brewingRecipeTranslationsV2Refs)
                    await $_getPrefetchedData<
                      BrewingRecipesV2Data,
                      $BrewingRecipesV2Table,
                      BrewingRecipeTranslationsV2Data
                    >(
                      currentTable: table,
                      referencedTable: $$BrewingRecipesV2TableReferences
                          ._brewingRecipeTranslationsV2RefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BrewingRecipesV2TableReferences(
                            db,
                            table,
                            p0,
                          ).brewingRecipeTranslationsV2Refs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.recipeKey == item.methodKey,
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

typedef $$BrewingRecipesV2TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrewingRecipesV2Table,
      BrewingRecipesV2Data,
      $$BrewingRecipesV2TableFilterComposer,
      $$BrewingRecipesV2TableOrderingComposer,
      $$BrewingRecipesV2TableAnnotationComposer,
      $$BrewingRecipesV2TableCreateCompanionBuilder,
      $$BrewingRecipesV2TableUpdateCompanionBuilder,
      (BrewingRecipesV2Data, $$BrewingRecipesV2TableReferences),
      BrewingRecipesV2Data,
      PrefetchHooks Function({bool brewingRecipeTranslationsV2Refs})
    >;
typedef $$BrewingRecipeTranslationsV2TableCreateCompanionBuilder =
    BrewingRecipeTranslationsV2Companion Function({
      required String recipeKey,
      required String languageCode,
      Value<String?> name,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$BrewingRecipeTranslationsV2TableUpdateCompanionBuilder =
    BrewingRecipeTranslationsV2Companion Function({
      Value<String> recipeKey,
      Value<String> languageCode,
      Value<String?> name,
      Value<String?> description,
      Value<int> rowid,
    });

final class $$BrewingRecipeTranslationsV2TableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BrewingRecipeTranslationsV2Table,
          BrewingRecipeTranslationsV2Data
        > {
  $$BrewingRecipeTranslationsV2TableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BrewingRecipesV2Table _recipeKeyTable(_$AppDatabase db) =>
      db.brewingRecipesV2.createAlias(
        $_aliasNameGenerator(
          db.brewingRecipeTranslationsV2.recipeKey,
          db.brewingRecipesV2.methodKey,
        ),
      );

  $$BrewingRecipesV2TableProcessedTableManager get recipeKey {
    final $_column = $_itemColumn<String>('recipe_key')!;

    final manager = $$BrewingRecipesV2TableTableManager(
      $_db,
      $_db.brewingRecipesV2,
    ).filter((f) => f.methodKey.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeKeyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BrewingRecipeTranslationsV2TableFilterComposer
    extends Composer<_$AppDatabase, $BrewingRecipeTranslationsV2Table> {
  $$BrewingRecipeTranslationsV2TableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  $$BrewingRecipesV2TableFilterComposer get recipeKey {
    final $$BrewingRecipesV2TableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeKey,
      referencedTable: $db.brewingRecipesV2,
      getReferencedColumn: (t) => t.methodKey,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrewingRecipesV2TableFilterComposer(
            $db: $db,
            $table: $db.brewingRecipesV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BrewingRecipeTranslationsV2TableOrderingComposer
    extends Composer<_$AppDatabase, $BrewingRecipeTranslationsV2Table> {
  $$BrewingRecipeTranslationsV2TableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
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

  $$BrewingRecipesV2TableOrderingComposer get recipeKey {
    final $$BrewingRecipesV2TableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeKey,
      referencedTable: $db.brewingRecipesV2,
      getReferencedColumn: (t) => t.methodKey,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrewingRecipesV2TableOrderingComposer(
            $db: $db,
            $table: $db.brewingRecipesV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BrewingRecipeTranslationsV2TableAnnotationComposer
    extends Composer<_$AppDatabase, $BrewingRecipeTranslationsV2Table> {
  $$BrewingRecipeTranslationsV2TableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$BrewingRecipesV2TableAnnotationComposer get recipeKey {
    final $$BrewingRecipesV2TableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeKey,
      referencedTable: $db.brewingRecipesV2,
      getReferencedColumn: (t) => t.methodKey,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrewingRecipesV2TableAnnotationComposer(
            $db: $db,
            $table: $db.brewingRecipesV2,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BrewingRecipeTranslationsV2TableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrewingRecipeTranslationsV2Table,
          BrewingRecipeTranslationsV2Data,
          $$BrewingRecipeTranslationsV2TableFilterComposer,
          $$BrewingRecipeTranslationsV2TableOrderingComposer,
          $$BrewingRecipeTranslationsV2TableAnnotationComposer,
          $$BrewingRecipeTranslationsV2TableCreateCompanionBuilder,
          $$BrewingRecipeTranslationsV2TableUpdateCompanionBuilder,
          (
            BrewingRecipeTranslationsV2Data,
            $$BrewingRecipeTranslationsV2TableReferences,
          ),
          BrewingRecipeTranslationsV2Data,
          PrefetchHooks Function({bool recipeKey})
        > {
  $$BrewingRecipeTranslationsV2TableTableManager(
    _$AppDatabase db,
    $BrewingRecipeTranslationsV2Table table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrewingRecipeTranslationsV2TableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BrewingRecipeTranslationsV2TableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BrewingRecipeTranslationsV2TableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> recipeKey = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrewingRecipeTranslationsV2Companion(
                recipeKey: recipeKey,
                languageCode: languageCode,
                name: name,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String recipeKey,
                required String languageCode,
                Value<String?> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrewingRecipeTranslationsV2Companion.insert(
                recipeKey: recipeKey,
                languageCode: languageCode,
                name: name,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BrewingRecipeTranslationsV2TableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeKey = false}) {
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
                    if (recipeKey) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeKey,
                                referencedTable:
                                    $$BrewingRecipeTranslationsV2TableReferences
                                        ._recipeKeyTable(db),
                                referencedColumn:
                                    $$BrewingRecipeTranslationsV2TableReferences
                                        ._recipeKeyTable(db)
                                        .methodKey,
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

typedef $$BrewingRecipeTranslationsV2TableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrewingRecipeTranslationsV2Table,
      BrewingRecipeTranslationsV2Data,
      $$BrewingRecipeTranslationsV2TableFilterComposer,
      $$BrewingRecipeTranslationsV2TableOrderingComposer,
      $$BrewingRecipeTranslationsV2TableAnnotationComposer,
      $$BrewingRecipeTranslationsV2TableCreateCompanionBuilder,
      $$BrewingRecipeTranslationsV2TableUpdateCompanionBuilder,
      (
        BrewingRecipeTranslationsV2Data,
        $$BrewingRecipeTranslationsV2TableReferences,
      ),
      BrewingRecipeTranslationsV2Data,
      PrefetchHooks Function({bool recipeKey})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalizedBrandsTableTableManager get localizedBrands =>
      $$LocalizedBrandsTableTableManager(_db, _db.localizedBrands);
  $$LocalizedFarmersTableTableManager get localizedFarmers =>
      $$LocalizedFarmersTableTableManager(_db, _db.localizedFarmers);
  $$LocalizedBeansTableTableManager get localizedBeans =>
      $$LocalizedBeansTableTableManager(_db, _db.localizedBeans);
  $$LocalizedBeanTranslationsTableTableManager get localizedBeanTranslations =>
      $$LocalizedBeanTranslationsTableTableManager(
        _db,
        _db.localizedBeanTranslations,
      );
  $$LocalizedBrandTranslationsTableTableManager
  get localizedBrandTranslations =>
      $$LocalizedBrandTranslationsTableTableManager(
        _db,
        _db.localizedBrandTranslations,
      );
  $$LocalizedFarmerTranslationsTableTableManager
  get localizedFarmerTranslations =>
      $$LocalizedFarmerTranslationsTableTableManager(
        _db,
        _db.localizedFarmerTranslations,
      );
  $$SphereRegionsTableTableManager get sphereRegions =>
      $$SphereRegionsTableTableManager(_db, _db.sphereRegions);
  $$SphereRegionTranslationsTableTableManager get sphereRegionTranslations =>
      $$SphereRegionTranslationsTableTableManager(
        _db,
        _db.sphereRegionTranslations,
      );
  $$SpecialtyArticlesTableTableManager get specialtyArticles =>
      $$SpecialtyArticlesTableTableManager(_db, _db.specialtyArticles);
  $$SpecialtyArticleTranslationsTableTableManager
  get specialtyArticleTranslations =>
      $$SpecialtyArticleTranslationsTableTableManager(
        _db,
        _db.specialtyArticleTranslations,
      );
  $$CoffeeLotsTableTableManager get coffeeLots =>
      $$CoffeeLotsTableTableManager(_db, _db.coffeeLots);
  $$FermentationLogsTableTableManager get fermentationLogs =>
      $$FermentationLogsTableTableManager(_db, _db.fermentationLogs);
  $$BrewingRecipesTableTableManager get brewingRecipes =>
      $$BrewingRecipesTableTableManager(_db, _db.brewingRecipes);
  $$BrewingRecipeTranslationsTableTableManager get brewingRecipeTranslations =>
      $$BrewingRecipeTranslationsTableTableManager(
        _db,
        _db.brewingRecipeTranslations,
      );
  $$RecommendedRecipesTableTableManager get recommendedRecipes =>
      $$RecommendedRecipesTableTableManager(_db, _db.recommendedRecipes);
  $$CustomRecipesTableTableManager get customRecipes =>
      $$CustomRecipesTableTableManager(_db, _db.customRecipes);
  $$LocalizedFarmersV2TableTableManager get localizedFarmersV2 =>
      $$LocalizedFarmersV2TableTableManager(_db, _db.localizedFarmersV2);
  $$LocalizedFarmerTranslationsV2TableTableManager
  get localizedFarmerTranslationsV2 =>
      $$LocalizedFarmerTranslationsV2TableTableManager(
        _db,
        _db.localizedFarmerTranslationsV2,
      );
  $$SpecialtyArticlesV2TableTableManager get specialtyArticlesV2 =>
      $$SpecialtyArticlesV2TableTableManager(_db, _db.specialtyArticlesV2);
  $$SpecialtyArticleTranslationsV2TableTableManager
  get specialtyArticleTranslationsV2 =>
      $$SpecialtyArticleTranslationsV2TableTableManager(
        _db,
        _db.specialtyArticleTranslationsV2,
      );
  $$LocalizedBeansV2TableTableManager get localizedBeansV2 =>
      $$LocalizedBeansV2TableTableManager(_db, _db.localizedBeansV2);
  $$LocalizedBeanTranslationsV2TableTableManager
  get localizedBeanTranslationsV2 =>
      $$LocalizedBeanTranslationsV2TableTableManager(
        _db,
        _db.localizedBeanTranslationsV2,
      );
  $$BrewingRecipesV2TableTableManager get brewingRecipesV2 =>
      $$BrewingRecipesV2TableTableManager(_db, _db.brewingRecipesV2);
  $$BrewingRecipeTranslationsV2TableTableManager
  get brewingRecipeTranslationsV2 =>
      $$BrewingRecipeTranslationsV2TableTableManager(
        _db,
        _db.brewingRecipeTranslationsV2,
      );
}
