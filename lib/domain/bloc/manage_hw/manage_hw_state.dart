part of 'manage_hw_cubit.dart';

class ManageHWState extends Equatable {
  int pageNow;
  int lengthNow;
  List<ResultHWAPIModel>? searchList;
  List<ResultHWAPIModel>? nativeList;
  List<ResultHWAPIModel>? allList;
  Map<String, String> imageList;
  ManageStatus status;

  ManageHWState(
      {required this.pageNow,
      required this.lengthNow,
      required this.status,
      required this.searchList,
      required this.nativeList,
      required this.allList,
      required this.imageList
      //this.user,
      });
  factory ManageHWState.initial() {
    return ManageHWState(
        nativeList: [],
        status: ManageStatus.initial,
        pageNow: 1,
        searchList: [],
        allList: [],
        lengthNow: 1,
        imageList: {});
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [pageNow, lengthNow,allList, searchList, imageList, nativeList,status];

  ManageHWState copyWith(
      {int? pageNow,
      int? lengthNow,
      List<ResultHWAPIModel>? searchList,
      List<ResultHWAPIModel>? nativeList,
      List<ResultHWAPIModel>? allList,
      Map<String, String>? imageList,
      ManageStatus? status
      // auth.user? user,
      }) {
    return ManageHWState(
      status: status ?? this.status,
      pageNow: pageNow ?? this.pageNow,
      lengthNow: lengthNow ?? this.lengthNow,
      imageList: imageList ?? this.imageList,
      searchList: searchList ?? this.searchList,
      nativeList: nativeList ?? this.nativeList,
      allList: allList ?? this.allList,
      //user: user ?? this.user,
    );
  }
}
