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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    logoUrl,
    siteUrl,
    createdAt,
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
  const LocalizedBrand({
    required this.id,
    this.userId,
    required this.name,
    this.logoUrl,
    this.siteUrl,
    this.createdAt,
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
    };
  }

  LocalizedBrand copyWith({
    int? id,
    Value<String?> userId = const Value.absent(),
    String? name,
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> siteUrl = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
  }) => LocalizedBrand(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    name: name ?? this.name,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    siteUrl: siteUrl.present ? siteUrl.value : this.siteUrl,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  LocalizedBrand copyWithCompanion(LocalizedBrandsCompanion data) {
    return LocalizedBrand(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      siteUrl: data.siteUrl.present ? data.siteUrl.value : this.siteUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
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
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, name, logoUrl, siteUrl, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedBrand &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.logoUrl == this.logoUrl &&
          other.siteUrl == this.siteUrl &&
          other.createdAt == this.createdAt);
}

class LocalizedBrandsCompanion extends UpdateCompanion<LocalizedBrand> {
  final Value<int> id;
  final Value<String?> userId;
  final Value<String> name;
  final Value<String?> logoUrl;
  final Value<String?> siteUrl;
  final Value<DateTime?> createdAt;
  const LocalizedBrandsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocalizedBrandsCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    required String name,
    this.logoUrl = const Value.absent(),
    this.siteUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<LocalizedBrand> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? logoUrl,
    Expression<String>? siteUrl,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (siteUrl != null) 'site_url': siteUrl,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocalizedBrandsCompanion copyWith({
    Value<int>? id,
    Value<String?>? userId,
    Value<String>? name,
    Value<String?>? logoUrl,
    Value<String?>? siteUrl,
    Value<DateTime?>? createdAt,
  }) {
    return LocalizedBrandsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      createdAt: createdAt ?? this.createdAt,
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
          ..write('createdAt: $createdAt')
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
  static const VerificationMeta _nameUkMeta = const VerificationMeta('nameUk');
  @override
  late final GeneratedColumn<String> nameUk = GeneratedColumn<String>(
    'name_uk',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Тут має бути ім\'я'),
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
    defaultValue: const Constant('Тут має бути фото'),
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
    defaultValue: const Constant('Тут має бути прапор'),
  );
  static const VerificationMeta _descriptionHtmlUkMeta = const VerificationMeta(
    'descriptionHtmlUk',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlUk =
      GeneratedColumn<String>(
        'description_html_uk',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('Тут має бути опис'),
      );
  static const VerificationMeta _regionUkMeta = const VerificationMeta(
    'regionUk',
  );
  @override
  late final GeneratedColumn<String> regionUk = GeneratedColumn<String>(
    'region_uk',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryUkMeta = const VerificationMeta(
    'countryUk',
  );
  @override
  late final GeneratedColumn<String> countryUk = GeneratedColumn<String>(
    'country_uk',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlEnMeta = const VerificationMeta(
    'descriptionHtmlEn',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlEn =
      GeneratedColumn<String>(
        'description_html_en',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _regionEnMeta = const VerificationMeta(
    'regionEn',
  );
  @override
  late final GeneratedColumn<String> regionEn = GeneratedColumn<String>(
    'region_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryEnMeta = const VerificationMeta(
    'countryEn',
  );
  @override
  late final GeneratedColumn<String> countryEn = GeneratedColumn<String>(
    'country_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _namePlMeta = const VerificationMeta('namePl');
  @override
  late final GeneratedColumn<String> namePl = GeneratedColumn<String>(
    'name_pl',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlPlMeta = const VerificationMeta(
    'descriptionHtmlPl',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlPl =
      GeneratedColumn<String>(
        'description_html_pl',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameDeMeta = const VerificationMeta('nameDe');
  @override
  late final GeneratedColumn<String> nameDe = GeneratedColumn<String>(
    'name_de',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlDeMeta = const VerificationMeta(
    'descriptionHtmlDe',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlDe =
      GeneratedColumn<String>(
        'description_html_de',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameFrMeta = const VerificationMeta('nameFr');
  @override
  late final GeneratedColumn<String> nameFr = GeneratedColumn<String>(
    'name_fr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlFrMeta = const VerificationMeta(
    'descriptionHtmlFr',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlFr =
      GeneratedColumn<String>(
        'description_html_fr',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlEsMeta = const VerificationMeta(
    'descriptionHtmlEs',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlEs =
      GeneratedColumn<String>(
        'description_html_es',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameItMeta = const VerificationMeta('nameIt');
  @override
  late final GeneratedColumn<String> nameIt = GeneratedColumn<String>(
    'name_it',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlItMeta = const VerificationMeta(
    'descriptionHtmlIt',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlIt =
      GeneratedColumn<String>(
        'description_html_it',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _namePtMeta = const VerificationMeta('namePt');
  @override
  late final GeneratedColumn<String> namePt = GeneratedColumn<String>(
    'name_pt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlPtMeta = const VerificationMeta(
    'descriptionHtmlPt',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlPt =
      GeneratedColumn<String>(
        'description_html_pt',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameRoMeta = const VerificationMeta('nameRo');
  @override
  late final GeneratedColumn<String> nameRo = GeneratedColumn<String>(
    'name_ro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlRoMeta = const VerificationMeta(
    'descriptionHtmlRo',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlRo =
      GeneratedColumn<String>(
        'description_html_ro',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameTrMeta = const VerificationMeta('nameTr');
  @override
  late final GeneratedColumn<String> nameTr = GeneratedColumn<String>(
    'name_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlTrMeta = const VerificationMeta(
    'descriptionHtmlTr',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlTr =
      GeneratedColumn<String>(
        'description_html_tr',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlJaMeta = const VerificationMeta(
    'descriptionHtmlJa',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlJa =
      GeneratedColumn<String>(
        'description_html_ja',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameKoMeta = const VerificationMeta('nameKo');
  @override
  late final GeneratedColumn<String> nameKo = GeneratedColumn<String>(
    'name_ko',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlKoMeta = const VerificationMeta(
    'descriptionHtmlKo',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlKo =
      GeneratedColumn<String>(
        'description_html_ko',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionHtmlZhMeta = const VerificationMeta(
    'descriptionHtmlZh',
  );
  @override
  late final GeneratedColumn<String> descriptionHtmlZh =
      GeneratedColumn<String>(
        'description_html_zh',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
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
    nameUk,
    imageUrl,
    flagUrl,
    descriptionHtmlUk,
    regionUk,
    countryUk,
    nameEn,
    descriptionHtmlEn,
    regionEn,
    countryEn,
    namePl,
    descriptionHtmlPl,
    nameDe,
    descriptionHtmlDe,
    nameFr,
    descriptionHtmlFr,
    nameEs,
    descriptionHtmlEs,
    nameIt,
    descriptionHtmlIt,
    namePt,
    descriptionHtmlPt,
    nameRo,
    descriptionHtmlRo,
    nameTr,
    descriptionHtmlTr,
    nameJa,
    descriptionHtmlJa,
    nameKo,
    descriptionHtmlKo,
    nameZh,
    descriptionHtmlZh,
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
    if (data.containsKey('name_uk')) {
      context.handle(
        _nameUkMeta,
        nameUk.isAcceptableOrUnknown(data['name_uk']!, _nameUkMeta),
      );
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
    if (data.containsKey('description_html_uk')) {
      context.handle(
        _descriptionHtmlUkMeta,
        descriptionHtmlUk.isAcceptableOrUnknown(
          data['description_html_uk']!,
          _descriptionHtmlUkMeta,
        ),
      );
    }
    if (data.containsKey('region_uk')) {
      context.handle(
        _regionUkMeta,
        regionUk.isAcceptableOrUnknown(data['region_uk']!, _regionUkMeta),
      );
    }
    if (data.containsKey('country_uk')) {
      context.handle(
        _countryUkMeta,
        countryUk.isAcceptableOrUnknown(data['country_uk']!, _countryUkMeta),
      );
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('description_html_en')) {
      context.handle(
        _descriptionHtmlEnMeta,
        descriptionHtmlEn.isAcceptableOrUnknown(
          data['description_html_en']!,
          _descriptionHtmlEnMeta,
        ),
      );
    }
    if (data.containsKey('region_en')) {
      context.handle(
        _regionEnMeta,
        regionEn.isAcceptableOrUnknown(data['region_en']!, _regionEnMeta),
      );
    }
    if (data.containsKey('country_en')) {
      context.handle(
        _countryEnMeta,
        countryEn.isAcceptableOrUnknown(data['country_en']!, _countryEnMeta),
      );
    }
    if (data.containsKey('name_pl')) {
      context.handle(
        _namePlMeta,
        namePl.isAcceptableOrUnknown(data['name_pl']!, _namePlMeta),
      );
    }
    if (data.containsKey('description_html_pl')) {
      context.handle(
        _descriptionHtmlPlMeta,
        descriptionHtmlPl.isAcceptableOrUnknown(
          data['description_html_pl']!,
          _descriptionHtmlPlMeta,
        ),
      );
    }
    if (data.containsKey('name_de')) {
      context.handle(
        _nameDeMeta,
        nameDe.isAcceptableOrUnknown(data['name_de']!, _nameDeMeta),
      );
    }
    if (data.containsKey('description_html_de')) {
      context.handle(
        _descriptionHtmlDeMeta,
        descriptionHtmlDe.isAcceptableOrUnknown(
          data['description_html_de']!,
          _descriptionHtmlDeMeta,
        ),
      );
    }
    if (data.containsKey('name_fr')) {
      context.handle(
        _nameFrMeta,
        nameFr.isAcceptableOrUnknown(data['name_fr']!, _nameFrMeta),
      );
    }
    if (data.containsKey('description_html_fr')) {
      context.handle(
        _descriptionHtmlFrMeta,
        descriptionHtmlFr.isAcceptableOrUnknown(
          data['description_html_fr']!,
          _descriptionHtmlFrMeta,
        ),
      );
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    if (data.containsKey('description_html_es')) {
      context.handle(
        _descriptionHtmlEsMeta,
        descriptionHtmlEs.isAcceptableOrUnknown(
          data['description_html_es']!,
          _descriptionHtmlEsMeta,
        ),
      );
    }
    if (data.containsKey('name_it')) {
      context.handle(
        _nameItMeta,
        nameIt.isAcceptableOrUnknown(data['name_it']!, _nameItMeta),
      );
    }
    if (data.containsKey('description_html_it')) {
      context.handle(
        _descriptionHtmlItMeta,
        descriptionHtmlIt.isAcceptableOrUnknown(
          data['description_html_it']!,
          _descriptionHtmlItMeta,
        ),
      );
    }
    if (data.containsKey('name_pt')) {
      context.handle(
        _namePtMeta,
        namePt.isAcceptableOrUnknown(data['name_pt']!, _namePtMeta),
      );
    }
    if (data.containsKey('description_html_pt')) {
      context.handle(
        _descriptionHtmlPtMeta,
        descriptionHtmlPt.isAcceptableOrUnknown(
          data['description_html_pt']!,
          _descriptionHtmlPtMeta,
        ),
      );
    }
    if (data.containsKey('name_ro')) {
      context.handle(
        _nameRoMeta,
        nameRo.isAcceptableOrUnknown(data['name_ro']!, _nameRoMeta),
      );
    }
    if (data.containsKey('description_html_ro')) {
      context.handle(
        _descriptionHtmlRoMeta,
        descriptionHtmlRo.isAcceptableOrUnknown(
          data['description_html_ro']!,
          _descriptionHtmlRoMeta,
        ),
      );
    }
    if (data.containsKey('name_tr')) {
      context.handle(
        _nameTrMeta,
        nameTr.isAcceptableOrUnknown(data['name_tr']!, _nameTrMeta),
      );
    }
    if (data.containsKey('description_html_tr')) {
      context.handle(
        _descriptionHtmlTrMeta,
        descriptionHtmlTr.isAcceptableOrUnknown(
          data['description_html_tr']!,
          _descriptionHtmlTrMeta,
        ),
      );
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    }
    if (data.containsKey('description_html_ja')) {
      context.handle(
        _descriptionHtmlJaMeta,
        descriptionHtmlJa.isAcceptableOrUnknown(
          data['description_html_ja']!,
          _descriptionHtmlJaMeta,
        ),
      );
    }
    if (data.containsKey('name_ko')) {
      context.handle(
        _nameKoMeta,
        nameKo.isAcceptableOrUnknown(data['name_ko']!, _nameKoMeta),
      );
    }
    if (data.containsKey('description_html_ko')) {
      context.handle(
        _descriptionHtmlKoMeta,
        descriptionHtmlKo.isAcceptableOrUnknown(
          data['description_html_ko']!,
          _descriptionHtmlKoMeta,
        ),
      );
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    if (data.containsKey('description_html_zh')) {
      context.handle(
        _descriptionHtmlZhMeta,
        descriptionHtmlZh.isAcceptableOrUnknown(
          data['description_html_zh']!,
          _descriptionHtmlZhMeta,
        ),
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
      nameUk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_uk'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      flagUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flag_url'],
      )!,
      descriptionHtmlUk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_uk'],
      )!,
      regionUk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region_uk'],
      ),
      countryUk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_uk'],
      ),
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      descriptionHtmlEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_en'],
      ),
      regionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region_en'],
      ),
      countryEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_en'],
      ),
      namePl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_pl'],
      ),
      descriptionHtmlPl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_pl'],
      ),
      nameDe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_de'],
      ),
      descriptionHtmlDe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_de'],
      ),
      nameFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_fr'],
      ),
      descriptionHtmlFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_fr'],
      ),
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      descriptionHtmlEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_es'],
      ),
      nameIt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_it'],
      ),
      descriptionHtmlIt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_it'],
      ),
      namePt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_pt'],
      ),
      descriptionHtmlPt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_pt'],
      ),
      nameRo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ro'],
      ),
      descriptionHtmlRo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_ro'],
      ),
      nameTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_tr'],
      ),
      descriptionHtmlTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_tr'],
      ),
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      ),
      descriptionHtmlJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_ja'],
      ),
      nameKo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ko'],
      ),
      descriptionHtmlKo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_ko'],
      ),
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
      descriptionHtmlZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_html_zh'],
      ),
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
  final String nameUk;
  final String imageUrl;
  final String flagUrl;
  final String descriptionHtmlUk;
  final String? regionUk;
  final String? countryUk;
  final String? nameEn;
  final String? descriptionHtmlEn;
  final String? regionEn;
  final String? countryEn;
  final String? namePl;
  final String? descriptionHtmlPl;
  final String? nameDe;
  final String? descriptionHtmlDe;
  final String? nameFr;
  final String? descriptionHtmlFr;
  final String? nameEs;
  final String? descriptionHtmlEs;
  final String? nameIt;
  final String? descriptionHtmlIt;
  final String? namePt;
  final String? descriptionHtmlPt;
  final String? nameRo;
  final String? descriptionHtmlRo;
  final String? nameTr;
  final String? descriptionHtmlTr;
  final String? nameJa;
  final String? descriptionHtmlJa;
  final String? nameKo;
  final String? descriptionHtmlKo;
  final String? nameZh;
  final String? descriptionHtmlZh;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  const LocalizedFarmer({
    required this.id,
    required this.nameUk,
    required this.imageUrl,
    required this.flagUrl,
    required this.descriptionHtmlUk,
    this.regionUk,
    this.countryUk,
    this.nameEn,
    this.descriptionHtmlEn,
    this.regionEn,
    this.countryEn,
    this.namePl,
    this.descriptionHtmlPl,
    this.nameDe,
    this.descriptionHtmlDe,
    this.nameFr,
    this.descriptionHtmlFr,
    this.nameEs,
    this.descriptionHtmlEs,
    this.nameIt,
    this.descriptionHtmlIt,
    this.namePt,
    this.descriptionHtmlPt,
    this.nameRo,
    this.descriptionHtmlRo,
    this.nameTr,
    this.descriptionHtmlTr,
    this.nameJa,
    this.descriptionHtmlJa,
    this.nameKo,
    this.descriptionHtmlKo,
    this.nameZh,
    this.descriptionHtmlZh,
    this.latitude,
    this.longitude,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_uk'] = Variable<String>(nameUk);
    map['image_url'] = Variable<String>(imageUrl);
    map['flag_url'] = Variable<String>(flagUrl);
    map['description_html_uk'] = Variable<String>(descriptionHtmlUk);
    if (!nullToAbsent || regionUk != null) {
      map['region_uk'] = Variable<String>(regionUk);
    }
    if (!nullToAbsent || countryUk != null) {
      map['country_uk'] = Variable<String>(countryUk);
    }
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || descriptionHtmlEn != null) {
      map['description_html_en'] = Variable<String>(descriptionHtmlEn);
    }
    if (!nullToAbsent || regionEn != null) {
      map['region_en'] = Variable<String>(regionEn);
    }
    if (!nullToAbsent || countryEn != null) {
      map['country_en'] = Variable<String>(countryEn);
    }
    if (!nullToAbsent || namePl != null) {
      map['name_pl'] = Variable<String>(namePl);
    }
    if (!nullToAbsent || descriptionHtmlPl != null) {
      map['description_html_pl'] = Variable<String>(descriptionHtmlPl);
    }
    if (!nullToAbsent || nameDe != null) {
      map['name_de'] = Variable<String>(nameDe);
    }
    if (!nullToAbsent || descriptionHtmlDe != null) {
      map['description_html_de'] = Variable<String>(descriptionHtmlDe);
    }
    if (!nullToAbsent || nameFr != null) {
      map['name_fr'] = Variable<String>(nameFr);
    }
    if (!nullToAbsent || descriptionHtmlFr != null) {
      map['description_html_fr'] = Variable<String>(descriptionHtmlFr);
    }
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    if (!nullToAbsent || descriptionHtmlEs != null) {
      map['description_html_es'] = Variable<String>(descriptionHtmlEs);
    }
    if (!nullToAbsent || nameIt != null) {
      map['name_it'] = Variable<String>(nameIt);
    }
    if (!nullToAbsent || descriptionHtmlIt != null) {
      map['description_html_it'] = Variable<String>(descriptionHtmlIt);
    }
    if (!nullToAbsent || namePt != null) {
      map['name_pt'] = Variable<String>(namePt);
    }
    if (!nullToAbsent || descriptionHtmlPt != null) {
      map['description_html_pt'] = Variable<String>(descriptionHtmlPt);
    }
    if (!nullToAbsent || nameRo != null) {
      map['name_ro'] = Variable<String>(nameRo);
    }
    if (!nullToAbsent || descriptionHtmlRo != null) {
      map['description_html_ro'] = Variable<String>(descriptionHtmlRo);
    }
    if (!nullToAbsent || nameTr != null) {
      map['name_tr'] = Variable<String>(nameTr);
    }
    if (!nullToAbsent || descriptionHtmlTr != null) {
      map['description_html_tr'] = Variable<String>(descriptionHtmlTr);
    }
    if (!nullToAbsent || nameJa != null) {
      map['name_ja'] = Variable<String>(nameJa);
    }
    if (!nullToAbsent || descriptionHtmlJa != null) {
      map['description_html_ja'] = Variable<String>(descriptionHtmlJa);
    }
    if (!nullToAbsent || nameKo != null) {
      map['name_ko'] = Variable<String>(nameKo);
    }
    if (!nullToAbsent || descriptionHtmlKo != null) {
      map['description_html_ko'] = Variable<String>(descriptionHtmlKo);
    }
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    if (!nullToAbsent || descriptionHtmlZh != null) {
      map['description_html_zh'] = Variable<String>(descriptionHtmlZh);
    }
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
      nameUk: Value(nameUk),
      imageUrl: Value(imageUrl),
      flagUrl: Value(flagUrl),
      descriptionHtmlUk: Value(descriptionHtmlUk),
      regionUk: regionUk == null && nullToAbsent
          ? const Value.absent()
          : Value(regionUk),
      countryUk: countryUk == null && nullToAbsent
          ? const Value.absent()
          : Value(countryUk),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      descriptionHtmlEn: descriptionHtmlEn == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlEn),
      regionEn: regionEn == null && nullToAbsent
          ? const Value.absent()
          : Value(regionEn),
      countryEn: countryEn == null && nullToAbsent
          ? const Value.absent()
          : Value(countryEn),
      namePl: namePl == null && nullToAbsent
          ? const Value.absent()
          : Value(namePl),
      descriptionHtmlPl: descriptionHtmlPl == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlPl),
      nameDe: nameDe == null && nullToAbsent
          ? const Value.absent()
          : Value(nameDe),
      descriptionHtmlDe: descriptionHtmlDe == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlDe),
      nameFr: nameFr == null && nullToAbsent
          ? const Value.absent()
          : Value(nameFr),
      descriptionHtmlFr: descriptionHtmlFr == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlFr),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      descriptionHtmlEs: descriptionHtmlEs == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlEs),
      nameIt: nameIt == null && nullToAbsent
          ? const Value.absent()
          : Value(nameIt),
      descriptionHtmlIt: descriptionHtmlIt == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlIt),
      namePt: namePt == null && nullToAbsent
          ? const Value.absent()
          : Value(namePt),
      descriptionHtmlPt: descriptionHtmlPt == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlPt),
      nameRo: nameRo == null && nullToAbsent
          ? const Value.absent()
          : Value(nameRo),
      descriptionHtmlRo: descriptionHtmlRo == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlRo),
      nameTr: nameTr == null && nullToAbsent
          ? const Value.absent()
          : Value(nameTr),
      descriptionHtmlTr: descriptionHtmlTr == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlTr),
      nameJa: nameJa == null && nullToAbsent
          ? const Value.absent()
          : Value(nameJa),
      descriptionHtmlJa: descriptionHtmlJa == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlJa),
      nameKo: nameKo == null && nullToAbsent
          ? const Value.absent()
          : Value(nameKo),
      descriptionHtmlKo: descriptionHtmlKo == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlKo),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
      descriptionHtmlZh: descriptionHtmlZh == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionHtmlZh),
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
      nameUk: serializer.fromJson<String>(json['nameUk']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      flagUrl: serializer.fromJson<String>(json['flagUrl']),
      descriptionHtmlUk: serializer.fromJson<String>(json['descriptionHtmlUk']),
      regionUk: serializer.fromJson<String?>(json['regionUk']),
      countryUk: serializer.fromJson<String?>(json['countryUk']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      descriptionHtmlEn: serializer.fromJson<String?>(
        json['descriptionHtmlEn'],
      ),
      regionEn: serializer.fromJson<String?>(json['regionEn']),
      countryEn: serializer.fromJson<String?>(json['countryEn']),
      namePl: serializer.fromJson<String?>(json['namePl']),
      descriptionHtmlPl: serializer.fromJson<String?>(
        json['descriptionHtmlPl'],
      ),
      nameDe: serializer.fromJson<String?>(json['nameDe']),
      descriptionHtmlDe: serializer.fromJson<String?>(
        json['descriptionHtmlDe'],
      ),
      nameFr: serializer.fromJson<String?>(json['nameFr']),
      descriptionHtmlFr: serializer.fromJson<String?>(
        json['descriptionHtmlFr'],
      ),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      descriptionHtmlEs: serializer.fromJson<String?>(
        json['descriptionHtmlEs'],
      ),
      nameIt: serializer.fromJson<String?>(json['nameIt']),
      descriptionHtmlIt: serializer.fromJson<String?>(
        json['descriptionHtmlIt'],
      ),
      namePt: serializer.fromJson<String?>(json['namePt']),
      descriptionHtmlPt: serializer.fromJson<String?>(
        json['descriptionHtmlPt'],
      ),
      nameRo: serializer.fromJson<String?>(json['nameRo']),
      descriptionHtmlRo: serializer.fromJson<String?>(
        json['descriptionHtmlRo'],
      ),
      nameTr: serializer.fromJson<String?>(json['nameTr']),
      descriptionHtmlTr: serializer.fromJson<String?>(
        json['descriptionHtmlTr'],
      ),
      nameJa: serializer.fromJson<String?>(json['nameJa']),
      descriptionHtmlJa: serializer.fromJson<String?>(
        json['descriptionHtmlJa'],
      ),
      nameKo: serializer.fromJson<String?>(json['nameKo']),
      descriptionHtmlKo: serializer.fromJson<String?>(
        json['descriptionHtmlKo'],
      ),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
      descriptionHtmlZh: serializer.fromJson<String?>(
        json['descriptionHtmlZh'],
      ),
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
      'nameUk': serializer.toJson<String>(nameUk),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'flagUrl': serializer.toJson<String>(flagUrl),
      'descriptionHtmlUk': serializer.toJson<String>(descriptionHtmlUk),
      'regionUk': serializer.toJson<String?>(regionUk),
      'countryUk': serializer.toJson<String?>(countryUk),
      'nameEn': serializer.toJson<String?>(nameEn),
      'descriptionHtmlEn': serializer.toJson<String?>(descriptionHtmlEn),
      'regionEn': serializer.toJson<String?>(regionEn),
      'countryEn': serializer.toJson<String?>(countryEn),
      'namePl': serializer.toJson<String?>(namePl),
      'descriptionHtmlPl': serializer.toJson<String?>(descriptionHtmlPl),
      'nameDe': serializer.toJson<String?>(nameDe),
      'descriptionHtmlDe': serializer.toJson<String?>(descriptionHtmlDe),
      'nameFr': serializer.toJson<String?>(nameFr),
      'descriptionHtmlFr': serializer.toJson<String?>(descriptionHtmlFr),
      'nameEs': serializer.toJson<String?>(nameEs),
      'descriptionHtmlEs': serializer.toJson<String?>(descriptionHtmlEs),
      'nameIt': serializer.toJson<String?>(nameIt),
      'descriptionHtmlIt': serializer.toJson<String?>(descriptionHtmlIt),
      'namePt': serializer.toJson<String?>(namePt),
      'descriptionHtmlPt': serializer.toJson<String?>(descriptionHtmlPt),
      'nameRo': serializer.toJson<String?>(nameRo),
      'descriptionHtmlRo': serializer.toJson<String?>(descriptionHtmlRo),
      'nameTr': serializer.toJson<String?>(nameTr),
      'descriptionHtmlTr': serializer.toJson<String?>(descriptionHtmlTr),
      'nameJa': serializer.toJson<String?>(nameJa),
      'descriptionHtmlJa': serializer.toJson<String?>(descriptionHtmlJa),
      'nameKo': serializer.toJson<String?>(nameKo),
      'descriptionHtmlKo': serializer.toJson<String?>(descriptionHtmlKo),
      'nameZh': serializer.toJson<String?>(nameZh),
      'descriptionHtmlZh': serializer.toJson<String?>(descriptionHtmlZh),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  LocalizedFarmer copyWith({
    int? id,
    String? nameUk,
    String? imageUrl,
    String? flagUrl,
    String? descriptionHtmlUk,
    Value<String?> regionUk = const Value.absent(),
    Value<String?> countryUk = const Value.absent(),
    Value<String?> nameEn = const Value.absent(),
    Value<String?> descriptionHtmlEn = const Value.absent(),
    Value<String?> regionEn = const Value.absent(),
    Value<String?> countryEn = const Value.absent(),
    Value<String?> namePl = const Value.absent(),
    Value<String?> descriptionHtmlPl = const Value.absent(),
    Value<String?> nameDe = const Value.absent(),
    Value<String?> descriptionHtmlDe = const Value.absent(),
    Value<String?> nameFr = const Value.absent(),
    Value<String?> descriptionHtmlFr = const Value.absent(),
    Value<String?> nameEs = const Value.absent(),
    Value<String?> descriptionHtmlEs = const Value.absent(),
    Value<String?> nameIt = const Value.absent(),
    Value<String?> descriptionHtmlIt = const Value.absent(),
    Value<String?> namePt = const Value.absent(),
    Value<String?> descriptionHtmlPt = const Value.absent(),
    Value<String?> nameRo = const Value.absent(),
    Value<String?> descriptionHtmlRo = const Value.absent(),
    Value<String?> nameTr = const Value.absent(),
    Value<String?> descriptionHtmlTr = const Value.absent(),
    Value<String?> nameJa = const Value.absent(),
    Value<String?> descriptionHtmlJa = const Value.absent(),
    Value<String?> nameKo = const Value.absent(),
    Value<String?> descriptionHtmlKo = const Value.absent(),
    Value<String?> nameZh = const Value.absent(),
    Value<String?> descriptionHtmlZh = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
  }) => LocalizedFarmer(
    id: id ?? this.id,
    nameUk: nameUk ?? this.nameUk,
    imageUrl: imageUrl ?? this.imageUrl,
    flagUrl: flagUrl ?? this.flagUrl,
    descriptionHtmlUk: descriptionHtmlUk ?? this.descriptionHtmlUk,
    regionUk: regionUk.present ? regionUk.value : this.regionUk,
    countryUk: countryUk.present ? countryUk.value : this.countryUk,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    descriptionHtmlEn: descriptionHtmlEn.present
        ? descriptionHtmlEn.value
        : this.descriptionHtmlEn,
    regionEn: regionEn.present ? regionEn.value : this.regionEn,
    countryEn: countryEn.present ? countryEn.value : this.countryEn,
    namePl: namePl.present ? namePl.value : this.namePl,
    descriptionHtmlPl: descriptionHtmlPl.present
        ? descriptionHtmlPl.value
        : this.descriptionHtmlPl,
    nameDe: nameDe.present ? nameDe.value : this.nameDe,
    descriptionHtmlDe: descriptionHtmlDe.present
        ? descriptionHtmlDe.value
        : this.descriptionHtmlDe,
    nameFr: nameFr.present ? nameFr.value : this.nameFr,
    descriptionHtmlFr: descriptionHtmlFr.present
        ? descriptionHtmlFr.value
        : this.descriptionHtmlFr,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    descriptionHtmlEs: descriptionHtmlEs.present
        ? descriptionHtmlEs.value
        : this.descriptionHtmlEs,
    nameIt: nameIt.present ? nameIt.value : this.nameIt,
    descriptionHtmlIt: descriptionHtmlIt.present
        ? descriptionHtmlIt.value
        : this.descriptionHtmlIt,
    namePt: namePt.present ? namePt.value : this.namePt,
    descriptionHtmlPt: descriptionHtmlPt.present
        ? descriptionHtmlPt.value
        : this.descriptionHtmlPt,
    nameRo: nameRo.present ? nameRo.value : this.nameRo,
    descriptionHtmlRo: descriptionHtmlRo.present
        ? descriptionHtmlRo.value
        : this.descriptionHtmlRo,
    nameTr: nameTr.present ? nameTr.value : this.nameTr,
    descriptionHtmlTr: descriptionHtmlTr.present
        ? descriptionHtmlTr.value
        : this.descriptionHtmlTr,
    nameJa: nameJa.present ? nameJa.value : this.nameJa,
    descriptionHtmlJa: descriptionHtmlJa.present
        ? descriptionHtmlJa.value
        : this.descriptionHtmlJa,
    nameKo: nameKo.present ? nameKo.value : this.nameKo,
    descriptionHtmlKo: descriptionHtmlKo.present
        ? descriptionHtmlKo.value
        : this.descriptionHtmlKo,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
    descriptionHtmlZh: descriptionHtmlZh.present
        ? descriptionHtmlZh.value
        : this.descriptionHtmlZh,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  LocalizedFarmer copyWithCompanion(LocalizedFarmersCompanion data) {
    return LocalizedFarmer(
      id: data.id.present ? data.id.value : this.id,
      nameUk: data.nameUk.present ? data.nameUk.value : this.nameUk,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      flagUrl: data.flagUrl.present ? data.flagUrl.value : this.flagUrl,
      descriptionHtmlUk: data.descriptionHtmlUk.present
          ? data.descriptionHtmlUk.value
          : this.descriptionHtmlUk,
      regionUk: data.regionUk.present ? data.regionUk.value : this.regionUk,
      countryUk: data.countryUk.present ? data.countryUk.value : this.countryUk,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      descriptionHtmlEn: data.descriptionHtmlEn.present
          ? data.descriptionHtmlEn.value
          : this.descriptionHtmlEn,
      regionEn: data.regionEn.present ? data.regionEn.value : this.regionEn,
      countryEn: data.countryEn.present ? data.countryEn.value : this.countryEn,
      namePl: data.namePl.present ? data.namePl.value : this.namePl,
      descriptionHtmlPl: data.descriptionHtmlPl.present
          ? data.descriptionHtmlPl.value
          : this.descriptionHtmlPl,
      nameDe: data.nameDe.present ? data.nameDe.value : this.nameDe,
      descriptionHtmlDe: data.descriptionHtmlDe.present
          ? data.descriptionHtmlDe.value
          : this.descriptionHtmlDe,
      nameFr: data.nameFr.present ? data.nameFr.value : this.nameFr,
      descriptionHtmlFr: data.descriptionHtmlFr.present
          ? data.descriptionHtmlFr.value
          : this.descriptionHtmlFr,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      descriptionHtmlEs: data.descriptionHtmlEs.present
          ? data.descriptionHtmlEs.value
          : this.descriptionHtmlEs,
      nameIt: data.nameIt.present ? data.nameIt.value : this.nameIt,
      descriptionHtmlIt: data.descriptionHtmlIt.present
          ? data.descriptionHtmlIt.value
          : this.descriptionHtmlIt,
      namePt: data.namePt.present ? data.namePt.value : this.namePt,
      descriptionHtmlPt: data.descriptionHtmlPt.present
          ? data.descriptionHtmlPt.value
          : this.descriptionHtmlPt,
      nameRo: data.nameRo.present ? data.nameRo.value : this.nameRo,
      descriptionHtmlRo: data.descriptionHtmlRo.present
          ? data.descriptionHtmlRo.value
          : this.descriptionHtmlRo,
      nameTr: data.nameTr.present ? data.nameTr.value : this.nameTr,
      descriptionHtmlTr: data.descriptionHtmlTr.present
          ? data.descriptionHtmlTr.value
          : this.descriptionHtmlTr,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      descriptionHtmlJa: data.descriptionHtmlJa.present
          ? data.descriptionHtmlJa.value
          : this.descriptionHtmlJa,
      nameKo: data.nameKo.present ? data.nameKo.value : this.nameKo,
      descriptionHtmlKo: data.descriptionHtmlKo.present
          ? data.descriptionHtmlKo.value
          : this.descriptionHtmlKo,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
      descriptionHtmlZh: data.descriptionHtmlZh.present
          ? data.descriptionHtmlZh.value
          : this.descriptionHtmlZh,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizedFarmer(')
          ..write('id: $id, ')
          ..write('nameUk: $nameUk, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('descriptionHtmlUk: $descriptionHtmlUk, ')
          ..write('regionUk: $regionUk, ')
          ..write('countryUk: $countryUk, ')
          ..write('nameEn: $nameEn, ')
          ..write('descriptionHtmlEn: $descriptionHtmlEn, ')
          ..write('regionEn: $regionEn, ')
          ..write('countryEn: $countryEn, ')
          ..write('namePl: $namePl, ')
          ..write('descriptionHtmlPl: $descriptionHtmlPl, ')
          ..write('nameDe: $nameDe, ')
          ..write('descriptionHtmlDe: $descriptionHtmlDe, ')
          ..write('nameFr: $nameFr, ')
          ..write('descriptionHtmlFr: $descriptionHtmlFr, ')
          ..write('nameEs: $nameEs, ')
          ..write('descriptionHtmlEs: $descriptionHtmlEs, ')
          ..write('nameIt: $nameIt, ')
          ..write('descriptionHtmlIt: $descriptionHtmlIt, ')
          ..write('namePt: $namePt, ')
          ..write('descriptionHtmlPt: $descriptionHtmlPt, ')
          ..write('nameRo: $nameRo, ')
          ..write('descriptionHtmlRo: $descriptionHtmlRo, ')
          ..write('nameTr: $nameTr, ')
          ..write('descriptionHtmlTr: $descriptionHtmlTr, ')
          ..write('nameJa: $nameJa, ')
          ..write('descriptionHtmlJa: $descriptionHtmlJa, ')
          ..write('nameKo: $nameKo, ')
          ..write('descriptionHtmlKo: $descriptionHtmlKo, ')
          ..write('nameZh: $nameZh, ')
          ..write('descriptionHtmlZh: $descriptionHtmlZh, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    nameUk,
    imageUrl,
    flagUrl,
    descriptionHtmlUk,
    regionUk,
    countryUk,
    nameEn,
    descriptionHtmlEn,
    regionEn,
    countryEn,
    namePl,
    descriptionHtmlPl,
    nameDe,
    descriptionHtmlDe,
    nameFr,
    descriptionHtmlFr,
    nameEs,
    descriptionHtmlEs,
    nameIt,
    descriptionHtmlIt,
    namePt,
    descriptionHtmlPt,
    nameRo,
    descriptionHtmlRo,
    nameTr,
    descriptionHtmlTr,
    nameJa,
    descriptionHtmlJa,
    nameKo,
    descriptionHtmlKo,
    nameZh,
    descriptionHtmlZh,
    latitude,
    longitude,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizedFarmer &&
          other.id == this.id &&
          other.nameUk == this.nameUk &&
          other.imageUrl == this.imageUrl &&
          other.flagUrl == this.flagUrl &&
          other.descriptionHtmlUk == this.descriptionHtmlUk &&
          other.regionUk == this.regionUk &&
          other.countryUk == this.countryUk &&
          other.nameEn == this.nameEn &&
          other.descriptionHtmlEn == this.descriptionHtmlEn &&
          other.regionEn == this.regionEn &&
          other.countryEn == this.countryEn &&
          other.namePl == this.namePl &&
          other.descriptionHtmlPl == this.descriptionHtmlPl &&
          other.nameDe == this.nameDe &&
          other.descriptionHtmlDe == this.descriptionHtmlDe &&
          other.nameFr == this.nameFr &&
          other.descriptionHtmlFr == this.descriptionHtmlFr &&
          other.nameEs == this.nameEs &&
          other.descriptionHtmlEs == this.descriptionHtmlEs &&
          other.nameIt == this.nameIt &&
          other.descriptionHtmlIt == this.descriptionHtmlIt &&
          other.namePt == this.namePt &&
          other.descriptionHtmlPt == this.descriptionHtmlPt &&
          other.nameRo == this.nameRo &&
          other.descriptionHtmlRo == this.descriptionHtmlRo &&
          other.nameTr == this.nameTr &&
          other.descriptionHtmlTr == this.descriptionHtmlTr &&
          other.nameJa == this.nameJa &&
          other.descriptionHtmlJa == this.descriptionHtmlJa &&
          other.nameKo == this.nameKo &&
          other.descriptionHtmlKo == this.descriptionHtmlKo &&
          other.nameZh == this.nameZh &&
          other.descriptionHtmlZh == this.descriptionHtmlZh &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.createdAt == this.createdAt);
}

class LocalizedFarmersCompanion extends UpdateCompanion<LocalizedFarmer> {
  final Value<int> id;
  final Value<String> nameUk;
  final Value<String> imageUrl;
  final Value<String> flagUrl;
  final Value<String> descriptionHtmlUk;
  final Value<String?> regionUk;
  final Value<String?> countryUk;
  final Value<String?> nameEn;
  final Value<String?> descriptionHtmlEn;
  final Value<String?> regionEn;
  final Value<String?> countryEn;
  final Value<String?> namePl;
  final Value<String?> descriptionHtmlPl;
  final Value<String?> nameDe;
  final Value<String?> descriptionHtmlDe;
  final Value<String?> nameFr;
  final Value<String?> descriptionHtmlFr;
  final Value<String?> nameEs;
  final Value<String?> descriptionHtmlEs;
  final Value<String?> nameIt;
  final Value<String?> descriptionHtmlIt;
  final Value<String?> namePt;
  final Value<String?> descriptionHtmlPt;
  final Value<String?> nameRo;
  final Value<String?> descriptionHtmlRo;
  final Value<String?> nameTr;
  final Value<String?> descriptionHtmlTr;
  final Value<String?> nameJa;
  final Value<String?> descriptionHtmlJa;
  final Value<String?> nameKo;
  final Value<String?> descriptionHtmlKo;
  final Value<String?> nameZh;
  final Value<String?> descriptionHtmlZh;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime?> createdAt;
  const LocalizedFarmersCompanion({
    this.id = const Value.absent(),
    this.nameUk = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.descriptionHtmlUk = const Value.absent(),
    this.regionUk = const Value.absent(),
    this.countryUk = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.descriptionHtmlEn = const Value.absent(),
    this.regionEn = const Value.absent(),
    this.countryEn = const Value.absent(),
    this.namePl = const Value.absent(),
    this.descriptionHtmlPl = const Value.absent(),
    this.nameDe = const Value.absent(),
    this.descriptionHtmlDe = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.descriptionHtmlFr = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.descriptionHtmlEs = const Value.absent(),
    this.nameIt = const Value.absent(),
    this.descriptionHtmlIt = const Value.absent(),
    this.namePt = const Value.absent(),
    this.descriptionHtmlPt = const Value.absent(),
    this.nameRo = const Value.absent(),
    this.descriptionHtmlRo = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.descriptionHtmlTr = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.descriptionHtmlJa = const Value.absent(),
    this.nameKo = const Value.absent(),
    this.descriptionHtmlKo = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.descriptionHtmlZh = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocalizedFarmersCompanion.insert({
    this.id = const Value.absent(),
    this.nameUk = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.descriptionHtmlUk = const Value.absent(),
    this.regionUk = const Value.absent(),
    this.countryUk = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.descriptionHtmlEn = const Value.absent(),
    this.regionEn = const Value.absent(),
    this.countryEn = const Value.absent(),
    this.namePl = const Value.absent(),
    this.descriptionHtmlPl = const Value.absent(),
    this.nameDe = const Value.absent(),
    this.descriptionHtmlDe = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.descriptionHtmlFr = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.descriptionHtmlEs = const Value.absent(),
    this.nameIt = const Value.absent(),
    this.descriptionHtmlIt = const Value.absent(),
    this.namePt = const Value.absent(),
    this.descriptionHtmlPt = const Value.absent(),
    this.nameRo = const Value.absent(),
    this.descriptionHtmlRo = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.descriptionHtmlTr = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.descriptionHtmlJa = const Value.absent(),
    this.nameKo = const Value.absent(),
    this.descriptionHtmlKo = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.descriptionHtmlZh = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<LocalizedFarmer> custom({
    Expression<int>? id,
    Expression<String>? nameUk,
    Expression<String>? imageUrl,
    Expression<String>? flagUrl,
    Expression<String>? descriptionHtmlUk,
    Expression<String>? regionUk,
    Expression<String>? countryUk,
    Expression<String>? nameEn,
    Expression<String>? descriptionHtmlEn,
    Expression<String>? regionEn,
    Expression<String>? countryEn,
    Expression<String>? namePl,
    Expression<String>? descriptionHtmlPl,
    Expression<String>? nameDe,
    Expression<String>? descriptionHtmlDe,
    Expression<String>? nameFr,
    Expression<String>? descriptionHtmlFr,
    Expression<String>? nameEs,
    Expression<String>? descriptionHtmlEs,
    Expression<String>? nameIt,
    Expression<String>? descriptionHtmlIt,
    Expression<String>? namePt,
    Expression<String>? descriptionHtmlPt,
    Expression<String>? nameRo,
    Expression<String>? descriptionHtmlRo,
    Expression<String>? nameTr,
    Expression<String>? descriptionHtmlTr,
    Expression<String>? nameJa,
    Expression<String>? descriptionHtmlJa,
    Expression<String>? nameKo,
    Expression<String>? descriptionHtmlKo,
    Expression<String>? nameZh,
    Expression<String>? descriptionHtmlZh,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameUk != null) 'name_uk': nameUk,
      if (imageUrl != null) 'image_url': imageUrl,
      if (flagUrl != null) 'flag_url': flagUrl,
      if (descriptionHtmlUk != null) 'description_html_uk': descriptionHtmlUk,
      if (regionUk != null) 'region_uk': regionUk,
      if (countryUk != null) 'country_uk': countryUk,
      if (nameEn != null) 'name_en': nameEn,
      if (descriptionHtmlEn != null) 'description_html_en': descriptionHtmlEn,
      if (regionEn != null) 'region_en': regionEn,
      if (countryEn != null) 'country_en': countryEn,
      if (namePl != null) 'name_pl': namePl,
      if (descriptionHtmlPl != null) 'description_html_pl': descriptionHtmlPl,
      if (nameDe != null) 'name_de': nameDe,
      if (descriptionHtmlDe != null) 'description_html_de': descriptionHtmlDe,
      if (nameFr != null) 'name_fr': nameFr,
      if (descriptionHtmlFr != null) 'description_html_fr': descriptionHtmlFr,
      if (nameEs != null) 'name_es': nameEs,
      if (descriptionHtmlEs != null) 'description_html_es': descriptionHtmlEs,
      if (nameIt != null) 'name_it': nameIt,
      if (descriptionHtmlIt != null) 'description_html_it': descriptionHtmlIt,
      if (namePt != null) 'name_pt': namePt,
      if (descriptionHtmlPt != null) 'description_html_pt': descriptionHtmlPt,
      if (nameRo != null) 'name_ro': nameRo,
      if (descriptionHtmlRo != null) 'description_html_ro': descriptionHtmlRo,
      if (nameTr != null) 'name_tr': nameTr,
      if (descriptionHtmlTr != null) 'description_html_tr': descriptionHtmlTr,
      if (nameJa != null) 'name_ja': nameJa,
      if (descriptionHtmlJa != null) 'description_html_ja': descriptionHtmlJa,
      if (nameKo != null) 'name_ko': nameKo,
      if (descriptionHtmlKo != null) 'description_html_ko': descriptionHtmlKo,
      if (nameZh != null) 'name_zh': nameZh,
      if (descriptionHtmlZh != null) 'description_html_zh': descriptionHtmlZh,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocalizedFarmersCompanion copyWith({
    Value<int>? id,
    Value<String>? nameUk,
    Value<String>? imageUrl,
    Value<String>? flagUrl,
    Value<String>? descriptionHtmlUk,
    Value<String?>? regionUk,
    Value<String?>? countryUk,
    Value<String?>? nameEn,
    Value<String?>? descriptionHtmlEn,
    Value<String?>? regionEn,
    Value<String?>? countryEn,
    Value<String?>? namePl,
    Value<String?>? descriptionHtmlPl,
    Value<String?>? nameDe,
    Value<String?>? descriptionHtmlDe,
    Value<String?>? nameFr,
    Value<String?>? descriptionHtmlFr,
    Value<String?>? nameEs,
    Value<String?>? descriptionHtmlEs,
    Value<String?>? nameIt,
    Value<String?>? descriptionHtmlIt,
    Value<String?>? namePt,
    Value<String?>? descriptionHtmlPt,
    Value<String?>? nameRo,
    Value<String?>? descriptionHtmlRo,
    Value<String?>? nameTr,
    Value<String?>? descriptionHtmlTr,
    Value<String?>? nameJa,
    Value<String?>? descriptionHtmlJa,
    Value<String?>? nameKo,
    Value<String?>? descriptionHtmlKo,
    Value<String?>? nameZh,
    Value<String?>? descriptionHtmlZh,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime?>? createdAt,
  }) {
    return LocalizedFarmersCompanion(
      id: id ?? this.id,
      nameUk: nameUk ?? this.nameUk,
      imageUrl: imageUrl ?? this.imageUrl,
      flagUrl: flagUrl ?? this.flagUrl,
      descriptionHtmlUk: descriptionHtmlUk ?? this.descriptionHtmlUk,
      regionUk: regionUk ?? this.regionUk,
      countryUk: countryUk ?? this.countryUk,
      nameEn: nameEn ?? this.nameEn,
      descriptionHtmlEn: descriptionHtmlEn ?? this.descriptionHtmlEn,
      regionEn: regionEn ?? this.regionEn,
      countryEn: countryEn ?? this.countryEn,
      namePl: namePl ?? this.namePl,
      descriptionHtmlPl: descriptionHtmlPl ?? this.descriptionHtmlPl,
      nameDe: nameDe ?? this.nameDe,
      descriptionHtmlDe: descriptionHtmlDe ?? this.descriptionHtmlDe,
      nameFr: nameFr ?? this.nameFr,
      descriptionHtmlFr: descriptionHtmlFr ?? this.descriptionHtmlFr,
      nameEs: nameEs ?? this.nameEs,
      descriptionHtmlEs: descriptionHtmlEs ?? this.descriptionHtmlEs,
      nameIt: nameIt ?? this.nameIt,
      descriptionHtmlIt: descriptionHtmlIt ?? this.descriptionHtmlIt,
      namePt: namePt ?? this.namePt,
      descriptionHtmlPt: descriptionHtmlPt ?? this.descriptionHtmlPt,
      nameRo: nameRo ?? this.nameRo,
      descriptionHtmlRo: descriptionHtmlRo ?? this.descriptionHtmlRo,
      nameTr: nameTr ?? this.nameTr,
      descriptionHtmlTr: descriptionHtmlTr ?? this.descriptionHtmlTr,
      nameJa: nameJa ?? this.nameJa,
      descriptionHtmlJa: descriptionHtmlJa ?? this.descriptionHtmlJa,
      nameKo: nameKo ?? this.nameKo,
      descriptionHtmlKo: descriptionHtmlKo ?? this.descriptionHtmlKo,
      nameZh: nameZh ?? this.nameZh,
      descriptionHtmlZh: descriptionHtmlZh ?? this.descriptionHtmlZh,
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
    if (nameUk.present) {
      map['name_uk'] = Variable<String>(nameUk.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (flagUrl.present) {
      map['flag_url'] = Variable<String>(flagUrl.value);
    }
    if (descriptionHtmlUk.present) {
      map['description_html_uk'] = Variable<String>(descriptionHtmlUk.value);
    }
    if (regionUk.present) {
      map['region_uk'] = Variable<String>(regionUk.value);
    }
    if (countryUk.present) {
      map['country_uk'] = Variable<String>(countryUk.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (descriptionHtmlEn.present) {
      map['description_html_en'] = Variable<String>(descriptionHtmlEn.value);
    }
    if (regionEn.present) {
      map['region_en'] = Variable<String>(regionEn.value);
    }
    if (countryEn.present) {
      map['country_en'] = Variable<String>(countryEn.value);
    }
    if (namePl.present) {
      map['name_pl'] = Variable<String>(namePl.value);
    }
    if (descriptionHtmlPl.present) {
      map['description_html_pl'] = Variable<String>(descriptionHtmlPl.value);
    }
    if (nameDe.present) {
      map['name_de'] = Variable<String>(nameDe.value);
    }
    if (descriptionHtmlDe.present) {
      map['description_html_de'] = Variable<String>(descriptionHtmlDe.value);
    }
    if (nameFr.present) {
      map['name_fr'] = Variable<String>(nameFr.value);
    }
    if (descriptionHtmlFr.present) {
      map['description_html_fr'] = Variable<String>(descriptionHtmlFr.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (descriptionHtmlEs.present) {
      map['description_html_es'] = Variable<String>(descriptionHtmlEs.value);
    }
    if (nameIt.present) {
      map['name_it'] = Variable<String>(nameIt.value);
    }
    if (descriptionHtmlIt.present) {
      map['description_html_it'] = Variable<String>(descriptionHtmlIt.value);
    }
    if (namePt.present) {
      map['name_pt'] = Variable<String>(namePt.value);
    }
    if (descriptionHtmlPt.present) {
      map['description_html_pt'] = Variable<String>(descriptionHtmlPt.value);
    }
    if (nameRo.present) {
      map['name_ro'] = Variable<String>(nameRo.value);
    }
    if (descriptionHtmlRo.present) {
      map['description_html_ro'] = Variable<String>(descriptionHtmlRo.value);
    }
    if (nameTr.present) {
      map['name_tr'] = Variable<String>(nameTr.value);
    }
    if (descriptionHtmlTr.present) {
      map['description_html_tr'] = Variable<String>(descriptionHtmlTr.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (descriptionHtmlJa.present) {
      map['description_html_ja'] = Variable<String>(descriptionHtmlJa.value);
    }
    if (nameKo.present) {
      map['name_ko'] = Variable<String>(nameKo.value);
    }
    if (descriptionHtmlKo.present) {
      map['description_html_ko'] = Variable<String>(descriptionHtmlKo.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (descriptionHtmlZh.present) {
      map['description_html_zh'] = Variable<String>(descriptionHtmlZh.value);
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
          ..write('nameUk: $nameUk, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('descriptionHtmlUk: $descriptionHtmlUk, ')
          ..write('regionUk: $regionUk, ')
          ..write('countryUk: $countryUk, ')
          ..write('nameEn: $nameEn, ')
          ..write('descriptionHtmlEn: $descriptionHtmlEn, ')
          ..write('regionEn: $regionEn, ')
          ..write('countryEn: $countryEn, ')
          ..write('namePl: $namePl, ')
          ..write('descriptionHtmlPl: $descriptionHtmlPl, ')
          ..write('nameDe: $nameDe, ')
          ..write('descriptionHtmlDe: $descriptionHtmlDe, ')
          ..write('nameFr: $nameFr, ')
          ..write('descriptionHtmlFr: $descriptionHtmlFr, ')
          ..write('nameEs: $nameEs, ')
          ..write('descriptionHtmlEs: $descriptionHtmlEs, ')
          ..write('nameIt: $nameIt, ')
          ..write('descriptionHtmlIt: $descriptionHtmlIt, ')
          ..write('namePt: $namePt, ')
          ..write('descriptionHtmlPt: $descriptionHtmlPt, ')
          ..write('nameRo: $nameRo, ')
          ..write('descriptionHtmlRo: $descriptionHtmlRo, ')
          ..write('nameTr: $nameTr, ')
          ..write('descriptionHtmlTr: $descriptionHtmlTr, ')
          ..write('nameJa: $nameJa, ')
          ..write('descriptionHtmlJa: $descriptionHtmlJa, ')
          ..write('nameKo: $nameKo, ')
          ..write('descriptionHtmlKo: $descriptionHtmlKo, ')
          ..write('nameZh: $nameZh, ')
          ..write('descriptionHtmlZh: $descriptionHtmlZh, ')
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
  static const VerificationMeta _titleUkMeta = const VerificationMeta(
    'titleUk',
  );
  @override
  late final GeneratedColumn<String> titleUk = GeneratedColumn<String>(
    'title_uk',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Тут має бути заголовок'),
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
    defaultValue: const Constant('Тут має бути лінк на бакет'),
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
    defaultValue: const Constant('Тут має бути лінк на прапор'),
  );
  static const VerificationMeta _contentHtmlUkMeta = const VerificationMeta(
    'contentHtmlUk',
  );
  @override
  late final GeneratedColumn<String> contentHtmlUk = GeneratedColumn<String>(
    'content_html_uk',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Тут має бути текст статті'),
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
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlEnMeta = const VerificationMeta(
    'contentHtmlEn',
  );
  @override
  late final GeneratedColumn<String> contentHtmlEn = GeneratedColumn<String>(
    'content_html_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titlePlMeta = const VerificationMeta(
    'titlePl',
  );
  @override
  late final GeneratedColumn<String> titlePl = GeneratedColumn<String>(
    'title_pl',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlPlMeta = const VerificationMeta(
    'contentHtmlPl',
  );
  @override
  late final GeneratedColumn<String> contentHtmlPl = GeneratedColumn<String>(
    'content_html_pl',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleDeMeta = const VerificationMeta(
    'titleDe',
  );
  @override
  late final GeneratedColumn<String> titleDe = GeneratedColumn<String>(
    'title_de',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlDeMeta = const VerificationMeta(
    'contentHtmlDe',
  );
  @override
  late final GeneratedColumn<String> contentHtmlDe = GeneratedColumn<String>(
    'content_html_de',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleFrMeta = const VerificationMeta(
    'titleFr',
  );
  @override
  late final GeneratedColumn<String> titleFr = GeneratedColumn<String>(
    'title_fr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlFrMeta = const VerificationMeta(
    'contentHtmlFr',
  );
  @override
  late final GeneratedColumn<String> contentHtmlFr = GeneratedColumn<String>(
    'content_html_fr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleEsMeta = const VerificationMeta(
    'titleEs',
  );
  @override
  late final GeneratedColumn<String> titleEs = GeneratedColumn<String>(
    'title_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlEsMeta = const VerificationMeta(
    'contentHtmlEs',
  );
  @override
  late final GeneratedColumn<String> contentHtmlEs = GeneratedColumn<String>(
    'content_html_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleItMeta = const VerificationMeta(
    'titleIt',
  );
  @override
  late final GeneratedColumn<String> titleIt = GeneratedColumn<String>(
    'title_it',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlItMeta = const VerificationMeta(
    'contentHtmlIt',
  );
  @override
  late final GeneratedColumn<String> contentHtmlIt = GeneratedColumn<String>(
    'content_html_it',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titlePtMeta = const VerificationMeta(
    'titlePt',
  );
  @override
  late final GeneratedColumn<String> titlePt = GeneratedColumn<String>(
    'title_pt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlPtMeta = const VerificationMeta(
    'contentHtmlPt',
  );
  @override
  late final GeneratedColumn<String> contentHtmlPt = GeneratedColumn<String>(
    'content_html_pt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleRoMeta = const VerificationMeta(
    'titleRo',
  );
  @override
  late final GeneratedColumn<String> titleRo = GeneratedColumn<String>(
    'title_ro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlRoMeta = const VerificationMeta(
    'contentHtmlRo',
  );
  @override
  late final GeneratedColumn<String> contentHtmlRo = GeneratedColumn<String>(
    'content_html_ro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleTrMeta = const VerificationMeta(
    'titleTr',
  );
  @override
  late final GeneratedColumn<String> titleTr = GeneratedColumn<String>(
    'title_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlTrMeta = const VerificationMeta(
    'contentHtmlTr',
  );
  @override
  late final GeneratedColumn<String> contentHtmlTr = GeneratedColumn<String>(
    'content_html_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleJaMeta = const VerificationMeta(
    'titleJa',
  );
  @override
  late final GeneratedColumn<String> titleJa = GeneratedColumn<String>(
    'title_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlJaMeta = const VerificationMeta(
    'contentHtmlJa',
  );
  @override
  late final GeneratedColumn<String> contentHtmlJa = GeneratedColumn<String>(
    'content_html_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleKoMeta = const VerificationMeta(
    'titleKo',
  );
  @override
  late final GeneratedColumn<String> titleKo = GeneratedColumn<String>(
    'title_ko',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlKoMeta = const VerificationMeta(
    'contentHtmlKo',
  );
  @override
  late final GeneratedColumn<String> contentHtmlKo = GeneratedColumn<String>(
    'content_html_ko',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleZhMeta = const VerificationMeta(
    'titleZh',
  );
  @override
  late final GeneratedColumn<String> titleZh = GeneratedColumn<String>(
    'title_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHtmlZhMeta = const VerificationMeta(
    'contentHtmlZh',
  );
  @override
  late final GeneratedColumn<String> contentHtmlZh = GeneratedColumn<String>(
    'content_html_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titleUk,
    imageUrl,
    flagUrl,
    contentHtmlUk,
    readTimeMin,
    titleEn,
    contentHtmlEn,
    titlePl,
    contentHtmlPl,
    titleDe,
    contentHtmlDe,
    titleFr,
    contentHtmlFr,
    titleEs,
    contentHtmlEs,
    titleIt,
    contentHtmlIt,
    titlePt,
    contentHtmlPt,
    titleRo,
    contentHtmlRo,
    titleTr,
    contentHtmlTr,
    titleJa,
    contentHtmlJa,
    titleKo,
    contentHtmlKo,
    titleZh,
    contentHtmlZh,
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
    if (data.containsKey('title_uk')) {
      context.handle(
        _titleUkMeta,
        titleUk.isAcceptableOrUnknown(data['title_uk']!, _titleUkMeta),
      );
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
    if (data.containsKey('content_html_uk')) {
      context.handle(
        _contentHtmlUkMeta,
        contentHtmlUk.isAcceptableOrUnknown(
          data['content_html_uk']!,
          _contentHtmlUkMeta,
        ),
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
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    }
    if (data.containsKey('content_html_en')) {
      context.handle(
        _contentHtmlEnMeta,
        contentHtmlEn.isAcceptableOrUnknown(
          data['content_html_en']!,
          _contentHtmlEnMeta,
        ),
      );
    }
    if (data.containsKey('title_pl')) {
      context.handle(
        _titlePlMeta,
        titlePl.isAcceptableOrUnknown(data['title_pl']!, _titlePlMeta),
      );
    }
    if (data.containsKey('content_html_pl')) {
      context.handle(
        _contentHtmlPlMeta,
        contentHtmlPl.isAcceptableOrUnknown(
          data['content_html_pl']!,
          _contentHtmlPlMeta,
        ),
      );
    }
    if (data.containsKey('title_de')) {
      context.handle(
        _titleDeMeta,
        titleDe.isAcceptableOrUnknown(data['title_de']!, _titleDeMeta),
      );
    }
    if (data.containsKey('content_html_de')) {
      context.handle(
        _contentHtmlDeMeta,
        contentHtmlDe.isAcceptableOrUnknown(
          data['content_html_de']!,
          _contentHtmlDeMeta,
        ),
      );
    }
    if (data.containsKey('title_fr')) {
      context.handle(
        _titleFrMeta,
        titleFr.isAcceptableOrUnknown(data['title_fr']!, _titleFrMeta),
      );
    }
    if (data.containsKey('content_html_fr')) {
      context.handle(
        _contentHtmlFrMeta,
        contentHtmlFr.isAcceptableOrUnknown(
          data['content_html_fr']!,
          _contentHtmlFrMeta,
        ),
      );
    }
    if (data.containsKey('title_es')) {
      context.handle(
        _titleEsMeta,
        titleEs.isAcceptableOrUnknown(data['title_es']!, _titleEsMeta),
      );
    }
    if (data.containsKey('content_html_es')) {
      context.handle(
        _contentHtmlEsMeta,
        contentHtmlEs.isAcceptableOrUnknown(
          data['content_html_es']!,
          _contentHtmlEsMeta,
        ),
      );
    }
    if (data.containsKey('title_it')) {
      context.handle(
        _titleItMeta,
        titleIt.isAcceptableOrUnknown(data['title_it']!, _titleItMeta),
      );
    }
    if (data.containsKey('content_html_it')) {
      context.handle(
        _contentHtmlItMeta,
        contentHtmlIt.isAcceptableOrUnknown(
          data['content_html_it']!,
          _contentHtmlItMeta,
        ),
      );
    }
    if (data.containsKey('title_pt')) {
      context.handle(
        _titlePtMeta,
        titlePt.isAcceptableOrUnknown(data['title_pt']!, _titlePtMeta),
      );
    }
    if (data.containsKey('content_html_pt')) {
      context.handle(
        _contentHtmlPtMeta,
        contentHtmlPt.isAcceptableOrUnknown(
          data['content_html_pt']!,
          _contentHtmlPtMeta,
        ),
      );
    }
    if (data.containsKey('title_ro')) {
      context.handle(
        _titleRoMeta,
        titleRo.isAcceptableOrUnknown(data['title_ro']!, _titleRoMeta),
      );
    }
    if (data.containsKey('content_html_ro')) {
      context.handle(
        _contentHtmlRoMeta,
        contentHtmlRo.isAcceptableOrUnknown(
          data['content_html_ro']!,
          _contentHtmlRoMeta,
        ),
      );
    }
    if (data.containsKey('title_tr')) {
      context.handle(
        _titleTrMeta,
        titleTr.isAcceptableOrUnknown(data['title_tr']!, _titleTrMeta),
      );
    }
    if (data.containsKey('content_html_tr')) {
      context.handle(
        _contentHtmlTrMeta,
        contentHtmlTr.isAcceptableOrUnknown(
          data['content_html_tr']!,
          _contentHtmlTrMeta,
        ),
      );
    }
    if (data.containsKey('title_ja')) {
      context.handle(
        _titleJaMeta,
        titleJa.isAcceptableOrUnknown(data['title_ja']!, _titleJaMeta),
      );
    }
    if (data.containsKey('content_html_ja')) {
      context.handle(
        _contentHtmlJaMeta,
        contentHtmlJa.isAcceptableOrUnknown(
          data['content_html_ja']!,
          _contentHtmlJaMeta,
        ),
      );
    }
    if (data.containsKey('title_ko')) {
      context.handle(
        _titleKoMeta,
        titleKo.isAcceptableOrUnknown(data['title_ko']!, _titleKoMeta),
      );
    }
    if (data.containsKey('content_html_ko')) {
      context.handle(
        _contentHtmlKoMeta,
        contentHtmlKo.isAcceptableOrUnknown(
          data['content_html_ko']!,
          _contentHtmlKoMeta,
        ),
      );
    }
    if (data.containsKey('title_zh')) {
      context.handle(
        _titleZhMeta,
        titleZh.isAcceptableOrUnknown(data['title_zh']!, _titleZhMeta),
      );
    }
    if (data.containsKey('content_html_zh')) {
      context.handle(
        _contentHtmlZhMeta,
        contentHtmlZh.isAcceptableOrUnknown(
          data['content_html_zh']!,
          _contentHtmlZhMeta,
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
      titleUk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_uk'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      flagUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flag_url'],
      )!,
      contentHtmlUk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_uk'],
      )!,
      readTimeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}read_time_min'],
      )!,
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      ),
      contentHtmlEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_en'],
      ),
      titlePl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_pl'],
      ),
      contentHtmlPl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_pl'],
      ),
      titleDe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_de'],
      ),
      contentHtmlDe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_de'],
      ),
      titleFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_fr'],
      ),
      contentHtmlFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_fr'],
      ),
      titleEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_es'],
      ),
      contentHtmlEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_es'],
      ),
      titleIt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_it'],
      ),
      contentHtmlIt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_it'],
      ),
      titlePt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_pt'],
      ),
      contentHtmlPt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_pt'],
      ),
      titleRo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_ro'],
      ),
      contentHtmlRo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_ro'],
      ),
      titleTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_tr'],
      ),
      contentHtmlTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_tr'],
      ),
      titleJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_ja'],
      ),
      contentHtmlJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_ja'],
      ),
      titleKo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_ko'],
      ),
      contentHtmlKo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_ko'],
      ),
      titleZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_zh'],
      ),
      contentHtmlZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_html_zh'],
      ),
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
  final String titleUk;
  final String imageUrl;
  final String flagUrl;
  final String contentHtmlUk;
  final int readTimeMin;
  final String? titleEn;
  final String? contentHtmlEn;
  final String? titlePl;
  final String? contentHtmlPl;
  final String? titleDe;
  final String? contentHtmlDe;
  final String? titleFr;
  final String? contentHtmlFr;
  final String? titleEs;
  final String? contentHtmlEs;
  final String? titleIt;
  final String? contentHtmlIt;
  final String? titlePt;
  final String? contentHtmlPt;
  final String? titleRo;
  final String? contentHtmlRo;
  final String? titleTr;
  final String? contentHtmlTr;
  final String? titleJa;
  final String? contentHtmlJa;
  final String? titleKo;
  final String? contentHtmlKo;
  final String? titleZh;
  final String? contentHtmlZh;
  const SpecialtyArticle({
    required this.id,
    required this.titleUk,
    required this.imageUrl,
    required this.flagUrl,
    required this.contentHtmlUk,
    required this.readTimeMin,
    this.titleEn,
    this.contentHtmlEn,
    this.titlePl,
    this.contentHtmlPl,
    this.titleDe,
    this.contentHtmlDe,
    this.titleFr,
    this.contentHtmlFr,
    this.titleEs,
    this.contentHtmlEs,
    this.titleIt,
    this.contentHtmlIt,
    this.titlePt,
    this.contentHtmlPt,
    this.titleRo,
    this.contentHtmlRo,
    this.titleTr,
    this.contentHtmlTr,
    this.titleJa,
    this.contentHtmlJa,
    this.titleKo,
    this.contentHtmlKo,
    this.titleZh,
    this.contentHtmlZh,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title_uk'] = Variable<String>(titleUk);
    map['image_url'] = Variable<String>(imageUrl);
    map['flag_url'] = Variable<String>(flagUrl);
    map['content_html_uk'] = Variable<String>(contentHtmlUk);
    map['read_time_min'] = Variable<int>(readTimeMin);
    if (!nullToAbsent || titleEn != null) {
      map['title_en'] = Variable<String>(titleEn);
    }
    if (!nullToAbsent || contentHtmlEn != null) {
      map['content_html_en'] = Variable<String>(contentHtmlEn);
    }
    if (!nullToAbsent || titlePl != null) {
      map['title_pl'] = Variable<String>(titlePl);
    }
    if (!nullToAbsent || contentHtmlPl != null) {
      map['content_html_pl'] = Variable<String>(contentHtmlPl);
    }
    if (!nullToAbsent || titleDe != null) {
      map['title_de'] = Variable<String>(titleDe);
    }
    if (!nullToAbsent || contentHtmlDe != null) {
      map['content_html_de'] = Variable<String>(contentHtmlDe);
    }
    if (!nullToAbsent || titleFr != null) {
      map['title_fr'] = Variable<String>(titleFr);
    }
    if (!nullToAbsent || contentHtmlFr != null) {
      map['content_html_fr'] = Variable<String>(contentHtmlFr);
    }
    if (!nullToAbsent || titleEs != null) {
      map['title_es'] = Variable<String>(titleEs);
    }
    if (!nullToAbsent || contentHtmlEs != null) {
      map['content_html_es'] = Variable<String>(contentHtmlEs);
    }
    if (!nullToAbsent || titleIt != null) {
      map['title_it'] = Variable<String>(titleIt);
    }
    if (!nullToAbsent || contentHtmlIt != null) {
      map['content_html_it'] = Variable<String>(contentHtmlIt);
    }
    if (!nullToAbsent || titlePt != null) {
      map['title_pt'] = Variable<String>(titlePt);
    }
    if (!nullToAbsent || contentHtmlPt != null) {
      map['content_html_pt'] = Variable<String>(contentHtmlPt);
    }
    if (!nullToAbsent || titleRo != null) {
      map['title_ro'] = Variable<String>(titleRo);
    }
    if (!nullToAbsent || contentHtmlRo != null) {
      map['content_html_ro'] = Variable<String>(contentHtmlRo);
    }
    if (!nullToAbsent || titleTr != null) {
      map['title_tr'] = Variable<String>(titleTr);
    }
    if (!nullToAbsent || contentHtmlTr != null) {
      map['content_html_tr'] = Variable<String>(contentHtmlTr);
    }
    if (!nullToAbsent || titleJa != null) {
      map['title_ja'] = Variable<String>(titleJa);
    }
    if (!nullToAbsent || contentHtmlJa != null) {
      map['content_html_ja'] = Variable<String>(contentHtmlJa);
    }
    if (!nullToAbsent || titleKo != null) {
      map['title_ko'] = Variable<String>(titleKo);
    }
    if (!nullToAbsent || contentHtmlKo != null) {
      map['content_html_ko'] = Variable<String>(contentHtmlKo);
    }
    if (!nullToAbsent || titleZh != null) {
      map['title_zh'] = Variable<String>(titleZh);
    }
    if (!nullToAbsent || contentHtmlZh != null) {
      map['content_html_zh'] = Variable<String>(contentHtmlZh);
    }
    return map;
  }

  SpecialtyArticlesCompanion toCompanion(bool nullToAbsent) {
    return SpecialtyArticlesCompanion(
      id: Value(id),
      titleUk: Value(titleUk),
      imageUrl: Value(imageUrl),
      flagUrl: Value(flagUrl),
      contentHtmlUk: Value(contentHtmlUk),
      readTimeMin: Value(readTimeMin),
      titleEn: titleEn == null && nullToAbsent
          ? const Value.absent()
          : Value(titleEn),
      contentHtmlEn: contentHtmlEn == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlEn),
      titlePl: titlePl == null && nullToAbsent
          ? const Value.absent()
          : Value(titlePl),
      contentHtmlPl: contentHtmlPl == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlPl),
      titleDe: titleDe == null && nullToAbsent
          ? const Value.absent()
          : Value(titleDe),
      contentHtmlDe: contentHtmlDe == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlDe),
      titleFr: titleFr == null && nullToAbsent
          ? const Value.absent()
          : Value(titleFr),
      contentHtmlFr: contentHtmlFr == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlFr),
      titleEs: titleEs == null && nullToAbsent
          ? const Value.absent()
          : Value(titleEs),
      contentHtmlEs: contentHtmlEs == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlEs),
      titleIt: titleIt == null && nullToAbsent
          ? const Value.absent()
          : Value(titleIt),
      contentHtmlIt: contentHtmlIt == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlIt),
      titlePt: titlePt == null && nullToAbsent
          ? const Value.absent()
          : Value(titlePt),
      contentHtmlPt: contentHtmlPt == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlPt),
      titleRo: titleRo == null && nullToAbsent
          ? const Value.absent()
          : Value(titleRo),
      contentHtmlRo: contentHtmlRo == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlRo),
      titleTr: titleTr == null && nullToAbsent
          ? const Value.absent()
          : Value(titleTr),
      contentHtmlTr: contentHtmlTr == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlTr),
      titleJa: titleJa == null && nullToAbsent
          ? const Value.absent()
          : Value(titleJa),
      contentHtmlJa: contentHtmlJa == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlJa),
      titleKo: titleKo == null && nullToAbsent
          ? const Value.absent()
          : Value(titleKo),
      contentHtmlKo: contentHtmlKo == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlKo),
      titleZh: titleZh == null && nullToAbsent
          ? const Value.absent()
          : Value(titleZh),
      contentHtmlZh: contentHtmlZh == null && nullToAbsent
          ? const Value.absent()
          : Value(contentHtmlZh),
    );
  }

  factory SpecialtyArticle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecialtyArticle(
      id: serializer.fromJson<int>(json['id']),
      titleUk: serializer.fromJson<String>(json['titleUk']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      flagUrl: serializer.fromJson<String>(json['flagUrl']),
      contentHtmlUk: serializer.fromJson<String>(json['contentHtmlUk']),
      readTimeMin: serializer.fromJson<int>(json['readTimeMin']),
      titleEn: serializer.fromJson<String?>(json['titleEn']),
      contentHtmlEn: serializer.fromJson<String?>(json['contentHtmlEn']),
      titlePl: serializer.fromJson<String?>(json['titlePl']),
      contentHtmlPl: serializer.fromJson<String?>(json['contentHtmlPl']),
      titleDe: serializer.fromJson<String?>(json['titleDe']),
      contentHtmlDe: serializer.fromJson<String?>(json['contentHtmlDe']),
      titleFr: serializer.fromJson<String?>(json['titleFr']),
      contentHtmlFr: serializer.fromJson<String?>(json['contentHtmlFr']),
      titleEs: serializer.fromJson<String?>(json['titleEs']),
      contentHtmlEs: serializer.fromJson<String?>(json['contentHtmlEs']),
      titleIt: serializer.fromJson<String?>(json['titleIt']),
      contentHtmlIt: serializer.fromJson<String?>(json['contentHtmlIt']),
      titlePt: serializer.fromJson<String?>(json['titlePt']),
      contentHtmlPt: serializer.fromJson<String?>(json['contentHtmlPt']),
      titleRo: serializer.fromJson<String?>(json['titleRo']),
      contentHtmlRo: serializer.fromJson<String?>(json['contentHtmlRo']),
      titleTr: serializer.fromJson<String?>(json['titleTr']),
      contentHtmlTr: serializer.fromJson<String?>(json['contentHtmlTr']),
      titleJa: serializer.fromJson<String?>(json['titleJa']),
      contentHtmlJa: serializer.fromJson<String?>(json['contentHtmlJa']),
      titleKo: serializer.fromJson<String?>(json['titleKo']),
      contentHtmlKo: serializer.fromJson<String?>(json['contentHtmlKo']),
      titleZh: serializer.fromJson<String?>(json['titleZh']),
      contentHtmlZh: serializer.fromJson<String?>(json['contentHtmlZh']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'titleUk': serializer.toJson<String>(titleUk),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'flagUrl': serializer.toJson<String>(flagUrl),
      'contentHtmlUk': serializer.toJson<String>(contentHtmlUk),
      'readTimeMin': serializer.toJson<int>(readTimeMin),
      'titleEn': serializer.toJson<String?>(titleEn),
      'contentHtmlEn': serializer.toJson<String?>(contentHtmlEn),
      'titlePl': serializer.toJson<String?>(titlePl),
      'contentHtmlPl': serializer.toJson<String?>(contentHtmlPl),
      'titleDe': serializer.toJson<String?>(titleDe),
      'contentHtmlDe': serializer.toJson<String?>(contentHtmlDe),
      'titleFr': serializer.toJson<String?>(titleFr),
      'contentHtmlFr': serializer.toJson<String?>(contentHtmlFr),
      'titleEs': serializer.toJson<String?>(titleEs),
      'contentHtmlEs': serializer.toJson<String?>(contentHtmlEs),
      'titleIt': serializer.toJson<String?>(titleIt),
      'contentHtmlIt': serializer.toJson<String?>(contentHtmlIt),
      'titlePt': serializer.toJson<String?>(titlePt),
      'contentHtmlPt': serializer.toJson<String?>(contentHtmlPt),
      'titleRo': serializer.toJson<String?>(titleRo),
      'contentHtmlRo': serializer.toJson<String?>(contentHtmlRo),
      'titleTr': serializer.toJson<String?>(titleTr),
      'contentHtmlTr': serializer.toJson<String?>(contentHtmlTr),
      'titleJa': serializer.toJson<String?>(titleJa),
      'contentHtmlJa': serializer.toJson<String?>(contentHtmlJa),
      'titleKo': serializer.toJson<String?>(titleKo),
      'contentHtmlKo': serializer.toJson<String?>(contentHtmlKo),
      'titleZh': serializer.toJson<String?>(titleZh),
      'contentHtmlZh': serializer.toJson<String?>(contentHtmlZh),
    };
  }

  SpecialtyArticle copyWith({
    int? id,
    String? titleUk,
    String? imageUrl,
    String? flagUrl,
    String? contentHtmlUk,
    int? readTimeMin,
    Value<String?> titleEn = const Value.absent(),
    Value<String?> contentHtmlEn = const Value.absent(),
    Value<String?> titlePl = const Value.absent(),
    Value<String?> contentHtmlPl = const Value.absent(),
    Value<String?> titleDe = const Value.absent(),
    Value<String?> contentHtmlDe = const Value.absent(),
    Value<String?> titleFr = const Value.absent(),
    Value<String?> contentHtmlFr = const Value.absent(),
    Value<String?> titleEs = const Value.absent(),
    Value<String?> contentHtmlEs = const Value.absent(),
    Value<String?> titleIt = const Value.absent(),
    Value<String?> contentHtmlIt = const Value.absent(),
    Value<String?> titlePt = const Value.absent(),
    Value<String?> contentHtmlPt = const Value.absent(),
    Value<String?> titleRo = const Value.absent(),
    Value<String?> contentHtmlRo = const Value.absent(),
    Value<String?> titleTr = const Value.absent(),
    Value<String?> contentHtmlTr = const Value.absent(),
    Value<String?> titleJa = const Value.absent(),
    Value<String?> contentHtmlJa = const Value.absent(),
    Value<String?> titleKo = const Value.absent(),
    Value<String?> contentHtmlKo = const Value.absent(),
    Value<String?> titleZh = const Value.absent(),
    Value<String?> contentHtmlZh = const Value.absent(),
  }) => SpecialtyArticle(
    id: id ?? this.id,
    titleUk: titleUk ?? this.titleUk,
    imageUrl: imageUrl ?? this.imageUrl,
    flagUrl: flagUrl ?? this.flagUrl,
    contentHtmlUk: contentHtmlUk ?? this.contentHtmlUk,
    readTimeMin: readTimeMin ?? this.readTimeMin,
    titleEn: titleEn.present ? titleEn.value : this.titleEn,
    contentHtmlEn: contentHtmlEn.present
        ? contentHtmlEn.value
        : this.contentHtmlEn,
    titlePl: titlePl.present ? titlePl.value : this.titlePl,
    contentHtmlPl: contentHtmlPl.present
        ? contentHtmlPl.value
        : this.contentHtmlPl,
    titleDe: titleDe.present ? titleDe.value : this.titleDe,
    contentHtmlDe: contentHtmlDe.present
        ? contentHtmlDe.value
        : this.contentHtmlDe,
    titleFr: titleFr.present ? titleFr.value : this.titleFr,
    contentHtmlFr: contentHtmlFr.present
        ? contentHtmlFr.value
        : this.contentHtmlFr,
    titleEs: titleEs.present ? titleEs.value : this.titleEs,
    contentHtmlEs: contentHtmlEs.present
        ? contentHtmlEs.value
        : this.contentHtmlEs,
    titleIt: titleIt.present ? titleIt.value : this.titleIt,
    contentHtmlIt: contentHtmlIt.present
        ? contentHtmlIt.value
        : this.contentHtmlIt,
    titlePt: titlePt.present ? titlePt.value : this.titlePt,
    contentHtmlPt: contentHtmlPt.present
        ? contentHtmlPt.value
        : this.contentHtmlPt,
    titleRo: titleRo.present ? titleRo.value : this.titleRo,
    contentHtmlRo: contentHtmlRo.present
        ? contentHtmlRo.value
        : this.contentHtmlRo,
    titleTr: titleTr.present ? titleTr.value : this.titleTr,
    contentHtmlTr: contentHtmlTr.present
        ? contentHtmlTr.value
        : this.contentHtmlTr,
    titleJa: titleJa.present ? titleJa.value : this.titleJa,
    contentHtmlJa: contentHtmlJa.present
        ? contentHtmlJa.value
        : this.contentHtmlJa,
    titleKo: titleKo.present ? titleKo.value : this.titleKo,
    contentHtmlKo: contentHtmlKo.present
        ? contentHtmlKo.value
        : this.contentHtmlKo,
    titleZh: titleZh.present ? titleZh.value : this.titleZh,
    contentHtmlZh: contentHtmlZh.present
        ? contentHtmlZh.value
        : this.contentHtmlZh,
  );
  SpecialtyArticle copyWithCompanion(SpecialtyArticlesCompanion data) {
    return SpecialtyArticle(
      id: data.id.present ? data.id.value : this.id,
      titleUk: data.titleUk.present ? data.titleUk.value : this.titleUk,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      flagUrl: data.flagUrl.present ? data.flagUrl.value : this.flagUrl,
      contentHtmlUk: data.contentHtmlUk.present
          ? data.contentHtmlUk.value
          : this.contentHtmlUk,
      readTimeMin: data.readTimeMin.present
          ? data.readTimeMin.value
          : this.readTimeMin,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      contentHtmlEn: data.contentHtmlEn.present
          ? data.contentHtmlEn.value
          : this.contentHtmlEn,
      titlePl: data.titlePl.present ? data.titlePl.value : this.titlePl,
      contentHtmlPl: data.contentHtmlPl.present
          ? data.contentHtmlPl.value
          : this.contentHtmlPl,
      titleDe: data.titleDe.present ? data.titleDe.value : this.titleDe,
      contentHtmlDe: data.contentHtmlDe.present
          ? data.contentHtmlDe.value
          : this.contentHtmlDe,
      titleFr: data.titleFr.present ? data.titleFr.value : this.titleFr,
      contentHtmlFr: data.contentHtmlFr.present
          ? data.contentHtmlFr.value
          : this.contentHtmlFr,
      titleEs: data.titleEs.present ? data.titleEs.value : this.titleEs,
      contentHtmlEs: data.contentHtmlEs.present
          ? data.contentHtmlEs.value
          : this.contentHtmlEs,
      titleIt: data.titleIt.present ? data.titleIt.value : this.titleIt,
      contentHtmlIt: data.contentHtmlIt.present
          ? data.contentHtmlIt.value
          : this.contentHtmlIt,
      titlePt: data.titlePt.present ? data.titlePt.value : this.titlePt,
      contentHtmlPt: data.contentHtmlPt.present
          ? data.contentHtmlPt.value
          : this.contentHtmlPt,
      titleRo: data.titleRo.present ? data.titleRo.value : this.titleRo,
      contentHtmlRo: data.contentHtmlRo.present
          ? data.contentHtmlRo.value
          : this.contentHtmlRo,
      titleTr: data.titleTr.present ? data.titleTr.value : this.titleTr,
      contentHtmlTr: data.contentHtmlTr.present
          ? data.contentHtmlTr.value
          : this.contentHtmlTr,
      titleJa: data.titleJa.present ? data.titleJa.value : this.titleJa,
      contentHtmlJa: data.contentHtmlJa.present
          ? data.contentHtmlJa.value
          : this.contentHtmlJa,
      titleKo: data.titleKo.present ? data.titleKo.value : this.titleKo,
      contentHtmlKo: data.contentHtmlKo.present
          ? data.contentHtmlKo.value
          : this.contentHtmlKo,
      titleZh: data.titleZh.present ? data.titleZh.value : this.titleZh,
      contentHtmlZh: data.contentHtmlZh.present
          ? data.contentHtmlZh.value
          : this.contentHtmlZh,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticle(')
          ..write('id: $id, ')
          ..write('titleUk: $titleUk, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('contentHtmlUk: $contentHtmlUk, ')
          ..write('readTimeMin: $readTimeMin, ')
          ..write('titleEn: $titleEn, ')
          ..write('contentHtmlEn: $contentHtmlEn, ')
          ..write('titlePl: $titlePl, ')
          ..write('contentHtmlPl: $contentHtmlPl, ')
          ..write('titleDe: $titleDe, ')
          ..write('contentHtmlDe: $contentHtmlDe, ')
          ..write('titleFr: $titleFr, ')
          ..write('contentHtmlFr: $contentHtmlFr, ')
          ..write('titleEs: $titleEs, ')
          ..write('contentHtmlEs: $contentHtmlEs, ')
          ..write('titleIt: $titleIt, ')
          ..write('contentHtmlIt: $contentHtmlIt, ')
          ..write('titlePt: $titlePt, ')
          ..write('contentHtmlPt: $contentHtmlPt, ')
          ..write('titleRo: $titleRo, ')
          ..write('contentHtmlRo: $contentHtmlRo, ')
          ..write('titleTr: $titleTr, ')
          ..write('contentHtmlTr: $contentHtmlTr, ')
          ..write('titleJa: $titleJa, ')
          ..write('contentHtmlJa: $contentHtmlJa, ')
          ..write('titleKo: $titleKo, ')
          ..write('contentHtmlKo: $contentHtmlKo, ')
          ..write('titleZh: $titleZh, ')
          ..write('contentHtmlZh: $contentHtmlZh')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    titleUk,
    imageUrl,
    flagUrl,
    contentHtmlUk,
    readTimeMin,
    titleEn,
    contentHtmlEn,
    titlePl,
    contentHtmlPl,
    titleDe,
    contentHtmlDe,
    titleFr,
    contentHtmlFr,
    titleEs,
    contentHtmlEs,
    titleIt,
    contentHtmlIt,
    titlePt,
    contentHtmlPt,
    titleRo,
    contentHtmlRo,
    titleTr,
    contentHtmlTr,
    titleJa,
    contentHtmlJa,
    titleKo,
    contentHtmlKo,
    titleZh,
    contentHtmlZh,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecialtyArticle &&
          other.id == this.id &&
          other.titleUk == this.titleUk &&
          other.imageUrl == this.imageUrl &&
          other.flagUrl == this.flagUrl &&
          other.contentHtmlUk == this.contentHtmlUk &&
          other.readTimeMin == this.readTimeMin &&
          other.titleEn == this.titleEn &&
          other.contentHtmlEn == this.contentHtmlEn &&
          other.titlePl == this.titlePl &&
          other.contentHtmlPl == this.contentHtmlPl &&
          other.titleDe == this.titleDe &&
          other.contentHtmlDe == this.contentHtmlDe &&
          other.titleFr == this.titleFr &&
          other.contentHtmlFr == this.contentHtmlFr &&
          other.titleEs == this.titleEs &&
          other.contentHtmlEs == this.contentHtmlEs &&
          other.titleIt == this.titleIt &&
          other.contentHtmlIt == this.contentHtmlIt &&
          other.titlePt == this.titlePt &&
          other.contentHtmlPt == this.contentHtmlPt &&
          other.titleRo == this.titleRo &&
          other.contentHtmlRo == this.contentHtmlRo &&
          other.titleTr == this.titleTr &&
          other.contentHtmlTr == this.contentHtmlTr &&
          other.titleJa == this.titleJa &&
          other.contentHtmlJa == this.contentHtmlJa &&
          other.titleKo == this.titleKo &&
          other.contentHtmlKo == this.contentHtmlKo &&
          other.titleZh == this.titleZh &&
          other.contentHtmlZh == this.contentHtmlZh);
}

class SpecialtyArticlesCompanion extends UpdateCompanion<SpecialtyArticle> {
  final Value<int> id;
  final Value<String> titleUk;
  final Value<String> imageUrl;
  final Value<String> flagUrl;
  final Value<String> contentHtmlUk;
  final Value<int> readTimeMin;
  final Value<String?> titleEn;
  final Value<String?> contentHtmlEn;
  final Value<String?> titlePl;
  final Value<String?> contentHtmlPl;
  final Value<String?> titleDe;
  final Value<String?> contentHtmlDe;
  final Value<String?> titleFr;
  final Value<String?> contentHtmlFr;
  final Value<String?> titleEs;
  final Value<String?> contentHtmlEs;
  final Value<String?> titleIt;
  final Value<String?> contentHtmlIt;
  final Value<String?> titlePt;
  final Value<String?> contentHtmlPt;
  final Value<String?> titleRo;
  final Value<String?> contentHtmlRo;
  final Value<String?> titleTr;
  final Value<String?> contentHtmlTr;
  final Value<String?> titleJa;
  final Value<String?> contentHtmlJa;
  final Value<String?> titleKo;
  final Value<String?> contentHtmlKo;
  final Value<String?> titleZh;
  final Value<String?> contentHtmlZh;
  const SpecialtyArticlesCompanion({
    this.id = const Value.absent(),
    this.titleUk = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.contentHtmlUk = const Value.absent(),
    this.readTimeMin = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.contentHtmlEn = const Value.absent(),
    this.titlePl = const Value.absent(),
    this.contentHtmlPl = const Value.absent(),
    this.titleDe = const Value.absent(),
    this.contentHtmlDe = const Value.absent(),
    this.titleFr = const Value.absent(),
    this.contentHtmlFr = const Value.absent(),
    this.titleEs = const Value.absent(),
    this.contentHtmlEs = const Value.absent(),
    this.titleIt = const Value.absent(),
    this.contentHtmlIt = const Value.absent(),
    this.titlePt = const Value.absent(),
    this.contentHtmlPt = const Value.absent(),
    this.titleRo = const Value.absent(),
    this.contentHtmlRo = const Value.absent(),
    this.titleTr = const Value.absent(),
    this.contentHtmlTr = const Value.absent(),
    this.titleJa = const Value.absent(),
    this.contentHtmlJa = const Value.absent(),
    this.titleKo = const Value.absent(),
    this.contentHtmlKo = const Value.absent(),
    this.titleZh = const Value.absent(),
    this.contentHtmlZh = const Value.absent(),
  });
  SpecialtyArticlesCompanion.insert({
    this.id = const Value.absent(),
    this.titleUk = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.contentHtmlUk = const Value.absent(),
    this.readTimeMin = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.contentHtmlEn = const Value.absent(),
    this.titlePl = const Value.absent(),
    this.contentHtmlPl = const Value.absent(),
    this.titleDe = const Value.absent(),
    this.contentHtmlDe = const Value.absent(),
    this.titleFr = const Value.absent(),
    this.contentHtmlFr = const Value.absent(),
    this.titleEs = const Value.absent(),
    this.contentHtmlEs = const Value.absent(),
    this.titleIt = const Value.absent(),
    this.contentHtmlIt = const Value.absent(),
    this.titlePt = const Value.absent(),
    this.contentHtmlPt = const Value.absent(),
    this.titleRo = const Value.absent(),
    this.contentHtmlRo = const Value.absent(),
    this.titleTr = const Value.absent(),
    this.contentHtmlTr = const Value.absent(),
    this.titleJa = const Value.absent(),
    this.contentHtmlJa = const Value.absent(),
    this.titleKo = const Value.absent(),
    this.contentHtmlKo = const Value.absent(),
    this.titleZh = const Value.absent(),
    this.contentHtmlZh = const Value.absent(),
  });
  static Insertable<SpecialtyArticle> custom({
    Expression<int>? id,
    Expression<String>? titleUk,
    Expression<String>? imageUrl,
    Expression<String>? flagUrl,
    Expression<String>? contentHtmlUk,
    Expression<int>? readTimeMin,
    Expression<String>? titleEn,
    Expression<String>? contentHtmlEn,
    Expression<String>? titlePl,
    Expression<String>? contentHtmlPl,
    Expression<String>? titleDe,
    Expression<String>? contentHtmlDe,
    Expression<String>? titleFr,
    Expression<String>? contentHtmlFr,
    Expression<String>? titleEs,
    Expression<String>? contentHtmlEs,
    Expression<String>? titleIt,
    Expression<String>? contentHtmlIt,
    Expression<String>? titlePt,
    Expression<String>? contentHtmlPt,
    Expression<String>? titleRo,
    Expression<String>? contentHtmlRo,
    Expression<String>? titleTr,
    Expression<String>? contentHtmlTr,
    Expression<String>? titleJa,
    Expression<String>? contentHtmlJa,
    Expression<String>? titleKo,
    Expression<String>? contentHtmlKo,
    Expression<String>? titleZh,
    Expression<String>? contentHtmlZh,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titleUk != null) 'title_uk': titleUk,
      if (imageUrl != null) 'image_url': imageUrl,
      if (flagUrl != null) 'flag_url': flagUrl,
      if (contentHtmlUk != null) 'content_html_uk': contentHtmlUk,
      if (readTimeMin != null) 'read_time_min': readTimeMin,
      if (titleEn != null) 'title_en': titleEn,
      if (contentHtmlEn != null) 'content_html_en': contentHtmlEn,
      if (titlePl != null) 'title_pl': titlePl,
      if (contentHtmlPl != null) 'content_html_pl': contentHtmlPl,
      if (titleDe != null) 'title_de': titleDe,
      if (contentHtmlDe != null) 'content_html_de': contentHtmlDe,
      if (titleFr != null) 'title_fr': titleFr,
      if (contentHtmlFr != null) 'content_html_fr': contentHtmlFr,
      if (titleEs != null) 'title_es': titleEs,
      if (contentHtmlEs != null) 'content_html_es': contentHtmlEs,
      if (titleIt != null) 'title_it': titleIt,
      if (contentHtmlIt != null) 'content_html_it': contentHtmlIt,
      if (titlePt != null) 'title_pt': titlePt,
      if (contentHtmlPt != null) 'content_html_pt': contentHtmlPt,
      if (titleRo != null) 'title_ro': titleRo,
      if (contentHtmlRo != null) 'content_html_ro': contentHtmlRo,
      if (titleTr != null) 'title_tr': titleTr,
      if (contentHtmlTr != null) 'content_html_tr': contentHtmlTr,
      if (titleJa != null) 'title_ja': titleJa,
      if (contentHtmlJa != null) 'content_html_ja': contentHtmlJa,
      if (titleKo != null) 'title_ko': titleKo,
      if (contentHtmlKo != null) 'content_html_ko': contentHtmlKo,
      if (titleZh != null) 'title_zh': titleZh,
      if (contentHtmlZh != null) 'content_html_zh': contentHtmlZh,
    });
  }

  SpecialtyArticlesCompanion copyWith({
    Value<int>? id,
    Value<String>? titleUk,
    Value<String>? imageUrl,
    Value<String>? flagUrl,
    Value<String>? contentHtmlUk,
    Value<int>? readTimeMin,
    Value<String?>? titleEn,
    Value<String?>? contentHtmlEn,
    Value<String?>? titlePl,
    Value<String?>? contentHtmlPl,
    Value<String?>? titleDe,
    Value<String?>? contentHtmlDe,
    Value<String?>? titleFr,
    Value<String?>? contentHtmlFr,
    Value<String?>? titleEs,
    Value<String?>? contentHtmlEs,
    Value<String?>? titleIt,
    Value<String?>? contentHtmlIt,
    Value<String?>? titlePt,
    Value<String?>? contentHtmlPt,
    Value<String?>? titleRo,
    Value<String?>? contentHtmlRo,
    Value<String?>? titleTr,
    Value<String?>? contentHtmlTr,
    Value<String?>? titleJa,
    Value<String?>? contentHtmlJa,
    Value<String?>? titleKo,
    Value<String?>? contentHtmlKo,
    Value<String?>? titleZh,
    Value<String?>? contentHtmlZh,
  }) {
    return SpecialtyArticlesCompanion(
      id: id ?? this.id,
      titleUk: titleUk ?? this.titleUk,
      imageUrl: imageUrl ?? this.imageUrl,
      flagUrl: flagUrl ?? this.flagUrl,
      contentHtmlUk: contentHtmlUk ?? this.contentHtmlUk,
      readTimeMin: readTimeMin ?? this.readTimeMin,
      titleEn: titleEn ?? this.titleEn,
      contentHtmlEn: contentHtmlEn ?? this.contentHtmlEn,
      titlePl: titlePl ?? this.titlePl,
      contentHtmlPl: contentHtmlPl ?? this.contentHtmlPl,
      titleDe: titleDe ?? this.titleDe,
      contentHtmlDe: contentHtmlDe ?? this.contentHtmlDe,
      titleFr: titleFr ?? this.titleFr,
      contentHtmlFr: contentHtmlFr ?? this.contentHtmlFr,
      titleEs: titleEs ?? this.titleEs,
      contentHtmlEs: contentHtmlEs ?? this.contentHtmlEs,
      titleIt: titleIt ?? this.titleIt,
      contentHtmlIt: contentHtmlIt ?? this.contentHtmlIt,
      titlePt: titlePt ?? this.titlePt,
      contentHtmlPt: contentHtmlPt ?? this.contentHtmlPt,
      titleRo: titleRo ?? this.titleRo,
      contentHtmlRo: contentHtmlRo ?? this.contentHtmlRo,
      titleTr: titleTr ?? this.titleTr,
      contentHtmlTr: contentHtmlTr ?? this.contentHtmlTr,
      titleJa: titleJa ?? this.titleJa,
      contentHtmlJa: contentHtmlJa ?? this.contentHtmlJa,
      titleKo: titleKo ?? this.titleKo,
      contentHtmlKo: contentHtmlKo ?? this.contentHtmlKo,
      titleZh: titleZh ?? this.titleZh,
      contentHtmlZh: contentHtmlZh ?? this.contentHtmlZh,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (titleUk.present) {
      map['title_uk'] = Variable<String>(titleUk.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (flagUrl.present) {
      map['flag_url'] = Variable<String>(flagUrl.value);
    }
    if (contentHtmlUk.present) {
      map['content_html_uk'] = Variable<String>(contentHtmlUk.value);
    }
    if (readTimeMin.present) {
      map['read_time_min'] = Variable<int>(readTimeMin.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (contentHtmlEn.present) {
      map['content_html_en'] = Variable<String>(contentHtmlEn.value);
    }
    if (titlePl.present) {
      map['title_pl'] = Variable<String>(titlePl.value);
    }
    if (contentHtmlPl.present) {
      map['content_html_pl'] = Variable<String>(contentHtmlPl.value);
    }
    if (titleDe.present) {
      map['title_de'] = Variable<String>(titleDe.value);
    }
    if (contentHtmlDe.present) {
      map['content_html_de'] = Variable<String>(contentHtmlDe.value);
    }
    if (titleFr.present) {
      map['title_fr'] = Variable<String>(titleFr.value);
    }
    if (contentHtmlFr.present) {
      map['content_html_fr'] = Variable<String>(contentHtmlFr.value);
    }
    if (titleEs.present) {
      map['title_es'] = Variable<String>(titleEs.value);
    }
    if (contentHtmlEs.present) {
      map['content_html_es'] = Variable<String>(contentHtmlEs.value);
    }
    if (titleIt.present) {
      map['title_it'] = Variable<String>(titleIt.value);
    }
    if (contentHtmlIt.present) {
      map['content_html_it'] = Variable<String>(contentHtmlIt.value);
    }
    if (titlePt.present) {
      map['title_pt'] = Variable<String>(titlePt.value);
    }
    if (contentHtmlPt.present) {
      map['content_html_pt'] = Variable<String>(contentHtmlPt.value);
    }
    if (titleRo.present) {
      map['title_ro'] = Variable<String>(titleRo.value);
    }
    if (contentHtmlRo.present) {
      map['content_html_ro'] = Variable<String>(contentHtmlRo.value);
    }
    if (titleTr.present) {
      map['title_tr'] = Variable<String>(titleTr.value);
    }
    if (contentHtmlTr.present) {
      map['content_html_tr'] = Variable<String>(contentHtmlTr.value);
    }
    if (titleJa.present) {
      map['title_ja'] = Variable<String>(titleJa.value);
    }
    if (contentHtmlJa.present) {
      map['content_html_ja'] = Variable<String>(contentHtmlJa.value);
    }
    if (titleKo.present) {
      map['title_ko'] = Variable<String>(titleKo.value);
    }
    if (contentHtmlKo.present) {
      map['content_html_ko'] = Variable<String>(contentHtmlKo.value);
    }
    if (titleZh.present) {
      map['title_zh'] = Variable<String>(titleZh.value);
    }
    if (contentHtmlZh.present) {
      map['content_html_zh'] = Variable<String>(contentHtmlZh.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecialtyArticlesCompanion(')
          ..write('id: $id, ')
          ..write('titleUk: $titleUk, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('contentHtmlUk: $contentHtmlUk, ')
          ..write('readTimeMin: $readTimeMin, ')
          ..write('titleEn: $titleEn, ')
          ..write('contentHtmlEn: $contentHtmlEn, ')
          ..write('titlePl: $titlePl, ')
          ..write('contentHtmlPl: $contentHtmlPl, ')
          ..write('titleDe: $titleDe, ')
          ..write('contentHtmlDe: $contentHtmlDe, ')
          ..write('titleFr: $titleFr, ')
          ..write('contentHtmlFr: $contentHtmlFr, ')
          ..write('titleEs: $titleEs, ')
          ..write('contentHtmlEs: $contentHtmlEs, ')
          ..write('titleIt: $titleIt, ')
          ..write('contentHtmlIt: $contentHtmlIt, ')
          ..write('titlePt: $titlePt, ')
          ..write('contentHtmlPt: $contentHtmlPt, ')
          ..write('titleRo: $titleRo, ')
          ..write('contentHtmlRo: $contentHtmlRo, ')
          ..write('titleTr: $titleTr, ')
          ..write('contentHtmlTr: $contentHtmlTr, ')
          ..write('titleJa: $titleJa, ')
          ..write('contentHtmlJa: $contentHtmlJa, ')
          ..write('titleKo: $titleKo, ')
          ..write('contentHtmlKo: $contentHtmlKo, ')
          ..write('titleZh: $titleZh, ')
          ..write('contentHtmlZh: $contentHtmlZh')
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
  static const VerificationMeta _nameUkMeta = const VerificationMeta('nameUk');
  @override
  late final GeneratedColumn<String> nameUk = GeneratedColumn<String>(
    'name_uk',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Тут має бути назва'),
  );
  static const VerificationMeta _descriptionUkMeta = const VerificationMeta(
    'descriptionUk',
  );
  @override
  late final GeneratedColumn<String> descriptionUk = GeneratedColumn<String>(
    'description_uk',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Тут має бути опис'),
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
    defaultValue: const Constant('Тут має бути лінк на фото'),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionEnMeta = const VerificationMeta(
    'descriptionEn',
  );
  @override
  late final GeneratedColumn<String> descriptionEn = GeneratedColumn<String>(
    'description_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _namePlMeta = const VerificationMeta('namePl');
  @override
  late final GeneratedColumn<String> namePl = GeneratedColumn<String>(
    'name_pl',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionPlMeta = const VerificationMeta(
    'descriptionPl',
  );
  @override
  late final GeneratedColumn<String> descriptionPl = GeneratedColumn<String>(
    'description_pl',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameDeMeta = const VerificationMeta('nameDe');
  @override
  late final GeneratedColumn<String> nameDe = GeneratedColumn<String>(
    'name_de',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionDeMeta = const VerificationMeta(
    'descriptionDe',
  );
  @override
  late final GeneratedColumn<String> descriptionDe = GeneratedColumn<String>(
    'description_de',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameFrMeta = const VerificationMeta('nameFr');
  @override
  late final GeneratedColumn<String> nameFr = GeneratedColumn<String>(
    'name_fr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionFrMeta = const VerificationMeta(
    'descriptionFr',
  );
  @override
  late final GeneratedColumn<String> descriptionFr = GeneratedColumn<String>(
    'description_fr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameEsMeta = const VerificationMeta('nameEs');
  @override
  late final GeneratedColumn<String> nameEs = GeneratedColumn<String>(
    'name_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionEsMeta = const VerificationMeta(
    'descriptionEs',
  );
  @override
  late final GeneratedColumn<String> descriptionEs = GeneratedColumn<String>(
    'description_es',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameItMeta = const VerificationMeta('nameIt');
  @override
  late final GeneratedColumn<String> nameIt = GeneratedColumn<String>(
    'name_it',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionItMeta = const VerificationMeta(
    'descriptionIt',
  );
  @override
  late final GeneratedColumn<String> descriptionIt = GeneratedColumn<String>(
    'description_it',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _namePtMeta = const VerificationMeta('namePt');
  @override
  late final GeneratedColumn<String> namePt = GeneratedColumn<String>(
    'name_pt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionPtMeta = const VerificationMeta(
    'descriptionPt',
  );
  @override
  late final GeneratedColumn<String> descriptionPt = GeneratedColumn<String>(
    'description_pt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameRoMeta = const VerificationMeta('nameRo');
  @override
  late final GeneratedColumn<String> nameRo = GeneratedColumn<String>(
    'name_ro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionRoMeta = const VerificationMeta(
    'descriptionRo',
  );
  @override
  late final GeneratedColumn<String> descriptionRo = GeneratedColumn<String>(
    'description_ro',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameTrMeta = const VerificationMeta('nameTr');
  @override
  late final GeneratedColumn<String> nameTr = GeneratedColumn<String>(
    'name_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionTrMeta = const VerificationMeta(
    'descriptionTr',
  );
  @override
  late final GeneratedColumn<String> descriptionTr = GeneratedColumn<String>(
    'description_tr',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameJaMeta = const VerificationMeta('nameJa');
  @override
  late final GeneratedColumn<String> nameJa = GeneratedColumn<String>(
    'name_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionJaMeta = const VerificationMeta(
    'descriptionJa',
  );
  @override
  late final GeneratedColumn<String> descriptionJa = GeneratedColumn<String>(
    'description_ja',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameKoMeta = const VerificationMeta('nameKo');
  @override
  late final GeneratedColumn<String> nameKo = GeneratedColumn<String>(
    'name_ko',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionKoMeta = const VerificationMeta(
    'descriptionKo',
  );
  @override
  late final GeneratedColumn<String> descriptionKo = GeneratedColumn<String>(
    'description_ko',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameZhMeta = const VerificationMeta('nameZh');
  @override
  late final GeneratedColumn<String> nameZh = GeneratedColumn<String>(
    'name_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionZhMeta = const VerificationMeta(
    'descriptionZh',
  );
  @override
  late final GeneratedColumn<String> descriptionZh = GeneratedColumn<String>(
    'description_zh',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    nameUk,
    descriptionUk,
    imageUrl,
    nameEn,
    descriptionEn,
    namePl,
    descriptionPl,
    nameDe,
    descriptionDe,
    nameFr,
    descriptionFr,
    nameEs,
    descriptionEs,
    nameIt,
    descriptionIt,
    namePt,
    descriptionPt,
    nameRo,
    descriptionRo,
    nameTr,
    descriptionTr,
    nameJa,
    descriptionJa,
    nameKo,
    descriptionKo,
    nameZh,
    descriptionZh,
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
    if (data.containsKey('name_uk')) {
      context.handle(
        _nameUkMeta,
        nameUk.isAcceptableOrUnknown(data['name_uk']!, _nameUkMeta),
      );
    }
    if (data.containsKey('description_uk')) {
      context.handle(
        _descriptionUkMeta,
        descriptionUk.isAcceptableOrUnknown(
          data['description_uk']!,
          _descriptionUkMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    }
    if (data.containsKey('description_en')) {
      context.handle(
        _descriptionEnMeta,
        descriptionEn.isAcceptableOrUnknown(
          data['description_en']!,
          _descriptionEnMeta,
        ),
      );
    }
    if (data.containsKey('name_pl')) {
      context.handle(
        _namePlMeta,
        namePl.isAcceptableOrUnknown(data['name_pl']!, _namePlMeta),
      );
    }
    if (data.containsKey('description_pl')) {
      context.handle(
        _descriptionPlMeta,
        descriptionPl.isAcceptableOrUnknown(
          data['description_pl']!,
          _descriptionPlMeta,
        ),
      );
    }
    if (data.containsKey('name_de')) {
      context.handle(
        _nameDeMeta,
        nameDe.isAcceptableOrUnknown(data['name_de']!, _nameDeMeta),
      );
    }
    if (data.containsKey('description_de')) {
      context.handle(
        _descriptionDeMeta,
        descriptionDe.isAcceptableOrUnknown(
          data['description_de']!,
          _descriptionDeMeta,
        ),
      );
    }
    if (data.containsKey('name_fr')) {
      context.handle(
        _nameFrMeta,
        nameFr.isAcceptableOrUnknown(data['name_fr']!, _nameFrMeta),
      );
    }
    if (data.containsKey('description_fr')) {
      context.handle(
        _descriptionFrMeta,
        descriptionFr.isAcceptableOrUnknown(
          data['description_fr']!,
          _descriptionFrMeta,
        ),
      );
    }
    if (data.containsKey('name_es')) {
      context.handle(
        _nameEsMeta,
        nameEs.isAcceptableOrUnknown(data['name_es']!, _nameEsMeta),
      );
    }
    if (data.containsKey('description_es')) {
      context.handle(
        _descriptionEsMeta,
        descriptionEs.isAcceptableOrUnknown(
          data['description_es']!,
          _descriptionEsMeta,
        ),
      );
    }
    if (data.containsKey('name_it')) {
      context.handle(
        _nameItMeta,
        nameIt.isAcceptableOrUnknown(data['name_it']!, _nameItMeta),
      );
    }
    if (data.containsKey('description_it')) {
      context.handle(
        _descriptionItMeta,
        descriptionIt.isAcceptableOrUnknown(
          data['description_it']!,
          _descriptionItMeta,
        ),
      );
    }
    if (data.containsKey('name_pt')) {
      context.handle(
        _namePtMeta,
        namePt.isAcceptableOrUnknown(data['name_pt']!, _namePtMeta),
      );
    }
    if (data.containsKey('description_pt')) {
      context.handle(
        _descriptionPtMeta,
        descriptionPt.isAcceptableOrUnknown(
          data['description_pt']!,
          _descriptionPtMeta,
        ),
      );
    }
    if (data.containsKey('name_ro')) {
      context.handle(
        _nameRoMeta,
        nameRo.isAcceptableOrUnknown(data['name_ro']!, _nameRoMeta),
      );
    }
    if (data.containsKey('description_ro')) {
      context.handle(
        _descriptionRoMeta,
        descriptionRo.isAcceptableOrUnknown(
          data['description_ro']!,
          _descriptionRoMeta,
        ),
      );
    }
    if (data.containsKey('name_tr')) {
      context.handle(
        _nameTrMeta,
        nameTr.isAcceptableOrUnknown(data['name_tr']!, _nameTrMeta),
      );
    }
    if (data.containsKey('description_tr')) {
      context.handle(
        _descriptionTrMeta,
        descriptionTr.isAcceptableOrUnknown(
          data['description_tr']!,
          _descriptionTrMeta,
        ),
      );
    }
    if (data.containsKey('name_ja')) {
      context.handle(
        _nameJaMeta,
        nameJa.isAcceptableOrUnknown(data['name_ja']!, _nameJaMeta),
      );
    }
    if (data.containsKey('description_ja')) {
      context.handle(
        _descriptionJaMeta,
        descriptionJa.isAcceptableOrUnknown(
          data['description_ja']!,
          _descriptionJaMeta,
        ),
      );
    }
    if (data.containsKey('name_ko')) {
      context.handle(
        _nameKoMeta,
        nameKo.isAcceptableOrUnknown(data['name_ko']!, _nameKoMeta),
      );
    }
    if (data.containsKey('description_ko')) {
      context.handle(
        _descriptionKoMeta,
        descriptionKo.isAcceptableOrUnknown(
          data['description_ko']!,
          _descriptionKoMeta,
        ),
      );
    }
    if (data.containsKey('name_zh')) {
      context.handle(
        _nameZhMeta,
        nameZh.isAcceptableOrUnknown(data['name_zh']!, _nameZhMeta),
      );
    }
    if (data.containsKey('description_zh')) {
      context.handle(
        _descriptionZhMeta,
        descriptionZh.isAcceptableOrUnknown(
          data['description_zh']!,
          _descriptionZhMeta,
        ),
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
      nameUk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_uk'],
      )!,
      descriptionUk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_uk'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      ),
      descriptionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_en'],
      ),
      namePl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_pl'],
      ),
      descriptionPl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_pl'],
      ),
      nameDe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_de'],
      ),
      descriptionDe: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_de'],
      ),
      nameFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_fr'],
      ),
      descriptionFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_fr'],
      ),
      nameEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_es'],
      ),
      descriptionEs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_es'],
      ),
      nameIt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_it'],
      ),
      descriptionIt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_it'],
      ),
      namePt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_pt'],
      ),
      descriptionPt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_pt'],
      ),
      nameRo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ro'],
      ),
      descriptionRo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ro'],
      ),
      nameTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_tr'],
      ),
      descriptionTr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_tr'],
      ),
      nameJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ja'],
      ),
      descriptionJa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ja'],
      ),
      nameKo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ko'],
      ),
      descriptionKo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ko'],
      ),
      nameZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_zh'],
      ),
      descriptionZh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_zh'],
      ),
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
  final String nameUk;
  final String descriptionUk;
  final String imageUrl;
  final String? nameEn;
  final String? descriptionEn;
  final String? namePl;
  final String? descriptionPl;
  final String? nameDe;
  final String? descriptionDe;
  final String? nameFr;
  final String? descriptionFr;
  final String? nameEs;
  final String? descriptionEs;
  final String? nameIt;
  final String? descriptionIt;
  final String? namePt;
  final String? descriptionPt;
  final String? nameRo;
  final String? descriptionRo;
  final String? nameTr;
  final String? descriptionTr;
  final String? nameJa;
  final String? descriptionJa;
  final String? nameKo;
  final String? descriptionKo;
  final String? nameZh;
  final String? descriptionZh;
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
    required this.nameUk,
    required this.descriptionUk,
    required this.imageUrl,
    this.nameEn,
    this.descriptionEn,
    this.namePl,
    this.descriptionPl,
    this.nameDe,
    this.descriptionDe,
    this.nameFr,
    this.descriptionFr,
    this.nameEs,
    this.descriptionEs,
    this.nameIt,
    this.descriptionIt,
    this.namePt,
    this.descriptionPt,
    this.nameRo,
    this.descriptionRo,
    this.nameTr,
    this.descriptionTr,
    this.nameJa,
    this.descriptionJa,
    this.nameKo,
    this.descriptionKo,
    this.nameZh,
    this.descriptionZh,
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
    map['name_uk'] = Variable<String>(nameUk);
    map['description_uk'] = Variable<String>(descriptionUk);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || descriptionEn != null) {
      map['description_en'] = Variable<String>(descriptionEn);
    }
    if (!nullToAbsent || namePl != null) {
      map['name_pl'] = Variable<String>(namePl);
    }
    if (!nullToAbsent || descriptionPl != null) {
      map['description_pl'] = Variable<String>(descriptionPl);
    }
    if (!nullToAbsent || nameDe != null) {
      map['name_de'] = Variable<String>(nameDe);
    }
    if (!nullToAbsent || descriptionDe != null) {
      map['description_de'] = Variable<String>(descriptionDe);
    }
    if (!nullToAbsent || nameFr != null) {
      map['name_fr'] = Variable<String>(nameFr);
    }
    if (!nullToAbsent || descriptionFr != null) {
      map['description_fr'] = Variable<String>(descriptionFr);
    }
    if (!nullToAbsent || nameEs != null) {
      map['name_es'] = Variable<String>(nameEs);
    }
    if (!nullToAbsent || descriptionEs != null) {
      map['description_es'] = Variable<String>(descriptionEs);
    }
    if (!nullToAbsent || nameIt != null) {
      map['name_it'] = Variable<String>(nameIt);
    }
    if (!nullToAbsent || descriptionIt != null) {
      map['description_it'] = Variable<String>(descriptionIt);
    }
    if (!nullToAbsent || namePt != null) {
      map['name_pt'] = Variable<String>(namePt);
    }
    if (!nullToAbsent || descriptionPt != null) {
      map['description_pt'] = Variable<String>(descriptionPt);
    }
    if (!nullToAbsent || nameRo != null) {
      map['name_ro'] = Variable<String>(nameRo);
    }
    if (!nullToAbsent || descriptionRo != null) {
      map['description_ro'] = Variable<String>(descriptionRo);
    }
    if (!nullToAbsent || nameTr != null) {
      map['name_tr'] = Variable<String>(nameTr);
    }
    if (!nullToAbsent || descriptionTr != null) {
      map['description_tr'] = Variable<String>(descriptionTr);
    }
    if (!nullToAbsent || nameJa != null) {
      map['name_ja'] = Variable<String>(nameJa);
    }
    if (!nullToAbsent || descriptionJa != null) {
      map['description_ja'] = Variable<String>(descriptionJa);
    }
    if (!nullToAbsent || nameKo != null) {
      map['name_ko'] = Variable<String>(nameKo);
    }
    if (!nullToAbsent || descriptionKo != null) {
      map['description_ko'] = Variable<String>(descriptionKo);
    }
    if (!nullToAbsent || nameZh != null) {
      map['name_zh'] = Variable<String>(nameZh);
    }
    if (!nullToAbsent || descriptionZh != null) {
      map['description_zh'] = Variable<String>(descriptionZh);
    }
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
      nameUk: Value(nameUk),
      descriptionUk: Value(descriptionUk),
      imageUrl: Value(imageUrl),
      nameEn: nameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEn),
      descriptionEn: descriptionEn == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionEn),
      namePl: namePl == null && nullToAbsent
          ? const Value.absent()
          : Value(namePl),
      descriptionPl: descriptionPl == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionPl),
      nameDe: nameDe == null && nullToAbsent
          ? const Value.absent()
          : Value(nameDe),
      descriptionDe: descriptionDe == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionDe),
      nameFr: nameFr == null && nullToAbsent
          ? const Value.absent()
          : Value(nameFr),
      descriptionFr: descriptionFr == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionFr),
      nameEs: nameEs == null && nullToAbsent
          ? const Value.absent()
          : Value(nameEs),
      descriptionEs: descriptionEs == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionEs),
      nameIt: nameIt == null && nullToAbsent
          ? const Value.absent()
          : Value(nameIt),
      descriptionIt: descriptionIt == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionIt),
      namePt: namePt == null && nullToAbsent
          ? const Value.absent()
          : Value(namePt),
      descriptionPt: descriptionPt == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionPt),
      nameRo: nameRo == null && nullToAbsent
          ? const Value.absent()
          : Value(nameRo),
      descriptionRo: descriptionRo == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionRo),
      nameTr: nameTr == null && nullToAbsent
          ? const Value.absent()
          : Value(nameTr),
      descriptionTr: descriptionTr == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionTr),
      nameJa: nameJa == null && nullToAbsent
          ? const Value.absent()
          : Value(nameJa),
      descriptionJa: descriptionJa == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionJa),
      nameKo: nameKo == null && nullToAbsent
          ? const Value.absent()
          : Value(nameKo),
      descriptionKo: descriptionKo == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionKo),
      nameZh: nameZh == null && nullToAbsent
          ? const Value.absent()
          : Value(nameZh),
      descriptionZh: descriptionZh == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionZh),
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
      nameUk: serializer.fromJson<String>(json['nameUk']),
      descriptionUk: serializer.fromJson<String>(json['descriptionUk']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      descriptionEn: serializer.fromJson<String?>(json['descriptionEn']),
      namePl: serializer.fromJson<String?>(json['namePl']),
      descriptionPl: serializer.fromJson<String?>(json['descriptionPl']),
      nameDe: serializer.fromJson<String?>(json['nameDe']),
      descriptionDe: serializer.fromJson<String?>(json['descriptionDe']),
      nameFr: serializer.fromJson<String?>(json['nameFr']),
      descriptionFr: serializer.fromJson<String?>(json['descriptionFr']),
      nameEs: serializer.fromJson<String?>(json['nameEs']),
      descriptionEs: serializer.fromJson<String?>(json['descriptionEs']),
      nameIt: serializer.fromJson<String?>(json['nameIt']),
      descriptionIt: serializer.fromJson<String?>(json['descriptionIt']),
      namePt: serializer.fromJson<String?>(json['namePt']),
      descriptionPt: serializer.fromJson<String?>(json['descriptionPt']),
      nameRo: serializer.fromJson<String?>(json['nameRo']),
      descriptionRo: serializer.fromJson<String?>(json['descriptionRo']),
      nameTr: serializer.fromJson<String?>(json['nameTr']),
      descriptionTr: serializer.fromJson<String?>(json['descriptionTr']),
      nameJa: serializer.fromJson<String?>(json['nameJa']),
      descriptionJa: serializer.fromJson<String?>(json['descriptionJa']),
      nameKo: serializer.fromJson<String?>(json['nameKo']),
      descriptionKo: serializer.fromJson<String?>(json['descriptionKo']),
      nameZh: serializer.fromJson<String?>(json['nameZh']),
      descriptionZh: serializer.fromJson<String?>(json['descriptionZh']),
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
      'nameUk': serializer.toJson<String>(nameUk),
      'descriptionUk': serializer.toJson<String>(descriptionUk),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'nameEn': serializer.toJson<String?>(nameEn),
      'descriptionEn': serializer.toJson<String?>(descriptionEn),
      'namePl': serializer.toJson<String?>(namePl),
      'descriptionPl': serializer.toJson<String?>(descriptionPl),
      'nameDe': serializer.toJson<String?>(nameDe),
      'descriptionDe': serializer.toJson<String?>(descriptionDe),
      'nameFr': serializer.toJson<String?>(nameFr),
      'descriptionFr': serializer.toJson<String?>(descriptionFr),
      'nameEs': serializer.toJson<String?>(nameEs),
      'descriptionEs': serializer.toJson<String?>(descriptionEs),
      'nameIt': serializer.toJson<String?>(nameIt),
      'descriptionIt': serializer.toJson<String?>(descriptionIt),
      'namePt': serializer.toJson<String?>(namePt),
      'descriptionPt': serializer.toJson<String?>(descriptionPt),
      'nameRo': serializer.toJson<String?>(nameRo),
      'descriptionRo': serializer.toJson<String?>(descriptionRo),
      'nameTr': serializer.toJson<String?>(nameTr),
      'descriptionTr': serializer.toJson<String?>(descriptionTr),
      'nameJa': serializer.toJson<String?>(nameJa),
      'descriptionJa': serializer.toJson<String?>(descriptionJa),
      'nameKo': serializer.toJson<String?>(nameKo),
      'descriptionKo': serializer.toJson<String?>(descriptionKo),
      'nameZh': serializer.toJson<String?>(nameZh),
      'descriptionZh': serializer.toJson<String?>(descriptionZh),
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
    String? nameUk,
    String? descriptionUk,
    String? imageUrl,
    Value<String?> nameEn = const Value.absent(),
    Value<String?> descriptionEn = const Value.absent(),
    Value<String?> namePl = const Value.absent(),
    Value<String?> descriptionPl = const Value.absent(),
    Value<String?> nameDe = const Value.absent(),
    Value<String?> descriptionDe = const Value.absent(),
    Value<String?> nameFr = const Value.absent(),
    Value<String?> descriptionFr = const Value.absent(),
    Value<String?> nameEs = const Value.absent(),
    Value<String?> descriptionEs = const Value.absent(),
    Value<String?> nameIt = const Value.absent(),
    Value<String?> descriptionIt = const Value.absent(),
    Value<String?> namePt = const Value.absent(),
    Value<String?> descriptionPt = const Value.absent(),
    Value<String?> nameRo = const Value.absent(),
    Value<String?> descriptionRo = const Value.absent(),
    Value<String?> nameTr = const Value.absent(),
    Value<String?> descriptionTr = const Value.absent(),
    Value<String?> nameJa = const Value.absent(),
    Value<String?> descriptionJa = const Value.absent(),
    Value<String?> nameKo = const Value.absent(),
    Value<String?> descriptionKo = const Value.absent(),
    Value<String?> nameZh = const Value.absent(),
    Value<String?> descriptionZh = const Value.absent(),
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
    nameUk: nameUk ?? this.nameUk,
    descriptionUk: descriptionUk ?? this.descriptionUk,
    imageUrl: imageUrl ?? this.imageUrl,
    nameEn: nameEn.present ? nameEn.value : this.nameEn,
    descriptionEn: descriptionEn.present
        ? descriptionEn.value
        : this.descriptionEn,
    namePl: namePl.present ? namePl.value : this.namePl,
    descriptionPl: descriptionPl.present
        ? descriptionPl.value
        : this.descriptionPl,
    nameDe: nameDe.present ? nameDe.value : this.nameDe,
    descriptionDe: descriptionDe.present
        ? descriptionDe.value
        : this.descriptionDe,
    nameFr: nameFr.present ? nameFr.value : this.nameFr,
    descriptionFr: descriptionFr.present
        ? descriptionFr.value
        : this.descriptionFr,
    nameEs: nameEs.present ? nameEs.value : this.nameEs,
    descriptionEs: descriptionEs.present
        ? descriptionEs.value
        : this.descriptionEs,
    nameIt: nameIt.present ? nameIt.value : this.nameIt,
    descriptionIt: descriptionIt.present
        ? descriptionIt.value
        : this.descriptionIt,
    namePt: namePt.present ? namePt.value : this.namePt,
    descriptionPt: descriptionPt.present
        ? descriptionPt.value
        : this.descriptionPt,
    nameRo: nameRo.present ? nameRo.value : this.nameRo,
    descriptionRo: descriptionRo.present
        ? descriptionRo.value
        : this.descriptionRo,
    nameTr: nameTr.present ? nameTr.value : this.nameTr,
    descriptionTr: descriptionTr.present
        ? descriptionTr.value
        : this.descriptionTr,
    nameJa: nameJa.present ? nameJa.value : this.nameJa,
    descriptionJa: descriptionJa.present
        ? descriptionJa.value
        : this.descriptionJa,
    nameKo: nameKo.present ? nameKo.value : this.nameKo,
    descriptionKo: descriptionKo.present
        ? descriptionKo.value
        : this.descriptionKo,
    nameZh: nameZh.present ? nameZh.value : this.nameZh,
    descriptionZh: descriptionZh.present
        ? descriptionZh.value
        : this.descriptionZh,
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
      nameUk: data.nameUk.present ? data.nameUk.value : this.nameUk,
      descriptionUk: data.descriptionUk.present
          ? data.descriptionUk.value
          : this.descriptionUk,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      descriptionEn: data.descriptionEn.present
          ? data.descriptionEn.value
          : this.descriptionEn,
      namePl: data.namePl.present ? data.namePl.value : this.namePl,
      descriptionPl: data.descriptionPl.present
          ? data.descriptionPl.value
          : this.descriptionPl,
      nameDe: data.nameDe.present ? data.nameDe.value : this.nameDe,
      descriptionDe: data.descriptionDe.present
          ? data.descriptionDe.value
          : this.descriptionDe,
      nameFr: data.nameFr.present ? data.nameFr.value : this.nameFr,
      descriptionFr: data.descriptionFr.present
          ? data.descriptionFr.value
          : this.descriptionFr,
      nameEs: data.nameEs.present ? data.nameEs.value : this.nameEs,
      descriptionEs: data.descriptionEs.present
          ? data.descriptionEs.value
          : this.descriptionEs,
      nameIt: data.nameIt.present ? data.nameIt.value : this.nameIt,
      descriptionIt: data.descriptionIt.present
          ? data.descriptionIt.value
          : this.descriptionIt,
      namePt: data.namePt.present ? data.namePt.value : this.namePt,
      descriptionPt: data.descriptionPt.present
          ? data.descriptionPt.value
          : this.descriptionPt,
      nameRo: data.nameRo.present ? data.nameRo.value : this.nameRo,
      descriptionRo: data.descriptionRo.present
          ? data.descriptionRo.value
          : this.descriptionRo,
      nameTr: data.nameTr.present ? data.nameTr.value : this.nameTr,
      descriptionTr: data.descriptionTr.present
          ? data.descriptionTr.value
          : this.descriptionTr,
      nameJa: data.nameJa.present ? data.nameJa.value : this.nameJa,
      descriptionJa: data.descriptionJa.present
          ? data.descriptionJa.value
          : this.descriptionJa,
      nameKo: data.nameKo.present ? data.nameKo.value : this.nameKo,
      descriptionKo: data.descriptionKo.present
          ? data.descriptionKo.value
          : this.descriptionKo,
      nameZh: data.nameZh.present ? data.nameZh.value : this.nameZh,
      descriptionZh: data.descriptionZh.present
          ? data.descriptionZh.value
          : this.descriptionZh,
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
          ..write('nameUk: $nameUk, ')
          ..write('descriptionUk: $descriptionUk, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('nameEn: $nameEn, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('namePl: $namePl, ')
          ..write('descriptionPl: $descriptionPl, ')
          ..write('nameDe: $nameDe, ')
          ..write('descriptionDe: $descriptionDe, ')
          ..write('nameFr: $nameFr, ')
          ..write('descriptionFr: $descriptionFr, ')
          ..write('nameEs: $nameEs, ')
          ..write('descriptionEs: $descriptionEs, ')
          ..write('nameIt: $nameIt, ')
          ..write('descriptionIt: $descriptionIt, ')
          ..write('namePt: $namePt, ')
          ..write('descriptionPt: $descriptionPt, ')
          ..write('nameRo: $nameRo, ')
          ..write('descriptionRo: $descriptionRo, ')
          ..write('nameTr: $nameTr, ')
          ..write('descriptionTr: $descriptionTr, ')
          ..write('nameJa: $nameJa, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('nameKo: $nameKo, ')
          ..write('descriptionKo: $descriptionKo, ')
          ..write('nameZh: $nameZh, ')
          ..write('descriptionZh: $descriptionZh, ')
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
  int get hashCode => Object.hashAll([
    id,
    methodKey,
    nameUk,
    descriptionUk,
    imageUrl,
    nameEn,
    descriptionEn,
    namePl,
    descriptionPl,
    nameDe,
    descriptionDe,
    nameFr,
    descriptionFr,
    nameEs,
    descriptionEs,
    nameIt,
    descriptionIt,
    namePt,
    descriptionPt,
    nameRo,
    descriptionRo,
    nameTr,
    descriptionTr,
    nameJa,
    descriptionJa,
    nameKo,
    descriptionKo,
    nameZh,
    descriptionZh,
    ratioGramsPerMl,
    tempC,
    totalTimeSec,
    difficulty,
    stepsJson,
    flavorProfile,
    iconName,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrewingRecipe &&
          other.id == this.id &&
          other.methodKey == this.methodKey &&
          other.nameUk == this.nameUk &&
          other.descriptionUk == this.descriptionUk &&
          other.imageUrl == this.imageUrl &&
          other.nameEn == this.nameEn &&
          other.descriptionEn == this.descriptionEn &&
          other.namePl == this.namePl &&
          other.descriptionPl == this.descriptionPl &&
          other.nameDe == this.nameDe &&
          other.descriptionDe == this.descriptionDe &&
          other.nameFr == this.nameFr &&
          other.descriptionFr == this.descriptionFr &&
          other.nameEs == this.nameEs &&
          other.descriptionEs == this.descriptionEs &&
          other.nameIt == this.nameIt &&
          other.descriptionIt == this.descriptionIt &&
          other.namePt == this.namePt &&
          other.descriptionPt == this.descriptionPt &&
          other.nameRo == this.nameRo &&
          other.descriptionRo == this.descriptionRo &&
          other.nameTr == this.nameTr &&
          other.descriptionTr == this.descriptionTr &&
          other.nameJa == this.nameJa &&
          other.descriptionJa == this.descriptionJa &&
          other.nameKo == this.nameKo &&
          other.descriptionKo == this.descriptionKo &&
          other.nameZh == this.nameZh &&
          other.descriptionZh == this.descriptionZh &&
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
  final Value<String> nameUk;
  final Value<String> descriptionUk;
  final Value<String> imageUrl;
  final Value<String?> nameEn;
  final Value<String?> descriptionEn;
  final Value<String?> namePl;
  final Value<String?> descriptionPl;
  final Value<String?> nameDe;
  final Value<String?> descriptionDe;
  final Value<String?> nameFr;
  final Value<String?> descriptionFr;
  final Value<String?> nameEs;
  final Value<String?> descriptionEs;
  final Value<String?> nameIt;
  final Value<String?> descriptionIt;
  final Value<String?> namePt;
  final Value<String?> descriptionPt;
  final Value<String?> nameRo;
  final Value<String?> descriptionRo;
  final Value<String?> nameTr;
  final Value<String?> descriptionTr;
  final Value<String?> nameJa;
  final Value<String?> descriptionJa;
  final Value<String?> nameKo;
  final Value<String?> descriptionKo;
  final Value<String?> nameZh;
  final Value<String?> descriptionZh;
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
    this.nameUk = const Value.absent(),
    this.descriptionUk = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.namePl = const Value.absent(),
    this.descriptionPl = const Value.absent(),
    this.nameDe = const Value.absent(),
    this.descriptionDe = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.descriptionFr = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.descriptionEs = const Value.absent(),
    this.nameIt = const Value.absent(),
    this.descriptionIt = const Value.absent(),
    this.namePt = const Value.absent(),
    this.descriptionPt = const Value.absent(),
    this.nameRo = const Value.absent(),
    this.descriptionRo = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.descriptionTr = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.nameKo = const Value.absent(),
    this.descriptionKo = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.descriptionZh = const Value.absent(),
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
    this.nameUk = const Value.absent(),
    this.descriptionUk = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.namePl = const Value.absent(),
    this.descriptionPl = const Value.absent(),
    this.nameDe = const Value.absent(),
    this.descriptionDe = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.descriptionFr = const Value.absent(),
    this.nameEs = const Value.absent(),
    this.descriptionEs = const Value.absent(),
    this.nameIt = const Value.absent(),
    this.descriptionIt = const Value.absent(),
    this.namePt = const Value.absent(),
    this.descriptionPt = const Value.absent(),
    this.nameRo = const Value.absent(),
    this.descriptionRo = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.descriptionTr = const Value.absent(),
    this.nameJa = const Value.absent(),
    this.descriptionJa = const Value.absent(),
    this.nameKo = const Value.absent(),
    this.descriptionKo = const Value.absent(),
    this.nameZh = const Value.absent(),
    this.descriptionZh = const Value.absent(),
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
    Expression<String>? nameUk,
    Expression<String>? descriptionUk,
    Expression<String>? imageUrl,
    Expression<String>? nameEn,
    Expression<String>? descriptionEn,
    Expression<String>? namePl,
    Expression<String>? descriptionPl,
    Expression<String>? nameDe,
    Expression<String>? descriptionDe,
    Expression<String>? nameFr,
    Expression<String>? descriptionFr,
    Expression<String>? nameEs,
    Expression<String>? descriptionEs,
    Expression<String>? nameIt,
    Expression<String>? descriptionIt,
    Expression<String>? namePt,
    Expression<String>? descriptionPt,
    Expression<String>? nameRo,
    Expression<String>? descriptionRo,
    Expression<String>? nameTr,
    Expression<String>? descriptionTr,
    Expression<String>? nameJa,
    Expression<String>? descriptionJa,
    Expression<String>? nameKo,
    Expression<String>? descriptionKo,
    Expression<String>? nameZh,
    Expression<String>? descriptionZh,
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
      if (nameUk != null) 'name_uk': nameUk,
      if (descriptionUk != null) 'description_uk': descriptionUk,
      if (imageUrl != null) 'image_url': imageUrl,
      if (nameEn != null) 'name_en': nameEn,
      if (descriptionEn != null) 'description_en': descriptionEn,
      if (namePl != null) 'name_pl': namePl,
      if (descriptionPl != null) 'description_pl': descriptionPl,
      if (nameDe != null) 'name_de': nameDe,
      if (descriptionDe != null) 'description_de': descriptionDe,
      if (nameFr != null) 'name_fr': nameFr,
      if (descriptionFr != null) 'description_fr': descriptionFr,
      if (nameEs != null) 'name_es': nameEs,
      if (descriptionEs != null) 'description_es': descriptionEs,
      if (nameIt != null) 'name_it': nameIt,
      if (descriptionIt != null) 'description_it': descriptionIt,
      if (namePt != null) 'name_pt': namePt,
      if (descriptionPt != null) 'description_pt': descriptionPt,
      if (nameRo != null) 'name_ro': nameRo,
      if (descriptionRo != null) 'description_ro': descriptionRo,
      if (nameTr != null) 'name_tr': nameTr,
      if (descriptionTr != null) 'description_tr': descriptionTr,
      if (nameJa != null) 'name_ja': nameJa,
      if (descriptionJa != null) 'description_ja': descriptionJa,
      if (nameKo != null) 'name_ko': nameKo,
      if (descriptionKo != null) 'description_ko': descriptionKo,
      if (nameZh != null) 'name_zh': nameZh,
      if (descriptionZh != null) 'description_zh': descriptionZh,
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
    Value<String>? nameUk,
    Value<String>? descriptionUk,
    Value<String>? imageUrl,
    Value<String?>? nameEn,
    Value<String?>? descriptionEn,
    Value<String?>? namePl,
    Value<String?>? descriptionPl,
    Value<String?>? nameDe,
    Value<String?>? descriptionDe,
    Value<String?>? nameFr,
    Value<String?>? descriptionFr,
    Value<String?>? nameEs,
    Value<String?>? descriptionEs,
    Value<String?>? nameIt,
    Value<String?>? descriptionIt,
    Value<String?>? namePt,
    Value<String?>? descriptionPt,
    Value<String?>? nameRo,
    Value<String?>? descriptionRo,
    Value<String?>? nameTr,
    Value<String?>? descriptionTr,
    Value<String?>? nameJa,
    Value<String?>? descriptionJa,
    Value<String?>? nameKo,
    Value<String?>? descriptionKo,
    Value<String?>? nameZh,
    Value<String?>? descriptionZh,
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
      nameUk: nameUk ?? this.nameUk,
      descriptionUk: descriptionUk ?? this.descriptionUk,
      imageUrl: imageUrl ?? this.imageUrl,
      nameEn: nameEn ?? this.nameEn,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      namePl: namePl ?? this.namePl,
      descriptionPl: descriptionPl ?? this.descriptionPl,
      nameDe: nameDe ?? this.nameDe,
      descriptionDe: descriptionDe ?? this.descriptionDe,
      nameFr: nameFr ?? this.nameFr,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      nameEs: nameEs ?? this.nameEs,
      descriptionEs: descriptionEs ?? this.descriptionEs,
      nameIt: nameIt ?? this.nameIt,
      descriptionIt: descriptionIt ?? this.descriptionIt,
      namePt: namePt ?? this.namePt,
      descriptionPt: descriptionPt ?? this.descriptionPt,
      nameRo: nameRo ?? this.nameRo,
      descriptionRo: descriptionRo ?? this.descriptionRo,
      nameTr: nameTr ?? this.nameTr,
      descriptionTr: descriptionTr ?? this.descriptionTr,
      nameJa: nameJa ?? this.nameJa,
      descriptionJa: descriptionJa ?? this.descriptionJa,
      nameKo: nameKo ?? this.nameKo,
      descriptionKo: descriptionKo ?? this.descriptionKo,
      nameZh: nameZh ?? this.nameZh,
      descriptionZh: descriptionZh ?? this.descriptionZh,
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
    if (nameUk.present) {
      map['name_uk'] = Variable<String>(nameUk.value);
    }
    if (descriptionUk.present) {
      map['description_uk'] = Variable<String>(descriptionUk.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (descriptionEn.present) {
      map['description_en'] = Variable<String>(descriptionEn.value);
    }
    if (namePl.present) {
      map['name_pl'] = Variable<String>(namePl.value);
    }
    if (descriptionPl.present) {
      map['description_pl'] = Variable<String>(descriptionPl.value);
    }
    if (nameDe.present) {
      map['name_de'] = Variable<String>(nameDe.value);
    }
    if (descriptionDe.present) {
      map['description_de'] = Variable<String>(descriptionDe.value);
    }
    if (nameFr.present) {
      map['name_fr'] = Variable<String>(nameFr.value);
    }
    if (descriptionFr.present) {
      map['description_fr'] = Variable<String>(descriptionFr.value);
    }
    if (nameEs.present) {
      map['name_es'] = Variable<String>(nameEs.value);
    }
    if (descriptionEs.present) {
      map['description_es'] = Variable<String>(descriptionEs.value);
    }
    if (nameIt.present) {
      map['name_it'] = Variable<String>(nameIt.value);
    }
    if (descriptionIt.present) {
      map['description_it'] = Variable<String>(descriptionIt.value);
    }
    if (namePt.present) {
      map['name_pt'] = Variable<String>(namePt.value);
    }
    if (descriptionPt.present) {
      map['description_pt'] = Variable<String>(descriptionPt.value);
    }
    if (nameRo.present) {
      map['name_ro'] = Variable<String>(nameRo.value);
    }
    if (descriptionRo.present) {
      map['description_ro'] = Variable<String>(descriptionRo.value);
    }
    if (nameTr.present) {
      map['name_tr'] = Variable<String>(nameTr.value);
    }
    if (descriptionTr.present) {
      map['description_tr'] = Variable<String>(descriptionTr.value);
    }
    if (nameJa.present) {
      map['name_ja'] = Variable<String>(nameJa.value);
    }
    if (descriptionJa.present) {
      map['description_ja'] = Variable<String>(descriptionJa.value);
    }
    if (nameKo.present) {
      map['name_ko'] = Variable<String>(nameKo.value);
    }
    if (descriptionKo.present) {
      map['description_ko'] = Variable<String>(descriptionKo.value);
    }
    if (nameZh.present) {
      map['name_zh'] = Variable<String>(nameZh.value);
    }
    if (descriptionZh.present) {
      map['description_zh'] = Variable<String>(descriptionZh.value);
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
          ..write('nameUk: $nameUk, ')
          ..write('descriptionUk: $descriptionUk, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('nameEn: $nameEn, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('namePl: $namePl, ')
          ..write('descriptionPl: $descriptionPl, ')
          ..write('nameDe: $nameDe, ')
          ..write('descriptionDe: $descriptionDe, ')
          ..write('nameFr: $nameFr, ')
          ..write('descriptionFr: $descriptionFr, ')
          ..write('nameEs: $nameEs, ')
          ..write('descriptionEs: $descriptionEs, ')
          ..write('nameIt: $nameIt, ')
          ..write('descriptionIt: $descriptionIt, ')
          ..write('namePt: $namePt, ')
          ..write('descriptionPt: $descriptionPt, ')
          ..write('nameRo: $nameRo, ')
          ..write('descriptionRo: $descriptionRo, ')
          ..write('nameTr: $nameTr, ')
          ..write('descriptionTr: $descriptionTr, ')
          ..write('nameJa: $nameJa, ')
          ..write('descriptionJa: $descriptionJa, ')
          ..write('nameKo: $nameKo, ')
          ..write('descriptionKo: $descriptionKo, ')
          ..write('nameZh: $nameZh, ')
          ..write('descriptionZh: $descriptionZh, ')
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
          ..write('isSynced: $isSynced, ')
          ..write('isDeletedLocal: $isDeletedLocal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
    isSynced,
    isDeletedLocal,
  );
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
          ..write('isSynced: $isSynced, ')
          ..write('isDeletedLocal: $isDeletedLocal, ')
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
  late final $SphereRegionsTable sphereRegions = $SphereRegionsTable(this);
  late final $SphereRegionTranslationsTable sphereRegionTranslations =
      $SphereRegionTranslationsTable(this);
  late final $SpecialtyArticlesTable specialtyArticles =
      $SpecialtyArticlesTable(this);
  late final $CoffeeLotsTable coffeeLots = $CoffeeLotsTable(this);
  late final $FermentationLogsTable fermentationLogs = $FermentationLogsTable(
    this,
  );
  late final $BrewingRecipesTable brewingRecipes = $BrewingRecipesTable(this);
  late final $RecommendedRecipesTable recommendedRecipes =
      $RecommendedRecipesTable(this);
  late final $CustomRecipesTable customRecipes = $CustomRecipesTable(this);
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
    sphereRegions,
    sphereRegionTranslations,
    specialtyArticles,
    coffeeLots,
    fermentationLogs,
    brewingRecipes,
    recommendedRecipes,
    customRecipes,
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
    });
typedef $$LocalizedBrandsTableUpdateCompanionBuilder =
    LocalizedBrandsCompanion Function({
      Value<int> id,
      Value<String?> userId,
      Value<String> name,
      Value<String?> logoUrl,
      Value<String?> siteUrl,
      Value<DateTime?> createdAt,
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
              }) => LocalizedBrandsCompanion(
                id: id,
                userId: userId,
                name: name,
                logoUrl: logoUrl,
                siteUrl: siteUrl,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                required String name,
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> siteUrl = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedBrandsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                logoUrl: logoUrl,
                siteUrl: siteUrl,
                createdAt: createdAt,
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
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localizedBeansRefs) db.localizedBeans,
                    if (localizedBrandTranslationsRefs)
                      db.localizedBrandTranslations,
                    if (coffeeLotsRefs) db.coffeeLots,
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
      })
    >;
typedef $$LocalizedFarmersTableCreateCompanionBuilder =
    LocalizedFarmersCompanion Function({
      Value<int> id,
      Value<String> nameUk,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<String> descriptionHtmlUk,
      Value<String?> regionUk,
      Value<String?> countryUk,
      Value<String?> nameEn,
      Value<String?> descriptionHtmlEn,
      Value<String?> regionEn,
      Value<String?> countryEn,
      Value<String?> namePl,
      Value<String?> descriptionHtmlPl,
      Value<String?> nameDe,
      Value<String?> descriptionHtmlDe,
      Value<String?> nameFr,
      Value<String?> descriptionHtmlFr,
      Value<String?> nameEs,
      Value<String?> descriptionHtmlEs,
      Value<String?> nameIt,
      Value<String?> descriptionHtmlIt,
      Value<String?> namePt,
      Value<String?> descriptionHtmlPt,
      Value<String?> nameRo,
      Value<String?> descriptionHtmlRo,
      Value<String?> nameTr,
      Value<String?> descriptionHtmlTr,
      Value<String?> nameJa,
      Value<String?> descriptionHtmlJa,
      Value<String?> nameKo,
      Value<String?> descriptionHtmlKo,
      Value<String?> nameZh,
      Value<String?> descriptionHtmlZh,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<DateTime?> createdAt,
    });
typedef $$LocalizedFarmersTableUpdateCompanionBuilder =
    LocalizedFarmersCompanion Function({
      Value<int> id,
      Value<String> nameUk,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<String> descriptionHtmlUk,
      Value<String?> regionUk,
      Value<String?> countryUk,
      Value<String?> nameEn,
      Value<String?> descriptionHtmlEn,
      Value<String?> regionEn,
      Value<String?> countryEn,
      Value<String?> namePl,
      Value<String?> descriptionHtmlPl,
      Value<String?> nameDe,
      Value<String?> descriptionHtmlDe,
      Value<String?> nameFr,
      Value<String?> descriptionHtmlFr,
      Value<String?> nameEs,
      Value<String?> descriptionHtmlEs,
      Value<String?> nameIt,
      Value<String?> descriptionHtmlIt,
      Value<String?> namePt,
      Value<String?> descriptionHtmlPt,
      Value<String?> nameRo,
      Value<String?> descriptionHtmlRo,
      Value<String?> nameTr,
      Value<String?> descriptionHtmlTr,
      Value<String?> nameJa,
      Value<String?> descriptionHtmlJa,
      Value<String?> nameKo,
      Value<String?> descriptionHtmlKo,
      Value<String?> nameZh,
      Value<String?> descriptionHtmlZh,
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

  ColumnFilters<String> get nameUk => $composableBuilder(
    column: $table.nameUk,
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

  ColumnFilters<String> get descriptionHtmlUk => $composableBuilder(
    column: $table.descriptionHtmlUk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regionUk => $composableBuilder(
    column: $table.regionUk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryUk => $composableBuilder(
    column: $table.countryUk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlEn => $composableBuilder(
    column: $table.descriptionHtmlEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regionEn => $composableBuilder(
    column: $table.regionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryEn => $composableBuilder(
    column: $table.countryEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namePl => $composableBuilder(
    column: $table.namePl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlPl => $composableBuilder(
    column: $table.descriptionHtmlPl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameDe => $composableBuilder(
    column: $table.nameDe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlDe => $composableBuilder(
    column: $table.descriptionHtmlDe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameFr => $composableBuilder(
    column: $table.nameFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlFr => $composableBuilder(
    column: $table.descriptionHtmlFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlEs => $composableBuilder(
    column: $table.descriptionHtmlEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameIt => $composableBuilder(
    column: $table.nameIt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlIt => $composableBuilder(
    column: $table.descriptionHtmlIt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namePt => $composableBuilder(
    column: $table.namePt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlPt => $composableBuilder(
    column: $table.descriptionHtmlPt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameRo => $composableBuilder(
    column: $table.nameRo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlRo => $composableBuilder(
    column: $table.descriptionHtmlRo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlTr => $composableBuilder(
    column: $table.descriptionHtmlTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlJa => $composableBuilder(
    column: $table.descriptionHtmlJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameKo => $composableBuilder(
    column: $table.nameKo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlKo => $composableBuilder(
    column: $table.descriptionHtmlKo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionHtmlZh => $composableBuilder(
    column: $table.descriptionHtmlZh,
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

  ColumnOrderings<String> get nameUk => $composableBuilder(
    column: $table.nameUk,
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

  ColumnOrderings<String> get descriptionHtmlUk => $composableBuilder(
    column: $table.descriptionHtmlUk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regionUk => $composableBuilder(
    column: $table.regionUk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryUk => $composableBuilder(
    column: $table.countryUk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlEn => $composableBuilder(
    column: $table.descriptionHtmlEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regionEn => $composableBuilder(
    column: $table.regionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryEn => $composableBuilder(
    column: $table.countryEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namePl => $composableBuilder(
    column: $table.namePl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlPl => $composableBuilder(
    column: $table.descriptionHtmlPl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameDe => $composableBuilder(
    column: $table.nameDe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlDe => $composableBuilder(
    column: $table.descriptionHtmlDe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameFr => $composableBuilder(
    column: $table.nameFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlFr => $composableBuilder(
    column: $table.descriptionHtmlFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlEs => $composableBuilder(
    column: $table.descriptionHtmlEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameIt => $composableBuilder(
    column: $table.nameIt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlIt => $composableBuilder(
    column: $table.descriptionHtmlIt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namePt => $composableBuilder(
    column: $table.namePt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlPt => $composableBuilder(
    column: $table.descriptionHtmlPt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameRo => $composableBuilder(
    column: $table.nameRo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlRo => $composableBuilder(
    column: $table.descriptionHtmlRo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlTr => $composableBuilder(
    column: $table.descriptionHtmlTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlJa => $composableBuilder(
    column: $table.descriptionHtmlJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameKo => $composableBuilder(
    column: $table.nameKo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlKo => $composableBuilder(
    column: $table.descriptionHtmlKo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionHtmlZh => $composableBuilder(
    column: $table.descriptionHtmlZh,
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

  GeneratedColumn<String> get nameUk =>
      $composableBuilder(column: $table.nameUk, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get flagUrl =>
      $composableBuilder(column: $table.flagUrl, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlUk => $composableBuilder(
    column: $table.descriptionHtmlUk,
    builder: (column) => column,
  );

  GeneratedColumn<String> get regionUk =>
      $composableBuilder(column: $table.regionUk, builder: (column) => column);

  GeneratedColumn<String> get countryUk =>
      $composableBuilder(column: $table.countryUk, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlEn => $composableBuilder(
    column: $table.descriptionHtmlEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get regionEn =>
      $composableBuilder(column: $table.regionEn, builder: (column) => column);

  GeneratedColumn<String> get countryEn =>
      $composableBuilder(column: $table.countryEn, builder: (column) => column);

  GeneratedColumn<String> get namePl =>
      $composableBuilder(column: $table.namePl, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlPl => $composableBuilder(
    column: $table.descriptionHtmlPl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameDe =>
      $composableBuilder(column: $table.nameDe, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlDe => $composableBuilder(
    column: $table.descriptionHtmlDe,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameFr =>
      $composableBuilder(column: $table.nameFr, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlFr => $composableBuilder(
    column: $table.descriptionHtmlFr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlEs => $composableBuilder(
    column: $table.descriptionHtmlEs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameIt =>
      $composableBuilder(column: $table.nameIt, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlIt => $composableBuilder(
    column: $table.descriptionHtmlIt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get namePt =>
      $composableBuilder(column: $table.namePt, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlPt => $composableBuilder(
    column: $table.descriptionHtmlPt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameRo =>
      $composableBuilder(column: $table.nameRo, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlRo => $composableBuilder(
    column: $table.descriptionHtmlRo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameTr =>
      $composableBuilder(column: $table.nameTr, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlTr => $composableBuilder(
    column: $table.descriptionHtmlTr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlJa => $composableBuilder(
    column: $table.descriptionHtmlJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameKo =>
      $composableBuilder(column: $table.nameKo, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlKo => $composableBuilder(
    column: $table.descriptionHtmlKo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  GeneratedColumn<String> get descriptionHtmlZh => $composableBuilder(
    column: $table.descriptionHtmlZh,
    builder: (column) => column,
  );

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
          PrefetchHooks Function({bool localizedBeansRefs})
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
                Value<String> nameUk = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<String> descriptionHtmlUk = const Value.absent(),
                Value<String?> regionUk = const Value.absent(),
                Value<String?> countryUk = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> descriptionHtmlEn = const Value.absent(),
                Value<String?> regionEn = const Value.absent(),
                Value<String?> countryEn = const Value.absent(),
                Value<String?> namePl = const Value.absent(),
                Value<String?> descriptionHtmlPl = const Value.absent(),
                Value<String?> nameDe = const Value.absent(),
                Value<String?> descriptionHtmlDe = const Value.absent(),
                Value<String?> nameFr = const Value.absent(),
                Value<String?> descriptionHtmlFr = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<String?> descriptionHtmlEs = const Value.absent(),
                Value<String?> nameIt = const Value.absent(),
                Value<String?> descriptionHtmlIt = const Value.absent(),
                Value<String?> namePt = const Value.absent(),
                Value<String?> descriptionHtmlPt = const Value.absent(),
                Value<String?> nameRo = const Value.absent(),
                Value<String?> descriptionHtmlRo = const Value.absent(),
                Value<String?> nameTr = const Value.absent(),
                Value<String?> descriptionHtmlTr = const Value.absent(),
                Value<String?> nameJa = const Value.absent(),
                Value<String?> descriptionHtmlJa = const Value.absent(),
                Value<String?> nameKo = const Value.absent(),
                Value<String?> descriptionHtmlKo = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<String?> descriptionHtmlZh = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedFarmersCompanion(
                id: id,
                nameUk: nameUk,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                descriptionHtmlUk: descriptionHtmlUk,
                regionUk: regionUk,
                countryUk: countryUk,
                nameEn: nameEn,
                descriptionHtmlEn: descriptionHtmlEn,
                regionEn: regionEn,
                countryEn: countryEn,
                namePl: namePl,
                descriptionHtmlPl: descriptionHtmlPl,
                nameDe: nameDe,
                descriptionHtmlDe: descriptionHtmlDe,
                nameFr: nameFr,
                descriptionHtmlFr: descriptionHtmlFr,
                nameEs: nameEs,
                descriptionHtmlEs: descriptionHtmlEs,
                nameIt: nameIt,
                descriptionHtmlIt: descriptionHtmlIt,
                namePt: namePt,
                descriptionHtmlPt: descriptionHtmlPt,
                nameRo: nameRo,
                descriptionHtmlRo: descriptionHtmlRo,
                nameTr: nameTr,
                descriptionHtmlTr: descriptionHtmlTr,
                nameJa: nameJa,
                descriptionHtmlJa: descriptionHtmlJa,
                nameKo: nameKo,
                descriptionHtmlKo: descriptionHtmlKo,
                nameZh: nameZh,
                descriptionHtmlZh: descriptionHtmlZh,
                latitude: latitude,
                longitude: longitude,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameUk = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<String> descriptionHtmlUk = const Value.absent(),
                Value<String?> regionUk = const Value.absent(),
                Value<String?> countryUk = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> descriptionHtmlEn = const Value.absent(),
                Value<String?> regionEn = const Value.absent(),
                Value<String?> countryEn = const Value.absent(),
                Value<String?> namePl = const Value.absent(),
                Value<String?> descriptionHtmlPl = const Value.absent(),
                Value<String?> nameDe = const Value.absent(),
                Value<String?> descriptionHtmlDe = const Value.absent(),
                Value<String?> nameFr = const Value.absent(),
                Value<String?> descriptionHtmlFr = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<String?> descriptionHtmlEs = const Value.absent(),
                Value<String?> nameIt = const Value.absent(),
                Value<String?> descriptionHtmlIt = const Value.absent(),
                Value<String?> namePt = const Value.absent(),
                Value<String?> descriptionHtmlPt = const Value.absent(),
                Value<String?> nameRo = const Value.absent(),
                Value<String?> descriptionHtmlRo = const Value.absent(),
                Value<String?> nameTr = const Value.absent(),
                Value<String?> descriptionHtmlTr = const Value.absent(),
                Value<String?> nameJa = const Value.absent(),
                Value<String?> descriptionHtmlJa = const Value.absent(),
                Value<String?> nameKo = const Value.absent(),
                Value<String?> descriptionHtmlKo = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<String?> descriptionHtmlZh = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => LocalizedFarmersCompanion.insert(
                id: id,
                nameUk: nameUk,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                descriptionHtmlUk: descriptionHtmlUk,
                regionUk: regionUk,
                countryUk: countryUk,
                nameEn: nameEn,
                descriptionHtmlEn: descriptionHtmlEn,
                regionEn: regionEn,
                countryEn: countryEn,
                namePl: namePl,
                descriptionHtmlPl: descriptionHtmlPl,
                nameDe: nameDe,
                descriptionHtmlDe: descriptionHtmlDe,
                nameFr: nameFr,
                descriptionHtmlFr: descriptionHtmlFr,
                nameEs: nameEs,
                descriptionHtmlEs: descriptionHtmlEs,
                nameIt: nameIt,
                descriptionHtmlIt: descriptionHtmlIt,
                namePt: namePt,
                descriptionHtmlPt: descriptionHtmlPt,
                nameRo: nameRo,
                descriptionHtmlRo: descriptionHtmlRo,
                nameTr: nameTr,
                descriptionHtmlTr: descriptionHtmlTr,
                nameJa: nameJa,
                descriptionHtmlJa: descriptionHtmlJa,
                nameKo: nameKo,
                descriptionHtmlKo: descriptionHtmlKo,
                nameZh: nameZh,
                descriptionHtmlZh: descriptionHtmlZh,
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
          prefetchHooksCallback: ({localizedBeansRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localizedBeansRefs) db.localizedBeans,
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
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.farmerId == item.id),
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
      PrefetchHooks Function({bool localizedBeansRefs})
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
      Value<String> titleUk,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<String> contentHtmlUk,
      Value<int> readTimeMin,
      Value<String?> titleEn,
      Value<String?> contentHtmlEn,
      Value<String?> titlePl,
      Value<String?> contentHtmlPl,
      Value<String?> titleDe,
      Value<String?> contentHtmlDe,
      Value<String?> titleFr,
      Value<String?> contentHtmlFr,
      Value<String?> titleEs,
      Value<String?> contentHtmlEs,
      Value<String?> titleIt,
      Value<String?> contentHtmlIt,
      Value<String?> titlePt,
      Value<String?> contentHtmlPt,
      Value<String?> titleRo,
      Value<String?> contentHtmlRo,
      Value<String?> titleTr,
      Value<String?> contentHtmlTr,
      Value<String?> titleJa,
      Value<String?> contentHtmlJa,
      Value<String?> titleKo,
      Value<String?> contentHtmlKo,
      Value<String?> titleZh,
      Value<String?> contentHtmlZh,
    });
typedef $$SpecialtyArticlesTableUpdateCompanionBuilder =
    SpecialtyArticlesCompanion Function({
      Value<int> id,
      Value<String> titleUk,
      Value<String> imageUrl,
      Value<String> flagUrl,
      Value<String> contentHtmlUk,
      Value<int> readTimeMin,
      Value<String?> titleEn,
      Value<String?> contentHtmlEn,
      Value<String?> titlePl,
      Value<String?> contentHtmlPl,
      Value<String?> titleDe,
      Value<String?> contentHtmlDe,
      Value<String?> titleFr,
      Value<String?> contentHtmlFr,
      Value<String?> titleEs,
      Value<String?> contentHtmlEs,
      Value<String?> titleIt,
      Value<String?> contentHtmlIt,
      Value<String?> titlePt,
      Value<String?> contentHtmlPt,
      Value<String?> titleRo,
      Value<String?> contentHtmlRo,
      Value<String?> titleTr,
      Value<String?> contentHtmlTr,
      Value<String?> titleJa,
      Value<String?> contentHtmlJa,
      Value<String?> titleKo,
      Value<String?> contentHtmlKo,
      Value<String?> titleZh,
      Value<String?> contentHtmlZh,
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

  ColumnFilters<String> get titleUk => $composableBuilder(
    column: $table.titleUk,
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

  ColumnFilters<String> get contentHtmlUk => $composableBuilder(
    column: $table.contentHtmlUk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlEn => $composableBuilder(
    column: $table.contentHtmlEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titlePl => $composableBuilder(
    column: $table.titlePl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlPl => $composableBuilder(
    column: $table.contentHtmlPl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleDe => $composableBuilder(
    column: $table.titleDe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlDe => $composableBuilder(
    column: $table.contentHtmlDe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleFr => $composableBuilder(
    column: $table.titleFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlFr => $composableBuilder(
    column: $table.contentHtmlFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEs => $composableBuilder(
    column: $table.titleEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlEs => $composableBuilder(
    column: $table.contentHtmlEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleIt => $composableBuilder(
    column: $table.titleIt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlIt => $composableBuilder(
    column: $table.contentHtmlIt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titlePt => $composableBuilder(
    column: $table.titlePt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlPt => $composableBuilder(
    column: $table.contentHtmlPt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleRo => $composableBuilder(
    column: $table.titleRo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlRo => $composableBuilder(
    column: $table.contentHtmlRo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleTr => $composableBuilder(
    column: $table.titleTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlTr => $composableBuilder(
    column: $table.contentHtmlTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleJa => $composableBuilder(
    column: $table.titleJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlJa => $composableBuilder(
    column: $table.contentHtmlJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleKo => $composableBuilder(
    column: $table.titleKo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlKo => $composableBuilder(
    column: $table.contentHtmlKo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleZh => $composableBuilder(
    column: $table.titleZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHtmlZh => $composableBuilder(
    column: $table.contentHtmlZh,
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

  ColumnOrderings<String> get titleUk => $composableBuilder(
    column: $table.titleUk,
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

  ColumnOrderings<String> get contentHtmlUk => $composableBuilder(
    column: $table.contentHtmlUk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlEn => $composableBuilder(
    column: $table.contentHtmlEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titlePl => $composableBuilder(
    column: $table.titlePl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlPl => $composableBuilder(
    column: $table.contentHtmlPl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleDe => $composableBuilder(
    column: $table.titleDe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlDe => $composableBuilder(
    column: $table.contentHtmlDe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleFr => $composableBuilder(
    column: $table.titleFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlFr => $composableBuilder(
    column: $table.contentHtmlFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEs => $composableBuilder(
    column: $table.titleEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlEs => $composableBuilder(
    column: $table.contentHtmlEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleIt => $composableBuilder(
    column: $table.titleIt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlIt => $composableBuilder(
    column: $table.contentHtmlIt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titlePt => $composableBuilder(
    column: $table.titlePt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlPt => $composableBuilder(
    column: $table.contentHtmlPt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleRo => $composableBuilder(
    column: $table.titleRo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlRo => $composableBuilder(
    column: $table.contentHtmlRo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleTr => $composableBuilder(
    column: $table.titleTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlTr => $composableBuilder(
    column: $table.contentHtmlTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleJa => $composableBuilder(
    column: $table.titleJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlJa => $composableBuilder(
    column: $table.contentHtmlJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleKo => $composableBuilder(
    column: $table.titleKo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlKo => $composableBuilder(
    column: $table.contentHtmlKo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleZh => $composableBuilder(
    column: $table.titleZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHtmlZh => $composableBuilder(
    column: $table.contentHtmlZh,
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

  GeneratedColumn<String> get titleUk =>
      $composableBuilder(column: $table.titleUk, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get flagUrl =>
      $composableBuilder(column: $table.flagUrl, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlUk => $composableBuilder(
    column: $table.contentHtmlUk,
    builder: (column) => column,
  );

  GeneratedColumn<int> get readTimeMin => $composableBuilder(
    column: $table.readTimeMin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlEn => $composableBuilder(
    column: $table.contentHtmlEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titlePl =>
      $composableBuilder(column: $table.titlePl, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlPl => $composableBuilder(
    column: $table.contentHtmlPl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleDe =>
      $composableBuilder(column: $table.titleDe, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlDe => $composableBuilder(
    column: $table.contentHtmlDe,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleFr =>
      $composableBuilder(column: $table.titleFr, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlFr => $composableBuilder(
    column: $table.contentHtmlFr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleEs =>
      $composableBuilder(column: $table.titleEs, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlEs => $composableBuilder(
    column: $table.contentHtmlEs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleIt =>
      $composableBuilder(column: $table.titleIt, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlIt => $composableBuilder(
    column: $table.contentHtmlIt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titlePt =>
      $composableBuilder(column: $table.titlePt, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlPt => $composableBuilder(
    column: $table.contentHtmlPt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleRo =>
      $composableBuilder(column: $table.titleRo, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlRo => $composableBuilder(
    column: $table.contentHtmlRo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleTr =>
      $composableBuilder(column: $table.titleTr, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlTr => $composableBuilder(
    column: $table.contentHtmlTr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleJa =>
      $composableBuilder(column: $table.titleJa, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlJa => $composableBuilder(
    column: $table.contentHtmlJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleKo =>
      $composableBuilder(column: $table.titleKo, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlKo => $composableBuilder(
    column: $table.contentHtmlKo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleZh =>
      $composableBuilder(column: $table.titleZh, builder: (column) => column);

  GeneratedColumn<String> get contentHtmlZh => $composableBuilder(
    column: $table.contentHtmlZh,
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
                Value<String> titleUk = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<String> contentHtmlUk = const Value.absent(),
                Value<int> readTimeMin = const Value.absent(),
                Value<String?> titleEn = const Value.absent(),
                Value<String?> contentHtmlEn = const Value.absent(),
                Value<String?> titlePl = const Value.absent(),
                Value<String?> contentHtmlPl = const Value.absent(),
                Value<String?> titleDe = const Value.absent(),
                Value<String?> contentHtmlDe = const Value.absent(),
                Value<String?> titleFr = const Value.absent(),
                Value<String?> contentHtmlFr = const Value.absent(),
                Value<String?> titleEs = const Value.absent(),
                Value<String?> contentHtmlEs = const Value.absent(),
                Value<String?> titleIt = const Value.absent(),
                Value<String?> contentHtmlIt = const Value.absent(),
                Value<String?> titlePt = const Value.absent(),
                Value<String?> contentHtmlPt = const Value.absent(),
                Value<String?> titleRo = const Value.absent(),
                Value<String?> contentHtmlRo = const Value.absent(),
                Value<String?> titleTr = const Value.absent(),
                Value<String?> contentHtmlTr = const Value.absent(),
                Value<String?> titleJa = const Value.absent(),
                Value<String?> contentHtmlJa = const Value.absent(),
                Value<String?> titleKo = const Value.absent(),
                Value<String?> contentHtmlKo = const Value.absent(),
                Value<String?> titleZh = const Value.absent(),
                Value<String?> contentHtmlZh = const Value.absent(),
              }) => SpecialtyArticlesCompanion(
                id: id,
                titleUk: titleUk,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                contentHtmlUk: contentHtmlUk,
                readTimeMin: readTimeMin,
                titleEn: titleEn,
                contentHtmlEn: contentHtmlEn,
                titlePl: titlePl,
                contentHtmlPl: contentHtmlPl,
                titleDe: titleDe,
                contentHtmlDe: contentHtmlDe,
                titleFr: titleFr,
                contentHtmlFr: contentHtmlFr,
                titleEs: titleEs,
                contentHtmlEs: contentHtmlEs,
                titleIt: titleIt,
                contentHtmlIt: contentHtmlIt,
                titlePt: titlePt,
                contentHtmlPt: contentHtmlPt,
                titleRo: titleRo,
                contentHtmlRo: contentHtmlRo,
                titleTr: titleTr,
                contentHtmlTr: contentHtmlTr,
                titleJa: titleJa,
                contentHtmlJa: contentHtmlJa,
                titleKo: titleKo,
                contentHtmlKo: contentHtmlKo,
                titleZh: titleZh,
                contentHtmlZh: contentHtmlZh,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> titleUk = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> flagUrl = const Value.absent(),
                Value<String> contentHtmlUk = const Value.absent(),
                Value<int> readTimeMin = const Value.absent(),
                Value<String?> titleEn = const Value.absent(),
                Value<String?> contentHtmlEn = const Value.absent(),
                Value<String?> titlePl = const Value.absent(),
                Value<String?> contentHtmlPl = const Value.absent(),
                Value<String?> titleDe = const Value.absent(),
                Value<String?> contentHtmlDe = const Value.absent(),
                Value<String?> titleFr = const Value.absent(),
                Value<String?> contentHtmlFr = const Value.absent(),
                Value<String?> titleEs = const Value.absent(),
                Value<String?> contentHtmlEs = const Value.absent(),
                Value<String?> titleIt = const Value.absent(),
                Value<String?> contentHtmlIt = const Value.absent(),
                Value<String?> titlePt = const Value.absent(),
                Value<String?> contentHtmlPt = const Value.absent(),
                Value<String?> titleRo = const Value.absent(),
                Value<String?> contentHtmlRo = const Value.absent(),
                Value<String?> titleTr = const Value.absent(),
                Value<String?> contentHtmlTr = const Value.absent(),
                Value<String?> titleJa = const Value.absent(),
                Value<String?> contentHtmlJa = const Value.absent(),
                Value<String?> titleKo = const Value.absent(),
                Value<String?> contentHtmlKo = const Value.absent(),
                Value<String?> titleZh = const Value.absent(),
                Value<String?> contentHtmlZh = const Value.absent(),
              }) => SpecialtyArticlesCompanion.insert(
                id: id,
                titleUk: titleUk,
                imageUrl: imageUrl,
                flagUrl: flagUrl,
                contentHtmlUk: contentHtmlUk,
                readTimeMin: readTimeMin,
                titleEn: titleEn,
                contentHtmlEn: contentHtmlEn,
                titlePl: titlePl,
                contentHtmlPl: contentHtmlPl,
                titleDe: titleDe,
                contentHtmlDe: contentHtmlDe,
                titleFr: titleFr,
                contentHtmlFr: contentHtmlFr,
                titleEs: titleEs,
                contentHtmlEs: contentHtmlEs,
                titleIt: titleIt,
                contentHtmlIt: contentHtmlIt,
                titlePt: titlePt,
                contentHtmlPt: contentHtmlPt,
                titleRo: titleRo,
                contentHtmlRo: contentHtmlRo,
                titleTr: titleTr,
                contentHtmlTr: contentHtmlTr,
                titleJa: titleJa,
                contentHtmlJa: contentHtmlJa,
                titleKo: titleKo,
                contentHtmlKo: contentHtmlKo,
                titleZh: titleZh,
                contentHtmlZh: contentHtmlZh,
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
      Value<String> nameUk,
      Value<String> descriptionUk,
      Value<String> imageUrl,
      Value<String?> nameEn,
      Value<String?> descriptionEn,
      Value<String?> namePl,
      Value<String?> descriptionPl,
      Value<String?> nameDe,
      Value<String?> descriptionDe,
      Value<String?> nameFr,
      Value<String?> descriptionFr,
      Value<String?> nameEs,
      Value<String?> descriptionEs,
      Value<String?> nameIt,
      Value<String?> descriptionIt,
      Value<String?> namePt,
      Value<String?> descriptionPt,
      Value<String?> nameRo,
      Value<String?> descriptionRo,
      Value<String?> nameTr,
      Value<String?> descriptionTr,
      Value<String?> nameJa,
      Value<String?> descriptionJa,
      Value<String?> nameKo,
      Value<String?> descriptionKo,
      Value<String?> nameZh,
      Value<String?> descriptionZh,
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
      Value<String> nameUk,
      Value<String> descriptionUk,
      Value<String> imageUrl,
      Value<String?> nameEn,
      Value<String?> descriptionEn,
      Value<String?> namePl,
      Value<String?> descriptionPl,
      Value<String?> nameDe,
      Value<String?> descriptionDe,
      Value<String?> nameFr,
      Value<String?> descriptionFr,
      Value<String?> nameEs,
      Value<String?> descriptionEs,
      Value<String?> nameIt,
      Value<String?> descriptionIt,
      Value<String?> namePt,
      Value<String?> descriptionPt,
      Value<String?> nameRo,
      Value<String?> descriptionRo,
      Value<String?> nameTr,
      Value<String?> descriptionTr,
      Value<String?> nameJa,
      Value<String?> descriptionJa,
      Value<String?> nameKo,
      Value<String?> descriptionKo,
      Value<String?> nameZh,
      Value<String?> descriptionZh,
      Value<double> ratioGramsPerMl,
      Value<double> tempC,
      Value<int> totalTimeSec,
      Value<String> difficulty,
      Value<String> stepsJson,
      Value<String> flavorProfile,
      Value<String?> iconName,
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

  ColumnFilters<String> get nameUk => $composableBuilder(
    column: $table.nameUk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionUk => $composableBuilder(
    column: $table.descriptionUk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namePl => $composableBuilder(
    column: $table.namePl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionPl => $composableBuilder(
    column: $table.descriptionPl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameDe => $composableBuilder(
    column: $table.nameDe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionDe => $composableBuilder(
    column: $table.descriptionDe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameFr => $composableBuilder(
    column: $table.nameFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionFr => $composableBuilder(
    column: $table.descriptionFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionEs => $composableBuilder(
    column: $table.descriptionEs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameIt => $composableBuilder(
    column: $table.nameIt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionIt => $composableBuilder(
    column: $table.descriptionIt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namePt => $composableBuilder(
    column: $table.namePt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionPt => $composableBuilder(
    column: $table.descriptionPt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameRo => $composableBuilder(
    column: $table.nameRo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionRo => $composableBuilder(
    column: $table.descriptionRo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionTr => $composableBuilder(
    column: $table.descriptionTr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameKo => $composableBuilder(
    column: $table.nameKo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionKo => $composableBuilder(
    column: $table.descriptionKo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
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

  ColumnOrderings<String> get nameUk => $composableBuilder(
    column: $table.nameUk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionUk => $composableBuilder(
    column: $table.descriptionUk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namePl => $composableBuilder(
    column: $table.namePl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionPl => $composableBuilder(
    column: $table.descriptionPl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameDe => $composableBuilder(
    column: $table.nameDe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionDe => $composableBuilder(
    column: $table.descriptionDe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameFr => $composableBuilder(
    column: $table.nameFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionFr => $composableBuilder(
    column: $table.descriptionFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEs => $composableBuilder(
    column: $table.nameEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionEs => $composableBuilder(
    column: $table.descriptionEs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameIt => $composableBuilder(
    column: $table.nameIt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionIt => $composableBuilder(
    column: $table.descriptionIt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namePt => $composableBuilder(
    column: $table.namePt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionPt => $composableBuilder(
    column: $table.descriptionPt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameRo => $composableBuilder(
    column: $table.nameRo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionRo => $composableBuilder(
    column: $table.descriptionRo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameTr => $composableBuilder(
    column: $table.nameTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionTr => $composableBuilder(
    column: $table.descriptionTr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameJa => $composableBuilder(
    column: $table.nameJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameKo => $composableBuilder(
    column: $table.nameKo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionKo => $composableBuilder(
    column: $table.descriptionKo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameZh => $composableBuilder(
    column: $table.nameZh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
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

  GeneratedColumn<String> get nameUk =>
      $composableBuilder(column: $table.nameUk, builder: (column) => column);

  GeneratedColumn<String> get descriptionUk => $composableBuilder(
    column: $table.descriptionUk,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get namePl =>
      $composableBuilder(column: $table.namePl, builder: (column) => column);

  GeneratedColumn<String> get descriptionPl => $composableBuilder(
    column: $table.descriptionPl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameDe =>
      $composableBuilder(column: $table.nameDe, builder: (column) => column);

  GeneratedColumn<String> get descriptionDe => $composableBuilder(
    column: $table.descriptionDe,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameFr =>
      $composableBuilder(column: $table.nameFr, builder: (column) => column);

  GeneratedColumn<String> get descriptionFr => $composableBuilder(
    column: $table.descriptionFr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameEs =>
      $composableBuilder(column: $table.nameEs, builder: (column) => column);

  GeneratedColumn<String> get descriptionEs => $composableBuilder(
    column: $table.descriptionEs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameIt =>
      $composableBuilder(column: $table.nameIt, builder: (column) => column);

  GeneratedColumn<String> get descriptionIt => $composableBuilder(
    column: $table.descriptionIt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get namePt =>
      $composableBuilder(column: $table.namePt, builder: (column) => column);

  GeneratedColumn<String> get descriptionPt => $composableBuilder(
    column: $table.descriptionPt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameRo =>
      $composableBuilder(column: $table.nameRo, builder: (column) => column);

  GeneratedColumn<String> get descriptionRo => $composableBuilder(
    column: $table.descriptionRo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameTr =>
      $composableBuilder(column: $table.nameTr, builder: (column) => column);

  GeneratedColumn<String> get descriptionTr => $composableBuilder(
    column: $table.descriptionTr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameJa =>
      $composableBuilder(column: $table.nameJa, builder: (column) => column);

  GeneratedColumn<String> get descriptionJa => $composableBuilder(
    column: $table.descriptionJa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameKo =>
      $composableBuilder(column: $table.nameKo, builder: (column) => column);

  GeneratedColumn<String> get descriptionKo => $composableBuilder(
    column: $table.descriptionKo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameZh =>
      $composableBuilder(column: $table.nameZh, builder: (column) => column);

  GeneratedColumn<String> get descriptionZh => $composableBuilder(
    column: $table.descriptionZh,
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
                Value<String> nameUk = const Value.absent(),
                Value<String> descriptionUk = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> descriptionEn = const Value.absent(),
                Value<String?> namePl = const Value.absent(),
                Value<String?> descriptionPl = const Value.absent(),
                Value<String?> nameDe = const Value.absent(),
                Value<String?> descriptionDe = const Value.absent(),
                Value<String?> nameFr = const Value.absent(),
                Value<String?> descriptionFr = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<String?> descriptionEs = const Value.absent(),
                Value<String?> nameIt = const Value.absent(),
                Value<String?> descriptionIt = const Value.absent(),
                Value<String?> namePt = const Value.absent(),
                Value<String?> descriptionPt = const Value.absent(),
                Value<String?> nameRo = const Value.absent(),
                Value<String?> descriptionRo = const Value.absent(),
                Value<String?> nameTr = const Value.absent(),
                Value<String?> descriptionTr = const Value.absent(),
                Value<String?> nameJa = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> nameKo = const Value.absent(),
                Value<String?> descriptionKo = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
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
                nameUk: nameUk,
                descriptionUk: descriptionUk,
                imageUrl: imageUrl,
                nameEn: nameEn,
                descriptionEn: descriptionEn,
                namePl: namePl,
                descriptionPl: descriptionPl,
                nameDe: nameDe,
                descriptionDe: descriptionDe,
                nameFr: nameFr,
                descriptionFr: descriptionFr,
                nameEs: nameEs,
                descriptionEs: descriptionEs,
                nameIt: nameIt,
                descriptionIt: descriptionIt,
                namePt: namePt,
                descriptionPt: descriptionPt,
                nameRo: nameRo,
                descriptionRo: descriptionRo,
                nameTr: nameTr,
                descriptionTr: descriptionTr,
                nameJa: nameJa,
                descriptionJa: descriptionJa,
                nameKo: nameKo,
                descriptionKo: descriptionKo,
                nameZh: nameZh,
                descriptionZh: descriptionZh,
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
                Value<String> nameUk = const Value.absent(),
                Value<String> descriptionUk = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String?> nameEn = const Value.absent(),
                Value<String?> descriptionEn = const Value.absent(),
                Value<String?> namePl = const Value.absent(),
                Value<String?> descriptionPl = const Value.absent(),
                Value<String?> nameDe = const Value.absent(),
                Value<String?> descriptionDe = const Value.absent(),
                Value<String?> nameFr = const Value.absent(),
                Value<String?> descriptionFr = const Value.absent(),
                Value<String?> nameEs = const Value.absent(),
                Value<String?> descriptionEs = const Value.absent(),
                Value<String?> nameIt = const Value.absent(),
                Value<String?> descriptionIt = const Value.absent(),
                Value<String?> namePt = const Value.absent(),
                Value<String?> descriptionPt = const Value.absent(),
                Value<String?> nameRo = const Value.absent(),
                Value<String?> descriptionRo = const Value.absent(),
                Value<String?> nameTr = const Value.absent(),
                Value<String?> descriptionTr = const Value.absent(),
                Value<String?> nameJa = const Value.absent(),
                Value<String?> descriptionJa = const Value.absent(),
                Value<String?> nameKo = const Value.absent(),
                Value<String?> descriptionKo = const Value.absent(),
                Value<String?> nameZh = const Value.absent(),
                Value<String?> descriptionZh = const Value.absent(),
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
                nameUk: nameUk,
                descriptionUk: descriptionUk,
                imageUrl: imageUrl,
                nameEn: nameEn,
                descriptionEn: descriptionEn,
                namePl: namePl,
                descriptionPl: descriptionPl,
                nameDe: nameDe,
                descriptionDe: descriptionDe,
                nameFr: nameFr,
                descriptionFr: descriptionFr,
                nameEs: nameEs,
                descriptionEs: descriptionEs,
                nameIt: nameIt,
                descriptionIt: descriptionIt,
                namePt: namePt,
                descriptionPt: descriptionPt,
                nameRo: nameRo,
                descriptionRo: descriptionRo,
                nameTr: nameTr,
                descriptionTr: descriptionTr,
                nameJa: nameJa,
                descriptionJa: descriptionJa,
                nameKo: nameKo,
                descriptionKo: descriptionKo,
                nameZh: nameZh,
                descriptionZh: descriptionZh,
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
  $$SphereRegionsTableTableManager get sphereRegions =>
      $$SphereRegionsTableTableManager(_db, _db.sphereRegions);
  $$SphereRegionTranslationsTableTableManager get sphereRegionTranslations =>
      $$SphereRegionTranslationsTableTableManager(
        _db,
        _db.sphereRegionTranslations,
      );
  $$SpecialtyArticlesTableTableManager get specialtyArticles =>
      $$SpecialtyArticlesTableTableManager(_db, _db.specialtyArticles);
  $$CoffeeLotsTableTableManager get coffeeLots =>
      $$CoffeeLotsTableTableManager(_db, _db.coffeeLots);
  $$FermentationLogsTableTableManager get fermentationLogs =>
      $$FermentationLogsTableTableManager(_db, _db.fermentationLogs);
  $$BrewingRecipesTableTableManager get brewingRecipes =>
      $$BrewingRecipesTableTableManager(_db, _db.brewingRecipes);
  $$RecommendedRecipesTableTableManager get recommendedRecipes =>
      $$RecommendedRecipesTableTableManager(_db, _db.recommendedRecipes);
  $$CustomRecipesTableTableManager get customRecipes =>
      $$CustomRecipesTableTableManager(_db, _db.customRecipes);
}
