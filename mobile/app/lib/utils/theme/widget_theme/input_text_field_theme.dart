import 'package:app/constants/color.dart';
import 'package:flutter/material.dart';

class AppTextFormFieldTheme {
  
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)),
    prefixIconColor: secondaryColor,
    floatingLabelStyle: const TextStyle(color: secondaryColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
      borderSide: const BorderSide(width: 2.0, color: secondaryColor),
    ),
  );

  static InputDecorationTheme darknputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)),
    prefixIconColor: primaryColor,
    floatingLabelStyle: const TextStyle(color: primaryColor),
    focusedBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0), 
      borderSide: const BorderSide(width: 2.0, color: primaryColor),
    )
  );
  
}