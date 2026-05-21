// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duo_db.dart';

// ignore_for_file: type=lint
mixin _$PlanItemDaoMixin on DatabaseAccessor<DuoDatabase> {
  $DbPlanItemTable get dbPlanItem => attachedDatabase.dbPlanItem;
}

class $DbPlanItemTable extends DbPlanItem
    with TableInfo<$DbPlanItemTable, DbPlanItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbPlanItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
      'duration', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _intensityMeta =
      const VerificationMeta('intensity');
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
      'intensity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _studentNameMeta =
      const VerificationMeta('studentName');
  @override
  late final GeneratedColumn<String> studentName = GeneratedColumn<String>(
      'student_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSelfStudyMeta =
      const VerificationMeta('isSelfStudy');
  @override
  late final GeneratedColumn<bool> isSelfStudy = GeneratedColumn<bool>(
      'is_self_study', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_self_study" IN (0, 1))'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, duration, intensity, studentName, isSelfStudy, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_plan_item';
  @override
  VerificationContext validateIntegrity(Insertable<DbPlanItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('intensity')) {
      context.handle(_intensityMeta,
          intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta));
    } else if (isInserting) {
      context.missing(_intensityMeta);
    }
    if (data.containsKey('student_name')) {
      context.handle(
          _studentNameMeta,
          studentName.isAcceptableOrUnknown(
              data['student_name']!, _studentNameMeta));
    } else if (isInserting) {
      context.missing(_studentNameMeta);
    }
    if (data.containsKey('is_self_study')) {
      context.handle(
          _isSelfStudyMeta,
          isSelfStudy.isAcceptableOrUnknown(
              data['is_self_study']!, _isSelfStudyMeta));
    } else if (isInserting) {
      context.missing(_isSelfStudyMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbPlanItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbPlanItemData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}duration'])!,
      intensity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}intensity'])!,
      studentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_name'])!,
      isSelfStudy: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_self_study'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $DbPlanItemTable createAlias(String alias) {
    return $DbPlanItemTable(attachedDatabase, alias);
  }
}

class DbPlanItemData extends DataClass implements Insertable<DbPlanItemData> {
  final int id;
  final String name;
  final String duration;
  final int intensity;
  final String studentName;
  final bool isSelfStudy;
  final DateTime date;
  const DbPlanItemData(
      {required this.id,
      required this.name,
      required this.duration,
      required this.intensity,
      required this.studentName,
      required this.isSelfStudy,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['duration'] = Variable<String>(duration);
    map['intensity'] = Variable<int>(intensity);
    map['student_name'] = Variable<String>(studentName);
    map['is_self_study'] = Variable<bool>(isSelfStudy);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  DbPlanItemCompanion toCompanion(bool nullToAbsent) {
    return DbPlanItemCompanion(
      id: Value(id),
      name: Value(name),
      duration: Value(duration),
      intensity: Value(intensity),
      studentName: Value(studentName),
      isSelfStudy: Value(isSelfStudy),
      date: Value(date),
    );
  }

  factory DbPlanItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbPlanItemData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      duration: serializer.fromJson<String>(json['duration']),
      intensity: serializer.fromJson<int>(json['intensity']),
      studentName: serializer.fromJson<String>(json['studentName']),
      isSelfStudy: serializer.fromJson<bool>(json['isSelfStudy']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'duration': serializer.toJson<String>(duration),
      'intensity': serializer.toJson<int>(intensity),
      'studentName': serializer.toJson<String>(studentName),
      'isSelfStudy': serializer.toJson<bool>(isSelfStudy),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  DbPlanItemData copyWith(
          {int? id,
          String? name,
          String? duration,
          int? intensity,
          String? studentName,
          bool? isSelfStudy,
          DateTime? date}) =>
      DbPlanItemData(
        id: id ?? this.id,
        name: name ?? this.name,
        duration: duration ?? this.duration,
        intensity: intensity ?? this.intensity,
        studentName: studentName ?? this.studentName,
        isSelfStudy: isSelfStudy ?? this.isSelfStudy,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('DbPlanItemData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('duration: $duration, ')
          ..write('intensity: $intensity, ')
          ..write('studentName: $studentName, ')
          ..write('isSelfStudy: $isSelfStudy, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, duration, intensity, studentName, isSelfStudy, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPlanItemData &&
          other.id == this.id &&
          other.name == this.name &&
          other.duration == this.duration &&
          other.intensity == this.intensity &&
          other.studentName == this.studentName &&
          other.isSelfStudy == this.isSelfStudy &&
          other.date == this.date);
}

class DbPlanItemCompanion extends UpdateCompanion<DbPlanItemData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> duration;
  final Value<int> intensity;
  final Value<String> studentName;
  final Value<bool> isSelfStudy;
  final Value<DateTime> date;
  const DbPlanItemCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.duration = const Value.absent(),
    this.intensity = const Value.absent(),
    this.studentName = const Value.absent(),
    this.isSelfStudy = const Value.absent(),
    this.date = const Value.absent(),
  });
  DbPlanItemCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String duration,
    required int intensity,
    required String studentName,
    required bool isSelfStudy,
    required DateTime date,
  })  : name = Value(name),
        duration = Value(duration),
        intensity = Value(intensity),
        studentName = Value(studentName),
        isSelfStudy = Value(isSelfStudy),
        date = Value(date);
  static Insertable<DbPlanItemData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? duration,
    Expression<int>? intensity,
    Expression<String>? studentName,
    Expression<bool>? isSelfStudy,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (duration != null) 'duration': duration,
      if (intensity != null) 'intensity': intensity,
      if (studentName != null) 'student_name': studentName,
      if (isSelfStudy != null) 'is_self_study': isSelfStudy,
      if (date != null) 'date': date,
    });
  }

  DbPlanItemCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? duration,
      Value<int>? intensity,
      Value<String>? studentName,
      Value<bool>? isSelfStudy,
      Value<DateTime>? date}) {
    return DbPlanItemCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      intensity: intensity ?? this.intensity,
      studentName: studentName ?? this.studentName,
      isSelfStudy: isSelfStudy ?? this.isSelfStudy,
      date: date ?? this.date,
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
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (studentName.present) {
      map['student_name'] = Variable<String>(studentName.value);
    }
    if (isSelfStudy.present) {
      map['is_self_study'] = Variable<bool>(isSelfStudy.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbPlanItemCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('duration: $duration, ')
          ..write('intensity: $intensity, ')
          ..write('studentName: $studentName, ')
          ..write('isSelfStudy: $isSelfStudy, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$DuoDatabase extends GeneratedDatabase {
  _$DuoDatabase(QueryExecutor e) : super(e);
  late final $DbPlanItemTable dbPlanItem = $DbPlanItemTable(this);
  late final PlanItemDao planItemDao = PlanItemDao(this as DuoDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dbPlanItem];
}
