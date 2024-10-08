import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobquest/controllers/exports.dart';
import 'package:jobquest/views/common/exports.dart';
import 'package:jobquest/views/ui/onboarding/widgets/page_one.dart';
import 'package:jobquest/views/ui/onboarding/widgets/page_three.dart';
import 'package:jobquest/views/ui/onboarding/widgets/page_two.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardNotifier>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              PageView(
                physics: provider.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) {
                  provider.isLastPage = value == 2;
                },
                children: const [
                  PageOne(),
                  PageTwo(),
                  PageThree(),
                ],
              ),
              Positioned(
                bottom: height * 0.12,
                left: 0,
                right: 0,
                child: provider.isLastPage
                    ? const SizedBox.shrink()
                    : Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      spacing: 10,
                      dotColor: Color(kLightGrey.value).withOpacity(0.5),
                      activeDotColor: Color(kLight.value),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: provider.isLastPage
                    ? const SizedBox.shrink()
                    : Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(2);
                          },
                          child: ReusableText(
                            text: "Skip",
                            style: appstyle(16, Color(kLight.value), FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                          },
                          child: ReusableText(
                            text: "Next",
                            style: appstyle(16, Color(kLight.value), FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}