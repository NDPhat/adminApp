// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_app.dart';

// ignore_for_file: type=lint
class $NotifyTaskTable extends NotifyTask
    with TableInfo<$NotifyTaskTable, NotifyTaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotifyTaskTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<int> isCompleted = GeneratedColumn<int>(
      'isCompleted', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _daySaveMeta =
      const VerificationMeta('daySave');
  @override
  late final GeneratedColumn<String> daySave = GeneratedColumn<String>(
      'dateSave', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ringDayMeta =
      const VerificationMeta('ringDay');
  @override
  late final GeneratedColumn<String> ringDay = GeneratedColumn<String>(
      'ringDay', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
      'startTime', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
      'endTime', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remindMeta = const VerificationMeta('remind');
  @override
  late final GeneratedColumn<String> remind = GeneratedColumn<String>(
      'remind', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        note,
        isCompleted,
        daySave,
        ringDay,
        startTime,
        endTime,
        color,
        remind
      ];
  @override
  String get aliasedName => _alias ?? 'notify_task';
  @override
  String get actualTableName => 'notify_task';
  @override
  VerificationContext validateIntegrity(Insertable<NotifyTaskData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('isCompleted')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['isCompleted']!, _isCompletedMeta));
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    if (data.containsKey('dateSave')) {
      context.handle(_daySaveMeta,
          daySave.isAcceptableOrUnknown(data['dateSave']!, _daySaveMeta));
    } else if (isInserting) {
      context.missing(_daySaveMeta);
    }
    if (data.containsKey('ringDay')) {
      context.handle(_ringDayMeta,
          ringDay.isAcceptableOrUnknown(data['ringDay']!, _ringDayMeta));
    } else if (isInserting) {
      context.missing(_ringDayMeta);
    }
    if (data.containsKey('startTime')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['startTime']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('endTime')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['endTime']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('remind')) {
      context.handle(_remindMeta,
          remind.isAcceptableOrUnknown(data['remind']!, _remindMeta));
    } else if (isInserting) {
      context.missing(_remindMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotifyTaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotifyTaskData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}isCompleted'])!,
      daySave: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dateSave'])!,
      ringDay: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ringDay'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}startTime'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endTime'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      remind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remind'])!,
    );
  }

  @override
  $NotifyTaskTable createAlias(String alias) {
    return $NotifyTaskTable(attachedDatabase, alias);
  }
}

class NotifyTaskData extends DataClass implements Insertable<NotifyTaskData> {
  final int id;
  final String title;
  final String note;
  final int isCompleted;
  final String daySave;
  final String ringDay;
  final String startTime;
  final String endTime;
  final String color;
  final String remind;
  const NotifyTaskData(
      {required this.id,
      required this.title,
      required this.note,
      required this.isCompleted,
      required this.daySave,
      required this.ringDay,
      required this.startTime,
      required this.endTime,
      required this.color,
      required this.remind});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['note'] = Variable<String>(note);
    map['isCompleted'] = Variable<int>(isCompleted);
    map['dateSave'] = Variable<String>(daySave);
    map['ringDay'] = Variable<String>(ringDay);
    map['startTime'] = Variable<String>(startTime);
    map['endTime'] = Variable<String>(endTime);
    map['color'] = Variable<String>(color);
    map['remind'] = Variable<String>(remind);
    return map;
  }

  NotifyTaskCompanion toCompanion(bool nullToAbsent) {
    return NotifyTaskCompanion(
      id: Value(id),
      title: Value(title),
      note: Value(note),
      isCompleted: Value(isCompleted),
      daySave: Value(daySave),
      ringDay: Value(ringDay),
      startTime: Value(startTime),
      endTime: Value(endTime),
      color: Value(color),
      remind: Value(remind),
    );
  }

  factory NotifyTaskData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotifyTaskData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      note: serializer.fromJson<String>(json['note']),
      isCompleted: serializer.fromJson<int>(json['isCompleted']),
      daySave: serializer.fromJson<String>(json['daySave']),
      ringDay: serializer.fromJson<String>(json['ringDay']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
      color: serializer.fromJson<String>(json['color']),
      remind: serializer.fromJson<String>(json['remind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'note': serializer.toJson<String>(note),
      'isCompleted': serializer.toJson<int>(isCompleted),
      'daySave': serializer.toJson<String>(daySave),
      'ringDay': serializer.toJson<String>(ringDay),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'color': serializer.toJson<String>(color),
      'remind': serializer.toJson<String>(remind),
    };
  }

  NotifyTaskData copyWith(
          {int? id,
          String? title,
          String? note,
          int? isCompleted,
          String? daySave,
          String? ringDay,
          String? startTime,
          String? endTime,
          String? color,
          String? remind}) =>
      NotifyTaskData(
        id: id ?? this.id,
        title: title ?? this.title,
        note: note ?? this.note,
        isCompleted: isCompleted ?? this.isCompleted,
        daySave: daySave ?? this.daySave,
        ringDay: ringDay ?? this.ringDay,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        color: color ?? this.color,
        remind: remind ?? this.remind,
      );
  @override
  String toString() {
    return (StringBuffer('NotifyTaskData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('daySave: $daySave, ')
          ..write('ringDay: $ringDay, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('color: $color, ')
          ..write('remind: $remind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, note, isCompleted, daySave,
      ringDay, startTime, endTime, color, remind);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotifyTaskData &&
          other.id == this.id &&
          other.title == this.title &&
          other.note == this.note &&
          other.isCompleted == this.isCompleted &&
          other.daySave == this.daySave &&
          other.ringDay == this.ringDay &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.color == this.color &&
          other.remind == this.remind);
}

class NotifyTaskCompanion extends UpdateCompanion<NotifyTaskData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> note;
  final Value<int> isCompleted;
  final Value<String> daySave;
  final Value<String> ringDay;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<String> color;
  final Value<String> remind;
  const NotifyTaskCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.note = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.daySave = const Value.absent(),
    this.ringDay = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.color = const Value.absent(),
    this.remind = const Value.absent(),
  });
  NotifyTaskCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String note,
    required int isCompleted,
    required String daySave,
    required String ringDay,
    required String startTime,
    required String endTime,
    required String color,
    required String remind,
  })  : title = Value(title),
        note = Value(note),
        isCompleted = Value(isCompleted),
        daySave = Value(daySave),
        ringDay = Value(ringDay),
        startTime = Value(startTime),
        endTime = Value(endTime),
        color = Value(color),
        remind = Value(remind);
  static Insertable<NotifyTaskData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? note,
    Expression<int>? isCompleted,
    Expression<String>? daySave,
    Expression<String>? ringDay,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? color,
    Expression<String>? remind,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (note != null) 'note': note,
      if (isCompleted != null) 'isCompleted': isCompleted,
      if (daySave != null) 'dateSave': daySave,
      if (ringDay != null) 'ringDay': ringDay,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (color != null) 'color': color,
      if (remind != null) 'remind': remind,
    });
  }

  NotifyTaskCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? note,
      Value<int>? isCompleted,
      Value<String>? daySave,
      Value<String>? ringDay,
      Value<String>? startTime,
      Value<String>? endTime,
      Value<String>? color,
      Value<String>? remind}) {
    return NotifyTaskCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted,
      daySave: daySave ?? this.daySave,
      ringDay: ringDay ?? this.ringDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      remind: remind ?? this.remind,
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
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isCompleted.present) {
      map['isCompleted'] = Variable<int>(isCompleted.value);
    }
    if (daySave.present) {
      map['dateSave'] = Variable<String>(daySave.value);
    }
    if (ringDay.present) {
      map['ringDay'] = Variable<String>(ringDay.value);
    }
    if (startTime.present) {
      map['startTime'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['endTime'] = Variable<String>(endTime.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (remind.present) {
      map['remind'] = Variable<String>(remind.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotifyTaskCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('daySave: $daySave, ')
          ..write('ringDay: $ringDay, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('color: $color, ')
          ..write('remind: $remind')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $NotifyTaskTable notifyTask = $NotifyTaskTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notifyTask];
}
