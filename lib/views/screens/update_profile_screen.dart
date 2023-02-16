import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/controllers/profile/profile_cubit.dart';
import 'package:shopping_app/views/screens/main_screen.dart';
import '../widgets/authentication_widgets/text_field_auth.dart';

class UpdateProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  final TextEditingController userName = TextEditingController(),
      phone = TextEditingController(),
      email = TextEditingController();

  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            ProfileCubit cubit = ProfileCubit.get(context);
            var model = cubit.userDataModel;
            userName.text = model!.data!.name!;
            email.text = model.data!.email!;
            phone.text = model.data!.phone!;
          }
          if (state is UpdateProfileSuccessState) {
            FocusScope.of(context).unfocus();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            body: Form(
              key: form,
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  const Text("User Name"),
                  TextFieldAuth(
                      controller: userName,
                      validator: (value) {
                        if (value.toString().isNotEmpty &&
                            value.toString().trim().length > 5) {
                          return null;
                        } else {
                          return "please enter user name five character at least";
                        }
                      },
                      hintText: "User Name"),
                   SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.text,
                    enabled: false,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.alternate_email),
                    ),
                  ),
                   SizedBox(
                    height: 8.h,
                  ),
                  const Text("Phone"),
                  TextFieldAuth(
                      controller: phone,
                      validator: (value) {
                        if (value != null && value.length >= 11) {
                          return null;
                        } else {
                          return "Please enter 11 characters at least.";
                        }
                      },
                      suffixIcon: const Icon(Icons.phone),
                      hintText: "Phone"),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (form.currentState!.validate()) {
                          ProfileCubit.get(context).updateProfileData(
                              email: email.text,
                              name: userName.text,
                              phone: phone.text);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Text("Update"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Text("Cancle"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
