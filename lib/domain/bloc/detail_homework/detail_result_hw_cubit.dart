import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/utils/find_average/find_average_score.dart';
import '../../../data/local/models/chart_data.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/models/result_hw_pagi_res.dart';
import '../../../main.dart';

part 'detail_result_hw_state.dart';

class DetailResultHWCubit extends Cubit<DetailResultHWState> {
  final TeacherAPIRepo teacherAPIRepo;
  DetailResultHWCubit({required this.teacherAPIRepo})
      : super(DetailResultHWState.initial());

  Future<void> scoreChoose(String week) async {
    bool choose = state.scoreChoose;
    List<ResultQuizHWAPIModel>? newPost = [...state.posts!];
    List<ResultQuizHWAPIModel>? oldPost = await getBackList(week);

    ///FALSE - > TRUE
    if (choose == false) {
      newPost!.sort((a, b) => a.score!.compareTo(b.score!));
      emit(state.copyWith(
          scoreChoose: !choose, posts: newPost, nameChoose: false));
    }

    /// TRUE -> FALSE
    else {
      emit(state.copyWith(
          scoreChoose: !choose, posts: oldPost, nameChoose: false));
    }
  }

  Future<void> nameChoose(String week) async {
    bool choose = state.nameChoose;
    List<ResultQuizHWAPIModel>? newPost = [...state.posts!];
    List<ResultQuizHWAPIModel>? oldPost = await getBackList(week);

    ///FALSE - > TRUE
    if (choose == false) {
      newPost.sort((a, b) => a.name!.compareTo(b.name!));
      emit(state.copyWith(
          nameChoose: !choose, posts: newPost, scoreChoose: false));
    }

    /// TRUE -> FALSE
    else {
      emit(state.copyWith(
          nameChoose: !choose, posts: oldPost, scoreChoose: false));
    }
  }

  Future<void> pagePlus(String week) async {
    if (state.pageNow < findLength((state.lengthNow))) {
      List<ResultQuizHWAPIModel>? dataList = [...state.posts!];
      dataList.clear();
      int pageNow = state.pageNow;
      pageNow = pageNow + 1;
      state.pageNow = pageNow;
      dataList = await getMoreData(week);
      emit(state.copyWith(
        pageNow: pageNow,
        posts: dataList,
        nameChoose: false,
        scoreChoose: false,
      ));
    }
  }

  Future<void> initPage(String week) async {
    late ResultHWPagiAPI? dataPagination;
    List<ResultQuizHWAPIModel>? dataList = [...state.posts!];
    List<ResultQuizHWAPIModel>? dataListALl = [];
    List<ChartData>? chart = [...state.dataListChart!];
    dataPagination = await instance
        .get<TeacherAPIRepo>()
        .getAllResultQuizHWByWeekAndLopWithPagi(
            week, instance.get<UserGlobal>().lop.toString(), state.pageNow);
    dataList = dataPagination!.data;
    dataListALl = await instance
        .get<TeacherAPIRepo>()
        .getAllResultQuizHWByWeekAndLop(
            week, instance.get<UserGlobal>().lop.toString());
    for (int i = 0; i < dataListALl!.length; i++) {
      chart.add(ChartData(dataListALl![i].name!, dataListALl![i].score!));
    }
    int length = dataPagination.total!;
    if (dataList!.isNotEmpty) {
      emit(state.copyWith(
          posts: dataList,
          pageNow: 1,
          lengthNow: length,
          dataListChart: chart));
    }
  }

  Future<List<ResultQuizHWAPIModel>?> getBackList(String week) async {
    late ResultHWPagiAPI? dataPagination;
    List<ResultQuizHWAPIModel>? dataList = [];
    dataPagination = await instance
        .get<TeacherAPIRepo>()
        .getAllResultQuizHWByWeekAndLopWithPagi(
            week, instance.get<UserGlobal>().lop.toString(), state.pageNow);
    dataList = dataPagination!.data;
    if (dataList!.isNotEmpty) {
      return dataList;
    }
    return null;
  }

  Future<List<ResultQuizHWAPIModel>?> getMoreData(String week) async {
    late ResultHWPagiAPI? dataPagination;
    List<ResultQuizHWAPIModel>? dataList = [...state.posts!];
    dataList.clear();
    dataPagination = await instance
        .get<TeacherAPIRepo>()
        .getAllResultQuizHWByWeekAndLopWithPagi(
            week, instance.get<UserGlobal>().lop.toString(), state.pageNow);
    dataList = dataPagination!.data;
    if (dataList!.isNotEmpty) {
      return dataList;
    }
    return null;
  }

  Future<void> pageMinus(String week) async {
    if (state.pageNow != 1) {
      List<ResultQuizHWAPIModel>? dataList = [...state.posts!];
      dataList.clear();
      int pageNow = state.pageNow;
      pageNow = pageNow - 1;
      state.pageNow = pageNow;
      dataList = await getMoreData(week);
      emit(state.copyWith(
        pageNow: pageNow,
        posts: dataList,
        nameChoose: false,
        scoreChoose: false,
      ));
    }
  }
}
