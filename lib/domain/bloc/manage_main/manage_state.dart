part of 'manage_cubit.dart';

class ManageState extends Equatable {
  int pageNow;
  int lengthNow;
  List<PreHWAPIModel>? posts;
  ManageState({
    required this.pageNow,
    required this.lengthNow,
    required this.posts,
    //this.user,
  });
  factory ManageState.initial() {
    return ManageState(pageNow: 1, posts: [], lengthNow: 1);
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [pageNow, lengthNow, posts];

  ManageState copyWith({
    int? pageNow,
    int? lengthNow,
    List<PreHWAPIModel>? posts,

    // auth.user? user,
  }) {
    return ManageState(
      pageNow: pageNow ?? this.pageNow,
      lengthNow: lengthNow ?? this.lengthNow,
      posts: posts ?? this.posts,
      //user: user ?? this.user,
    );
  }
}
