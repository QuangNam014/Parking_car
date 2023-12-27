import 'package:app/constants/image.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/screens/auth/login/login_screen.dart';
import 'package:app/features/screens/customer/manager/customer_manager_screen.dart';
import 'package:app/features/screens/home/home_screen.dart';
import 'package:app/features/screens/profile/profile_screen.dart';
import 'package:app/widgets/drawer/drawer_item_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerOptionWidget extends StatelessWidget {
  const DrawerOptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //logo
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  logoP,
                  width: 100,
                  height: 100,
                ),
              ),
    
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(color: Color.fromARGB(255, 95, 93, 93)),
              ),
    
              //other pages
              DrawerItemBtnWidget(
                title: textDrawerHome, 
                icon: Icons.home, 
                onTap: () => Get.offAll(() => const HomeScreen()),
              ),
              DrawerItemBtnWidget(
                title: textDrawerProfile, 
                icon: Icons.info_rounded, 
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const ProfileScreen());
                },
              ),
              DrawerItemBtnWidget(
                title: textDrawerCustomer, 
                icon: Icons.person_2_rounded, 
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const CustomerManagerScreen());
                },
              ),
            ],
          ),
    
          DrawerItemBtnWidget(
            title: textDrawerLogout, 
            colorIcon: Colors.red[600],
            icon: Icons.logout_rounded, 
            onTap: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Get.offAll(() => const LoginScreen());
            },
          ),
          
        ],
      ),
    );
  }
}


