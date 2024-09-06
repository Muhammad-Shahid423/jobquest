import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controllers/exports.dart';
import '../../../models/request/auth/login_model.dart';
import '../../common/app_bar.dart';
import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/exports.dart';
import '../../common/height_spacer.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, value, child) {
        value.getPrefs();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "Login ",
              child: value.entryPoint && value.loggedIn ? GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(CupertinoIcons.arrow_left),
              ) : const SizedBox.shrink(),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: value.loginFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const HeightSpacer(size: 50),
                  ReusableText(
                    text: 'Welcome Back',
                    style: appstyle(
                      30,
                      Color(kDark.value),
                      FontWeight.w600,
                    ),
                  ),
                  ReusableText(
                    text: 'Fill in the details to login to your account',
                    style: appstyle(
                      16,
                      Color(kDarkGrey.value),
                      FontWeight.w600,
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  CustomTextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    validator: (email) {
                      if (email!.isEmpty ||
                          !email.contains("@") ||
                          !email.contains(".")) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: password,
                    obscureText: value.obscureText,
                    keyboardType: TextInputType.text,
                    hintText: "Password",
                    validator: (password) {
                      if (password!.isEmpty || password.length < 8) {
                        return "Please enter a valid password";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        value.obscureText = !value.obscureText;
                      },
                      child: Icon(
                        value.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(kDark.value),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const RegistrationPage());
                      },
                      child: ReusableText(
                        text: "Register",
                        style: appstyle(14, Color(kDark.value), FontWeight.w500),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  CustomButton(
                    onTap: () {
                      if (value.validateAndSave()) {
                        value.userLogin(
                          LoginModel(
                            email: email.text.trim(),
                            password: password.text.trim(),
                          ),
                        );
                      } else {
                        Get.snackbar(
                          "Sign In Failed",
                          "Please check your credentials",
                          colorText: Color(kLight.value),
                          backgroundColor: Colors.red,
                          icon: const Icon(Icons.add_alert),
                        );
                      }
                    },
                    text: "Login",
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}