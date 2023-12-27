// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:app/constants/color.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/profile/update_infor_controller.dart';
import 'package:app/features/models/profile/profile_doc_customer_request.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileCustomerScreen extends StatelessWidget {
  const UpdateProfileCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateInforController());
    ProfileUser data =  Get.arguments;
    controller.docController.text = data.userDocument!;
    controller.licenseController.text = data.userLicense!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          controller.futureProfileUser.value = controller.getProfileUser();
          Get.back();
        }, icon: const Icon(LineAwesomeIcons.angle_left)),
        centerTitle: true,
        title:const Text(textEditProfile, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              // -- Form Fields
              Form(
                key: controller.formKeyCustomer,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      controller: controller.docController,
                      decoration: const InputDecoration(
                        label: Text(textUserDoc), 
                        prefixIcon: Icon(Icons.edit_document),
                      ),
                      validator:(value) {
                        if (value!.isEmpty) {
                          return "CCCD is not empty";
                        } else if (value.length != 12 || int.tryParse(value) == null) {
                          return "Please enter 12 numbers";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: formHeight - 10),
                    
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.licenseController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text(textUserLicense), 
                        prefixIcon: Icon(Icons.edit_document)
                      ),
                      validator:(value) => (value!.isEmpty) ? "License is not empty":null, 
                    ),
                    
                    const SizedBox(height: formHeight),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.formKeyCustomer.currentState!.validate()) {
                            ProfileUpdateDocCustomerRequest customerRequest = ProfileUpdateDocCustomerRequest(
                              userDocument: controller.docController.text, 
                              userLicense: controller.licenseController.text,
                            );
                            controller.updateCustomerProfile(customerRequest, context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(textUpdate, style: TextStyle(color: darkColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}