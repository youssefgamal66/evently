import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/module/onboarding/pages/onBoarding_detaild.dart';
import 'package:evently/module/onboarding/widget/iteams_detaild.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int value = 0;

  void nextNav() {
    if (value < OnBoarding_detaild.iteams.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, RouteName.Login);
    }
  }


  void backNav() {
    if (value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.small_logo),
                    const SizedBox(width: 5),
                    Text(
                      "Evently",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: theme.primaryColor,
                        fontFamily: GoogleFonts.jockeyOne().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
             
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: OnBoarding_detaild.iteams.length,
                  onPageChanged: (index) {
                    setState(() {
                      value = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return IteamsDetaild(
                        items: OnBoarding_detaild.iteams[index]);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if(value>0)
                    InkWell(
                      onTap: backNav,
                      child: Image.asset(AppAssets.back),
                    ),
                    const Spacer(),
                    AnimatedSmoothIndicator(
                      activeIndex: value,
                      count: OnBoarding_detaild.iteams.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    const Spacer(),

                    InkWell(
                      onTap: nextNav,
                      child: Image.asset(AppAssets.next),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
