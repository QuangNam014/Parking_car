import 'package:app/features/screens/welcome/welcome_screen.dart';
import 'package:app/utils/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.dartTheme,
      // themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const WelcomeScreen(),
    );
  }
}
