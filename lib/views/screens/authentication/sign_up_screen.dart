import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/controllers/sign_up/sign_up_cubit.dart';
import '../../widgets/authentication_widgets/sign_up/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {


  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: SignUpBody(),
    );
  }
}
