import 'package:app/utils/theme/widget_theme/elevated_btn_theme.dart';
import 'package:app/utils/theme/widget_theme/input_text_field_theme.dart';
import 'package:app/utils/theme/widget_theme/outlined_btn_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {

  // AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButton,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButton,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    // textTheme: AppTextTheme.lightTextTheme,
  );

  static ThemeData dartTheme = ThemeData(
    brightness: Brightness.dark,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButton,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButton,
    inputDecorationTheme: AppTextFormFieldTheme.darknputDecorationTheme,
    // textTheme: AppTextTheme.dartTextTheme,
  );
  
}