import 'package:app/constants/color.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/screens/auth/forget_password/options/forget_password_modal_screen.dart';
import 'package:app/widgets/options/email_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => ForgetPasswordModalScreen.showModelBottomSheetForgetPassword(context),
          child: const Text(
            textForgetPassword,
            style: TextStyle(color: accentColor),
          ),
        ),
      
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 30.0, 
          width: 2.0,
          color: secondaryColor,
        ),
        
        TextButton(
          onPressed: () {
            Get.to(() => EmailOptionWidget(nextView: textSignUpView,));
          },
          child: const Text(
            textSignup,
            style: TextStyle(color: accentColor),
          ),
        ),
      ],
    );
  }

  
}