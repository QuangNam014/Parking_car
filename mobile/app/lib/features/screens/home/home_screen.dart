// ignore_for_file: unnecessary_null_comparison

import 'package:app/constants/color.dart';
import 'package:app/constants/image.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/customer/customer_infor_controller.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:app/features/screens/customer/customer_home_screen.dart';
import 'package:app/features/screens/home/home_option_btn_widget.dart';
import 'package:app/features/screens/supplier/supplier_home_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = Get.put(CustomerHomeInforController()); 

  final listCarousel = [
    Image.asset(carousel1),
    Image.asset(carousel2),
    Image.asset(carousel3),
    Image.asset(carousel4),
    Image.asset(carousel5),
    Image.asset(carousel6),
    Image.asset(carousel7),
    Image.asset(carousel8),
    Image.asset(carousel9),
    Image.asset(carousel10),
    Image.asset(carousel11),
    Image.asset(carousel12),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: viewBgColor,
      appBar: AppBar(
        backgroundColor: lightBlueColor,
        centerTitle: true,
        title: const Image(image: AssetImage(logoP), height: 40.0,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0, bottom: 10.0),
                child: Text(
                  textHomeTitle,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0, top: 2.0, right: 18.0, bottom: 10.0),
                child: Text(
                  textHomeSubTitle,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: defaultSize-20,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      OptionHomeBtnWidget(
                        title: textHomeOptionParkingLot, 
                        image: logoOptionParkingLot, 
                        onTap: () => Get.offAll(() => SupplierHomeScreen()),
                      ),
          
                      OptionHomeBtnWidget(
                        title: textHomeOptionSearch, 
                        image: logoOptionSearchParking, 
                        colorBgCard: Colors.lightBlue,  
                        onTap: () async {
                          ProfileUser user = await controller.getProfileUser(); 
                          if(user != null) {
                            Get.to(() => CustomerHomeScreen(user: user,));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
          
              const SizedBox(height: defaultSize-20,),
          
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayInterval: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    height: 400,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    }
                  ),
                  items: listCarousel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


