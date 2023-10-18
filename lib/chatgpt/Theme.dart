import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeModel with ChangeNotifier, WidgetsBindingObserver {
  ThemeData lightTheme = ThemeConfig.lightTheme;
  ThemeData darkTheme = ThemeConfig.darkTheme;
  ThemeMode themeMode = ThemeConfig.defaultThemeMode;

  ThemeModel() {
    debugPrint("init ThemeModel");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    var brightness = WidgetsBinding.instance!.window.platformBrightness;
    if (brightness == Brightness.dark) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    debugPrint("theme changed to be ${themeMode.name}");

    notifyListeners();
  }

  ThemeData getCurrent() {
    debugPrint("get current returned " + themeMode.name);
    if (themeMode == ThemeMode.light) {
      return lightTheme;
    } else {
      return darkTheme;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}

class ThemeConfig {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Colors.cyan,
        brightness: Brightness.dark,
        backgroundColor: Colors.greenAccent,
        //scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          //   color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.greenAccent,
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        brightness: Brightness.dark,
        primaryColorDark: Colors.blue,
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
