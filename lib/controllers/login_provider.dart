import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobquest/constants/app_constants.dart';
import 'package:jobquest/models/request/auth/login_model.dart';
import 'package:jobquest/services/helpers/auth_helper.dart';
import 'package:jobquest/views/ui/auth/update_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/ui/mainscreen.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  // Entry Point
  bool? _entryPoint;
  bool get entryPoint => _entryPoint ?? false;
  // Logged In
  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;
  // Check First Time
  bool? _firstTime;
  bool get firstTime => _firstTime ?? false;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  set entryPoint(bool newState) {
    _entryPoint = newState;
    notifyListeners();
  }

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entryPoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }
  final loginFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  userLogin(LoginModel model) {
    print("Model: $model");
    AuthHelper.login(model).then((response) => {
      if (response && firstTime) {
        Get.off(() => const PersonalDetails())
      } else if (response && !firstTime) {
        Get.off(() => const MainScreen())
      } else if (!response) {
        Get.snackbar(
            "Sign In Failed",
            "Please check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        )
      }
    });
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
    _firstTime = false;
  }
}
