// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:app/constants/authenicated_http_client.dart';
import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/models/customer/product/get_list_product_available_model.dart';
import 'package:app/features/models/customer/product/product_detail_customer_model.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomerMapController extends GetxController {

  var listData = RxList<GetListProductAvaiLableModel>().obs;

  RxDouble lat = 10.78729681084099.obs;
  RxDouble long = 106.6665855667214.obs;

  late double latSearch;
  late double longSearch;


  Future<Uint8List> getImageFromMarker(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<Uint8List?> loadingNetWorkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((inforImage, _) => completer.complete(inforImage))
    );
    final imageInfor = await completer.future;
    final byteData = await imageInfor.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Position> getPosition() async {
    LocationPermission? permission;

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<List<GetListProductAvaiLableModel>> getListProductAvailable() async {
    var response = await AuthenticatedHttpClient.getAuthenticated(getListParkingDetailAvailableAPI);
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      listData.value.clear();
      for (var item in apiResponse.data) {
        listData.value.add(GetListProductAvaiLableModel.fromJson(item));
      }
      return listData.value;
    } else {
      return listData.value;
    }
  }

  Future<ProductDetailModel> getDetailProduct(int id) async {
    String url = domain + "api/v1/supplier/get-detail-product/${id}";
    var response = await AuthenticatedHttpClient.getAuthenticated(url);
    String responseBody = utf8.decode(response.bodyBytes);
    Map<String, dynamic> responseMap = json.decode(responseBody);
    ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
    if(apiResponse.status == 200) {
      return ProductDetailModel.fromJson(apiResponse.data);
    } else {
      throw Exception("fail to load data");
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

  Future<Uint8List> getImageNetWorkToMarker(String path) async {  
    Uint8List? image = await loadingNetWorkImage(path);
    final ui.Codec imageCodecMarker = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 120,
        targetWidth: 120);
    final ui.FrameInfo frameInfo = await imageCodecMarker.getNextFrame();
    final ByteData? byteData =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageMarkerResized = byteData!.buffer.asUint8List();
    return imageMarkerResized;
  }

  void loadData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      lat.value = prefs.getDouble('latitude') ?? 0; 
      long.value = prefs.getDouble('longitude') ?? 0; 
  }
}