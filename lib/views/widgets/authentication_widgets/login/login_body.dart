import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/utils/app_constants.dart';
import 'package:shopping_app/utils/constants_widgets.dart';
import 'package:shopping_app/views/screens/authentication/sign_up_screen.dart';
import 'package:shopping_app/views/screens/main_screen.dart';
import 'package:shopping_app/views/widgets/authentication_widgets/login/login_fom.dart';
import 'package:shopping_app/views/widgets/progress_indicator_widget.dart';
import '../../../../controllers/login/login_cubit.dart';
import '../../../../data/local/preferences.dart';
import '../auth_button.dart';

class LoginBody extends StatelessWidget {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      user = TextEditingController();

  LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState ) {
          if (state.loginModel.status) {
            ConstantsWidgets.getSnackBar(
                context, state.loginModel.message!, Colors.green);
            Preferences.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ));
            });
          } else {
            ConstantsWidgets.getSnackBar(
                context, state.loginModel.message!, Colors.red);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            title: const Text(AppConstants.loginScreenTitle),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: const Image(
                          image: AssetImage(AppConstants.loginImage,
                      ))),
                ),
                LoginForm(
                    email: email,
                    password: password,
                    user: user,
                    form: form,
                    visible: LoginCubit.get(context).visible,
                    changeVisibility: LoginCubit.get(context).changeVisibility),
                const SizedBox(height: 10),
                ConditionalBuilder(
                  condition: state is! LoginLoadingState ,
                  builder: (context) => AuthButton(
                    text: "Login",
                    validate: () {
                      if (form.currentState!.validate()) {
                        LoginCubit.get(context).userLogin(
                            email: email.text, password: password.text);
                      }
                    },
                  ),
                  fallback: (context) =>const ProgressIndicatorWidget()),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: const Text('Or Create My Account'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
