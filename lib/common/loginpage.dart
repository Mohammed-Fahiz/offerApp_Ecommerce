import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/formborder.dart';
import 'package:offerapp/common/testStyle.dart';
import 'package:offerapp/screens/admin/adminhomepage.dart';
import 'package:offerapp/screens/stores/storehomepage.dart';
import 'package:offerapp/screens/user/bottomnavigationPage.dart';
import 'package:offerapp/screens/user/homepage.dart';
import 'package:offerapp/screens/user/userregistration.dart';
import 'package:offerapp/services/sharedpreferences.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers

  var type;
  bool? _show=true;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //form key
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        padding: EdgeInsets.all(25),
        child: Form(
            key: _loginKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        data: "Never miss an Offer",
                        txtColor: Colors.white,
                        textSize: 26,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: userNameController,
                        validator: (value) {
                          if (value != null || value!.isNotEmpty) {
                            final RegExp regex = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            if (!regex.hasMatch(value))
                              return 'Enter a valid email';
                            else
                              return null;
                          } else {
                            return 'Enter a valid email';
                          }
                        },
                        style: textStyle1,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: secondaryColor),
                            hintStyle: textStyle2,
                            enabledBorder: borderEnabledBorder,
                            focusedBorder: borderfocusedBorder,
                            hintText: "Email"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field Mandatory";
                          }
                          if (value.length < 5) {
                            return "Password should be greater than 5";
                          }
                        },
                        style: textStyle1,
                        obscureText: _show!,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){

                              if(_show==true){
                                setState(() {
                                  _show=false;
                                });
                              }else{
                                setState(() {
                                  _show=true;
                                });
                              }


                            },
                            icon: _show==true?Icon(Icons.visibility_off,color: Colors.grey,):Icon(Icons.visibility,color: Colors.white,),
                          ),
                            errorStyle: TextStyle(color: secondaryColor),
                            hintStyle: textStyle2,
                            enabledBorder: borderEnabledBorder,
                            focusedBorder: borderfocusedBorder,
                            hintText: "Password"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: AppButton(
                          onTap: () {
                            if (_loginKey.currentState!.validate()) {
                              if (userNameController.text.trim() ==
                                      "admin@gmail.com" &&
                                  passwordController.text.trim() ==
                                      "12345678") {
                                SharePreferenceService().setToken(
                                    userNameController.text.toString());
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            AdminHomePage(),
                                        transitionDuration:
                                            Duration(milliseconds: 400),
                                        transitionsBuilder: (context, animation,
                                            anotherAnimation, child) {
                                          animation = CurvedAnimation(
                                              curve: Curves.easeIn,
                                              parent: animation);
                                          return Align(
                                              child: SlideTransition(
                                            position: Tween(
                                                    begin: Offset(1.0, 0.0),
                                                    end: Offset(0.0, 0.0))
                                                .animate(animation),
                                            child: child,
                                          ));
                                        }),
                                    (route) => false);
                              } else {
                                {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: userNameController.text.trim(),
                                          password:
                                              passwordController.text.trim())
                                      .then((value) {
                                    FirebaseFirestore.instance
                                        .collection('login')
                                        .doc(value.user!.uid)
                                        .get()
                                        .then((value) {
                                      if (value.data()!['status'] == 1 &&
                                          value.data()!['usertype'] == "user") {
                                        type='user';
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(value.data()!['id'])
                                            .get()
                                            .then((value) {
                                          SharePreferenceService()
                                              .setToken(value.data()!['uid']);
                                          SharePreferenceService().setData(
                                            value.data()!['uid'],
                                            value.data()!['name'],
                                            value.data()!['phone'],
                                            value.data()!['email'],
                                            type
                                          );

                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      BottomNavigationPage(),
                                                  transitionDuration: Duration(
                                                      milliseconds: 400),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      anotherAnimation,
                                                      child) {
                                                    animation = CurvedAnimation(
                                                        curve: Curves.easeIn,
                                                        parent: animation);
                                                    return Align(
                                                        child: SlideTransition(
                                                      position: Tween(
                                                              begin: Offset(
                                                                  1.0, 0.0),
                                                              end: Offset(
                                                                  0.0, 0.0))
                                                          .animate(animation),
                                                      child: child,
                                                    ));
                                                  }),
                                              (route) => false);
                                        });
                                      }
                                      else if(value.data()!['status'] == 1 &&
                                          value.data()!['usertype'] == "store"){
                                        type='store';

                                        FirebaseFirestore.instance
                                            .collection('stores')
                                            .doc(value.data()!['id'])
                                            .get()
                                            .then((value) {
                                          SharePreferenceService()
                                              .setToken(value.data()!['uid']);
                                          SharePreferenceService().setData(
                                            value.data()!['storeid'],
                                            value.data()!['storename'],
                                            value.data()!['phone'],
                                            value.data()!['email'],
                                            type

                                          );

                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      StoreHomePage(id:  value.data()!['storeid'],),
                                                  transitionDuration: Duration(
                                                      milliseconds: 400),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      anotherAnimation,
                                                      child) {
                                                    animation = CurvedAnimation(
                                                        curve: Curves.easeIn,
                                                        parent: animation);
                                                    return Align(
                                                        child: SlideTransition(
                                                          position: Tween(
                                                              begin: Offset(
                                                                  1.0, 0.0),
                                                              end: Offset(
                                                                  0.0, 0.0))
                                                              .animate(animation),
                                                          child: child,
                                                        ));
                                                  }),
                                                  (route) => false);
                                        });
                                      }
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "You are not Authorized to Login")));
                                      }
                                    });
                                  });
                                }
                              }
                            }
                          },
                          data: "Login",
                          height: 48,
                          width: 250,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            data: "Don't have an account?",
                            txtColor: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        UserRegistration(),
                                    transitionDuration:
                                        Duration(milliseconds: 400),
                                    transitionsBuilder: (context, animation,
                                        anotherAnimation, child) {
                                      animation = CurvedAnimation(
                                          curve: Curves.easeIn,
                                          parent: animation);
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
                              data: "Sign up Now",
                              txtColor: secondaryColor,
                              textSize: 18,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
