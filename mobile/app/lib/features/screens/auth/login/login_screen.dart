import 'package:app/constants/size.dart';
import 'package:app/features/screens/auth/login/login_form_widget.dart';
import 'package:app/features/screens/auth/login/login_header_widget.dart';
import 'package:app/features/screens/auth/login/login_footer_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child:  const Column(
              children: [
                LoginHeaderWidget(),

                LoginFormWidget(),
      
                LoginFooterWidget(),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}






