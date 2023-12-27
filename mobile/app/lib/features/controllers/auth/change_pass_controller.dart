// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/auth/change_password_model.dart';
import 'package:app/features/models/profile/change_password_request.dart';
import 'package:app/features/screens/auth/login/login_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class ChangePasswordController extends GetxController {

  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  static ChangePasswordController get find => Get.find();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  onToggleShowPassword() => showPassword.value = !showPassword.value;
  onToggleShowConfirmPassword() => showConfirmPassword.value = !showConfirmPassword.value;

  Future<void> resetPass(ChangedPasswordModel reset, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await http.post(
        Uri.parse(resetPassAPI),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode(reset.toJson()),
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);

      if(apiResponse.status == 200) {
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

  Future<void> changePassProfile(ChangedPasswordRequest reset, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(profileChangePassAPI, reset);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);

      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
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