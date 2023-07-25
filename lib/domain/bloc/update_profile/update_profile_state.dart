part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  String fullName;
  String sex;
  String birthDate;
  String nameError;
  String addError;
  String birthDateError;
  String phoneError;
  String phone;
  String address;
  String lop;
  String email;
  UserGlobal userGlobal;
  UpdateProfileStatus status;

  //final auth.user? user;

  UpdateProfileState({
    required this.status,
    required this.fullName,
    required this.nameError,
    required this.addError,
    required this.phoneError,
    required this.birthDateError,
    required this.sex,
    required this.phone,
    required this.address,
    required this.userGlobal,
    required this.lop,
    required this.birthDate,
    required this.email,

    //this.user,
  });
  factory UpdateProfileState.initial() {
    return UpdateProfileState(
      fullName: instance.get<UserGlobal>().fullName ?? "",
      lop: instance.get<UserGlobal>().lop ?? "",
      sex: instance.get<UserGlobal>().gender ?? "Male",
      phone: instance.get<UserGlobal>().phone ?? "",
      nameError: '',
      phoneError: '',
      addError: '',
      birthDateError: "",
      email: instance.get<UserGlobal>().email ?? "",
      birthDate: instance.get<UserGlobal>().dateOfBirth ?? "",
      status: UpdateProfileStatus.initial,
      address: instance.get<UserGlobal>().address ?? "",
      userGlobal: instance.get<UserGlobal>(),

      //user: null,
    );
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        status,
        sex,
        phone,
        address,
        lop,
        email,
        address,
        phoneError,
        nameError,
        birthDate,
        addError,
        birthDateError,
        userGlobal,
      ];

  UpdateProfileState copyWith({
    String? fullName,
    String? email,
    String? lop,
    String? address,
    String? birthDate,
    String? phone,
    String? sex,
    String? addError,
    String? nameError,
    String? phoneError,
    String? birthError,
    UpdateProfileStatus? status,

    // auth.user? user,
  }) {
    return UpdateProfileState(
      userGlobal: instance.get<UserGlobal>(),
      status: status ?? this.status, fullName: fullName ?? this.fullName,
      nameError: nameError ?? this.nameError,
      addError: addError ?? this.addError,
      phoneError: phoneError ?? this.phoneError,
      birthDateError: birthError ?? this.birthDateError,
      sex: sex ?? this.sex,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      lop: lop ?? this.lop, birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,

      //user: user ?? this.user,
    );
  }
}
