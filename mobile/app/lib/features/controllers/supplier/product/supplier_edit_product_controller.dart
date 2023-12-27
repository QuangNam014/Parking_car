// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/supplier/infor_image_model.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/models/supplier/product/update_product_image_model.dart';
import 'package:app/features/screens/supplier/supplier_home_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';


class SupplierEditProductController extends GetxController {
  final uri = "https://api.cloudinary.com/v1_1/dpnkkp6rl/upload";
  RxBool hasSelectedImage = false.obs;
  RxInt selectedFileCount = 0.obs;

  late List<String> imagePathList;
  final ImagePicker imagePicker = ImagePicker();

  void selectMultiImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      for (var i in selectedImages) {
        imagePathList.add(i.path);
      }
      selectedFileCount.value = imagePathList.length;
      hasSelectedImage.value = true;
    }
  }

  Future<List<InforImageModel>> uploadMultiImage(List<String> imagePaths) async {
    List<InforImageModel> listImage = [];
    try {
      LoadingOptions.showLoading();
      final url = Uri.parse(uri);
      if(imagePaths.isNotEmpty) {
        for (String imagePath in imagePaths) {
          var request = http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = 'upload-image-project'
            ..files.add(await http.MultipartFile.fromPath('file', imagePath));
          var response = await request.send();
          if (response.statusCode == 200) {
            String responseData = await response.stream.bytesToString();
            Map<String, dynamic> jsonData = json.decode(responseData);
            InforImageModel imageModel = InforImageModel.fromJson(jsonData);
            listImage.add(imageModel);
          } else {
            LoadingOptions.hideLoading();
            throw Exception("upload fail");
          }
        }
      } 
      LoadingOptions.hideLoading();
      return listImage;
    } catch (error) {
      LoadingOptions.hideLoading();
      print('Error uploading image: $error');
      listImage = [];
      return listImage;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ProductListModel dataProduct = Get.arguments;
    List<ProductImageModel> data =  dataProduct.listImage;
    imagePathList = data.map((e) => e.url).toList();
    selectedFileCount.value = imagePathList.length;
  }

  Future<void> updateImage(UpdateProductImageModel productImage, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(supplierUpdateImageProductAPI, productImage);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
          confirmBtnText: 'Back to home',
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