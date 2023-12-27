import 'dart:io';
import 'package:app/features/controllers/supplier/product/supplier_add_product_controller.dart';
import 'package:app/features/screens/profile/menu_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddProductConfirmScreen extends StatelessWidget {
  const AddProductConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupplierAddProductController());
    return Center( 
      child: Column(
        children: [

          ProfileMenuWidget(title: "Total Slot: ${controller.totalSlotController.text} slot", icon: LineAwesomeIcons.parking, endIcon: false),
          ProfileMenuWidget(title: "Amount in 1 hour: ${controller.priceController.text} \$/h", icon: LineAwesomeIcons.money_check, endIcon: false),
          ProfileMenuWidget(title: "Address: ${controller.street}, ${controller.ward}, ${controller.district}", icon: LineAwesomeIcons.address_card, endIcon: false),

          Obx(() => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    itemCount: controller.selectedFileCount.value,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ), 
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          InstaImageViewer(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  image: FileImage(File(controller.imagePathList[index])), 
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}