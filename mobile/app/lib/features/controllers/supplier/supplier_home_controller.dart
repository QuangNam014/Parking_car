import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/supplier/list/get_supplier_count_dashboard.dart';
import 'package:app/features/screens/supplier/dashboard/supplier_dashboard_screen.dart';
import 'package:app/features/screens/supplier/order/supplier_order_product_screen.dart';
import 'package:app/features/screens/supplier/product/supplier_product_screen.dart';
import 'package:app/features/screens/supplier/transaction/supplier_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SupplierHomeController extends GetxController {

  RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
  
    const SupplierDashBoardScreen(),

    const SupplierProductScreen(),

    const SupplierOrderProductScreen(),

    const SupplierTransactionScreen(),
  ];

  final List<GButton> tabList = const [
    GButton(
      icon: Icons.home_filled,
      text: 'Home',
    ),
    GButton(
      icon: Icons.local_parking_rounded,
      text: 'Parking',
    ),
    GButton(
      icon: Icons.sticky_note_2_outlined,
      text: 'Manage Order',
    ),
    GButton(
      icon: Icons.car_rental_outlined,
      text: 'Manage Rental',
    ),
  ];

  navigateBottomBar(int index) => selectedIndex.value = index;

  Future<GetDataSupplierCountModel?> getDataCountSupplier() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(getCountDashboardAPI);
    Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      return GetDataSupplierCountModel.fromJson(apiResponse.data);
    } else {
      return null;
    }
  }
}