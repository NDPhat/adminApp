part of 'data_sheet_cubit.dart';

class DataSheetState extends Equatable {
  int pageNow;
  int lengthNow;
  List<FinalResultHW>? posts;
  DataSheetState({
    required this.pageNow,
    required this.lengthNow,
    required this.posts,
    //this.user,
  });
  factory DataSheetState.initial() {
    return DataSheetState(pageNow: 1, posts: [], lengthNow: 1);
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [pageNow, lengthNow, posts];

  DataSheetState copyWith({
    int? pageNow,
    int? lengthNow,
    List<FinalResultHW>? posts,

    // auth.user? user,
  }) {
    return DataSheetState(
      pageNow: pageNow ?? this.pageNow,
      lengthNow: lengthNow ?? this.lengthNow,
      posts: posts ?? this.posts,
      //user: user ?? this.user,
    );
  }
}
