part of 'add_pre_cubit.dart';

class AddPreHWState extends Equatable {
  String color;
  String week;
  String sNum;
  String eNum;
  String numQ;
  List<String> sign;
  String weekMess;
  String numQMess;
  String eNumMess;
  String sNumMess;
  String statusPre;
  AddPreHWStatus status;
  String timeStart;
  String dayStart;
  String dayEnd;
  String timeEnd;

  AddPreHWState({
    required this.color,
    required this.status,
    required this.timeStart,
    required this.timeEnd,
    required this.week,
    required this.numQ,
    required this.sign,
    required this.dayEnd,
    required this.statusPre,
    required this.dayStart,
    required this.eNum,
    required this.sNum,
    required this.sNumMess,
    required this.weekMess,
    required this.numQMess,
    required this.eNumMess,

    //this.user,
  });
  factory AddPreHWState.initial(
      ) {
    return AddPreHWState(
      color: 'blue',
      numQ: '',
      week: '',
      weekMess: '',
      dayEnd: formatDateInput.format(DateTime.now()),
      dayStart: formatDateInput.format(DateTime.now()),
      numQMess: '',
      sign: [],
      timeStart: formatTimeInput.format(DateTime.now()),
      timeEnd: formatTimeInput.format(DateTime.now()),
      status: AddPreHWStatus.initial,
      eNum: "",
      sNum: "",
      sNumMess: '',
      eNumMess: '', statusPre: 'GOING',
      //user: null,
    );
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        color,
        status,
        week,
        numQ,
        sign,
        dayStart,
        dayEnd,
        sNum,
        eNum,
        sNumMess,
        eNumMess,
        weekMess,
        numQMess,
        timeEnd,
        timeStart,
      ];

  AddPreHWState copyWith(
      {String? color,
      AddPreHWStatus? status,
      String? timeEnd,
      String? weekMess,
      String? numQ,
      String? week,
      String? numQMess,
      String? sNum,
      String? eNum,
      List<String>? sign,
      String? sNumMess,
      String? eNumMess,
      String? timeStart,
      String? dayStart,
      String? statusPre,
      String? dayEnd
      // auth.user? user,
      }) {
    return AddPreHWState(
        timeEnd: timeEnd ?? this.timeEnd,
        timeStart: timeStart ?? this.timeStart,
        color: color ?? this.color,
        numQ: numQ ?? this.numQ,
        week: week ?? this.week,
        statusPre: statusPre ?? this.statusPre,
        weekMess: numQMess ?? this.weekMess,
        numQMess: weekMess ?? this.numQMess,
        status: status ?? this.status,
        eNum: eNum ?? this.eNum,
        sNum: sNum ?? this.sNum,
        sNumMess: sNumMess ?? this.sNumMess,
        eNumMess: eNumMess ?? this.eNumMess,
        sign: sign ?? this.sign,
        dayEnd: dayEnd ?? this.dayEnd,
        dayStart: dayStart ?? this.dayStart
        //user: user ?? this.user,
        );
  }
}
