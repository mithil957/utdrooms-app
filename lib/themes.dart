import 'colors.dart';
import 'package:flutter/material.dart';


CustomTheme currentTheme = CustomTheme();


class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => ThemeMode.light;

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
      backgroundColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey,
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white)
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red)
    );
  }

  static ThemeData get shrineTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kShrinePink100,
        onPrimary: kShrineBrown900,
        secondary: kShrineBrown900,
        error: kShrineErrorRed,
      ),
      textTheme: _buildShrineTextTheme(base.textTheme),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: kShrinePink100,
      ),
    );
  }

  ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kShrinePink100,
        onPrimary: kShrineBrown900,
        secondary: kShrineBrown900,
        error: kShrineErrorRed,
      ),
      textTheme: _buildShrineTextTheme(base.textTheme),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: kShrinePink100,
      ),
    );
  }
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
    headline5: base.headline5!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    headline6: base.headline6!.copyWith(
      fontSize: 18.0,
    ),
    caption: base.caption!.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    bodyText1: base.bodyText1!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  )
      .apply(
    fontFamily: 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900,
  );
}