import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobquest/views/ui/auth/login.dart';
import 'package:jobquest/views/ui/auth/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/custom_outline_btn.dart';
import '../../../common/exports.dart';
import '../../../common/height_spacer.dart';


class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kLightBlue.value),
        child: Column(
          children: [
            Image.asset("assets/images/page3.png"),
            const HeightSpacer(size: 20),
            Column(
              children: [
                ReusableText(text: "Welcome to JobQuest", style: appstyle(30, Color(kLight.value), FontWeight.w500)),
                const HeightSpacer(size: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                      "We help you find your dream job according to your skillset, location, and preference to build your career",
                      textAlign: TextAlign.center,
                      style: appstyle(14, Color(kLight.value), FontWeight.normal)
                  ),
                ),
                const HeightSpacer(size: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomOutlineBtn(
                      onPressed: () async {
                        final SharedPreferences pref = await SharedPreferences.getInstance();
                        await pref.setBool("entrypoint", true);
                        Get.to(() => const LoginPage());
                      },
                      width: width * 0.4,
                      height: height * 0.06,
                      text: "Login",
                      color: Color(kLight.value),
                    ),
                    CustomOutlineBtn(
                      onPressed: () {
                        Get.to(() => const RegistrationPage());
                      },
                      width: width * 0.4,
                      height: height * 0.06,
                      text: "SignUp",
                      color: Color(kLight.value),
                      color2: Color(kLight.value),
                      textColor: Color(kLightBlue.value),
                    ),
                  ],
                ),
                const HeightSpacer(size: 30),
                ReusableText(text: "Continue as guest", style: appstyle(16, Color(kLight.value), FontWeight.w400))
              ],
            )
          ],
        ),
      ),
    );
  }
}