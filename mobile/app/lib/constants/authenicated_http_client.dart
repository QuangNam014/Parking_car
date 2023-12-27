import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticatedHttpClient {

  static Future<http.Response> getAuthenticated(String url) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token') ?? '';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": "Bearer $token",
      },
    );
    return response;
  }

  static Future<http.Response> postAuthenticated(String url, dynamic data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token') ?? '';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data.toJson())
    );
    return response;
  }
}