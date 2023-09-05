part of 'manage_hw_cubit.dart';

class ManageHWState extends Equatable {
  int pageNow;
  int lengthNow;
  List<ResultQuizHWAPIModel>? searchList;
  List<ResultQuizHWAPIModel>? nativeList;
  Map<String, String> imageList;

  ManageHWState(
      {required this.pageNow,
      required this.lengthNow,
      required this.searchList,
      required this.nativeList,
      required this.imageList
      //this.user,
      });
  factory ManageHWState.initial() {
    return ManageHWState(
        nativeList: [],
        pageNow: 1,
        searchList: [],
        lengthNow: 1,
        imageList: {});
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [pageNow, lengthNow, searchList, imageList, nativeList];

  ManageHWState copyWith(
      {int? pageNow,
      int? lengthNow,
      List<ResultQuizHWAPIModel>? searchList,
      List<ResultQuizHWAPIModel>? nativeList,
      Map<String, String>? imageList

      // auth.user? user,
      }) {
    return ManageHWState(
      pageNow: pageNow ?? this.pageNow,
      lengthNow: lengthNow ?? this.lengthNow,
      imageList: imageList ?? this.imageList,
      searchList: searchList ?? this.searchList,
      nativeList: nativeList ?? this.nativeList,
      //user: user ?? this.user,
    );
  }
}
