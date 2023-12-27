// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/controllers/customer/customer_map_controller.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/customer/customer_infor_model.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:app/features/screens/customer/customer_map_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class CustomerHomeInforController extends GetxController {

  final TextEditingController documentController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controller = Get.put(CustomerMapController());

  Future<ProfileUser> getProfileUser() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(profileUserAPI);
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      return ProfileUser.fromJson(apiResponse.data);
    } else {
      throw Exception("fail to load data");
    }
  }

  Future<void> createInforCustomer(CustomerInforModel customerInfor, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(customerCreateInforAPI, customerInfor);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 201) {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
          confirmBtnText: 'Go to map',
          onConfirmBtnTap: () => Get.off(() => const CustomerMapScreen()),
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