part of 'detail_pre_cubit.dart';

class DetailPreHWState extends Equatable {
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

  DetailPreHWState({
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
  factory DetailPreHWState.initial(
      ) {
    return DetailPreHWState(
      color: instance.get<PreGlobal>().color ?? 'blue',
      numQ: instance.get<PreGlobal>().numQ.toString() ?? '',
      week: instance.get<PreGlobal>().week ?? '',
      weekMess: '',
      dayEnd: convertToDate(instance.get<PreGlobal>().dend!.split(" ")[1]) ??
          (formatDateView.format((DateTime.now()))),
      dayStart:
          convertToDate(instance.get<PreGlobal>().dstart!.split(" ")[1]) ??
              (formatDateView.format((DateTime.now()))),
      numQMess: '',
      sign: instance.get<PreGlobal>().sign ?? [],
      timeStart: instance.get<PreGlobal>().dstart!.split(" ")[0].toString(),
      timeEnd: instance.get<PreGlobal>().dend!.split(" ")[0].toString(),
      status: AddPreHWStatus.initial,
      eNum: instance.get<PreGlobal>().eNum.toString() ?? "",
      sNum: instance.get<PreGlobal>().sNum.toString() ?? "",
      sNumMess: '',
      eNumMess: '', statusPre: instance.get<PreGlobal>().status ?? 'GOING',
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

  DetailPreHWState copyWith(
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
    return DetailPreHWState(
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
