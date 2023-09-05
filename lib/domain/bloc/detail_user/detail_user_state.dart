part of 'detail_user_cubit.dart';

class DetailUserState extends Equatable {
  String name;
  String email;
  String lop;
  String nameMess;
  String sexMess;
  String mailMess;
  String birthMess;
  String addMess;
  String lopMess;
  String phoneMess;
  String add;
  String sex;
  String birthDate;
  String phone;
  DetailUserStatus status;
  UserAPIModel userAPIModel;

  DetailUserState({
    required this.name,
    required this.email,
    required this.userAPIModel,
    required this.sex,
    required this.lop,
    required this.phone,
    required this.birthDate,
    required this.nameMess,
    required this.lopMess,
    required this.addMess,
    required this.mailMess,
    required this.status,
    required this.phoneMess,
    required this.birthMess,
    required this.sexMess,
    required this.add,
  });
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        name,
        email,
        lop,
        nameMess,
        userAPIModel,
        mailMess,
        phoneMess,
        status,
        lopMess,
        sexMess,
        addMess,
        birthMess,
        add,
        sex,
        birthDate,
        phone,
      ];

  DetailUserState copyWith({
    String? name,
    String? email,
    String? lop,
    String? add,
    DetailUserStatus? status,
    String? sex,
    String? birthDate,
    String? birthMess,
    String? nameMess,
    String? mailMess,
    String? phoneMess,
    String? addMess,
    String? sexMess,
    String? lopMess,
    String? phone,
    UserAPIModel? userAPIModel,
  }) {
    return DetailUserState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      lop: lop ?? this.lop,
      add: add ?? this.add,
      userAPIModel: userAPIModel ?? this.userAPIModel,
      status: status ?? this.status,
      birthDate: birthDate ?? this.birthDate,
      birthMess: birthMess ?? this.birthMess,
      nameMess: nameMess ?? this.nameMess,
      mailMess: mailMess ?? this.mailMess,
      phoneMess: phoneMess ?? this.phoneMess,
      addMess: addMess ?? this.addMess,
      sexMess: sexMess ?? this.sexMess,
      lopMess: lopMess ?? this.lopMess,
      sex: sex ?? this.sex,
    );
  }
}
