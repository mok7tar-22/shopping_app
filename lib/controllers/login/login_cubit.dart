import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/models/login_model.dart';
import '../../data/remote/dio_helper.dart';
import '../../data/remote/end_point.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState ());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool visible = true;
  bool isLoading = false;
  void userLogin({
    required String email,
    required String password,

  }) {
    emit(LoginLoadingState ());
    DioHelper.postData(
        url: ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        }).then((value) {
      emit(LoginSuccessState (LoginModel.fromJson(value.data)));
    }).catchError((error) {
      emit(LoginFailureState (error));
    });}

    changeVisibility() {
      visible = !visible;
      emit(ChangePasswordVisibility());
    }
  }
