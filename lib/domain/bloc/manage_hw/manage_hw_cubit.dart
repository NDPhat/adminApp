import 'package:admin/data/remote/api/api/result_hw_repo.dart';
import 'package:admin/data/remote/api/api/user_repo.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/utils/find_average/find_average_score.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/models/result_hw_res_pagi.dart';
import '../../../data/remote/models/user_res.dart';
import '../../../main.dart';

part 'manage_hw_state.dart';

class ManageHWCubit extends Cubit<ManageHWState> {
  final ResultHWAPIRepo resultHWAPIRepo;
  final UserAPIRepo userAPIRepo;
  ManageHWCubit({required this.resultHWAPIRepo, required this.userAPIRepo})
      : super(ManageHWState.initial());

  Future<void> pagePlus(String week) async {
    if (state.pageNow < findLength((state.lengthNow))) {
      List<ResultHWAPIModel>? dataList = [];
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
    late ResultHWAPIResPagi? dataPagination;
    List<ResultHWAPIModel>? dataList = [];
    dataPagination =
        await resultHWAPIRepo.getAllResultQuizHWByWeekAndLopWithPagi(
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

  Future<List<ResultHWAPIModel>?> getBackList(String week) async {
    late ResultHWAPIResPagi? dataPagination;
    List<ResultHWAPIModel>? dataList = [];
    dataPagination =
        await resultHWAPIRepo.getAllResultQuizHWByWeekAndLopWithPagi(
            week, instance.get<UserGlobal>().lop.toString(), state.pageNow);
    dataList = dataPagination!.data;
    if (dataList!.isNotEmpty) {
      return dataList;
    }
    return null;
  }

  Future<List<ResultHWAPIModel>?> getMoreData(String week) async {
    late ResultHWAPIResPagi? dataPagination;
    List<ResultHWAPIModel>? dataList = [];
    dataPagination =
        await resultHWAPIRepo.getAllResultQuizHWByWeekAndLopWithPagi(
            week, instance.get<UserGlobal>().lop.toString(), state.pageNow);
    dataList = dataPagination!.data;
    if (dataList!.isNotEmpty) {
      return dataList;
    }
    return null;
  }

  void onSearchChange(String value) {
    List<ResultHWAPIModel> results = [];
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
    List<UserAPIModel>? dataUser = await userAPIRepo
        .getAllStudentByClass(instance.get<UserGlobal>().lop.toString());
    dataUser!.forEach((element) {
      if (element.linkImage != null) {
        imageList.putIfAbsent(element.key!, () => element.linkImage!);
      }
    });
    return imageList;
  }

  Future<void> pageMinus(String week) async {
    if (state.pageNow != 1) {
      List<ResultHWAPIModel>? dataList = [];
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
