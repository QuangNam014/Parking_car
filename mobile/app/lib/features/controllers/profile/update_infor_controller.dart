// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/profile/profile_doc_customer_request.dart';
import 'package:app/features/models/profile/profile_update_request.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:app/features/models/supplier/infor_image_model.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class UpdateInforController extends GetxController {
  final uri = "https://api.cloudinary.com/v1_1/dpnkkp6rl/upload";
  RxString imagePath = "".obs;
  var futureProfileUser = Rxn<Future<ProfileUser>>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController docController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final GlobalKey<FormState> formKeyCustomer = GlobalKey<FormState>();

  void selectImage() async {
    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if(selectedImage != null) {
      imagePath.value = selectedImage.path;
    }
    print(selectedImage!.path.toString());  
  }

  Future<void> updateProfile(ProfileUpdateRequest profile, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(profileEditInforAPI, profile);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
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

  Future<InforImageModel?> uploadImage() async {
    try {
      LoadingOptions.showLoading();
      final url = Uri.parse(uri);
      if(imagePath.isNotEmpty) {
        var request = http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = 'upload-image-project'
          ..files.add(await http.MultipartFile.fromPath('file', imagePath.value));
        var response = await request.send();
        if (response.statusCode == 200) {
          String responseData = await response.stream.bytesToString();
          Map<String, dynamic> jsonData = json.decode(responseData);
          InforImageModel imageModel = InforImageModel.fromJson(jsonData);
          print("name: ${imageModel.name} --- url: ${imageModel.url}");
          LoadingOptions.hideLoading();
          return imageModel;
        } else {
          LoadingOptions.hideLoading();
          return  null;
        }
      } else {
        LoadingOptions.hideLoading();
        return  null;
      }
    } catch (error) {
      LoadingOptions.hideLoading();
      print('Error uploading image: $error');
      return  null;
    }
  }

  Future<ProfileUser> getProfileUser() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(profileUserAPI);
      String responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> responseMap = json.decode(responseBody);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        return ProfileUser.fromJson(apiResponse.data);
      } else {
        throw Exception("fail to load data");
      }
  }

  Future<void> updateCustomerProfile(ProfileUpdateDocCustomerRequest profile, BuildContext context) async {
    try {
      LoadingOptions.showLoading();
      var response = await AuthenticatedHttpClient.postAuthenticated(updateCustomerInforDocAPI, profile);
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        LoadingOptions.hideLoading();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: apiResponse.message,
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