// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:app/constants/color.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/constants/image.dart';
import 'package:app/features/controllers/profile/update_infor_controller.dart';
import 'package:app/features/models/profile/profile_update_request.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:app/features/models/supplier/infor_image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateInforController());
    ProfileUser data =  Get.arguments;
    controller.fullNameController.text = data.fullname!;
    controller.phoneController.text = data.phone!;

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
              // -- IMAGE with ICON
              Obx(() => Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: (controller.imagePath == null || controller.imagePath.isEmpty) ? 
                          ((data.imageUrl!.isEmpty) ? const Image(image: AssetImage(tProfileImage)) :  Image(image: NetworkImage(data.imageUrl!)))
                          : Image.file(File(controller.imagePath.value))
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100), color: primaryColor),
                        child: IconButton(
                          icon: const Icon(LineAwesomeIcons.camera), 
                          color: Colors.black, 
                          iconSize: 20, 
                          onPressed: controller.selectImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      controller: controller.fullNameController,
                      decoration: const InputDecoration(
                        label: Text(textFullName), 
                        prefixIcon: Icon(LineAwesomeIcons.user),
                      ),
                      validator: (value) => (value!.isEmpty) ? "Fullname is required" : null,
                    ),
                    const SizedBox(height: formHeight - 10),
                    
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        label: Text(textPhoneNo), 
                        prefixIcon: Icon(LineAwesomeIcons.phone)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone is required";
                        } else if (!RegExp(r'^0\d{9}$').hasMatch(value)) {
                          return "The phone starts with 0 and must have 10 numbers";
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: formHeight),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            late ProfileUpdateRequest updateUser;
                            if(controller.imagePath.isEmpty) {
                              updateUser = ProfileUpdateRequest(
                                fullname: controller.fullNameController.text,
                                phone: controller.phoneController.text,
                                imageName: data.imageName!,
                                imageUrl: data.imageUrl!
                              );
                            } else {
                              InforImageModel? dataImage = await controller.uploadImage();
                              if(dataImage == null) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text: 'upload image fail',
                                );
                                throw Exception();
                              } else {
                                updateUser = ProfileUpdateRequest(
                                  fullname: controller.fullNameController.text,
                                  phone: controller.phoneController.text,
                                  imageName: dataImage.name,
                                  imageUrl: dataImage.url,
                                );
                              }
                            }
                            controller.updateProfile(updateUser, context);
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