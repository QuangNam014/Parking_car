import 'package:app/constants/color.dart';
import 'package:app/constants/image.dart';
import 'package:app/features/controllers/customer/customer_manager_controller.dart';
import 'package:app/widgets/bottom_navigation_bar/bottom_navigation_bar_options_widget.dart';
import 'package:app/widgets/drawer/drawer_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerManagerScreen extends StatelessWidget {
  const CustomerManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerManagerController());

    return Scaffold(
      backgroundColor: Colors.grey[300],

      bottomNavigationBar: BottomNavigationBarWidget(
        onTabChange: (index) => controller.navigateBottomBar(index),
        listTab: controller.tabList,
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
      body: Obx(() => controller.pages[controller.selectedIndex.value]),
    );
  }
}