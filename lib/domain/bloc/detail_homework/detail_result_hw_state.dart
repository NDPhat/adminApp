part of 'detail_result_hw_cubit.dart';

class DetailResultHWState extends Equatable {
  int pageNow;
  int lengthNow;
  bool scoreChoose;
  bool nameChoose;
  List<ResultHWAPIModel>? posts;
  List<ChartData>? dataListChart;
  DetailResultHWState(
      {required this.pageNow,
      required this.scoreChoose,
      required this.nameChoose,
      required this.lengthNow,
      required this.posts,
      required this.dataListChart
      //this.user,
      });
  factory DetailResultHWState.initial() {
    return DetailResultHWState(
        pageNow: 1,
        scoreChoose: false,
        nameChoose: false,
        posts: [],
        dataListChart: [],
        lengthNow: 1);
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [pageNow, scoreChoose, nameChoose, lengthNow, posts, dataListChart];

  DetailResultHWState copyWith({
    int? pageNow,
    int? lengthNow,
    bool? scoreChoose,
    bool? nameChoose,
    List<ResultHWAPIModel>? posts,
    List<ChartData>? dataListChart,

    // auth.user? user,
  }) {
    return DetailResultHWState(
      pageNow: pageNow ?? this.pageNow,
      lengthNow: lengthNow ?? this.lengthNow,
      scoreChoose: scoreChoose ?? this.scoreChoose,
      nameChoose: nameChoose ?? this.nameChoose,
      posts: posts ?? this.posts,
      dataListChart: dataListChart ?? this.dataListChart,
      //user: user ?? this.user,
    );
  }
}
