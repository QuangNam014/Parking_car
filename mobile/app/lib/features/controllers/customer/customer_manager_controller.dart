// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/customer/list/get_customer_not_status_model.dart';
import 'package:app/features/models/supplier/status_model.dart';
import 'package:app/features/models/supplier/status_model_rent.dart';
import 'package:app/features/screens/customer/manager/customer_manager_screen.dart';
import 'package:app/features/screens/customer/manager/order/manager_order_screen.dart';
import 'package:app/features/screens/customer/manager/rent/manager_rent_screen.dart';
import 'package:app/features/screens/customer/manager/rent/payment_success_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:quickalert/quickalert.dart';

class CustomerManagerController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final List<Widget> pages = [
    const ManagerOrderCustomerScreen(),
    const ManagerRentCustomerScreen(),
  ];
  final List<GButton> tabList = const [
    GButton(
      icon: Icons.sticky_note_2_outlined,
      text: 'Order',
    ),
    GButton(
      icon: Icons.car_rental_outlined,
      text: 'Rent',
    ),
  ];

  navigateBottomBar(int index) => selectedIndex.value = index;

  // order

  var listDataOrder = RxList<GetDataCustomerNotStatusModel>().obs;

  Future<List<GetDataCustomerNotStatusModel>?> getListOrderCustomerNotSuccess() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(getListOrderCustomerNotSuccessAPI);
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      listDataOrder.value.clear();
      for (var item in apiResponse.data) {
        listDataOrder.value.add(GetDataCustomerNotStatusModel.fromJson(item));
      }
      return listDataOrder.value;
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
    }
  }

  // rent
  var listDataRent = RxList<GetDataCustomerNotStatusModel>().obs;

  Future<List<GetDataCustomerNotStatusModel>?> getLisRentCustomerNotCancel() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(getListRentCustomerNotCancelAPI);
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      listDataRent.value.clear();
      for (var item in apiResponse.data) {
        listDataRent.value.add(GetDataCustomerNotStatusModel.fromJson(item));
      }
      return listDataRent.value;
    } else {
      return null;
    }
  }

  Future<void> updateStatusRent(StatusRentModel data, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(supplierUpdateStatusRentAPI, data);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
        Get.off(() => const PaymentSuccessScreen());
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