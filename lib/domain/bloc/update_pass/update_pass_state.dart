part of 'update_pass_cubit.dart';

class UpdatePassState extends Equatable {
  String password;
  String oldPass;
  String confirmPass;
  UpdatePassStatus status;
  String confirmPassErrorMessage;
  String passErrorMessage;
  String oldPassErrorMessage;

  //final auth.user? user;

  UpdatePassState({
    required this.oldPass,
    required this.password,
    required this.confirmPass,
    required this.status,
    required this.passErrorMessage,
    required this.oldPassErrorMessage,
    required this.confirmPassErrorMessage,
    //this.user,
  });

  factory UpdatePassState.initial() {
    return UpdatePassState(
        password: '',
        oldPass: '',
        confirmPass: '',
        status: UpdatePassStatus.initial,
        confirmPassErrorMessage: '',
        oldPassErrorMessage: '',
        passErrorMessage: ''
        //user: null,
        );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        password,
        oldPass,
        confirmPass,
        status,
        confirmPassErrorMessage,
        passErrorMessage,
        oldPassErrorMessage
      ];

  UpdatePassState copyWith({
    String? password,
    String? oldPass,
    String? oldPassErrorMessage,
    String? confirmPass,
    String? confirmPassErrorMessage,
    String? passErrorMessage,
    UpdatePassStatus? status,
    // auth.user? user,
  }) {
    return UpdatePassState(
        password: password ?? this.password,
        oldPass: oldPass ?? this.oldPass,
        confirmPass: confirmPass ?? this.confirmPass,
        confirmPassErrorMessage:
            confirmPassErrorMessage ?? this.confirmPassErrorMessage,
        status: status ?? this.status,
        passErrorMessage: passErrorMessage ?? this.passErrorMessage,
        oldPassErrorMessage: oldPassErrorMessage ?? this.oldPassErrorMessage
        //user: user ?? this.user,
        );
  }
}
