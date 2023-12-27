// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/customer/product/product_order_park_model.dart';
import 'package:app/features/screens/customer/manager/customer_manager_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class CustomerOrderController extends GetxController {

  Future<void> createOrderPark(ProductOrderParkModel customerOrder, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(createOrderProductAPI, customerOrder);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 201) {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
          confirmBtnText: 'Go to manager',
          onConfirmBtnTap: () => Get.offAll(() => const CustomerManagerScreen()),
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