import 'package:admin/data/remote/models/user_req.dart';
import 'package:admin/data/remote/models/user_res.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/utils/status/detail_user_status.dart';
import '../../../data/remote/api/api/api_teacher_repo.dart';
part 'detail_user_state.dart';

class DetailUserCubit extends Cubit<DetailUserState> {
  String nameMess = "";
  String emailMess = "";
  String phoneMess = "";
  String classMess = "";
  String passMess = "";
  String addMess = "";
  String birthMess = "";

  final TeacherAPIRepo teacherAPIRepo;
  final UserAPIModel userAPIModel;
  DetailUserCubit({required this.teacherAPIRepo, required this.userAPIModel})
      : super(DetailUserState(
            userAPIModel: userAPIModel,
            name: userAPIModel.name!,
            email: userAPIModel.email!,
            nameMess: "",
            status: DetailUserStatus.initial,
            mailMess: "",
            sexMess: "",
            lopMess: "",
            birthMess: "",
            sex: userAPIModel.sex!,
            add: userAPIModel.add!,
            birthDate: userAPIModel.birthDate!,
            lop: userAPIModel.lop!,
            phone: userAPIModel.phone!,
            addMess: '',
            phoneMess: ''));
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

  bool checkClass() {
    if (state.lop.isEmpty) {
      classMess = " Fill this blank";
      return false;
    } else {
      classMess = "";
      return true;
    }
  }

  void phoneChanged(String value) {
    state.phone = value;
  }

  void lopChanged(String value) {
    state.lop = value;
  }

  void addChanged(String value) {
    state.add = value;
  }

  void sexChanged(String value) {
    emit(state.copyWith(sex: value));
  }

  void birthChangedConfirm(String value) {
    emit(state.copyWith(birthDate: value));
  }

  bool isFormValid() {
    if (checkAdd() &
        checkBirth() &
        checkName() &
        checkPhone() &
        checkMail() &
        checkClass()) {
      return true;
    }
    return false;
  }

  Future<void> updateUser(String key) async {
    emit(state.copyWith(status: DetailUserStatus.updating));
    if (isFormValid()) {
      bool? update = await teacherAPIRepo.updateProfileUser(
          key,
          UserAPIReq(
              name: state.name,
              sex: state.sex,
              birthDate: state.birthDate,
              phone: state.phone,
              add: state.add));
      if (update == true) {
        emit(state.copyWith(
          status: DetailUserStatus.successUpdate,
        ));
      } else {
        emit(state.copyWith(
          status: DetailUserStatus.error,
        ));
      }
    } else {
      emit(state.copyWith(
        status: DetailUserStatus.error,
        lopMess: classMess,
        mailMess: emailMess,
        addMess: addMess,
        nameMess: nameMess,
        phoneMess: phoneMess,
        birthMess: birthMess,
      ));
    }
  }

  Future<void> deleteUser(String userID) async {
    emit(state.copyWith(status: DetailUserStatus.deleting));
    teacherAPIRepo.deleteUserById(userID);
    emit(state.copyWith(
      status: DetailUserStatus.successDelete,
    ));
  }
}
