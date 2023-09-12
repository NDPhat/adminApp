import 'package:admin/data/remote/api/api/pre_hw_repo.dart';
import 'package:admin/data/remote/api/api/result_hw_repo.dart';
import 'package:admin/data/remote/api/api/user_repo.dart';
import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:admin/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../application/utils/status/add_pre_hw.dart';
import '../../../application/utils/time_change/format.dart';
import '../../../data/local/models/dataUser.dart';
import '../../../data/local/models/pre_global.dart';
import '../../../data/remote/models/result_hw_req.dart';
import '../../../data/remote/models/user_res.dart';

part 'detail_pre_state.dart';

class DetailPreHWCubit extends Cubit<DetailPreHWState> {
  String sNumMess = "";
  String eNumMess = "";
  String numQMess = "";
  String weekMess = "";

  final PreHWAPIRepo preHWAPIRepo;
  final UserAPIRepo userAPIRepo;
  final ResultHWAPIRepo resultHWAPIRepo;

  DetailPreHWCubit(
      {required this.preHWAPIRepo,
      required this.resultHWAPIRepo,
      required this.userAPIRepo})
      : super(DetailPreHWState.initial());

  void colorChange(String color) {
    emit(state.copyWith(color: color, status: AddPreHWStatus.initial));
  }

  void emitStartTimeChange(String time) {
    emit(state.copyWith(timeStart: time));
  }

  void emitEndTimeChange(String time) {
    emit(state.copyWith(timeEnd: time));
  }

  void dayEndChange(String time) {
    emit(state.copyWith(dayEnd: time));
  }

  void dayStartChange(String time) {
    emit(state.copyWith(dayStart: time));
  }

  void weekChanged(String value) {
    state.week = value;
  }

  void numQChanged(String value) {
    state.numQ = value;
  }

  void sNumChanged(String value) {
    state.sNum = value;
  }

  void eNumChanged(String value) {
    state.eNum = value;
  }

  void signChanged(List<String> value) {
    state.sign = value;
  }

  void clearOldDataErrorForm() {
    emit(state.copyWith(status: AddPreHWStatus.initial));
  }

  void clearForm() {
    emit(state.copyWith(
      color: 'blue',
      numQ: '',
      week: '',
      numQMess: '',
      weekMess: '',
      timeStart: DateFormat('hh:mm aa').format(DateTime.now()),
      timeEnd: DateFormat('hh:mm aa').format(DateTime.now()),
      status: AddPreHWStatus.initial,
    ));
  }

  bool weekValidator(String week) {
    if (week.isEmpty) {
      weekMess = 'Fill this blank';
      return false;
    } else {
      weekMess = "";
      return true;
    }
  }

  bool numQValidator(String numQ) {
    if (numQ.isEmpty) {
      numQMess = 'Fill this blank';
      return false;
    } else {
      numQMess = "";
      return true;
    }
  }

  bool sNumValidator(String sNum) {
    if (sNum.isEmpty) {
      sNumMess = 'Fill this blank';
      return false;
    } else {
      sNumMess = "";
      return true;
    }
  }

  bool eNumValidator(String eNum) {
    if (eNum.isEmpty) {
      eNumMess = 'Fill this blank';
      return false;
    } else {
      eNumMess = "";
      return true;
    }
  }

  bool isFormValid() {
    if (numQValidator(state.numQ) &
        weekValidator(state.week) &
        sNumValidator(state.sNum) &
        eNumValidator(state.eNum)) {
      return true;
    }
    return false;
  }

  Future<void> updatePreHW(String key) async {
    emit(state.copyWith(status: AddPreHWStatus.submit));
    if (isFormValid()) {
      try {
        bool? data = await preHWAPIRepo.updatePreHW(
            PreHWAPIReq(
              week: state.week,
              dstart: "${state.timeStart.trim()} ${state.dayStart.trim()}",
              dend: "${state.timeEnd.trim()} ${state.dayEnd.trim()}",
              sign: state.sign,
              sNum: int.parse(state.sNum),
              numQ: int.parse(state.numQ),
              eNum: int.parse(state.eNum),
              color: state.color,
              status: state.statusPre,
            ),
            key);
        if (data == true) {
          emit(state.copyWith(status: AddPreHWStatus.success));
        } else {
          emit(state.copyWith(status: AddPreHWStatus.error));
        }
      } on Exception catch (e) {}
    } else {
      emit(state.copyWith(
          status: AddPreHWStatus.error,
          weekMess: weekMess,
          sNumMess: sNumMess,
          numQMess: numQMess,
          eNumMess: eNumMess));
    }
  }

  getALlListStudentDoNotJoinHW(String lop, String week) async {
    List<UserAPIModel>? dataUserRes =
        await userAPIRepo.getAllStudentByClass(lop);
    List<ResultHWAPIModel>? dataRS =
        await resultHWAPIRepo.getAllResultQuizHWByWeekAndLop(week, lop);
    List<DataUser> dataUserLocal = [];
    List<DataUser> dataUserJoin = [];
    List<DataUser> dataUserNotJoin = [];

    dataUserRes!.forEach((element) {
      dataUserLocal.add(DataUser(key: element.key!, name: element.fullName!));
    });
    dataRS!.forEach((element) {
      dataUserJoin.add(DataUser(key: element.userId!, name: element.name!));
    });
    for (final e in dataUserLocal) {
      bool found = false;
      for (final f in dataUserJoin) {
        if (e.key == f.key) {
          found = true;
          break;
        }
      }
      if (!found) {
        dataUserNotJoin.add(e);
      }
    }
    if (dataUserNotJoin.isNotEmpty) {
      dataUserNotJoin.forEach((element) async {
        resultHWAPIRepo.createResultHWForStudentNoJoin(ResultHWAPIReq(
            week: week,
            lop: lop,
            numQ: 10,
            score: 0,
            trueQ: 0,
            status: "DONE",
            dateSave: formatDateInput.format(DateTime.now()),
            falseQ: 0,
            userId: element.key,
            name: element.name));
      });
    }
  }

  Future<void> updatePreHWToDone(String key, String week, String lop) async {
    emit(state.copyWith(status: AddPreHWStatus.updating));
    if (isFormValid()) {
      getALlListStudentDoNotJoinHW(lop, week);
      bool? data = await preHWAPIRepo.updatePreHW(
          PreHWAPIReq(
            week: state.week,
            dstart: "${state.timeStart} ${state.dayStart}",
            dend: "${state.timeEnd} ${state.dayEnd}",
            sign: state.sign,
            sNum: int.parse(state.sNum),
            numQ: int.parse(state.numQ),
            eNum: int.parse(state.eNum),
            color: state.color,
            status: "DONE",
          ),
          key);
      if (data == true) {
        emit(state.copyWith(status: AddPreHWStatus.success));
      } else {
        emit(state.copyWith(status: AddPreHWStatus.error));
      }
    } else {
      emit(state.copyWith(
          status: AddPreHWStatus.error,
          weekMess: weekMess,
          sNumMess: sNumMess,
          numQMess: numQMess,
          eNumMess: eNumMess));
    }
  }
}
