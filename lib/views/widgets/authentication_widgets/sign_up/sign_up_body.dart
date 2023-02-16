import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/controllers/sign_up/sign_up_cubit.dart';
import 'package:shopping_app/utils/app_constants.dart';
import '../../../../data/local/preferences.dart';
import '../../../../utils/constants_widgets.dart';
import '../../../screens/authentication/login_screen.dart';
import '../../../screens/main_screen.dart';
import '../../progress_indicator_widget.dart';
import '../auth_button.dart';
import 'sign_up_form.dart';

class SignUpBody extends StatelessWidget {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      user = TextEditingController(),
      phone = TextEditingController();

  SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
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
            elevation: 0,
            title: const Text(AppConstants.signUpScreenTitle),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: const Image(
                          image: AssetImage(
                        AppConstants.signUpImage,
                      ))),
                ),
                SignUpForm(
                    email: email,
                    password: password,
                    user: user,
                    phone: phone,
                    form: form,
                    visible: SignUpCubit.get(context).visible,
                    changeVisibility:
                        SignUpCubit.get(context).changeVisibility),
                const SizedBox(height: 10),
                ConditionalBuilder(
                    condition: state is! SignUpLoadingState,
                    builder: (context) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: AuthButton(
                            text: "Create My Account",
                            validate: () {
                              if (form.currentState!.validate()) {
                                SignUpCubit.get(context).signUp(
                                    email: email.text.trim(),
                                    password: password.text,
                                    name: user.text,
                                    phone: phone.text);
                              }
                            },
                          ),
                        ),
                    fallback: (context) => const ProgressIndicatorWidget())
              ],
            ),
          ),
        );
      },
    );
  }
}
