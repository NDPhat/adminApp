import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../application/utils/status/login_status.dart';
import '../../../data/remote/api/api/api_teacher_repo.dart';
import '../../../data/remote/authen/authen_repo.dart';
import '../../../main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TeacherAPIRepo teacherAPIRepo;
  final AuthenRepository authenRepository;
  String emailMess = "";
  String passMess = "";
  LoginCubit(
      {required TeacherAPIRepo teacherAPIRepo,
      required AuthenRepository authenRepository})
      : teacherAPIRepo = teacherAPIRepo,
        authenRepository = authenRepository,
        super(LoginState.initial());
  void emailChanged(String value) {
    state.email = value;
  }

  bool isEmailValid(email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  void passChanged(String value) {
    state.pass = value;
  }

  Future<void> loginAppWithEmailAndPass() async {
    emit(state.copyWith(status: LoginStatus.onLoading));
    if (isEmailValid(state.email)) {
    } else {
      emailMess = "This is not an email!";
      emit(state.copyWith(status: LoginStatus.error, emailError: emailMess));
    }
  }
}
