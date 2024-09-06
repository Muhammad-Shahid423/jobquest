import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:jobquest/models/request/auth/login_model.dart';
import 'package:jobquest/models/response/auth/login_res_model.dart';
import 'package:jobquest/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> login(LoginModel model) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    
    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    var response = await client.post(
        url,
        headers: headers,
        body: jsonEncode(model)
    );

    debugPrint("Response: ${response.body}");

    if (response.statusCode == 200) {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;
      String profile = loginResponseModelFromJson(response.body).profile;

      await preferences.setString('token', token);
      await preferences.setString('userId', userId);
      await preferences.setString('profile', profile);
      await preferences.setBool('loggedIn', true);
      return true;
    } else {
      return false;
    }
  }
}
