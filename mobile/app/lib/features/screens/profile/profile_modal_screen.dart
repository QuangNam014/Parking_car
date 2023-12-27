import 'package:app/constants/text.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:app/features/screens/profile/profile_btn_option_widget.dart';
import 'package:app/features/screens/profile/profile_change_password_screen.dart';
import 'package:app/features/screens/profile/update_profile_customer_screen.dart';
import 'package:app/features/screens/profile/update_profile_screen.dart';
import 'package:app/widgets/card_payment/card_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileModalScreen {
  static Future<dynamic> showModelBottomSheetProfile(BuildContext context, ProfileUser arguments) {
    return showModalBottomSheet(
      context: context, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                textForgetPasswordTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                textProfileSubHeading,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15.0),
              ProfileBtnOptionWidget(
                btnIcon: Icons.change_circle_outlined,
                title: textProfileChangePass,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => ProfileChangePasswordScreen());
                }
              ),
              const SizedBox(height: 30.0),
          
              ProfileBtnOptionWidget(
                btnIcon: Icons.manage_accounts,
                title: textProfileAccount,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const UpdateProfileScreen(), arguments: arguments);
                }
              ),
              const SizedBox(height: 30.0),

              (arguments.userDocument!.isNotEmpty && arguments.userLicense!.isNotEmpty) ?
              ProfileBtnOptionWidget(
                btnIcon: Icons.edit,
                title: textProfileCustomer,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const UpdateProfileCustomerScreen(), arguments: arguments);
                }
              ) : const SizedBox(),

              (arguments.paymentInfo!.isNotEmpty) ?
              ProfileBtnOptionWidget(
                btnIcon: Icons.edit,
                title: textProfileCustomerPayment,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const CardPaymentScreen());
                }
              ) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}