import 'dart:io';

import 'package:admin/data/remote/api/api/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/utils/status/update_profile_status.dart';
import '../../../data/local/models/user_global.dart';
import '../../../data/remote/models/user_req.dart';
import '../../../main.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UserAPIRepo userAPIRepo;
  String nameError = "";
  String phoneErr = "";
  String birthErr = "";
  String addEr = "";
  UpdateProfileCubit({required this.userAPIRepo})
      : super(UpdateProfileState.initial());
  void nameChanged(String value) {
    state.fullName = value;
  }

  bool checkName() {
    if (state.fullName.isEmpty) {
      nameError = " Fill this blank";
      return false;
    } else {
      nameError = "";
      return true;
    }
  }

  bool checkPhone() {
    if (state.phone.isEmpty) {
      phoneErr = " Fill this blank";
      return false;
    } else {
      phoneErr = "";
      return true;
    }
  }

  bool checkAdd() {
    if (state.address.isEmpty) {
      addEr = " Fill this blank";
      return false;
    } else {
      addEr = "";
      return true;
    }
  }

  bool checkBirth() {
    if (state.birthDate.isEmpty) {
      birthErr = " Fill this blank";
      return false;
    } else {
      birthErr = "";
      return true;
    }
  }

  void phoneChanged(String value) {
    state.phone = value;
  }

  void addChanged(String value) {
    state.address = value;
  }

  void sexChanged(String value) {
    emit(state.copyWith(sex: value));
  }

  bool isFormValid() {
    if (checkAdd() & checkBirth() & checkName() & checkPhone()) {
      return true;
    }
    return false;
  }

  void birthChanged(String value) {
    emit(state.copyWith(birthDate: value));
  }

  Future<void> updateProfileUser(
      String linkImage, String deleteHash, File? _imageFile) async {
    emit(state.copyWith(status: UpdateProfileStatus.onLoading));
    if (isFormValid()) {
      late UserAPIReq dataNew;
      if (_imageFile != null) {
        dataNew = UserAPIReq(
            address: state.address,
            phone: state.phone,
            fullName: state.fullName,
            birthDay: state.birthDate,
            deleteHash: deleteHash,
            linkImage: linkImage,
            sex: state.sex);
      } else {
        dataNew = UserAPIReq(
            address: state.address,
            phone: state.phone,
            fullName: state.fullName,
            birthDay: state.birthDate,
            sex: state.sex);
      }
      bool? updateDone = await userAPIRepo.updateProfileUser(
          instance.get<UserGlobal>().id.toString(), dataNew);
      if (updateDone == true) {
        await userAPIRepo.getUserById(instance.get<UserGlobal>().id.toString());
        emit(state.copyWith(status: UpdateProfileStatus.success));
      } else {
        emit(state.copyWith(status: UpdateProfileStatus.error));
      }
    } else {
      emit(state.copyWith(
          status: UpdateProfileStatus.error,
          nameError: nameError,
          addError: addEr,
          birthDate: birthErr,
          phoneError: phoneErr));
    }
  }
}
