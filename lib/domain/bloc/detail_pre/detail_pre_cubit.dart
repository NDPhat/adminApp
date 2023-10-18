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
  }
}
