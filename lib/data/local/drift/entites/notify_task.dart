import 'package:drift/drift.dart';

class NotifyTask extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get note => text().named('note')();
  IntColumn get isCompleted => integer().named("isCompleted")();
  TextColumn get daySave => text().named('dateSave')();
  TextColumn get ringDay => text().named('ringDay')();
  TextColumn get startTime => text().named('startTime')();
  TextColumn get endTime => text().named('endTime')();
  TextColumn get color => text().named('color')();
  TextColumn get remind => text().named('remind')();
}
