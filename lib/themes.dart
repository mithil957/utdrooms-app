import 'colors.dart';
import 'package:flutter/material.dart';


CustomTheme currentTheme = CustomTheme();


class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: Colors.lightBlue,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
            headline1: TextStyle(color: Colors.black),
            headline2: TextStyle(color: Colors.black),
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black)
        )
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.red,
      backgroundColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey,
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white)
      )
    );
  }
}