import 'package:drift/drift.dart';

import '../../drift/db/db_app.dart';
import 'notoify_task_repo.dart';

class NotifyTaskRepoImpl extends NotifyTaskLocalRepo {
  NotifyTaskRepoImpl(super.appDb);

  @override
  Future<void> delete(int id) async {
    // TODO: implement delete
    await (appDb.delete(appDb.notifyTask)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<NotifyTaskCompanion> getNotifyTask(int id) {
    // TODO: implement getNotifyTask
    throw UnimplementedError();
  }

  @override
  Future<void> insert(NotifyTaskCompanion entityCompanion) async {
    // TODO: implement insert
    await appDb.into(appDb.notifyTask).insert(entityCompanion);
  }

  @override
  Future<void> completeNotifyTask(int id) async {
    // TODO: implement update
    (appDb.update(appDb.notifyTask)..where((tbl) => tbl.id.equals(id)))
        .write(const NotifyTaskCompanion(isCompleted: Value(1)));
  }

  @override
  Stream<List<NotifyTaskData>> getAllTask() async* {
    // TODO: implement getAllTask
    yield* (appDb.select(appDb.notifyTask)).watch();
  }

  @override
  Stream<List<NotifyTaskData>> getAllTaskByDay(String dayNeeded) async* {
    yield* (appDb.select(appDb.notifyTask)
          ..where((tbl) => tbl.daySave.equals(dayNeeded)))
        .watch();
  }

  @override
  Future<NotifyTaskData> getLatestTask() async {
    List<NotifyTaskData> list = await (appDb.select(appDb.notifyTask)
          ..orderBy(
              [(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
        .get();
    return list.first;
  }
}
