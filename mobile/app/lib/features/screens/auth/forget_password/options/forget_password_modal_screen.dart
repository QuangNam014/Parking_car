import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/screens/auth/forget_password/options/forget_password_btn_widget.dart';
import 'package:app/widgets/options/email_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordModalScreen {
  static Future<dynamic> showModelBottomSheetForgetPassword(BuildContext context) {
    return showModalBottomSheet(
      context: context, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              textForgetPasswordTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              textForgetPasswordSubTitle,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mail_outline_outlined,
              title: textEmail,
              subTile: textResetViaEMail,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => EmailOptionWidget(nextView: textForgetView,));
              }
            ),
          ],
        ),
      ),
    );
  }
}

