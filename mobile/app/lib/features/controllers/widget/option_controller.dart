// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:app/constants/text.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/screens/auth/forget_password/change_password_screen.dart';
import 'package:app/features/screens/auth/signup/signup_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:app/widgets/options/otp_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';


class OptionWidgetController extends GetxController {
  RxString nextView = "".obs;

  static OptionWidgetController get find => Get.find();

  final TextEditingController emailController = TextEditingController();


  handleNextView() {
    switch (nextView.value) {
      case textSignUpView:
        Get.to(() => SignUpScreen(email: emailController.text));
        break;
      case textForgetView:
        Get.to(() => ChangePasswordScreen());
        break;
      default: break;
    }
  }

  Future<void> sendEmail(BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      String url = domain + 'auth/check-email/${emailController.text}';
      var response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
      );
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);

      // code 400 mail chưa tồn tại
      // code 200 mail tồn tại
      switch (nextView.value) {
        case textSignUpView:
          signUpCallApi(apiResponse, context);
          break;
        case textForgetView:
          forgetPassCallApi(apiResponse, context);
          break;
        default: break;
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

  Future<void> signUpCallApi (ApiResponse apiResponse, BuildContext context) async {
    if(apiResponse.status == 400) {
      var data = await getToken(context);
      if(data) {
        LoadingOptions.hideLoading();
        Get.to(() => const OtpOptionWidget());
      }
    } else {
      LoadingOptions.hideLoading();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: apiResponse.message,
      );
    }
  }

  Future<void> forgetPassCallApi (ApiResponse apiResponse, BuildContext context) async {
    if(apiResponse.status == 200) {
      var data = await getToken(context);
      if(data) {
        LoadingOptions.hideLoading();
        Get.to(() => const OtpOptionWidget());
      }
    } else {
      LoadingOptions.hideLoading();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: apiResponse.message,
      );
    }
  }

  Future<void> verifiedToken(BuildContext context, String token) async {
    try {
      LoadingOptions.showLoading();
      String url = domain + 'auth/send/verified-token/${emailController.text}&${token}';
      var response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
      );

      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);

      if(apiResponse.status == 200) {
      LoadingOptions.hideLoading();
        handleNextView();
      } else {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: apiResponse.message,
        );
      }
      
    } catch (e) {
      QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Switch to a different IP or a different WiFi',
          );
      print(e);
    }
  }

  Future<bool> getToken(BuildContext context) async {
    LoadingOptions.showLoading();
    var response = await http.post(Uri.parse(sendTokenAPI),
      headers: {"Content-Type": "application/json;charset=UTF-8"},
      body: jsonEncode({
        "email": emailController.text,
      }),
    );
    Map<String, dynamic> responseMap = json.decode(response.body);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      LoadingOptions.hideLoading();
      return true;
    } else {
      LoadingOptions.hideLoading();
      return false;
    }
  }
  

}