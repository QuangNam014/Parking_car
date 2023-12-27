// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/models/supplier/status_model.dart';
import 'package:app/features/screens/supplier/supplier_home_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class SupplierHomeProductController extends GetxController {

  var listData = RxList<ProductListModel>().obs;
  // var filterListProduct = RxList<ProductListModel>().obs;

  Future<List<ProductListModel>?> getListProduct() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(supplierListProductAPI);
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      listData.value.clear();
      for (var item in apiResponse.data) {
        listData.value.add(ProductListModel.fromJson(item));
      }
      return listData.value;
    } else {
      return null;
    }
  }

  Future<void> updateStatus(StatusModel data, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(supplierStatusProductAPI, data);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
         QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
          confirmBtnText: 'Back to Parking',
          onConfirmBtnTap: () => Get.offAll(() => SupplierHomeScreen()),
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
    }
    
  }
}