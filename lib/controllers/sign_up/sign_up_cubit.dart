import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/remote/dio_helper.dart';
import '../../data/remote/end_point.dart';
import '../../models/login_model.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitialState ());

  static SignUpCubit get(context) => BlocProvider.of(context);
  bool visible = true;
  bool isLoading = false;

  changeVisibility() {
    visible = !visible;

    emit(ChangePasswordVisibility());
  }

  signUp({required String name,
    required String email,
    required String password,
    required String phone}) async {
    emit(SignUpLoadingState ());
    DioHelper.postData(
        url: ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        }).then((value) {
      print(value);
     emit(SignUpSuccessState (LoginModel.fromJson(value.data)));
    }).catchError((error) {
      emit(SignUpFailureState (error));
    });
  }
}
