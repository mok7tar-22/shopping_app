import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/local/preferences.dart';

part 'setteings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);
  ThemeMode mode=Preferences.getThemePreference();
  bool isDark= Preferences.getThemePreference()==ThemeMode.dark?true:false;
  void changeMode(bool dark) {
    if(dark){
      Preferences.saveThemePreference(ThemeMode.dark);
      mode=Preferences.getThemePreference();
      isDark=true;
    }
    else{
      Preferences.saveThemePreference(ThemeMode.light);
      mode=Preferences.getThemePreference();
      isDark=false;

    }
    emit(ModeState());

  }
}
