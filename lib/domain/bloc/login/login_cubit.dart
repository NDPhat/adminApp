import 'package:admin/data/remote/api/api/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../application/utils/status/login_status.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/authen/authen_repo.dart';
import '../../../main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserAPIRepo userAPIRepo;
  final AuthenRepository authenRepository;
  String emailMess = "";
  String passMess = "";
  LoginCubit({required this.userAPIRepo, required this.authenRepository})
      : super(LoginState.initial());
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

  void clearData() {
    emit(state.copyWith(
        emailError: "", passError: "", status: LoginStatus.clear));
  }

  Future<void> loginAppWithEmailAndPass() async {
    emit(state.copyWith(status: LoginStatus.onLoading));
    if (isEmailValid(state.email)) {
      final user =
          await userAPIRepo.loginWithEmailAndPass(state.email, state.pass);
      if (user != null) {
        authenRepository.handleAutoLoginApp(true);
        authenRepository.handleMailLoginApp(state.email.toString());
        instance.get<UserGlobal>().onLogin = true;
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        passMess = "Your password do not match";
        emit(state.copyWith(status: LoginStatus.error, passError: passMess));
      }
    } else {
      emailMess = "This is not an email!";
      emit(state.copyWith(status: LoginStatus.error, emailError: emailMess));
    }
  }
}
