part of 'sign_up_cubit.dart';
abstract class SignUpState {}

class SignUpInitialState  extends SignUpState {}
class SignUpLoadingState extends SignUpState {}
class SignUpSuccessState  extends SignUpState {
  final LoginModel loginModel;

 SignUpSuccessState (this.loginModel);

}
class SignUpFailureState  extends SignUpState {
  final String error;

  SignUpFailureState (this.error);
}
class ChangePasswordVisibility extends SignUpState {}
