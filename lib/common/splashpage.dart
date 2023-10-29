import 'package:flutter/material.dart';
import 'package:offerapp/common/loginpage.dart';
import 'package:offerapp/common/onboardingscreen.dart';
import 'package:offerapp/screens/admin/adminhomepage.dart';
import 'package:offerapp/screens/stores/storehomepage.dart';
import 'package:offerapp/screens/user/bottomnavigationPage.dart';
import 'package:offerapp/screens/user/homepage.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var token;
  var type;
  var onboard;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    type=prefs.getString('type');
    onboard=prefs.getString('times');
    print(onboard);
  }



  @override
  void initState() {
    getdata();
    navigateScreen();
    super.initState();
  }

  void navigateScreen() {
    var d = Duration(seconds: 2);
    // delayed 5 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      (token != null && token=='admin@gmail.com')
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AdminHomePage();
                },
              ),
              (route) => false,
            ):token!=null && type=='user'?Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BottomNavigationPage();
          },
        ),
            (route) => false,
      )
          :token!=null && type=='store'?Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StoreHomePage();
          },
        ),
            (route) => false,
      ): onboard==null?

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OnBoardingPage();
          },
        ),
            (route) => false,
      ):
      Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ),
              (route) => false,
            );
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            AppText(
              data: "OfferApp",
              textSize: 22,
              txtColor: Colors.white,
              fw: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
