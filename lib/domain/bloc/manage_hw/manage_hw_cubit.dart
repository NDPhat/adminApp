import 'package:admin/data/remote/api/api/api_teacher_repo.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/utils/find_average/find_average_score.dart';
import '../../../data/local/models/chart_data.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/models/result_hw_pagi_res.dart';
import '../../../data/remote/models/user_res.dart';
import '../../../main.dart';

part 'manage_hw_state.dart';

class ManageHWCubit extends Cubit<ManageHWState> {
  final TeacherAPIRepo teacherAPIRepo;
  ManageHWCubit({required this.teacherAPIRepo})
      : super(ManageHWState.initial());

  Future<void> pagePlus(String week) async {
    if (state.pageNow < findLength((state.lengthNow))) {
      List<ResultQuizHWAPIModel>? dataList = [];
      int pageNow = state.pageNow;
      pageNow = pageNow + 1;
      state.pageNow = pageNow;
      dataList = await getMoreData(week);
      emit(state.copyWith(
        pageNow: pageNow,
        searchList: dataList,
      ));
    }
  }

  Future<void> initPage(String week) async {
    Map<String, String> imageList = await getImageLink();
    late ResultHWPagiAPI? dataPagination;
    List<ResultQuizHWAPIModel>? dataList = [];
    dataPagination = await instance
        .get<TeacherAPIRepo>()
        .getAllResultQuizHWByWeekAndLopWithPagi(
            week, instance.get<UserGlobal>().lop.toString(), state.pageNow);
    dataList = dataPagination!.data;
    int length = dataPagination.total!;
    if (dataList!.isNotEmpty) {
      emit(state.copyWith(
        pageNow: 1,
        searchList: dataList,
        imageList: imageList,
        nativeList: dataList,
        lengthNow: length,
      ));
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

  void onSearchChange(String value) {
    List<ResultQuizHWAPIModel> results = [];
    if (value.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = [...state.nativeList!];
    } else {
      results = state.nativeList!
          .where(
              (user) => user.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    emit(state.copyWith(searchList: results));
  }

  Future<Map<String, String>> getImageLink() async {
    Map<String, String> imageList = {};
    List<UserAPIModel>? dataUser = await instance
        .get<TeacherAPIRepo>()
        .getAllStudentByClass(instance.get<UserGlobal>().lop.toString());
    dataUser!.forEach((element) {
      imageList.putIfAbsent(element.key!, () => element.linkImage!);
    });
    return imageList;
  }

  Future<void> pageMinus(String week) async {
    if (state.pageNow != 1) {
      List<ResultQuizHWAPIModel>? dataList = [];
      int pageNow = state.pageNow;
      pageNow = pageNow - 1;
      state.pageNow = pageNow;
      dataList = await getMoreData(week);
      emit(state.copyWith(
        pageNow: pageNow,
        searchList: dataList,
      ));
    }
  }
}
