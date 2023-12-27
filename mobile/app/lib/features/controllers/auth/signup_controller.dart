// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/auth/register_model.dart';
import 'package:app/features/screens/auth/login/login_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class SignUpController extends GetxController {


  RxBool showPassword = false.obs;

  static SignUpController get find => Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  onToggleShowPassword() => showPassword.value = !showPassword.value;

  Future<void> createUser(RegisterModel user, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await http.post(
        Uri.parse(registerAPI),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode(user.toJson()),
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);

      if(apiResponse.status == 201) {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
          onConfirmBtnTap: () {
            Get.offAll(() => const LoginScreen());
          },
          confirmBtnText: 'Back to login',

        );
      } else {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: apiResponse.message,
        );
      }
    } catch (e) {
      LoadingOptions.hideLoading();
      QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Switch to a different IP or a different WiFi',
          );
      print(e);
    }
  }

}