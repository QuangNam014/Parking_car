// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:app/constants/url_api.dart';
import 'package:app/features/models/api_response.dart';
import 'package:app/features/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';

class LoginController extends GetxController {


  RxBool showPassword = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onToggleShowPassword() => showPassword.value = !showPassword.value;

  Future<void> login(String email, String pass, BuildContext context) async {

    try {
      LoadingOptions.showLoading();
      var response = await http.post(
        Uri.parse(loginAPI),
        headers: {"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode({
          "email": email,
          "password": pass,
        }),
      );
      print(" res: $response");
      Map<String, dynamic> responseMap = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(responseMap);
      if(apiResponse.status == 200) {
        String accessToken = apiResponse.data['token'];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', accessToken);

        bool result = await getDataToken(accessToken, prefs);
        if(result) {
          getPosition().then((value) async {
            double longitude = value.longitude;
            double latitude = value.latitude;
            await prefs.setDouble('latitude', latitude);
            await prefs.setDouble('longitude', longitude);  
            LoadingOptions.hideLoading();
            Get.offAll(() => const HomeScreen());
          }).catchError((error) {
            LoadingOptions.hideLoading();
            print("error position: $error");
          });
        }
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
      print("error: $e");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Switch to a different IP or a different WiFi',
      );
    }
  }
  
  Future<bool> getDataToken(String token, SharedPreferences prefs) async {
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    if (decodedToken.isNotEmpty) {
      String email = decodedToken['sub'];
      int expirationTime = decodedToken['exp'];
      DateTime expirationDateTime = DateTime.fromMillisecondsSinceEpoch(expirationTime * 1000) ;
      if(!checkTokenExp(expirationTime)) {
        await prefs.setString('email', email);
        await prefs.setInt('expirationTime', expirationTime);
        print("email: $email");
        print("Token Expiration Time: $expirationDateTime");
        return true;
      }
      print("Token Expiration Time: Đã hết hạn");
      return false;
    } else {
      print("Failed to decode JWT");
      return false;
    }
  }


  bool checkTokenExp(int expireTime) {
    bool checkTime = DateTime.now().millisecondsSinceEpoch > expireTime * 1000;
    return checkTime;
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


}