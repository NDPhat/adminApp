import 'package:admin/data/local/models/per_global.dart';
import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:admin/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../application/utils/status/add_pre_hw.dart';
import '../../../application/utils/time_change/format.dart';

part 'detail_pre_state.dart';

class DetailPreHWCubit extends Cubit<DetailPreHWState> {
  String sNumMess = "";
  String eNumMess = "";
  String numQMess = "";
  String weekMess = "";

  final TeacherAPIRepo teacherAPIRepo;
  DetailPreHWCubit({required TeacherAPIRepo teacherAPIRepo})
      : teacherAPIRepo = teacherAPIRepo,
        super(DetailPreHWState.initial());
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
      weekMess = 'This field is empty';
      return false;
    } else {
      weekMess = "";
      return true;
    }
  }

  bool numQValidator(String numQ) {
    if (numQ.isEmpty) {
      numQMess = 'This field is empty';
      return false;
    } else {
      numQMess = "";
      return true;
    }
  }

  bool sNumValidator(String sNum) {
    if (sNum.isEmpty) {
      sNumMess = 'This field is empty';
      return false;
    } else {
      sNumMess = "";
      return true;
    }
  }

  bool eNumValidator(String eNum) {
    if (eNum.isEmpty) {
      eNumMess = 'This field is empty';
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
        bool? data = await teacherAPIRepo.updatePreHW(
            PreQuizHWReqAPI(
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

  Future<void> updatePreHWToDone(String key) async {
    emit(state.copyWith(status: AddPreHWStatus.updating));
    if (isFormValid()) {
      try {
        bool? data = await teacherAPIRepo.updatePreHW(
            PreQuizHWReqAPI(
              week: state.week,
              dstart: state.timeStart + " " +state.dayStart,
              dend: state.timeEnd + " " +state.dayEnd,
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
}
