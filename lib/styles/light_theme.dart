import 'package:SmartTraffic/styles/app_colors.dart';
import 'package:flutter/material.dart';

lightTheme(BuildContext context) {
  const MaterialColor black = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  ThemeData lightTheme = ThemeData(
    primarySwatch: black,
    scaffoldBackgroundColor: AppColors.bgPrimaryLight,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff007dc0),
      brightness: Brightness.light,
      primary: AppColors.textOnBgPrimaryLight,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.textOnBgPrimaryLight,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppColors.textOnBgPrimaryLight,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: AppColors.textOnBgPrimaryLight,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.bgPrimaryLight,
      foregroundColor: AppColors.bgPrimaryLight,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(15),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffD7D7D7),
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color(0xffD7D7D7),
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(
          color: AppColors.dangerLight,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: const MaterialStatePropertyAll(AppColors.successLight),
      fillColor: const MaterialStatePropertyAll(AppColors.white),
      side: MaterialStateBorderSide.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return const BorderSide(color: AppColors.successLight, width: 1);
        } else {
          return const BorderSide(color: AppColors.successLight, width: 1);
        }
      }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
    ),
  );

  return lightTheme;
}
