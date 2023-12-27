import 'package:app/constants/text.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/screens/profile/profile_btn_option_widget.dart';
import 'package:app/features/screens/supplier/product/edit_product/edit_image_screen.dart';
import 'package:app/features/screens/supplier/product/edit_product/edit_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductScreen {
  static Future<dynamic> showModelBottomSheetEdit(BuildContext context, ProductListModel arguments) {
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
                textEditProductSubHeading,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15.0),
              ProfileBtnOptionWidget(
                btnIcon: Icons.change_circle_outlined,
                title: textEditProductImage,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const EditImageScreen(), arguments: arguments);
                }
              ),
              const SizedBox(height: 30.0),
          
              ProfileBtnOptionWidget(
                btnIcon: Icons.manage_accounts,
                title: textEditProductInfor,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const EditInformationScreen(), arguments: arguments);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}