import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData lightTheme = ThemeConfig.lightTheme;
  ThemeData darkTheme = ThemeConfig.darkTheme;
  ThemeMode themeMode = ThemeConfig.defaultThemeMode;

  void changeThemeModeBySystem(BuildContext context) {
    print("change theme");
    if (themeMode == ThemeMode.system) {
      var brightness = MediaQuery.of(context).platformBrightness;
      if (brightness == Brightness.dark) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.light;
      }
      notifyListeners();
    }
  }

  ThemeData get current {
    if (themeMode == ThemeMode.light) {
      return lightTheme;
    } else {
      return darkTheme;
    }
  }
}

class ThemeConfig {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Colors.cyan,
        brightness: Brightness.dark,
        backgroundColor: Colors.greenAccent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.greenAccent,
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        brightness: Brightness.dark,
        backgroundColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      );

  static ThemeMode get defaultThemeMode => ThemeMode.system;
}
