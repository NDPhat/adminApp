import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/utils/status/update_pass.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/api/api/user_repo.dart';
import '../../../data/remote/models/user_res.dart';
import '../../../main.dart';

part 'update_pass_state.dart';

class UpdatePassCubit extends Cubit<UpdatePassState> {
  final UserAPIRepo userRepo;
  String confirmPassMessage = "";
  String passMessage = "";
  String oldPassMessage = "";

  UpdatePassCubit({required this.userRepo}) : super(UpdatePassState.initial());

  void passChanged(String value) {
    state.password = value;
  }

  void oldPassChanged(String value) {
    state.oldPass = value;
  }

  void confirmPassChange(String value) {
    state.confirmPass = value;
  }

  void clearData() {
    emit(state.copyWith(
        passErrorMessage: "",
        oldPassErrorMessage: "",
        confirmPassErrorMessage: "",
        status: UpdatePassStatus.clear));
  }

  bool passValidator(String pass) {
    if (pass.isEmpty || pass.length < 8) {
      passMessage = "Password must have least 8 characters";
      return false;
    } else {
      passMessage = "";
      return true;
    }
  }

  bool oldPassValidator(String pass) {
    return true;
  }

  bool confirmPassValidator(String confirmPass) {
    if (confirmPass.isEmpty || confirmPass.compareTo(state.password) != 0) {
      confirmPassMessage = "Your passwords don't match";
      return false;
    } else {
      confirmPassMessage = "";
      return true;
    }
  }

  bool formValidatorForgetPass() {
    if (confirmPassValidator(state.confirmPass) &&
        passValidator(state.password)) {
      return true;
    }
    return false;
  }

  bool formValidatorChangePass() {
    if (confirmPassValidator(state.confirmPass) &&
        passValidator(state.password) &&
        oldPassValidator(state.oldPass)) {
      return true;
    }
    return false;
  }

  Future<void> updatePassWithCredentials(String email) async {
    emit(state.copyWith(status: UpdatePassStatus.onLoading));
    if (formValidatorForgetPass()) {
      bool updateDone = await userRepo.updatePassWord(
          email, UserAPIModel(password: state.password));
      if (updateDone) {
        emit(state.copyWith(
            passErrorMessage: "",
            confirmPassErrorMessage: "",
            status: UpdatePassStatus.success));
      } else {
        emit(state.copyWith(
            passErrorMessage: "Internal server error",
            confirmPassErrorMessage: "Internal server error",
            status: UpdatePassStatus.error));
      }
    } else {
      emit(state.copyWith(
          passErrorMessage: passMessage,
          confirmPassErrorMessage: confirmPassMessage,
          status: UpdatePassStatus.error));
    }
  }

  Future<void> changePassWithCredentials() async {
    emit(state.copyWith(status: UpdatePassStatus.onLoading));
    if (formValidatorChangePass()) {
      bool updateDone = await userRepo.updatePassWord(
          instance.get<UserGlobal>().email!.toString(),
          UserAPIModel(password: state.password));
      if (updateDone) {
        emit(state.copyWith(
            passErrorMessage: "",
            confirmPassErrorMessage: "",
            oldPassErrorMessage: "",
            status: UpdatePassStatus.success));
      } else {
        emit(state.copyWith(
            passErrorMessage: "Internal server error",
            confirmPassErrorMessage: "Internal server error",
            oldPassErrorMessage: "Internal server error",
            status: UpdatePassStatus.error));
      }
    } else {
      emit(state.copyWith(
          passErrorMessage: passMessage,
          confirmPassErrorMessage: confirmPassMessage,
          oldPassErrorMessage: oldPassMessage,
          status: UpdatePassStatus.error));
    }
  }
}
