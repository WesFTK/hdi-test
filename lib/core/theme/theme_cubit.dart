import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hdi_test/utils/local_storage/local_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(LocalStorage.themeMode);

  void setMode(ThemeMode mode) {
    LocalStorage.setThemeMode(mode);
    emit(mode);
  }
}
