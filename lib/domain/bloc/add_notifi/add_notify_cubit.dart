import 'package:admin/application/utils/extension/notify_ex.dart';
import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../application/utils/status/add_notify.dart';
import '../../../application/utils/time_change/format.dart';
import '../../../data/local/drift/db/db_app.dart';
import '../../../data/local/notify/notifi_helper.dart';
import '../../../data/local/repo/notify_task/notoify_task_repo.dart';

part 'add_notify_state.dart';

class AddNotifyCubit extends Cubit<AddNotifyState> {
  String titleMess = "";
  String noteMess = "";
  final NotifyTaskLocalRepo notifyTaskRepo;
  AddNotifyCubit({required this.notifyTaskRepo})
      : super(AddNotifyState.initial());
  void colorChange(String color) {
    emit(state.copyWith(color: color, status: AddNotifiStatus.initial));
  }

  void dateTimeChange(String date) {
    state.dateSaveTask = date;
  }

  void emitDateTimeChange(String date) {
    emit(state.copyWith(dateSave: date));
  }

  void emitStartTimeChange(String time) {
    emit(state.copyWith(timeStart: time));
  }

  void emitEndTimeChange(String time) {
    emit(state.copyWith(timeEnd: time));
  }

  void remindChange(int value) {
    emit(state.copyWith(indexRemind: value));
  }

  void titleChanged(String value) {
    state.title = value;
    if (state.titleMess.isNotEmpty) {
      emit(state.copyWith(titleMess: ""));
    }
  }

  void noteChanged(String value) {
    state.note = value;
    if (state.noteMess.isNotEmpty) {
      emit(state.copyWith(noteMess: ""));
    }
  }

  void remindSelected(String value) {
    emit(state.copyWith(remind: value));
  }

  void clearOldDataErrorForm() {
    emit(state.copyWith(status: AddNotifiStatus.initial));
  }

  void clearForm() {
    emit(state.copyWith(
      indexRemind: 0,
      remind: '5 minutes early',
      color: 'blue',
      note: '',
      title: '',
      noteMess: '',
      titleMess: '',
      dateSave: formatDateInput.format(DateTime.now()),
      timeStart: DateFormat('hh:mm aa').format(DateTime.now()),
      timeEnd: DateFormat('hh:mm aa').format(DateTime.now()),
      status: AddNotifiStatus.initial,
    ));
  }

  bool titleValidator(String title) {
    if (title.isEmpty) {
      titleMess = 'Fill this blank';
      return false;
    } else {
      titleMess = "";
      return true;
    }
  }

  bool noteValidator(String note) {
    if (note.isEmpty) {
      noteMess = 'Fill this blank';
      return false;
    } else {
      noteMess = "";
      return true;
    }
  }

  bool isFormValid() {
    if (noteValidator(state.note) & titleValidator(state.title)) {
      return true;
    }
    return false;
  }

  void completeNotifyTask(int id) async {
    notifyTaskRepo.completeNotifyTask(id);
  }

  Future<void> saveTaskToLocal() async {
    if (isFormValid()) {
      try {
        final entity = NotifyTaskCompanion(
          title: Value(state.title),
          note: Value(state.note),
          ringDay: Value(state.dateSaveTask.toString()),
          daySave: Value(formatDateInput.format(DateTime.now())),
          startTime: Value(state.timeStart),
          endTime: Value(state.timeEnd),
          remind: Value(state.remind),
          isCompleted: const Value(0),
          color: Value(state.color),
        );
        //insert task
        await notifyTaskRepo.insert(entity);
        NotifyTaskData task = await notifyTaskRepo.getLatestTask();
        int timeRemind = int.parse(state.remind.split(" ")[0]);
        NotifyHelper().scheduledNotification(
            int.parse(task.startTime.toString().split(":")[0]),
            int.parse(task.startTime.toString().split(":")[1]) - timeRemind,
            task.toGetNotifyTask());
        emit(state.copyWith(status: AddNotifiStatus.success));
      } on Exception catch (e) {
        print(e.toString());
        emit(state.copyWith(
            titleMess: titleMess,
            noteMess: noteMess,
            status: AddNotifiStatus.error));
      }
    } else {
      emit(state.copyWith(
          titleMess: titleMess,
          noteMess: noteMess,
          status: AddNotifiStatus.error));
    }
  }
}
