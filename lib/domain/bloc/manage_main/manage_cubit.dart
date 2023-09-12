import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/utils/find_average/find_average_score.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/api/api/pre_hw_repo.dart';
import '../../../data/remote/models/pre_hw_res.dart';
import '../../../data/remote/models/pre_hw_res_pagi.dart';
import '../../../main.dart';

part 'manage_state.dart';

class ManageCubit extends Cubit<ManageState> {
  final PreHWAPIRepo preHWAPIRepo;
  ManageCubit({required this.preHWAPIRepo}) : super(ManageState.initial());

  Future<void> pagePlus() async {
    if (state.pageNow < findLength((state.lengthNow))) {
      List<PreHWAPIModel>? dataList = [];
      int pageNow = state.pageNow;
      pageNow = pageNow + 1;
      state.pageNow = pageNow;
      dataList = await getMoreData();
      emit(state.copyWith(
        pageNow: pageNow,
        posts: dataList,
      ));
    }
  }

  Future<void> initPage() async {
    late PreHWAPIResPagi? dataPagination;
    List<PreHWAPIModel>? dataList = [...state.posts!];
    dataPagination = await preHWAPIRepo.getALlDonePreHWWithPagi(
        state.pageNow, instance.get<UserGlobal>().lop!);
    dataList = dataPagination!.data;
    int length = dataPagination.total!;
    if (dataList!.isNotEmpty) {
      emit(state.copyWith(posts: dataList, pageNow: 1, lengthNow: length));
    }
  }

  Future<List<PreHWAPIModel>?> getMoreData() async {
    late PreHWAPIResPagi? dataPagination;
    List<PreHWAPIModel>? dataList = [...state.posts!];
    dataList.clear();
    dataPagination = await preHWAPIRepo.getALlDonePreHWWithPagi(
        state.pageNow, instance.get<UserGlobal>().lop!);
    dataList = dataPagination!.data;
    if (dataList!.isNotEmpty) {
      return dataList;
    }
    return null;
  }

  Future<void> pageMinus() async {
    if (state.pageNow != 1) {
      List<PreHWAPIModel>? dataList = [];
      int pageNow = state.pageNow;
      pageNow = pageNow - 1;
      state.pageNow = pageNow;
      dataList = await getMoreData();
      emit(state.copyWith(
        pageNow: pageNow,
        posts: dataList,
      ));
    }
  }
}
