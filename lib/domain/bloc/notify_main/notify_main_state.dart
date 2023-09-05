part of 'notify_main_cubit.dart';

class NotifyMainState extends Equatable {
  String timeNow;
  int pageNow;
  int lengthNow;

  NotifyMainState({
    required this.timeNow,
    required this.pageNow,
    required this.lengthNow,
    //this.user,
  });
  factory NotifyMainState.initial() {
    return NotifyMainState(
      timeNow: formatDateInput.format(DateTime.now()),
      pageNow: 1,
      lengthNow: 1, //user: null,
    );
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [timeNow, pageNow, lengthNow];

  NotifyMainState copyWith({
    String? timeNow,
    int? pageNow,
    int? lengthNow,
    // auth.user? user,
  }) {
    return NotifyMainState(
      timeNow: timeNow ?? this.timeNow,
      pageNow: pageNow ?? this.pageNow,
      lengthNow: lengthNow ?? this.lengthNow,
    );
  }
}
