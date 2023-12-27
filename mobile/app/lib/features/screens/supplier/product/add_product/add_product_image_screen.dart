import 'dart:io';

import 'package:app/constants/color.dart';
import 'package:app/features/controllers/supplier/product/supplier_add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';



class AddProductImageScreen extends StatelessWidget {
  const AddProductImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupplierAddProductController());

    return Center(
      child: Column(
        children: [
          const Center(child: Text("Vui lòng chọn ít nhất 1 hình", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
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
            
                          Positioned(
                            top: -4, 
                            right: -4, 
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0), 
                                color: const Color.fromRGBO(255, 255, 244, 0.7),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red[900],
                                onPressed: () {
                                  controller.imagePathList.removeAt(index);
                                  controller.selectedFileCount.value = controller.imagePathList.length;
                                },
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

          const SizedBox(height: 20.0),

          SizedBox(
            width: 300,
            child: ElevatedButton.icon(
              onPressed: () {
                controller.selectMultiImages();
              },
              icon: const Icon(Icons.photo_size_select_actual_outlined, color: darkColor),
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
              label: const Text('Choose Image Gallery', style: TextStyle(color: darkColor)),
            ),
          ),

          // SizedBox(
          //   width: 300,
          //   child: ElevatedButton.icon(
          //     onPressed: () {
          //       // uploadImage(imagePath!);
          //       // uploadMultiImage(imagePathList);
          //     },
          //     icon: const Icon(Icons.cloud_upload_outlined, color: darkColor),
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
          //     label: const Text('Upload Images', style: TextStyle(color: darkColor)),
          //   ),
          // ),
        ],
      ),
    );
  }
}
