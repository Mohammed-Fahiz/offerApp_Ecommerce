import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/loginpage.dart';
import 'package:offerapp/screens/introscreens/introscreen_one.dart';
import 'package:offerapp/screens/introscreens/introscreen_three.dart';
import 'package:offerapp/screens/introscreens/introscreen_two.dart';
import 'package:offerapp/screens/user/userregistration.dart';
import 'package:offerapp/services/sharedpreferences.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();

  bool onlastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                setState(() {
                  onlastPage = (index == 2);
                });
              },
              controller: _pageController,
              children: [
                IntroScreenOne(),
                IntroScreenTwo(),
                IntroScreenThree(),
              ],
            ),
            Container(
              alignment: Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      SharePreferenceService().setOnBoarding();

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => UserRegistration(),
                            transitionDuration: Duration(milliseconds: 400),
                            transitionsBuilder:
                                (context, animation, anotherAnimation, child) {
                              animation = CurvedAnimation(
                                  curve: Curves.easeIn, parent: animation);
                              return Align(
                                  child: SlideTransition(
                                    position: Tween(
                                        begin: Offset(1.0, 0.0),
                                        end: Offset(0.0, 0.0))
                                        .animate(animation),
                                    child: child,
                                  ));
                            }),
                      );
                    },
                    child: AppText(
                      data: "Skip",
                      textSize: 18,
                      txtColor: Colors.black45,
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: SlideEffect(
                        spacing: 8.0,
                        radius: 8.0,
                        dotWidth: 20.0,
                        dotHeight: 12.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1,
                        dotColor: Colors.grey,
                        activeDotColor: secondaryColor),
                  ),
                  onlastPage
                      ? GestureDetector(
                          onTap: () {
                            SharePreferenceService().setOnBoarding();

                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => UserRegistration(),
                                  transitionDuration: Duration(milliseconds: 400),
                                  transitionsBuilder:
                                      (context, animation, anotherAnimation, child) {
                                    animation = CurvedAnimation(
                                        curve: Curves.easeIn, parent: animation);
                                    return Align(
                                        child: SlideTransition(
                                          position: Tween(
                                              begin: Offset(1.0, 0.0),
                                              end: Offset(0.0, 0.0))
                                              .animate(animation),
                                          child: child,
                                        ));
                                  }),
                            );
                          },
                          child: AppText(
                            data: "Done",
                            textSize: 18,
                            txtColor: secondaryColor,
                          ))
                      : GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                                duration: Duration(microseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: AppText(
                            data: "Next",
                            textSize: 18,
                            txtColor: Colors.black,
                          ))
                ],
              ),
            )
          ],
        ));
  }
}
