import 'package:app/constants/color.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/widget/option_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpOptionWidget extends StatelessWidget {
  const OtpOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final optionViewController = Get.put(OptionWidgetController());
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightBlueColor,
        ),
        body: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CODE',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 80.0),
              ),
              Text(
                'Verification'.toUpperCase(),
                style: GoogleFonts.montserrat(
                    fontSize: 24.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                "$textOtpMsg ${optionViewController.emailController.text}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              OtpTextField(
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (code) {
                  optionViewController.verifiedToken(context, code);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),

              TextButton(
                onPressed: () => optionViewController.getToken(context),
                child: const Text(
                  'Reset Token',
                  style: TextStyle(color: accentColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
