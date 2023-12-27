import 'package:app/features/screens/auth/login/login_screen.dart';
import 'package:app/features/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FadeInAnimationController extends GetxController {

  static FadeInAnimationController get find => Get.find();

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    bool result = await checkLoginStatus();
    if(result) {
      Get.off(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      bool result = await getDataToken(token, prefs);
      if (result) {
        return true;
      }
    } return false;
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



}



       

