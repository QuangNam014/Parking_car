import 'package:app/constants/color.dart';
import 'package:app/constants/image.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/auth/change_pass_controller.dart';
import 'package:app/features/controllers/profile/update_infor_controller.dart';
import 'package:app/features/models/profile/change_password_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileChangePasswordScreen extends StatelessWidget {
  ProfileChangePasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateInforController());
    final changePassController = Get.put(ChangePasswordController());
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlueColor,
        leading: IconButton(onPressed: () {
          controller.futureProfileUser.value = controller.getProfileUser();
          Get.back();
        }, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text('Changed Password'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                SizedBox(
                  child: Image(
                    image: const AssetImage(logoResetPass),
                    height: height * 0.1,
                    width: 200,
                  ),
                ),
                Form(
                  key: formKey,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: formHeight - 10),
                    child: Column(
                      children: [
                        Obx(
                          () => TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: changePassController.passwordController,
                            obscureText: !changePassController.showPassword.value,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.fingerprint),
                                labelText: textPassword,
                                hintText: textPassword,
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed:
                                      changePassController.onToggleShowPassword,
                                  color: secondaryColor,
                                  icon: Icon(
                                    changePassController.showPassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            validator: (value) => (value!.isEmpty)
                                ? "Password is required"
                                : null,
                          ),
                        ),

                        const SizedBox(height: formHeight),

                        Obx(
                          () => TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: changePassController.confirmPasswordController,
                            obscureText: !changePassController.showConfirmPassword.value,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.fingerprint),
                                labelText: textConfirmPassword,
                                hintText: textConfirmPassword,
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed:
                                      changePassController.onToggleShowConfirmPassword,
                                  color: secondaryColor,
                                  icon: Icon(
                                    changePassController.showConfirmPassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              } else if (value != changePassController.passwordController.text) {
                                return "Password do not match";
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: formHeight),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ChangedPasswordRequest changedPasswordRequest = ChangedPasswordRequest(
                                    password: changePassController.passwordController.text, 
                                    confirmPassword: changePassController.confirmPasswordController.text
                                  );
                                  changePassController.changePassProfile(changedPasswordRequest, context);
                                }
                              },
                              child: Text(textChangePassword.toUpperCase())),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}