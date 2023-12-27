// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app/constants/color.dart';
import 'package:app/features/controllers/supplier/product/supplier_edit_product_controller.dart';
import 'package:app/features/models/supplier/infor_image_model.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/models/supplier/product/update_product_image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({super.key});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupplierEditProductController());
    ProductListModel data =  Get.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: lightBlueColor,),
        body:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
              children: [
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
                                        image: getImageProvider(controller.imagePathList[index]),
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

                const SizedBox(height: 30,),
          
                SizedBox(
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      List<InforImageModel> listImage = [];
                      List<String> listString = [];
                      for (var imagePath in controller.imagePathList) {
                        if(imagePath.startsWith('http')) {
                          InforImageModel inforImageModel = InforImageModel(
                            name: extractSubstring(imagePath),
                            url: imagePath
                          );
                          listImage.add(inforImageModel);
                        } else {
                          listString.add(imagePath);
                        }
                      }

                      if(listString.isNotEmpty) {
                        List<InforImageModel> listImageUpload = await controller.uploadMultiImage(listString);
                        listImage.addAll(listImageUpload);
                      }

                      UpdateProductImageModel updateImage = UpdateProductImageModel(id: data.id!, listImage: listImage);
                      await controller.updateImage(updateImage, context);
                    },
                    icon: const Icon(Icons.cloud_upload_outlined, color: darkColor),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                    label: const Text('Update Image', style: TextStyle(color: darkColor)),
                  ),
                ),
              ],
            ),
        ),
         
      ),
    );
  }

  ImageProvider getImageProvider(String imagePath) {
    if (imagePath.startsWith('http')) {
      // Nếu là đường dẫn từ URL
      return NetworkImage(imagePath);
    } else {
      // Nếu là đường dẫn local
      return FileImage(File(imagePath));
    }
  }

  String extractSubstring(String input) {
    // Tìm vị trí của 'app-my-parking'
    int startIndex = input.indexOf('app-my-parking');

    // Nếu không tìm thấy hoặc vị trí không hợp lệ, trả về chuỗi ban đầu
    if (startIndex == -1 || startIndex + 'app-my-parking'.length >= input.length) {
      return input;
    }

    // Tìm vị trí của dấu chấm cuối cùng
    int endIndex = input.lastIndexOf('.');

    // Nếu không tìm thấy dấu chấm, hoặc nó nằm trước hoặc ngay sau 'app-my-parking', trả về chuỗi ban đầu
    if (endIndex == -1 || endIndex <= startIndex + 'app-my-parking'.length) {
      return input;
    }

    // Lấy đoạn từ 'app-my-parking' đến trước dấu chấm cuối cùng
    String result = input.substring(startIndex, endIndex);

    return result;
  }
}