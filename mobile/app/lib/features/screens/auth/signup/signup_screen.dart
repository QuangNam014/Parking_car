import 'package:app/constants/color.dart';
import 'package:app/constants/image.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/auth/signup_controller.dart';
import 'package:app/features/models/auth/register_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key, required this.email});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String email;

  @override
  Widget build(BuildContext context) {
    final signupController = Get.put(SignUpController());
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlueColor,
        title: const Text('Person information'),
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
                    image: const AssetImage(logoP),
                    height: height * 0.15,
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
                        TextFormField(
                          enabled: false,
                          initialValue: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: textEmail,
                            hintText: textEmail,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: formHeight),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: signupController.fullNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: textFullName,
                            hintText: textFullName,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              (value!.isEmpty) ? "Fullname is required" : null,
                        ),
                        const SizedBox(height: formHeight),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: signupController.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_rounded),
                            labelText: textPhoneNo,
                            hintText: textPhoneNo,
                            border: OutlineInputBorder(),
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
                        Obx(
                          () => TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: signupController.passwordController,
                            obscureText: !signupController.showPassword.value,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.fingerprint),
                                labelText: textPassword,
                                hintText: textPassword,
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed:
                                      signupController.onToggleShowPassword,
                                  color: secondaryColor,
                                  icon: Icon(
                                    signupController.showPassword.value
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterModel registerUser = RegisterModel(
                                    fullname: signupController.fullNameController.text, 
                                    email: email, 
                                    password: signupController.passwordController.text, 
                                    phone: signupController.phoneController.text
                                  );
                                  signupController.createUser(registerUser, context);
                                }
                              },
                              child: Text(textSignup.toUpperCase()),
                          ),
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
