import '../../../data/local/drift/db/db_app.dart';
import '../../../data/local/models/task_notify.dart';

extension TaskModel on NotifyTaskData {
  TaskNotify toGetNotifyTask() {
    return TaskNotify(
        id: id,
        title: title,
        note: note,
        isCompleted: isCompleted,
        ringDay: ringDay,
        daySave: daySave,
        startTime: startTime,
        endTime: endTime,
        color: color,
        remind: remind);
  }
}
