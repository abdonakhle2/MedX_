import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleThemeMode(bool isDarkMode) {
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  bool get isDarkMod {
    if (state == ThemeMode.dark) {
      return true;
    } else {
      return false;
    }
  }
}
