
import '../../drift/db/db_app.dart';

abstract class NotifyTaskLocalRepo {
  //Define DB
  final AppDb appDb;
  //Constructor
  NotifyTaskLocalRepo(this.appDb);
  Future<void> insert(NotifyTaskCompanion entityCompanion);
  Future<void> completeNotifyTask(int id);
  Future<NotifyTaskCompanion> getNotifyTask(int id);
  Stream<List<NotifyTaskData>> getAllTaskByDay(String dayNeeded);
  Stream<List<NotifyTaskData>> getAllTask();
  Future<NotifyTaskData> getLatestTask();
  Future<void> delete(int id);
}
