// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/models/supplier/product/update_product_infor_model.dart';
import 'package:app/features/screens/supplier/supplier_home_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class SupplierEditProductInforController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController totalSlotController = TextEditingController();
  final TextEditingController priceController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    ProductListModel data =  Get.arguments; 
    totalSlotController.text = data.totalSlot.toString();
    priceController.text = data.price.toString();
  }

  Future<void> updateInformation(UpdateProductInforModel productInfor, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(supplierUpdateInforProductAPI, productInfor);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
          confirmBtnText: 'Back to detail',
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
      print(e);
    }
  }
}