import 'package:admin/data/local/models/user_global.dart';
import 'package:admin/data/remote/models/user_res.dart';
import 'package:admin/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../application/utils/status/add_user_status.dart';
import '../../../data/remote/api/api/api_teacher_repo.dart';
import 'dart:math' as math;

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  String nameMess = "";
  String emailMess = "";
  String phoneMess = "";
  String passMess = "";
  String addMess = "";
  String birthMess = "";

  final TeacherAPIRepo teacherAPIRepo;
  AddUserCubit({required TeacherAPIRepo teacherAPIRepo})
      : teacherAPIRepo = teacherAPIRepo,
        super(AddUserState.initial());
  void nameChanged(String value) {
    state.name = value;
  }

  void mailChanged(String value) {
    state.email = value;
  }

  bool checkName() {
    if (state.name.isEmpty) {
      nameMess = " Fill this blank";
      return false;
    } else {
      nameMess = "";
      return true;
    }
  }

  bool isEmailValid(email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(email);
  }

  bool checkPhone() {
    if (state.phone.isEmpty) {
      phoneMess = " Fill this blank";
      return false;
    } else {
      phoneMess = "";
      return true;
    }
  }

  bool checkMail() {
    if (state.email.isEmpty) {
      emailMess = " Fill this blank";
      return false;
    } else if (isEmailValid(state.email)) {
      emailMess = "";
      return true;
    } else {
      emailMess = "This is not an email";
      return false;
    }
  }

  bool checkPass() {
    if (state.password.isEmpty) {
      passMess = " Fill this blank";
      return false;
    } else {
      passMess = "";
      return true;
    }
  }

  bool checkAdd() {
    if (state.add.isEmpty) {
      addMess = " Fill this blank";
      return false;
    } else {
      addMess = "";
      return true;
    }
  }

  bool checkBirth() {
    if (state.birthDate.isEmpty) {
      birthMess = " Fill this blank";
      return false;
    } else {
      birthMess = "";
      return true;
    }
  }

  void phoneChanged(String value) {
    state.phone = value;
  }

  void passChanged(String value) {
    state.password = value;
  }

  void addChanged(String value) {
    state.add = value;
  }

  void sexChanged(String value) {
    emit(state.copyWith(sex: value));
  }

  void birthChanged(String value) {
    emit(state.copyWith(birthDate: value));
  }

  bool isFormValid() {
    if (checkAdd() &
        checkBirth() &
        checkName() &
        checkPhone() &
        checkMail() &
        checkPass()) {
      return true;
    }
    return false;
  }

  Future<void> createUser() async {
    emit(state.copyWith(status: AddUserStatus.submit));
    if (isFormValid()) {
      int otp = math.Random().nextInt(50000) + 10000;
      bool? user = await teacherAPIRepo.createUser(UserAPIModel(
          email: state.email,
          lop: state.lop,
          add: state.add,
          birthDate: state.birthDate,
          password: state.password,
          sex: state.sex,
          role: "user",
          otp: otp.toString(),
          name: state.name,
          phone: state.phone));
      if (user == true) {
        emit(state.copyWith(status: AddUserStatus.success));
      } else {
        emit(state.copyWith(
          status: AddUserStatus.error,
          passMess: passMess,
          mailMess: emailMess,
          addMess: addMess,
          nameMess: nameMess,
          phoneMess: phoneMess,
          birthMess: birthMess,
        ));
      }
    } else {
      emit(state.copyWith(
        status: AddUserStatus.error,
        passMess: passMess,
        mailMess: emailMess,
        addMess: addMess,
        nameMess: nameMess,
        phoneMess: phoneMess,
        birthMess: birthMess,
      ));
    }
  }
}
