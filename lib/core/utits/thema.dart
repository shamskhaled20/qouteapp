import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ThemeProvider class to manage the theme
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData =
    _themeData == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}

// ThemeCubit to manage the overall theme mode of the app
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}

// QoutesCubit and AddQuoteCubit (if you have them)

// ApiServiceAddQuoteList class (if you have it)