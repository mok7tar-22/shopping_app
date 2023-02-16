import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/local/preferences.dart';
import 'package:shopping_app/data/remote/end_point.dart';
import '../../data/remote/dio_helper.dart';
import '../../models/login_model.dart';


part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);
  LoginModel? userDataModel;
  String? token = Preferences.token;
  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: ApiConstants.profile,
      token: Preferences.getData("token"),
    ).then((value) {
      userDataModel = LoginModel.fromJson(value.data);
      emit(ProfileSuccessState(userDataModel!));
    }).catchError((error) {
      emit(ProfileFailure(error.toString()));

    });
  }

  void updateProfileData({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(
        url: ApiConstants.updateProfile,
        token: token,
        data: {
          'name':name,
          'phone': phone,
          'email': email,
        }
    ).then((value){

      userDataModel = LoginModel.fromJson(value.data);
      emit(UpdateProfileSuccessState(userDataModel!));

    }).catchError((error){
      emit(UpdateProfileErrorState());
      print(error.toString());
    });
  }



}
