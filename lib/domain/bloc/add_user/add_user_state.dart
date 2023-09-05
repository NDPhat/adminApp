part of 'add_user_cubit.dart';

class AddUserState extends Equatable {
  String name;
  String email;
  String password;
  String lop;
  String nameMess;
  String sexMess;
  String mailMess;
  String birthMess;
  String passMess;
  String addMess;
  String phoneMess;
  String otp;
  String add;
  String sex;
  String birthDate;
  String linkImage;
  String phone;
  AddUserStatus status;

  AddUserState({
    required this.name,
    required this.email,
    required this.password,
    required this.sex,
    required this.linkImage,
    required this.lop,
    required this.phone,
    required this.birthDate,
    required this.nameMess,
    required this.addMess,
    required this.mailMess,
    required this.status,
    required this.phoneMess,
    required this.birthMess,
    required this.sexMess,
    required this.passMess,
    required this.otp,
    required this.add,
  });
  factory AddUserState.initial() {
    return AddUserState(
        name: "",
        otp: "",
        email: "",
        nameMess: "",
        passMess: "",
        status: AddUserStatus.initial,
        mailMess: "",
        sexMess: "",
        birthMess: "",
        sex: "Male",
        add: "",
        birthDate: "",
        lop: instance.get<UserGlobal>().lop!,
        linkImage: "",
        password: "",
        phone: "",
        addMess: '',
        phoneMess: ''
        //user: null,
        );
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        lop,
        otp,
        nameMess,
        passMess,
        mailMess,
        phoneMess,
        status,
        sexMess,
        addMess,
        birthMess,
        add,
        sex,
        birthDate,
        linkImage,
        phone,
      ];

  AddUserState copyWith({
    String? name,
    String? email,
    String? password,
    String? lop,
    String? otp,
    String? add,
    AddUserStatus? status,
    String? sex,
    String? birthDate,
    String? birthMess,
    String? nameMess,
    String? mailMess,
    String? passMess,
    String? phoneMess,
    String? addMess,
    String? sexMess,
    String? lopMess,
    String? linkImage,
    String? phone,
  }) {
    return AddUserState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      lop: lop ?? this.lop,
      add: add ?? this.add,
      status: status ?? this.status,
      birthDate: birthDate ?? this.birthDate,
      birthMess: birthMess ?? this.birthMess,
      nameMess: nameMess ?? this.nameMess,
      mailMess: mailMess ?? this.mailMess,
      phoneMess: phoneMess ?? this.phoneMess,
      addMess: addMess ?? this.addMess,
      sexMess: sexMess ?? this.sexMess,
      passMess: passMess ?? this.passMess,
      password: password ?? this.password,
      linkImage: linkImage ?? this.linkImage,
      sex: sex ?? this.sex,
    );
  }
}
