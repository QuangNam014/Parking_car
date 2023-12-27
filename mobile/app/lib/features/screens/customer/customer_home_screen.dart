// ignore_for_file: must_be_immutable


import 'package:app/features/controllers/customer/customer_map_controller.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:app/features/screens/customer/customer_infor_screen.dart';
import 'package:app/features/screens/customer/customer_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key, required this.user});

  final controller = Get.put(CustomerMapController());

  ProfileUser user;

  @override
  Widget build(BuildContext context) {
    
    controller.loadData();
    return Scaffold(
      body: (user.userDocument!.isEmpty || user.userLicense!.isEmpty) ?  const CustomerInforScreen() : const CustomerMapScreen(),
    );
  }
}



