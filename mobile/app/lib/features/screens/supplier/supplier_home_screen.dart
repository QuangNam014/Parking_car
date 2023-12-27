// ignore_for_file: must_be_immutable

import 'package:app/constants/color.dart';
import 'package:app/constants/image.dart';
import 'package:app/features/controllers/supplier/supplier_home_controller.dart';
import 'package:app/widgets/bottom_navigation_bar/bottom_navigation_bar_options_widget.dart';
import 'package:app/widgets/drawer/drawer_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SupplierHomeScreen extends StatelessWidget {
  SupplierHomeScreen({super.key, this.selectPage});

  int? selectPage;

  @override
  Widget build(BuildContext context) {
    final supllierHomeController = Get.put(SupplierHomeController());

    if(selectPage != null) {
      supllierHomeController.selectedIndex.value = selectPage!;
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],

      bottomNavigationBar: BottomNavigationBarWidget(
        onTabChange: (index) => supllierHomeController.navigateBottomBar(index),
        listTab: supllierHomeController.tabList,
      ),

      appBar: AppBar(
        backgroundColor: lightBlueColor,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        title: const Image(image: AssetImage(logoP), height: 40.0,),
      ),

      drawer: const DrawerOptionWidget(),
      body: Obx(() => supllierHomeController.pages[supllierHomeController.selectedIndex.value]),
    );
  }
}



