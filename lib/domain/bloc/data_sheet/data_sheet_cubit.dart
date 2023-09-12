import 'package:admin/data/remote/api/api/result_hw_repo.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/utils/find_average/find_average_score.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/models/final_result_hw.dart';
import '../../../main.dart';

part 'data_sheet_state.dart';

class DataSheetCubit extends Cubit<DataSheetState> {
  final ResultHWAPIRepo resultHWAPIRepo;
  DataSheetCubit({required this.resultHWAPIRepo})
      : super(DataSheetState.initial());

  Future<void> pagePlus() async {
    if (state.pageNow < findLength((state.lengthNow))) {
      List<FinalResultHW>? dataList = [];
      int pageNow = state.pageNow;
      pageNow = pageNow + 1;
      state.pageNow = pageNow;
      dataList = await getMoreData();
      emit(state.copyWith(pageNow: pageNow, posts: dataList));
    }
  }

  Future<void> initPage() async {
    List<ResultHWAPIModel>? dataList = [];
    List<FinalResultHW>? dataFinal = [];

    /// lay tu week1 den week5
    for (int i = 1; i <= 5; i++) {
      dataList = await resultHWAPIRepo.getAllResultQuizHWByWeekAndLop(
          i.toString(), instance.get<UserGlobal>().lop.toString());
      if (dataList!.isNotEmpty) {
        int totalQ = 0;
        int score = 0;
        for (var element in dataList) {
          totalQ = totalQ + element.numQ!;
          score = score + element.score!;
        }
        dataFinal.add(FinalResultHW(
            week: i.toString(),
            scoreAvg: ((score / totalQ) * 10).toStringAsFixed(2),
            totalJoin: dataList.length,
            time: dataList.first.dateSave));
      }
    }
    if (dataFinal.isNotEmpty) {
      dataFinal.sort((a, b) => a.week!.compareTo(b.week!));
      int length = int.parse(dataFinal.last.week!);
      emit(state.copyWith(posts: dataFinal, pageNow: 1, lengthNow: length));
    }
  }

  Future<List<FinalResultHW>?> getMoreData() async {
    List<ResultHWAPIModel>? dataList = [];
    List<FinalResultHW>? dataFinal = [];
    int start = (state.pageNow - 1) * 5 + 1;
    int end = state.pageNow * 5;

    for (int i = start; i <= end; i++) {
      dataList = await resultHWAPIRepo.getAllResultQuizHWByWeekAndLop(
          i.toString(), instance.get<UserGlobal>().lop.toString());
      if (dataList!.isNotEmpty) {
        int totalQ = 0;
        int score = 0;
        for (var element in dataList) {
          totalQ = totalQ + element.numQ!;
          score = score + element.score!;
        }
        dataFinal.add(FinalResultHW(
            week: i.toString(),
            scoreAvg: ((score / totalQ) * 10).toStringAsFixed(2),
            totalJoin: dataList.length,
            time: dataList.first.dateSave));
      }
    }
    if (dataFinal.isNotEmpty) {
      dataFinal.sort((a, b) => a.week!.compareTo(b.week!));
      return dataFinal;
    }
    return null;
  }

  Future<void> pageMinus() async {
    if (state.pageNow != 1) {
      List<FinalResultHW>? dataList = [];
      int pageNow = state.pageNow;
      pageNow = pageNow - 1;
      state.pageNow = pageNow;
      dataList = await getMoreData();
      emit(state.copyWith(pageNow: pageNow, posts: dataList));
    }
  }
}
