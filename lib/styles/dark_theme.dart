import 'package:SmartTraffic/styles/app_colors.dart';
import 'package:flutter/material.dart';

darkTheme(BuildContext context) {
  const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
  ThemeData darkTheme = ThemeData(
    primarySwatch: white,
    scaffoldBackgroundColor: AppColors.bgPrimaryDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff007dc0),
      brightness: Brightness.dark,
      primary: AppColors.textOnBgPrimaryDark,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.textOnBgPrimaryDark,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppColors.textOnBgPrimaryDark,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: AppColors.textOnBgPrimaryDark,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: AppColors.textOnBgPrimaryDark,
      elevation: 0,
      backgroundColor: AppColors.bgPrimaryDark,
    ),
    // textfield
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: AppColors.textOnBgPrimaryDark,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: AppColors.white,
          width: 3,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 3,
        ),
      ),
    ),
  );
  return darkTheme;
}
