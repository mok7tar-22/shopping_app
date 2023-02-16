import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/controllers/login/login_cubit.dart';
import '../../widgets/authentication_widgets/login/login_body.dart';

class LoginScreen extends StatelessWidget {


  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LoginCubit(), child: LoginBody());
  }
}
