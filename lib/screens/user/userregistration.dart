import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/formborder.dart';
import 'package:offerapp/common/loginpage.dart';
import 'package:offerapp/common/testStyle.dart';
import 'package:offerapp/screens/stores/soreregistration.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  // controllers

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  //form key
  final _regKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        padding: EdgeInsets.all(25),
        height: double.infinity,
        width: double.infinity,
        child: Form(
            key: _regKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          data: "Unlock the Offers\nNear You",
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
                              hintText: "User Name"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter a valid name";
                            }
                          },
                          style: textStyle1,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: secondaryColor),
                              hintStyle: textStyle2,
                              enabledBorder: borderEnabledBorder,
                              focusedBorder: borderfocusedBorder,
                              hintText: "Full Name"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty && value.length < 10) {
                              return "Enter a valid Mobile Number";
                            }
                          },
                          style: textStyle1,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: secondaryColor),
                              hintStyle: textStyle2,
                              enabledBorder: borderEnabledBorder,
                              focusedBorder: borderfocusedBorder,
                              hintText: "Mobile"),
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
                          obscureText: true,
                          decoration: InputDecoration(
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
                              if (_regKey.currentState!.validate()) {
                                userRegistration();
                              }
                            },
                            data: "Register",
                            height: 48,
                            width: 250,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              data: "Already have an account?",
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
                                      pageBuilder: (_, __, ___) => LoginPage(),
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
                                data: "Login Now",
                                txtColor: secondaryColor,
                                textSize: 18,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              data: "Register as Store?",
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
                                          StoreRegistration(),
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
                                data: "Sign Up",
                                txtColor: secondaryColor,
                                textSize: 18,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  userRegistration() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userNameController.text.trim(),
            password: passwordController.text.trim())
        .then((value) {
      var id = value.user!.uid;
      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
        'uid': value.user!.uid,
        'name': nameController.text,
        'email': userNameController.text,
        'created_at': DateTime.now(),
        'phone': phoneController.text,
        'status': 1,
        'wallet': 0,
        'shippingaddress': null,
        'updateStatus': 0,
        'fav': {}
      }).then((value) {
        FirebaseFirestore.instance.collection('cart').doc(id).set({
          'cartid': id,
          'item': null,
          'status': 1,
          'created_at': DateTime.now()
        }).then((value) {
          FirebaseFirestore.instance.collection('login').doc(id).set({
            'id': id,
            'usertype': "user",
            'createdat': DateTime.now(),
            'status': 1,
          }).then((value) => Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginPage(),
                    transitionDuration: Duration(milliseconds: 400),
                    transitionsBuilder:
                        (context, animation, anotherAnimation, child) {
                      animation = CurvedAnimation(
                          curve: Curves.easeIn, parent: animation);
                      return Align(
                          child: SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                        child: child,
                      ));
                    }),
              ));
        });
      });
    });
  }
}
