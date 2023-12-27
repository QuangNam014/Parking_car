import 'package:app/constants/color.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key,});

  @override
  Widget build(BuildContext context) {

    final loginController = LoginController();

    return Form(
      key: loginController.formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: loginController.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: textEmail,
                hintText: textEmail,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if(value!.isEmpty) {
                  return "Email is required";
                } else if(!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
                  return "Enter a valid email address";
                } return null;
              },
            ),
            
            const SizedBox(height: formHeight - 20),

            Obx(() => TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: loginController.passwordController,
                obscureText: !loginController.showPassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint),
                  labelText: textPassword,
                  hintText: textPassword,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: loginController.onToggleShowPassword,
                    color: secondaryColor,
                    icon: Icon(loginController.showPassword.value ? Icons.visibility : Icons.visibility_off,),
                  )
                ),
                validator: (value) => (value!.isEmpty) ? "Password is required":null,
              ),
            ),

            const SizedBox(height: formHeight),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if(loginController.formKey.currentState!.validate()) {                    
                      loginController.login(loginController.emailController.text, loginController.passwordController.text, context);
                    }
                  }, 
            
                  child: Text(textLogin.toUpperCase())
              )
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: 'Oops...',
    text: 'Sorry, something went wrong',
  );
}
}