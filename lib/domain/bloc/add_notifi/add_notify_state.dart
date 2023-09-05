part of 'add_notify_cubit.dart';

class AddNotifyState extends Equatable {
  String color;
  String title;
  String note;
  String noteMess;
  String titleMess;
  String dateSaveTask;
  AddNotifiStatus status;
  String timeStart;
  String timeEnd;
  int indexRemind;
  String remind;

  AddNotifyState({
    required this.color,
    required this.status,
    required this.dateSaveTask,
    required this.timeStart,
    required this.timeEnd,
    required this.indexRemind,
    required this.remind,
    required this.title,
    required this.note,
    required this.noteMess,
    required this.titleMess,

    //this.user,
  });
  factory AddNotifyState.initial() {
    return AddNotifyState(
      indexRemind: 0,
      remind: '0 minutes early',
      color: 'blue',
      note: '',
      title: '',
      noteMess: '',
      titleMess: '',
      dateSaveTask: formatDateInput.format(DateTime.now()),
      timeStart: formatTimeInput.format(DateTime.now()),
      timeEnd: formatTimeInput.format(DateTime.now()),
      status: AddNotifiStatus.initial,
      //user: null,
    );
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        color,
        status,
        dateSaveTask,
        title,
        note,
        noteMess,
        titleMess,
        timeEnd,
        timeStart,
        indexRemind,
        remind,
      ];

  AddNotifyState copyWith(
      {String? color,
      AddNotifiStatus? status,
      String? dateSave,
      String? remind,
      int? indexRemind,
      String? timeEnd,
      String? titleMess,
      String? note,
      String? title,
      String? noteMess,
      String? timeStart
      // auth.user? user,
      }) {
    return AddNotifyState(
      timeEnd: timeEnd ?? this.timeEnd,
      timeStart: timeStart ?? this.timeStart,
      color: color ?? this.color,
      note: note ?? this.note,
      title: title ?? this.title,
      noteMess: noteMess ?? this.noteMess,
      titleMess: titleMess ?? this.titleMess,
      remind: remind ?? this.remind,
      indexRemind: indexRemind ?? this.indexRemind,
      dateSaveTask: dateSave ?? dateSaveTask,
      status: status ?? this.status,
      //user: user ?? this.user,
    );
  }
}
