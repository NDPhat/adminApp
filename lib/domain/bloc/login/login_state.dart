part of 'login_cubit.dart';

class LoginState extends Equatable {
  String email;
  String pass;
  String emailError;
  String passError;
  LoginStatus status;

  LoginState({
    required this.email,
    required this.pass,
    required this.emailError,
    required this.passError,
    required this.status,
    //this.user,
  });
  factory LoginState.initial() {
    return LoginState(
        email: '',
        pass: '',
        emailError: '',
        passError: '',
        status: LoginStatus.initial
      //user: null,
    );
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email, pass, emailError, passError, status];

  LoginState copyWith({
    String? email,
    String? pass,
    String? emailError,
    String? passError,
    LoginStatus? status,
  }) {
    return LoginState(
        emailError: emailError ?? this.emailError,
        email: email ?? this.email,
        passError: passError ?? this.passError,
        pass: pass ?? this.pass,
        status: status ?? this.status
      //user: user ?? this.user,
    );
  }
}
