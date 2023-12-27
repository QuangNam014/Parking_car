// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/supplier/list/get_supplier_status_model.dart';
import 'package:app/features/models/supplier/status_model.dart';
import 'package:app/features/screens/supplier/supplier_home_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class SupplierManagerController extends GetxController {
  // -- order
  var listDataSupplierOrder = RxList<GetDataSupplierStatusModel>().obs;

  Future<List<GetDataSupplierStatusModel>?> getListOrderSupplier() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(supplierListOrderFullStatusByIdAPI);
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      listDataSupplierOrder.value.clear();
      for (var item in apiResponse.data) {
        listDataSupplierOrder.value.add(GetDataSupplierStatusModel.fromJson(item));
      }
      return listDataSupplierOrder.value;
    } else {
      return null;
    }
  }

  Future<void> updateStatusOrder(StatusModel data, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(customerUpdateStatusOrderAPI, data);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
         QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
          confirmBtnText: 'Back to Manager',
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

  // -- transaction
  var listDataSupplierTransaction = RxList<GetDataSupplierStatusModel>().obs;

  Future<List<GetDataSupplierStatusModel>?> getListTransactionSupplier() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(supplierListRentFullStatusByIdAPI);
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      listDataSupplierTransaction.value.clear();
      for (var item in apiResponse.data) {
        listDataSupplierTransaction.value.add(GetDataSupplierStatusModel.fromJson(item));
      }
      return listDataSupplierTransaction.value;
    } else {
      return null;
    }
  }

  Future<void> updateStatusTransaction(StatusModel data, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(supplierUpdateStatusRentAPI, data);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
         QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
          confirmBtnText: 'Back to Manager',
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