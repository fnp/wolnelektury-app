// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_storage.dart';

// ignore_for_file: type=lint
class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
    'theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('adaptive'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, theme];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String theme;
  const AppSetting({required this.id, required this.theme});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme'] = Variable<String>(theme);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(id: Value(id), theme: Value(theme));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      theme: serializer.fromJson<String>(json['theme']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'theme': serializer.toJson<String>(theme),
    };
  }

  AppSetting copyWith({int? id, String? theme}) =>
      AppSetting(id: id ?? this.id, theme: theme ?? this.theme);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      theme: data.theme.present ? data.theme.value : this.theme,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('theme: $theme')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, theme);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting && other.id == this.id && other.theme == this.theme);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String> theme;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? theme,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (theme != null) 'theme': theme,
    });
  }

  AppSettingsCompanion copyWith({Value<int>? id, Value<String>? theme}) {
    return AppSettingsCompanion(id: id ?? this.id, theme: theme ?? this.theme);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('theme: $theme')
          ..write(')'))
        .toString();
  }
}

class $AppCacheTable extends AppCache
    with TableInfo<$AppCacheTable, AppCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _callKeyMeta = const VerificationMeta(
    'callKey',
  );
  @override
  late final GeneratedColumn<String> callKey = GeneratedColumn<String>(
    'call_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _responseMeta = const VerificationMeta(
    'response',
  );
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
    'response',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [callKey, response, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('call_key')) {
      context.handle(
        _callKeyMeta,
        callKey.isAcceptableOrUnknown(data['call_key']!, _callKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_callKeyMeta);
    }
    if (data.containsKey('response')) {
      context.handle(
        _responseMeta,
        response.isAcceptableOrUnknown(data['response']!, _responseMeta),
      );
    } else if (isInserting) {
      context.missing(_responseMeta);
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AppCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppCacheData(
      callKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}call_key'],
      )!,
      response: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AppCacheTable createAlias(String alias) {
    return $AppCacheTable(attachedDatabase, alias);
  }
}

class AppCacheData extends DataClass implements Insertable<AppCacheData> {
  final String callKey;
  final String response;
  final DateTime createdAt;
  const AppCacheData({
    required this.callKey,
    required this.response,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['call_key'] = Variable<String>(callKey);
    map['response'] = Variable<String>(response);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AppCacheCompanion toCompanion(bool nullToAbsent) {
    return AppCacheCompanion(
      callKey: Value(callKey),
      response: Value(response),
      createdAt: Value(createdAt),
    );
  }

  factory AppCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppCacheData(
      callKey: serializer.fromJson<String>(json['callKey']),
      response: serializer.fromJson<String>(json['response']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'callKey': serializer.toJson<String>(callKey),
      'response': serializer.toJson<String>(response),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AppCacheData copyWith({
    String? callKey,
    String? response,
    DateTime? createdAt,
  }) => AppCacheData(
    callKey: callKey ?? this.callKey,
    response: response ?? this.response,
    createdAt: createdAt ?? this.createdAt,
  );
  AppCacheData copyWithCompanion(AppCacheCompanion data) {
    return AppCacheData(
      callKey: data.callKey.present ? data.callKey.value : this.callKey,
      response: data.response.present ? data.response.value : this.response,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppCacheData(')
          ..write('callKey: $callKey, ')
          ..write('response: $response, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(callKey, response, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppCacheData &&
          other.callKey == this.callKey &&
          other.response == this.response &&
          other.createdAt == this.createdAt);
}

class AppCacheCompanion extends UpdateCompanion<AppCacheData> {
  final Value<String> callKey;
  final Value<String> response;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AppCacheCompanion({
    this.callKey = const Value.absent(),
    this.response = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppCacheCompanion.insert({
    required String callKey,
    required String response,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : callKey = Value(callKey),
       response = Value(response);
  static Insertable<AppCacheData> custom({
    Expression<String>? callKey,
    Expression<String>? response,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (callKey != null) 'call_key': callKey,
      if (response != null) 'response': response,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppCacheCompanion copyWith({
    Value<String>? callKey,
    Value<String>? response,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AppCacheCompanion(
      callKey: callKey ?? this.callKey,
      response: response ?? this.response,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (callKey.present) {
      map['call_key'] = Variable<String>(callKey.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
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
    return (StringBuffer('AppCacheCompanion(')
          ..write('callKey: $callKey, ')
          ..write('response: $response, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReaderSettingsTable extends ReaderSettings
    with TableInfo<$ReaderSettingsTable, ReaderSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReaderSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _readingFontSizeMeta = const VerificationMeta(
    'readingFontSize',
  );
  @override
  late final GeneratedColumn<double> readingFontSize = GeneratedColumn<double>(
    'reading_font_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.5),
  );
  static const VerificationMeta _readingFontTypeMeta = const VerificationMeta(
    'readingFontType',
  );
  @override
  late final GeneratedColumn<String> readingFontType = GeneratedColumn<String>(
    'reading_font_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('sans'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, readingFontSize, readingFontType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reader_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReaderSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reading_font_size')) {
      context.handle(
        _readingFontSizeMeta,
        readingFontSize.isAcceptableOrUnknown(
          data['reading_font_size']!,
          _readingFontSizeMeta,
        ),
      );
    }
    if (data.containsKey('reading_font_type')) {
      context.handle(
        _readingFontTypeMeta,
        readingFontType.isAcceptableOrUnknown(
          data['reading_font_type']!,
          _readingFontTypeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReaderSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReaderSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      readingFontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reading_font_size'],
      )!,
      readingFontType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_font_type'],
      )!,
    );
  }

  @override
  $ReaderSettingsTable createAlias(String alias) {
    return $ReaderSettingsTable(attachedDatabase, alias);
  }
}

class ReaderSetting extends DataClass implements Insertable<ReaderSetting> {
  final int id;
  final double readingFontSize;
  final String readingFontType;
  const ReaderSetting({
    required this.id,
    required this.readingFontSize,
    required this.readingFontType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reading_font_size'] = Variable<double>(readingFontSize);
    map['reading_font_type'] = Variable<String>(readingFontType);
    return map;
  }

  ReaderSettingsCompanion toCompanion(bool nullToAbsent) {
    return ReaderSettingsCompanion(
      id: Value(id),
      readingFontSize: Value(readingFontSize),
      readingFontType: Value(readingFontType),
    );
  }

  factory ReaderSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReaderSetting(
      id: serializer.fromJson<int>(json['id']),
      readingFontSize: serializer.fromJson<double>(json['readingFontSize']),
      readingFontType: serializer.fromJson<String>(json['readingFontType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'readingFontSize': serializer.toJson<double>(readingFontSize),
      'readingFontType': serializer.toJson<String>(readingFontType),
    };
  }

  ReaderSetting copyWith({
    int? id,
    double? readingFontSize,
    String? readingFontType,
  }) => ReaderSetting(
    id: id ?? this.id,
    readingFontSize: readingFontSize ?? this.readingFontSize,
    readingFontType: readingFontType ?? this.readingFontType,
  );
  ReaderSetting copyWithCompanion(ReaderSettingsCompanion data) {
    return ReaderSetting(
      id: data.id.present ? data.id.value : this.id,
      readingFontSize: data.readingFontSize.present
          ? data.readingFontSize.value
          : this.readingFontSize,
      readingFontType: data.readingFontType.present
          ? data.readingFontType.value
          : this.readingFontType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReaderSetting(')
          ..write('id: $id, ')
          ..write('readingFontSize: $readingFontSize, ')
          ..write('readingFontType: $readingFontType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, readingFontSize, readingFontType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReaderSetting &&
          other.id == this.id &&
          other.readingFontSize == this.readingFontSize &&
          other.readingFontType == this.readingFontType);
}

class ReaderSettingsCompanion extends UpdateCompanion<ReaderSetting> {
  final Value<int> id;
  final Value<double> readingFontSize;
  final Value<String> readingFontType;
  const ReaderSettingsCompanion({
    this.id = const Value.absent(),
    this.readingFontSize = const Value.absent(),
    this.readingFontType = const Value.absent(),
  });
  ReaderSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.readingFontSize = const Value.absent(),
    this.readingFontType = const Value.absent(),
  });
  static Insertable<ReaderSetting> custom({
    Expression<int>? id,
    Expression<double>? readingFontSize,
    Expression<String>? readingFontType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (readingFontSize != null) 'reading_font_size': readingFontSize,
      if (readingFontType != null) 'reading_font_type': readingFontType,
    });
  }

  ReaderSettingsCompanion copyWith({
    Value<int>? id,
    Value<double>? readingFontSize,
    Value<String>? readingFontType,
  }) {
    return ReaderSettingsCompanion(
      id: id ?? this.id,
      readingFontSize: readingFontSize ?? this.readingFontSize,
      readingFontType: readingFontType ?? this.readingFontType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (readingFontSize.present) {
      map['reading_font_size'] = Variable<double>(readingFontSize.value);
    }
    if (readingFontType.present) {
      map['reading_font_type'] = Variable<String>(readingFontType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReaderSettingsCompanion(')
          ..write('id: $id, ')
          ..write('readingFontSize: $readingFontSize, ')
          ..write('readingFontType: $readingFontType')
          ..write(')'))
        .toString();
  }
}

class $OfflineBooksTable extends OfflineBooks
    with TableInfo<$OfflineBooksTable, OfflineBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflineBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _bookJsonMeta = const VerificationMeta(
    'bookJson',
  );
  @override
  late final GeneratedColumn<String> bookJson = GeneratedColumn<String>(
    'book_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [slug, bookJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfflineBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('book_json')) {
      context.handle(
        _bookJsonMeta,
        bookJson.isAcceptableOrUnknown(data['book_json']!, _bookJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  OfflineBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflineBook(
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      bookJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_json'],
      )!,
    );
  }

  @override
  $OfflineBooksTable createAlias(String alias) {
    return $OfflineBooksTable(attachedDatabase, alias);
  }
}

class OfflineBook extends DataClass implements Insertable<OfflineBook> {
  final String slug;
  final String bookJson;
  const OfflineBook({required this.slug, required this.bookJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    map['book_json'] = Variable<String>(bookJson);
    return map;
  }

  OfflineBooksCompanion toCompanion(bool nullToAbsent) {
    return OfflineBooksCompanion(slug: Value(slug), bookJson: Value(bookJson));
  }

  factory OfflineBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflineBook(
      slug: serializer.fromJson<String>(json['slug']),
      bookJson: serializer.fromJson<String>(json['bookJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'bookJson': serializer.toJson<String>(bookJson),
    };
  }

  OfflineBook copyWith({String? slug, String? bookJson}) =>
      OfflineBook(slug: slug ?? this.slug, bookJson: bookJson ?? this.bookJson);
  OfflineBook copyWithCompanion(OfflineBooksCompanion data) {
    return OfflineBook(
      slug: data.slug.present ? data.slug.value : this.slug,
      bookJson: data.bookJson.present ? data.bookJson.value : this.bookJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflineBook(')
          ..write('slug: $slug, ')
          ..write('bookJson: $bookJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(slug, bookJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflineBook &&
          other.slug == this.slug &&
          other.bookJson == this.bookJson);
}

class OfflineBooksCompanion extends UpdateCompanion<OfflineBook> {
  final Value<String> slug;
  final Value<String> bookJson;
  final Value<int> rowid;
  const OfflineBooksCompanion({
    this.slug = const Value.absent(),
    this.bookJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OfflineBooksCompanion.insert({
    required String slug,
    this.bookJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : slug = Value(slug);
  static Insertable<OfflineBook> custom({
    Expression<String>? slug,
    Expression<String>? bookJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (bookJson != null) 'book_json': bookJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OfflineBooksCompanion copyWith({
    Value<String>? slug,
    Value<String>? bookJson,
    Value<int>? rowid,
  }) {
    return OfflineBooksCompanion(
      slug: slug ?? this.slug,
      bookJson: bookJson ?? this.bookJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (bookJson.present) {
      map['book_json'] = Variable<String>(bookJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflineBooksCompanion(')
          ..write('slug: $slug, ')
          ..write('bookJson: $bookJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgressesTable extends Progresses
    with TableInfo<$ProgressesTable, ProgressesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressJsonMeta = const VerificationMeta(
    'progressJson',
  );
  @override
  late final GeneratedColumn<String> progressJson = GeneratedColumn<String>(
    'progress_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [slug, progressJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progresses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('progress_json')) {
      context.handle(
        _progressJsonMeta,
        progressJson.isAcceptableOrUnknown(
          data['progress_json']!,
          _progressJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_progressJsonMeta);
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
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  ProgressesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressesData(
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      progressJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}progress_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProgressesTable createAlias(String alias) {
    return $ProgressesTable(attachedDatabase, alias);
  }
}

class ProgressesData extends DataClass implements Insertable<ProgressesData> {
  final String slug;
  final String progressJson;
  final DateTime updatedAt;
  const ProgressesData({
    required this.slug,
    required this.progressJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    map['progress_json'] = Variable<String>(progressJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProgressesCompanion toCompanion(bool nullToAbsent) {
    return ProgressesCompanion(
      slug: Value(slug),
      progressJson: Value(progressJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProgressesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressesData(
      slug: serializer.fromJson<String>(json['slug']),
      progressJson: serializer.fromJson<String>(json['progressJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'progressJson': serializer.toJson<String>(progressJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProgressesData copyWith({
    String? slug,
    String? progressJson,
    DateTime? updatedAt,
  }) => ProgressesData(
    slug: slug ?? this.slug,
    progressJson: progressJson ?? this.progressJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProgressesData copyWithCompanion(ProgressesCompanion data) {
    return ProgressesData(
      slug: data.slug.present ? data.slug.value : this.slug,
      progressJson: data.progressJson.present
          ? data.progressJson.value
          : this.progressJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressesData(')
          ..write('slug: $slug, ')
          ..write('progressJson: $progressJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(slug, progressJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressesData &&
          other.slug == this.slug &&
          other.progressJson == this.progressJson &&
          other.updatedAt == this.updatedAt);
}

class ProgressesCompanion extends UpdateCompanion<ProgressesData> {
  final Value<String> slug;
  final Value<String> progressJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProgressesCompanion({
    this.slug = const Value.absent(),
    this.progressJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgressesCompanion.insert({
    required String slug,
    required String progressJson,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : slug = Value(slug),
       progressJson = Value(progressJson);
  static Insertable<ProgressesData> custom({
    Expression<String>? slug,
    Expression<String>? progressJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (progressJson != null) 'progress_json': progressJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgressesCompanion copyWith({
    Value<String>? slug,
    Value<String>? progressJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProgressesCompanion(
      slug: slug ?? this.slug,
      progressJson: progressJson ?? this.progressJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (progressJson.present) {
      map['progress_json'] = Variable<String>(progressJson.value);
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
    return (StringBuffer('ProgressesCompanion(')
          ..write('slug: $slug, ')
          ..write('progressJson: $progressJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncInfoTable extends SyncInfo
    with TableInfo<$SyncInfoTable, SyncInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncInfoTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _receivedProgressSyncAtMeta =
      const VerificationMeta('receivedProgressSyncAt');
  @override
  late final GeneratedColumn<DateTime> receivedProgressSyncAt =
      GeneratedColumn<DateTime>(
        'received_progress_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sentProgressSyncAtMeta =
      const VerificationMeta('sentProgressSyncAt');
  @override
  late final GeneratedColumn<DateTime> sentProgressSyncAt =
      GeneratedColumn<DateTime>(
        'sent_progress_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _receivedLikesSyncAtMeta =
      const VerificationMeta('receivedLikesSyncAt');
  @override
  late final GeneratedColumn<DateTime> receivedLikesSyncAt =
      GeneratedColumn<DateTime>(
        'received_likes_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sentLikesSyncAtMeta = const VerificationMeta(
    'sentLikesSyncAt',
  );
  @override
  late final GeneratedColumn<DateTime> sentLikesSyncAt =
      GeneratedColumn<DateTime>(
        'sent_likes_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _receivedBookmarksSyncAtMeta =
      const VerificationMeta('receivedBookmarksSyncAt');
  @override
  late final GeneratedColumn<DateTime> receivedBookmarksSyncAt =
      GeneratedColumn<DateTime>(
        'received_bookmarks_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sentBookmarksSyncAtMeta =
      const VerificationMeta('sentBookmarksSyncAt');
  @override
  late final GeneratedColumn<DateTime> sentBookmarksSyncAt =
      GeneratedColumn<DateTime>(
        'sent_bookmarks_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    receivedProgressSyncAt,
    sentProgressSyncAt,
    receivedLikesSyncAt,
    sentLikesSyncAt,
    receivedBookmarksSyncAt,
    sentBookmarksSyncAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('received_progress_sync_at')) {
      context.handle(
        _receivedProgressSyncAtMeta,
        receivedProgressSyncAt.isAcceptableOrUnknown(
          data['received_progress_sync_at']!,
          _receivedProgressSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('sent_progress_sync_at')) {
      context.handle(
        _sentProgressSyncAtMeta,
        sentProgressSyncAt.isAcceptableOrUnknown(
          data['sent_progress_sync_at']!,
          _sentProgressSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('received_likes_sync_at')) {
      context.handle(
        _receivedLikesSyncAtMeta,
        receivedLikesSyncAt.isAcceptableOrUnknown(
          data['received_likes_sync_at']!,
          _receivedLikesSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('sent_likes_sync_at')) {
      context.handle(
        _sentLikesSyncAtMeta,
        sentLikesSyncAt.isAcceptableOrUnknown(
          data['sent_likes_sync_at']!,
          _sentLikesSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('received_bookmarks_sync_at')) {
      context.handle(
        _receivedBookmarksSyncAtMeta,
        receivedBookmarksSyncAt.isAcceptableOrUnknown(
          data['received_bookmarks_sync_at']!,
          _receivedBookmarksSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('sent_bookmarks_sync_at')) {
      context.handle(
        _sentBookmarksSyncAtMeta,
        sentBookmarksSyncAt.isAcceptableOrUnknown(
          data['sent_bookmarks_sync_at']!,
          _sentBookmarksSyncAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncInfoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      receivedProgressSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_progress_sync_at'],
      ),
      sentProgressSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_progress_sync_at'],
      ),
      receivedLikesSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_likes_sync_at'],
      ),
      sentLikesSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_likes_sync_at'],
      ),
      receivedBookmarksSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_bookmarks_sync_at'],
      ),
      sentBookmarksSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_bookmarks_sync_at'],
      ),
    );
  }

  @override
  $SyncInfoTable createAlias(String alias) {
    return $SyncInfoTable(attachedDatabase, alias);
  }
}

class SyncInfoData extends DataClass implements Insertable<SyncInfoData> {
  final int id;
  final DateTime? receivedProgressSyncAt;
  final DateTime? sentProgressSyncAt;
  final DateTime? receivedLikesSyncAt;
  final DateTime? sentLikesSyncAt;
  final DateTime? receivedBookmarksSyncAt;
  final DateTime? sentBookmarksSyncAt;
  const SyncInfoData({
    required this.id,
    this.receivedProgressSyncAt,
    this.sentProgressSyncAt,
    this.receivedLikesSyncAt,
    this.sentLikesSyncAt,
    this.receivedBookmarksSyncAt,
    this.sentBookmarksSyncAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || receivedProgressSyncAt != null) {
      map['received_progress_sync_at'] = Variable<DateTime>(
        receivedProgressSyncAt,
      );
    }
    if (!nullToAbsent || sentProgressSyncAt != null) {
      map['sent_progress_sync_at'] = Variable<DateTime>(sentProgressSyncAt);
    }
    if (!nullToAbsent || receivedLikesSyncAt != null) {
      map['received_likes_sync_at'] = Variable<DateTime>(receivedLikesSyncAt);
    }
    if (!nullToAbsent || sentLikesSyncAt != null) {
      map['sent_likes_sync_at'] = Variable<DateTime>(sentLikesSyncAt);
    }
    if (!nullToAbsent || receivedBookmarksSyncAt != null) {
      map['received_bookmarks_sync_at'] = Variable<DateTime>(
        receivedBookmarksSyncAt,
      );
    }
    if (!nullToAbsent || sentBookmarksSyncAt != null) {
      map['sent_bookmarks_sync_at'] = Variable<DateTime>(sentBookmarksSyncAt);
    }
    return map;
  }

  SyncInfoCompanion toCompanion(bool nullToAbsent) {
    return SyncInfoCompanion(
      id: Value(id),
      receivedProgressSyncAt: receivedProgressSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedProgressSyncAt),
      sentProgressSyncAt: sentProgressSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentProgressSyncAt),
      receivedLikesSyncAt: receivedLikesSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedLikesSyncAt),
      sentLikesSyncAt: sentLikesSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentLikesSyncAt),
      receivedBookmarksSyncAt: receivedBookmarksSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedBookmarksSyncAt),
      sentBookmarksSyncAt: sentBookmarksSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentBookmarksSyncAt),
    );
  }

  factory SyncInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncInfoData(
      id: serializer.fromJson<int>(json['id']),
      receivedProgressSyncAt: serializer.fromJson<DateTime?>(
        json['receivedProgressSyncAt'],
      ),
      sentProgressSyncAt: serializer.fromJson<DateTime?>(
        json['sentProgressSyncAt'],
      ),
      receivedLikesSyncAt: serializer.fromJson<DateTime?>(
        json['receivedLikesSyncAt'],
      ),
      sentLikesSyncAt: serializer.fromJson<DateTime?>(json['sentLikesSyncAt']),
      receivedBookmarksSyncAt: serializer.fromJson<DateTime?>(
        json['receivedBookmarksSyncAt'],
      ),
      sentBookmarksSyncAt: serializer.fromJson<DateTime?>(
        json['sentBookmarksSyncAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'receivedProgressSyncAt': serializer.toJson<DateTime?>(
        receivedProgressSyncAt,
      ),
      'sentProgressSyncAt': serializer.toJson<DateTime?>(sentProgressSyncAt),
      'receivedLikesSyncAt': serializer.toJson<DateTime?>(receivedLikesSyncAt),
      'sentLikesSyncAt': serializer.toJson<DateTime?>(sentLikesSyncAt),
      'receivedBookmarksSyncAt': serializer.toJson<DateTime?>(
        receivedBookmarksSyncAt,
      ),
      'sentBookmarksSyncAt': serializer.toJson<DateTime?>(sentBookmarksSyncAt),
    };
  }

  SyncInfoData copyWith({
    int? id,
    Value<DateTime?> receivedProgressSyncAt = const Value.absent(),
    Value<DateTime?> sentProgressSyncAt = const Value.absent(),
    Value<DateTime?> receivedLikesSyncAt = const Value.absent(),
    Value<DateTime?> sentLikesSyncAt = const Value.absent(),
    Value<DateTime?> receivedBookmarksSyncAt = const Value.absent(),
    Value<DateTime?> sentBookmarksSyncAt = const Value.absent(),
  }) => SyncInfoData(
    id: id ?? this.id,
    receivedProgressSyncAt: receivedProgressSyncAt.present
        ? receivedProgressSyncAt.value
        : this.receivedProgressSyncAt,
    sentProgressSyncAt: sentProgressSyncAt.present
        ? sentProgressSyncAt.value
        : this.sentProgressSyncAt,
    receivedLikesSyncAt: receivedLikesSyncAt.present
        ? receivedLikesSyncAt.value
        : this.receivedLikesSyncAt,
    sentLikesSyncAt: sentLikesSyncAt.present
        ? sentLikesSyncAt.value
        : this.sentLikesSyncAt,
    receivedBookmarksSyncAt: receivedBookmarksSyncAt.present
        ? receivedBookmarksSyncAt.value
        : this.receivedBookmarksSyncAt,
    sentBookmarksSyncAt: sentBookmarksSyncAt.present
        ? sentBookmarksSyncAt.value
        : this.sentBookmarksSyncAt,
  );
  SyncInfoData copyWithCompanion(SyncInfoCompanion data) {
    return SyncInfoData(
      id: data.id.present ? data.id.value : this.id,
      receivedProgressSyncAt: data.receivedProgressSyncAt.present
          ? data.receivedProgressSyncAt.value
          : this.receivedProgressSyncAt,
      sentProgressSyncAt: data.sentProgressSyncAt.present
          ? data.sentProgressSyncAt.value
          : this.sentProgressSyncAt,
      receivedLikesSyncAt: data.receivedLikesSyncAt.present
          ? data.receivedLikesSyncAt.value
          : this.receivedLikesSyncAt,
      sentLikesSyncAt: data.sentLikesSyncAt.present
          ? data.sentLikesSyncAt.value
          : this.sentLikesSyncAt,
      receivedBookmarksSyncAt: data.receivedBookmarksSyncAt.present
          ? data.receivedBookmarksSyncAt.value
          : this.receivedBookmarksSyncAt,
      sentBookmarksSyncAt: data.sentBookmarksSyncAt.present
          ? data.sentBookmarksSyncAt.value
          : this.sentBookmarksSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncInfoData(')
          ..write('id: $id, ')
          ..write('receivedProgressSyncAt: $receivedProgressSyncAt, ')
          ..write('sentProgressSyncAt: $sentProgressSyncAt, ')
          ..write('receivedLikesSyncAt: $receivedLikesSyncAt, ')
          ..write('sentLikesSyncAt: $sentLikesSyncAt, ')
          ..write('receivedBookmarksSyncAt: $receivedBookmarksSyncAt, ')
          ..write('sentBookmarksSyncAt: $sentBookmarksSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    receivedProgressSyncAt,
    sentProgressSyncAt,
    receivedLikesSyncAt,
    sentLikesSyncAt,
    receivedBookmarksSyncAt,
    sentBookmarksSyncAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncInfoData &&
          other.id == this.id &&
          other.receivedProgressSyncAt == this.receivedProgressSyncAt &&
          other.sentProgressSyncAt == this.sentProgressSyncAt &&
          other.receivedLikesSyncAt == this.receivedLikesSyncAt &&
          other.sentLikesSyncAt == this.sentLikesSyncAt &&
          other.receivedBookmarksSyncAt == this.receivedBookmarksSyncAt &&
          other.sentBookmarksSyncAt == this.sentBookmarksSyncAt);
}

class SyncInfoCompanion extends UpdateCompanion<SyncInfoData> {
  final Value<int> id;
  final Value<DateTime?> receivedProgressSyncAt;
  final Value<DateTime?> sentProgressSyncAt;
  final Value<DateTime?> receivedLikesSyncAt;
  final Value<DateTime?> sentLikesSyncAt;
  final Value<DateTime?> receivedBookmarksSyncAt;
  final Value<DateTime?> sentBookmarksSyncAt;
  const SyncInfoCompanion({
    this.id = const Value.absent(),
    this.receivedProgressSyncAt = const Value.absent(),
    this.sentProgressSyncAt = const Value.absent(),
    this.receivedLikesSyncAt = const Value.absent(),
    this.sentLikesSyncAt = const Value.absent(),
    this.receivedBookmarksSyncAt = const Value.absent(),
    this.sentBookmarksSyncAt = const Value.absent(),
  });
  SyncInfoCompanion.insert({
    this.id = const Value.absent(),
    this.receivedProgressSyncAt = const Value.absent(),
    this.sentProgressSyncAt = const Value.absent(),
    this.receivedLikesSyncAt = const Value.absent(),
    this.sentLikesSyncAt = const Value.absent(),
    this.receivedBookmarksSyncAt = const Value.absent(),
    this.sentBookmarksSyncAt = const Value.absent(),
  });
  static Insertable<SyncInfoData> custom({
    Expression<int>? id,
    Expression<DateTime>? receivedProgressSyncAt,
    Expression<DateTime>? sentProgressSyncAt,
    Expression<DateTime>? receivedLikesSyncAt,
    Expression<DateTime>? sentLikesSyncAt,
    Expression<DateTime>? receivedBookmarksSyncAt,
    Expression<DateTime>? sentBookmarksSyncAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receivedProgressSyncAt != null)
        'received_progress_sync_at': receivedProgressSyncAt,
      if (sentProgressSyncAt != null)
        'sent_progress_sync_at': sentProgressSyncAt,
      if (receivedLikesSyncAt != null)
        'received_likes_sync_at': receivedLikesSyncAt,
      if (sentLikesSyncAt != null) 'sent_likes_sync_at': sentLikesSyncAt,
      if (receivedBookmarksSyncAt != null)
        'received_bookmarks_sync_at': receivedBookmarksSyncAt,
      if (sentBookmarksSyncAt != null)
        'sent_bookmarks_sync_at': sentBookmarksSyncAt,
    });
  }

  SyncInfoCompanion copyWith({
    Value<int>? id,
    Value<DateTime?>? receivedProgressSyncAt,
    Value<DateTime?>? sentProgressSyncAt,
    Value<DateTime?>? receivedLikesSyncAt,
    Value<DateTime?>? sentLikesSyncAt,
    Value<DateTime?>? receivedBookmarksSyncAt,
    Value<DateTime?>? sentBookmarksSyncAt,
  }) {
    return SyncInfoCompanion(
      id: id ?? this.id,
      receivedProgressSyncAt:
          receivedProgressSyncAt ?? this.receivedProgressSyncAt,
      sentProgressSyncAt: sentProgressSyncAt ?? this.sentProgressSyncAt,
      receivedLikesSyncAt: receivedLikesSyncAt ?? this.receivedLikesSyncAt,
      sentLikesSyncAt: sentLikesSyncAt ?? this.sentLikesSyncAt,
      receivedBookmarksSyncAt:
          receivedBookmarksSyncAt ?? this.receivedBookmarksSyncAt,
      sentBookmarksSyncAt: sentBookmarksSyncAt ?? this.sentBookmarksSyncAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (receivedProgressSyncAt.present) {
      map['received_progress_sync_at'] = Variable<DateTime>(
        receivedProgressSyncAt.value,
      );
    }
    if (sentProgressSyncAt.present) {
      map['sent_progress_sync_at'] = Variable<DateTime>(
        sentProgressSyncAt.value,
      );
    }
    if (receivedLikesSyncAt.present) {
      map['received_likes_sync_at'] = Variable<DateTime>(
        receivedLikesSyncAt.value,
      );
    }
    if (sentLikesSyncAt.present) {
      map['sent_likes_sync_at'] = Variable<DateTime>(sentLikesSyncAt.value);
    }
    if (receivedBookmarksSyncAt.present) {
      map['received_bookmarks_sync_at'] = Variable<DateTime>(
        receivedBookmarksSyncAt.value,
      );
    }
    if (sentBookmarksSyncAt.present) {
      map['sent_bookmarks_sync_at'] = Variable<DateTime>(
        sentBookmarksSyncAt.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncInfoCompanion(')
          ..write('id: $id, ')
          ..write('receivedProgressSyncAt: $receivedProgressSyncAt, ')
          ..write('sentProgressSyncAt: $sentProgressSyncAt, ')
          ..write('receivedLikesSyncAt: $receivedLikesSyncAt, ')
          ..write('sentLikesSyncAt: $sentLikesSyncAt, ')
          ..write('receivedBookmarksSyncAt: $receivedBookmarksSyncAt, ')
          ..write('sentBookmarksSyncAt: $sentBookmarksSyncAt')
          ..write(')'))
        .toString();
  }
}

class $LikesTable extends Likes with TableInfo<$LikesTable, Like> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LikesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isLikedMeta = const VerificationMeta(
    'isLiked',
  );
  @override
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
    'is_liked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_liked" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [slug, isLiked, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'likes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Like> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('is_liked')) {
      context.handle(
        _isLikedMeta,
        isLiked.isAcceptableOrUnknown(data['is_liked']!, _isLikedMeta),
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
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  Like map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Like(
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      isLiked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_liked'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LikesTable createAlias(String alias) {
    return $LikesTable(attachedDatabase, alias);
  }
}

class Like extends DataClass implements Insertable<Like> {
  final String slug;
  final bool isLiked;
  final DateTime updatedAt;
  const Like({
    required this.slug,
    required this.isLiked,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    map['is_liked'] = Variable<bool>(isLiked);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LikesCompanion toCompanion(bool nullToAbsent) {
    return LikesCompanion(
      slug: Value(slug),
      isLiked: Value(isLiked),
      updatedAt: Value(updatedAt),
    );
  }

  factory Like.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Like(
      slug: serializer.fromJson<String>(json['slug']),
      isLiked: serializer.fromJson<bool>(json['isLiked']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'isLiked': serializer.toJson<bool>(isLiked),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Like copyWith({String? slug, bool? isLiked, DateTime? updatedAt}) => Like(
    slug: slug ?? this.slug,
    isLiked: isLiked ?? this.isLiked,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Like copyWithCompanion(LikesCompanion data) {
    return Like(
      slug: data.slug.present ? data.slug.value : this.slug,
      isLiked: data.isLiked.present ? data.isLiked.value : this.isLiked,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Like(')
          ..write('slug: $slug, ')
          ..write('isLiked: $isLiked, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(slug, isLiked, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Like &&
          other.slug == this.slug &&
          other.isLiked == this.isLiked &&
          other.updatedAt == this.updatedAt);
}

class LikesCompanion extends UpdateCompanion<Like> {
  final Value<String> slug;
  final Value<bool> isLiked;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LikesCompanion({
    this.slug = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LikesCompanion.insert({
    required String slug,
    this.isLiked = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : slug = Value(slug);
  static Insertable<Like> custom({
    Expression<String>? slug,
    Expression<bool>? isLiked,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (isLiked != null) 'is_liked': isLiked,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LikesCompanion copyWith({
    Value<String>? slug,
    Value<bool>? isLiked,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LikesCompanion(
      slug: slug ?? this.slug,
      isLiked: isLiked ?? this.isLiked,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (isLiked.present) {
      map['is_liked'] = Variable<bool>(isLiked.value);
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
    return (StringBuffer('LikesCompanion(')
          ..write('slug: $slug, ')
          ..write('isLiked: $isLiked, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressJsonMeta = const VerificationMeta(
    'progressJson',
  );
  @override
  late final GeneratedColumn<String> progressJson = GeneratedColumn<String>(
    'progress_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, slug, progressJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('progress_json')) {
      context.handle(
        _progressJsonMeta,
        progressJson.isAcceptableOrUnknown(
          data['progress_json']!,
          _progressJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_progressJsonMeta);
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
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      progressJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}progress_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final String id;
  final String slug;
  final String progressJson;
  final DateTime updatedAt;
  const Bookmark({
    required this.id,
    required this.slug,
    required this.progressJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['progress_json'] = Variable<String>(progressJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      slug: Value(slug),
      progressJson: Value(progressJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      progressJson: serializer.fromJson<String>(json['progressJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'progressJson': serializer.toJson<String>(progressJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Bookmark copyWith({
    String? id,
    String? slug,
    String? progressJson,
    DateTime? updatedAt,
  }) => Bookmark(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    progressJson: progressJson ?? this.progressJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      progressJson: data.progressJson.present
          ? data.progressJson.value
          : this.progressJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('progressJson: $progressJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, progressJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.progressJson == this.progressJson &&
          other.updatedAt == this.updatedAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<String> id;
  final Value<String> slug;
  final Value<String> progressJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.progressJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksCompanion.insert({
    required String id,
    required String slug,
    required String progressJson,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       slug = Value(slug),
       progressJson = Value(progressJson);
  static Insertable<Bookmark> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<String>? progressJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (progressJson != null) 'progress_json': progressJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksCompanion copyWith({
    Value<String>? id,
    Value<String>? slug,
    Value<String>? progressJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      progressJson: progressJson ?? this.progressJson,
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
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (progressJson.present) {
      map['progress_json'] = Variable<String>(progressJson.value);
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
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('progressJson: $progressJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppStorage extends GeneratedDatabase {
  _$AppStorage(QueryExecutor e) : super(e);
  $AppStorageManager get managers => $AppStorageManager(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $AppCacheTable appCache = $AppCacheTable(this);
  late final $ReaderSettingsTable readerSettings = $ReaderSettingsTable(this);
  late final $OfflineBooksTable offlineBooks = $OfflineBooksTable(this);
  late final $ProgressesTable progresses = $ProgressesTable(this);
  late final $SyncInfoTable syncInfo = $SyncInfoTable(this);
  late final $LikesTable likes = $LikesTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appSettings,
    appCache,
    readerSettings,
    offlineBooks,
    progresses,
    syncInfo,
    likes,
    bookmarks,
  ];
}

typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({Value<int> id, Value<String> theme});
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({Value<int> id, Value<String> theme});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppStorage, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

  ColumnFilters<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppStorage, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppStorage, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppStorage,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppStorage, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppStorage db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> theme = const Value.absent(),
              }) => AppSettingsCompanion(id: id, theme: theme),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> theme = const Value.absent(),
              }) => AppSettingsCompanion.insert(id: id, theme: theme),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppStorage,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (AppSetting, BaseReferences<_$AppStorage, $AppSettingsTable, AppSetting>),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$AppCacheTableCreateCompanionBuilder =
    AppCacheCompanion Function({
      required String callKey,
      required String response,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$AppCacheTableUpdateCompanionBuilder =
    AppCacheCompanion Function({
      Value<String> callKey,
      Value<String> response,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$AppCacheTableFilterComposer
    extends Composer<_$AppStorage, $AppCacheTable> {
  $$AppCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get callKey => $composableBuilder(
    column: $table.callKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppCacheTableOrderingComposer
    extends Composer<_$AppStorage, $AppCacheTable> {
  $$AppCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get callKey => $composableBuilder(
    column: $table.callKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppCacheTableAnnotationComposer
    extends Composer<_$AppStorage, $AppCacheTable> {
  $$AppCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get callKey =>
      $composableBuilder(column: $table.callKey, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AppCacheTableTableManager
    extends
        RootTableManager<
          _$AppStorage,
          $AppCacheTable,
          AppCacheData,
          $$AppCacheTableFilterComposer,
          $$AppCacheTableOrderingComposer,
          $$AppCacheTableAnnotationComposer,
          $$AppCacheTableCreateCompanionBuilder,
          $$AppCacheTableUpdateCompanionBuilder,
          (
            AppCacheData,
            BaseReferences<_$AppStorage, $AppCacheTable, AppCacheData>,
          ),
          AppCacheData,
          PrefetchHooks Function()
        > {
  $$AppCacheTableTableManager(_$AppStorage db, $AppCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> callKey = const Value.absent(),
                Value<String> response = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppCacheCompanion(
                callKey: callKey,
                response: response,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String callKey,
                required String response,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppCacheCompanion.insert(
                callKey: callKey,
                response: response,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppStorage,
      $AppCacheTable,
      AppCacheData,
      $$AppCacheTableFilterComposer,
      $$AppCacheTableOrderingComposer,
      $$AppCacheTableAnnotationComposer,
      $$AppCacheTableCreateCompanionBuilder,
      $$AppCacheTableUpdateCompanionBuilder,
      (
        AppCacheData,
        BaseReferences<_$AppStorage, $AppCacheTable, AppCacheData>,
      ),
      AppCacheData,
      PrefetchHooks Function()
    >;
typedef $$ReaderSettingsTableCreateCompanionBuilder =
    ReaderSettingsCompanion Function({
      Value<int> id,
      Value<double> readingFontSize,
      Value<String> readingFontType,
    });
typedef $$ReaderSettingsTableUpdateCompanionBuilder =
    ReaderSettingsCompanion Function({
      Value<int> id,
      Value<double> readingFontSize,
      Value<String> readingFontType,
    });

class $$ReaderSettingsTableFilterComposer
    extends Composer<_$AppStorage, $ReaderSettingsTable> {
  $$ReaderSettingsTableFilterComposer({
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

  ColumnFilters<double> get readingFontSize => $composableBuilder(
    column: $table.readingFontSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingFontType => $composableBuilder(
    column: $table.readingFontType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReaderSettingsTableOrderingComposer
    extends Composer<_$AppStorage, $ReaderSettingsTable> {
  $$ReaderSettingsTableOrderingComposer({
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

  ColumnOrderings<double> get readingFontSize => $composableBuilder(
    column: $table.readingFontSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingFontType => $composableBuilder(
    column: $table.readingFontType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReaderSettingsTableAnnotationComposer
    extends Composer<_$AppStorage, $ReaderSettingsTable> {
  $$ReaderSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get readingFontSize => $composableBuilder(
    column: $table.readingFontSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingFontType => $composableBuilder(
    column: $table.readingFontType,
    builder: (column) => column,
  );
}

class $$ReaderSettingsTableTableManager
    extends
        RootTableManager<
          _$AppStorage,
          $ReaderSettingsTable,
          ReaderSetting,
          $$ReaderSettingsTableFilterComposer,
          $$ReaderSettingsTableOrderingComposer,
          $$ReaderSettingsTableAnnotationComposer,
          $$ReaderSettingsTableCreateCompanionBuilder,
          $$ReaderSettingsTableUpdateCompanionBuilder,
          (
            ReaderSetting,
            BaseReferences<_$AppStorage, $ReaderSettingsTable, ReaderSetting>,
          ),
          ReaderSetting,
          PrefetchHooks Function()
        > {
  $$ReaderSettingsTableTableManager(_$AppStorage db, $ReaderSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReaderSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReaderSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReaderSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> readingFontSize = const Value.absent(),
                Value<String> readingFontType = const Value.absent(),
              }) => ReaderSettingsCompanion(
                id: id,
                readingFontSize: readingFontSize,
                readingFontType: readingFontType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> readingFontSize = const Value.absent(),
                Value<String> readingFontType = const Value.absent(),
              }) => ReaderSettingsCompanion.insert(
                id: id,
                readingFontSize: readingFontSize,
                readingFontType: readingFontType,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReaderSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppStorage,
      $ReaderSettingsTable,
      ReaderSetting,
      $$ReaderSettingsTableFilterComposer,
      $$ReaderSettingsTableOrderingComposer,
      $$ReaderSettingsTableAnnotationComposer,
      $$ReaderSettingsTableCreateCompanionBuilder,
      $$ReaderSettingsTableUpdateCompanionBuilder,
      (
        ReaderSetting,
        BaseReferences<_$AppStorage, $ReaderSettingsTable, ReaderSetting>,
      ),
      ReaderSetting,
      PrefetchHooks Function()
    >;
typedef $$OfflineBooksTableCreateCompanionBuilder =
    OfflineBooksCompanion Function({
      required String slug,
      Value<String> bookJson,
      Value<int> rowid,
    });
typedef $$OfflineBooksTableUpdateCompanionBuilder =
    OfflineBooksCompanion Function({
      Value<String> slug,
      Value<String> bookJson,
      Value<int> rowid,
    });

class $$OfflineBooksTableFilterComposer
    extends Composer<_$AppStorage, $OfflineBooksTable> {
  $$OfflineBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookJson => $composableBuilder(
    column: $table.bookJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OfflineBooksTableOrderingComposer
    extends Composer<_$AppStorage, $OfflineBooksTable> {
  $$OfflineBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookJson => $composableBuilder(
    column: $table.bookJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OfflineBooksTableAnnotationComposer
    extends Composer<_$AppStorage, $OfflineBooksTable> {
  $$OfflineBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get bookJson =>
      $composableBuilder(column: $table.bookJson, builder: (column) => column);
}

class $$OfflineBooksTableTableManager
    extends
        RootTableManager<
          _$AppStorage,
          $OfflineBooksTable,
          OfflineBook,
          $$OfflineBooksTableFilterComposer,
          $$OfflineBooksTableOrderingComposer,
          $$OfflineBooksTableAnnotationComposer,
          $$OfflineBooksTableCreateCompanionBuilder,
          $$OfflineBooksTableUpdateCompanionBuilder,
          (
            OfflineBook,
            BaseReferences<_$AppStorage, $OfflineBooksTable, OfflineBook>,
          ),
          OfflineBook,
          PrefetchHooks Function()
        > {
  $$OfflineBooksTableTableManager(_$AppStorage db, $OfflineBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfflineBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfflineBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfflineBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> slug = const Value.absent(),
                Value<String> bookJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OfflineBooksCompanion(
                slug: slug,
                bookJson: bookJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String slug,
                Value<String> bookJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OfflineBooksCompanion.insert(
                slug: slug,
                bookJson: bookJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OfflineBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppStorage,
      $OfflineBooksTable,
      OfflineBook,
      $$OfflineBooksTableFilterComposer,
      $$OfflineBooksTableOrderingComposer,
      $$OfflineBooksTableAnnotationComposer,
      $$OfflineBooksTableCreateCompanionBuilder,
      $$OfflineBooksTableUpdateCompanionBuilder,
      (
        OfflineBook,
        BaseReferences<_$AppStorage, $OfflineBooksTable, OfflineBook>,
      ),
      OfflineBook,
      PrefetchHooks Function()
    >;
typedef $$ProgressesTableCreateCompanionBuilder =
    ProgressesCompanion Function({
      required String slug,
      required String progressJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ProgressesTableUpdateCompanionBuilder =
    ProgressesCompanion Function({
      Value<String> slug,
      Value<String> progressJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProgressesTableFilterComposer
    extends Composer<_$AppStorage, $ProgressesTable> {
  $$ProgressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get progressJson => $composableBuilder(
    column: $table.progressJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgressesTableOrderingComposer
    extends Composer<_$AppStorage, $ProgressesTable> {
  $$ProgressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get progressJson => $composableBuilder(
    column: $table.progressJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgressesTableAnnotationComposer
    extends Composer<_$AppStorage, $ProgressesTable> {
  $$ProgressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get progressJson => $composableBuilder(
    column: $table.progressJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProgressesTableTableManager
    extends
        RootTableManager<
          _$AppStorage,
          $ProgressesTable,
          ProgressesData,
          $$ProgressesTableFilterComposer,
          $$ProgressesTableOrderingComposer,
          $$ProgressesTableAnnotationComposer,
          $$ProgressesTableCreateCompanionBuilder,
          $$ProgressesTableUpdateCompanionBuilder,
          (
            ProgressesData,
            BaseReferences<_$AppStorage, $ProgressesTable, ProgressesData>,
          ),
          ProgressesData,
          PrefetchHooks Function()
        > {
  $$ProgressesTableTableManager(_$AppStorage db, $ProgressesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> slug = const Value.absent(),
                Value<String> progressJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressesCompanion(
                slug: slug,
                progressJson: progressJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String slug,
                required String progressJson,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressesCompanion.insert(
                slug: slug,
                progressJson: progressJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgressesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppStorage,
      $ProgressesTable,
      ProgressesData,
      $$ProgressesTableFilterComposer,
      $$ProgressesTableOrderingComposer,
      $$ProgressesTableAnnotationComposer,
      $$ProgressesTableCreateCompanionBuilder,
      $$ProgressesTableUpdateCompanionBuilder,
      (
        ProgressesData,
        BaseReferences<_$AppStorage, $ProgressesTable, ProgressesData>,
      ),
      ProgressesData,
      PrefetchHooks Function()
    >;
typedef $$SyncInfoTableCreateCompanionBuilder =
    SyncInfoCompanion Function({
      Value<int> id,
      Value<DateTime?> receivedProgressSyncAt,
      Value<DateTime?> sentProgressSyncAt,
      Value<DateTime?> receivedLikesSyncAt,
      Value<DateTime?> sentLikesSyncAt,
      Value<DateTime?> receivedBookmarksSyncAt,
      Value<DateTime?> sentBookmarksSyncAt,
    });
typedef $$SyncInfoTableUpdateCompanionBuilder =
    SyncInfoCompanion Function({
      Value<int> id,
      Value<DateTime?> receivedProgressSyncAt,
      Value<DateTime?> sentProgressSyncAt,
      Value<DateTime?> receivedLikesSyncAt,
      Value<DateTime?> sentLikesSyncAt,
      Value<DateTime?> receivedBookmarksSyncAt,
      Value<DateTime?> sentBookmarksSyncAt,
    });

class $$SyncInfoTableFilterComposer
    extends Composer<_$AppStorage, $SyncInfoTable> {
  $$SyncInfoTableFilterComposer({
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

  ColumnFilters<DateTime> get receivedProgressSyncAt => $composableBuilder(
    column: $table.receivedProgressSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentProgressSyncAt => $composableBuilder(
    column: $table.sentProgressSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedLikesSyncAt => $composableBuilder(
    column: $table.receivedLikesSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentLikesSyncAt => $composableBuilder(
    column: $table.sentLikesSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedBookmarksSyncAt => $composableBuilder(
    column: $table.receivedBookmarksSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentBookmarksSyncAt => $composableBuilder(
    column: $table.sentBookmarksSyncAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncInfoTableOrderingComposer
    extends Composer<_$AppStorage, $SyncInfoTable> {
  $$SyncInfoTableOrderingComposer({
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

  ColumnOrderings<DateTime> get receivedProgressSyncAt => $composableBuilder(
    column: $table.receivedProgressSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentProgressSyncAt => $composableBuilder(
    column: $table.sentProgressSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedLikesSyncAt => $composableBuilder(
    column: $table.receivedLikesSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentLikesSyncAt => $composableBuilder(
    column: $table.sentLikesSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedBookmarksSyncAt => $composableBuilder(
    column: $table.receivedBookmarksSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentBookmarksSyncAt => $composableBuilder(
    column: $table.sentBookmarksSyncAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncInfoTableAnnotationComposer
    extends Composer<_$AppStorage, $SyncInfoTable> {
  $$SyncInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedProgressSyncAt => $composableBuilder(
    column: $table.receivedProgressSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentProgressSyncAt => $composableBuilder(
    column: $table.sentProgressSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get receivedLikesSyncAt => $composableBuilder(
    column: $table.receivedLikesSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentLikesSyncAt => $composableBuilder(
    column: $table.sentLikesSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get receivedBookmarksSyncAt => $composableBuilder(
    column: $table.receivedBookmarksSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentBookmarksSyncAt => $composableBuilder(
    column: $table.sentBookmarksSyncAt,
    builder: (column) => column,
  );
}

class $$SyncInfoTableTableManager
    extends
        RootTableManager<
          _$AppStorage,
          $SyncInfoTable,
          SyncInfoData,
          $$SyncInfoTableFilterComposer,
          $$SyncInfoTableOrderingComposer,
          $$SyncInfoTableAnnotationComposer,
          $$SyncInfoTableCreateCompanionBuilder,
          $$SyncInfoTableUpdateCompanionBuilder,
          (
            SyncInfoData,
            BaseReferences<_$AppStorage, $SyncInfoTable, SyncInfoData>,
          ),
          SyncInfoData,
          PrefetchHooks Function()
        > {
  $$SyncInfoTableTableManager(_$AppStorage db, $SyncInfoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> receivedProgressSyncAt = const Value.absent(),
                Value<DateTime?> sentProgressSyncAt = const Value.absent(),
                Value<DateTime?> receivedLikesSyncAt = const Value.absent(),
                Value<DateTime?> sentLikesSyncAt = const Value.absent(),
                Value<DateTime?> receivedBookmarksSyncAt = const Value.absent(),
                Value<DateTime?> sentBookmarksSyncAt = const Value.absent(),
              }) => SyncInfoCompanion(
                id: id,
                receivedProgressSyncAt: receivedProgressSyncAt,
                sentProgressSyncAt: sentProgressSyncAt,
                receivedLikesSyncAt: receivedLikesSyncAt,
                sentLikesSyncAt: sentLikesSyncAt,
                receivedBookmarksSyncAt: receivedBookmarksSyncAt,
                sentBookmarksSyncAt: sentBookmarksSyncAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> receivedProgressSyncAt = const Value.absent(),
                Value<DateTime?> sentProgressSyncAt = const Value.absent(),
                Value<DateTime?> receivedLikesSyncAt = const Value.absent(),
                Value<DateTime?> sentLikesSyncAt = const Value.absent(),
                Value<DateTime?> receivedBookmarksSyncAt = const Value.absent(),
                Value<DateTime?> sentBookmarksSyncAt = const Value.absent(),
              }) => SyncInfoCompanion.insert(
                id: id,
                receivedProgressSyncAt: receivedProgressSyncAt,
                sentProgressSyncAt: sentProgressSyncAt,
                receivedLikesSyncAt: receivedLikesSyncAt,
                sentLikesSyncAt: sentLikesSyncAt,
                receivedBookmarksSyncAt: receivedBookmarksSyncAt,
                sentBookmarksSyncAt: sentBookmarksSyncAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncInfoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppStorage,
      $SyncInfoTable,
      SyncInfoData,
      $$SyncInfoTableFilterComposer,
      $$SyncInfoTableOrderingComposer,
      $$SyncInfoTableAnnotationComposer,
      $$SyncInfoTableCreateCompanionBuilder,
      $$SyncInfoTableUpdateCompanionBuilder,
      (
        SyncInfoData,
        BaseReferences<_$AppStorage, $SyncInfoTable, SyncInfoData>,
      ),
      SyncInfoData,
      PrefetchHooks Function()
    >;
typedef $$LikesTableCreateCompanionBuilder =
    LikesCompanion Function({
      required String slug,
      Value<bool> isLiked,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$LikesTableUpdateCompanionBuilder =
    LikesCompanion Function({
      Value<String> slug,
      Value<bool> isLiked,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$LikesTableFilterComposer extends Composer<_$AppStorage, $LikesTable> {
  $$LikesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LikesTableOrderingComposer extends Composer<_$AppStorage, $LikesTable> {
  $$LikesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LikesTableAnnotationComposer
    extends Composer<_$AppStorage, $LikesTable> {
  $$LikesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<bool> get isLiked =>
      $composableBuilder(column: $table.isLiked, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LikesTableTableManager
    extends
        RootTableManager<
          _$AppStorage,
          $LikesTable,
          Like,
          $$LikesTableFilterComposer,
          $$LikesTableOrderingComposer,
          $$LikesTableAnnotationComposer,
          $$LikesTableCreateCompanionBuilder,
          $$LikesTableUpdateCompanionBuilder,
          (Like, BaseReferences<_$AppStorage, $LikesTable, Like>),
          Like,
          PrefetchHooks Function()
        > {
  $$LikesTableTableManager(_$AppStorage db, $LikesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LikesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LikesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LikesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> slug = const Value.absent(),
                Value<bool> isLiked = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LikesCompanion(
                slug: slug,
                isLiked: isLiked,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String slug,
                Value<bool> isLiked = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LikesCompanion.insert(
                slug: slug,
                isLiked: isLiked,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LikesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppStorage,
      $LikesTable,
      Like,
      $$LikesTableFilterComposer,
      $$LikesTableOrderingComposer,
      $$LikesTableAnnotationComposer,
      $$LikesTableCreateCompanionBuilder,
      $$LikesTableUpdateCompanionBuilder,
      (Like, BaseReferences<_$AppStorage, $LikesTable, Like>),
      Like,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      required String id,
      required String slug,
      required String progressJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<String> id,
      Value<String> slug,
      Value<String> progressJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BookmarksTableFilterComposer
    extends Composer<_$AppStorage, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
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

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get progressJson => $composableBuilder(
    column: $table.progressJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppStorage, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
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

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get progressJson => $composableBuilder(
    column: $table.progressJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppStorage, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get progressJson => $composableBuilder(
    column: $table.progressJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppStorage,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, BaseReferences<_$AppStorage, $BookmarksTable, Bookmark>),
          Bookmark,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$AppStorage db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> progressJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                slug: slug,
                progressJson: progressJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String slug,
                required String progressJson,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion.insert(
                id: id,
                slug: slug,
                progressJson: progressJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppStorage,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, BaseReferences<_$AppStorage, $BookmarksTable, Bookmark>),
      Bookmark,
      PrefetchHooks Function()
    >;

class $AppStorageManager {
  final _$AppStorage _db;
  $AppStorageManager(this._db);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$AppCacheTableTableManager get appCache =>
      $$AppCacheTableTableManager(_db, _db.appCache);
  $$ReaderSettingsTableTableManager get readerSettings =>
      $$ReaderSettingsTableTableManager(_db, _db.readerSettings);
  $$OfflineBooksTableTableManager get offlineBooks =>
      $$OfflineBooksTableTableManager(_db, _db.offlineBooks);
  $$ProgressesTableTableManager get progresses =>
      $$ProgressesTableTableManager(_db, _db.progresses);
  $$SyncInfoTableTableManager get syncInfo =>
      $$SyncInfoTableTableManager(_db, _db.syncInfo);
  $$LikesTableTableManager get likes =>
      $$LikesTableTableManager(_db, _db.likes);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
}
