import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/controllers/profile/profile_cubit.dart';
import 'package:shopping_app/controllers/settings/setteings_cubit.dart';
import 'package:shopping_app/views/screens/authentication/login_screen.dart';
import 'package:shopping_app/views/screens/update_profile_screen.dart';
import 'package:shopping_app/views/widgets/progress_indicator_widget.dart';

import '../../data/local/preferences.dart';

class SettingsScree extends StatelessWidget {
  const SettingsScree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    ProfileCubit cubit = ProfileCubit.get(context);
    return ConditionalBuilder(
      condition: cubit.userDataModel != null,
      builder: (context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Expanded(
                child: Column(
                  children: [
                    Text(
                      cubit.userDataModel!.data!.name!,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      cubit.userDataModel!.data!.email!,
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                )),
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.grey,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        trailing: Icon(Icons.person),
                        title: Text(cubit.userDataModel!.data!.name!),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      ListTile(
                        trailing: Icon(Icons.alternate_email),
                        title: Text(cubit.userDataModel!.data!.email!),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      ListTile(
                        trailing: Icon(Icons.phone),
                        title: Text(cubit.userDataModel!.data!.phone!),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(),));

                        },
                        trailing: Icon(Icons.edit),
                        title: Text("Edit Profile"),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, state) {
                          return SwitchListTile(
                            title: Text("Mode"),

                            onChanged: (value) {
                              SettingsCubit.get(context)
                                  .changeMode(value);
                            },
                            value: SettingsCubit.get(context).isDark,
                          );
                        },
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                            Preferences.removeData("token");
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Logout"),
                                Icon(Icons.logout),
                              ],
                            ),
                          )),
                    ],
                  ),
                )),
          ]),
        ),
      ),
      fallback: (context) => const ProgressIndicatorWidget(),
    );
  },

    )
    );
  }
}

