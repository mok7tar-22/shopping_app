part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState  extends LoginState {}

class LoginLoadingState  extends LoginState {}

class LoginSuccessState  extends LoginState {
  final LoginModel loginModel;

  LoginSuccessState (this.loginModel);
}

class LoginFailureState  extends LoginState {
  final String error;

  LoginFailureState (this.error);
}

class ChangePasswordVisibility extends LoginState {}
