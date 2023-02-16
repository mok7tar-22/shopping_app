part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitialState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final LoginModel loginModel;

  const ProfileSuccessState(this.loginModel);

  @override
  List<Object> get props => [loginModel];

}

class ProfileFailure extends ProfileState {
  final String error;

  const ProfileFailure(this.error);

  @override
  List<Object> get props => [error];
}


class UpdateProfileLoadingState extends ProfileState {


  const UpdateProfileLoadingState();

  @override
  List<Object> get props => [];

}class UpdateProfileSuccessState extends ProfileState {
  final LoginModel loginModel;

  const UpdateProfileSuccessState(this.loginModel);

  @override
  List<Object> get props => [loginModel];

}

class UpdateProfileErrorState extends ProfileState {
  @override
  List<Object?> get props => [];
}
