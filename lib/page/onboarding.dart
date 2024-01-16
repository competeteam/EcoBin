import 'package:dinacom_2024/components/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  bool lastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarding_completed', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            color: const Color(0xFF222222),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: 5,
                      effect: const WormEffect(
                        spacing: 5,
                        dotColor: Color(0xFFD9D9D9),
                        activeDotColor: Color(0xFF75BC7B),
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        completeOnboarding();
                        print('Skip is clicked');
                        GoRouter.of(context).go('/garbage');
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: PageView(
                          controller: controller,
                          children: const [
                            OnboardingPage(
                              title: 'Discovery New Bins',
                              subTitle:
                                  'Explore your surroundings to locate available trash bins effortlessly',
                            ),
                            OnboardingPage(
                              title: 'Empower Green Living',
                              subTitle:
                                  'Be a part of the movement by providing new trash bins in your community, or reporting a full one',
                            ),
                            OnboardingPage(
                              title: 'Smart Classification, Cleaner World',
                              subTitle:
                                  'Utilize AI technology to identify trash types easily and effortlessly',
                            ),
                            OnboardingPage(
                              title: 'Knowledge at Your Fingertips',
                              subTitle:
                                  'Access insightful guides curated by professionals to stay informed about waste management',
                            ),
                            OnboardingPage(
                              title:
                                  'Transforming Waste Management for a Greener Future!',
                              logoPath:
                                  'assets/images/App_logo_and_text_with_white_backgroundremovebgpreview1.png',
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 62,
                      ),
                      MaterialButton(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          onPressed: () {
                            if (lastPage) {
                              completeOnboarding();
                              GoRouter.of(context).go('/garbage');
                            } else {
                              controller.nextPage(
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                  curve: Curves.easeInOut);
                              if (controller.page == 3) {
                                setState(() {
                                  lastPage = true;
                                });
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: Colors.white),
                          ),
                          child: Text(lastPage ? 'Start' : 'Continue',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15)))
                    ],
                  ),
                )
              ],
            )));
  }
}
