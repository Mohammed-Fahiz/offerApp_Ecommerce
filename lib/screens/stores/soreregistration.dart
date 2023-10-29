import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/formborder.dart';
import 'package:offerapp/common/loginpage.dart';
import 'package:offerapp/common/testStyle.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';

class StoreRegistration extends StatefulWidget {
  bool? status;
  StoreRegistration({Key? key, this.status = false}) : super(key: key);

  @override
  State<StoreRegistration> createState() => _StoreRegistrationState();
}

class _StoreRegistrationState extends State<StoreRegistration> {
  // controllers

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
//category
  String? _category;
  List<String> category = [
    "HomeAppliances",
    "Food",
    "Hospital",
    "Medicine",
    "Apparals"
  ];
  //form key
  final _regKey = GlobalKey<FormState>();


// daclare these variables inthe extendedstate class

  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?

  bool _status = false;

  @override
  void initState() {
    _status = widget.status!;
    super.initState();
  }

  var imageurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _status == true
          ? AppBar(
              title: Text("Add Store"),
              backgroundColor: primaryColor,
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
      backgroundColor: _status != true ? primaryColor : Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25),
          height: double.infinity,
          width: double.infinity,
          child: Form(
              key: _regKey,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (_status == false)
                            ? AppText(
                                data: "Register your\nStore",
                                txtColor: Colors.white,
                                textSize: 26,
                              )
                            : AppText(
                                data: "Create New Store",
                                txtColor: Colors.black87,
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
                          style: _status == false
                              ? textStyle2
                              : TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: secondaryColor),
                              hintStyle: _status == false
                                  ? textStyle2
                                  : TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.normal),
                              enabledBorder: _status == false
                                  ? borderEnabledBorder
                                  : borderEnabledBorderblck,
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
                          style: _status == false
                              ? textStyle2
                              : TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: secondaryColor),
                              hintStyle: _status == false
                                  ? textStyle2
                                  : TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.normal),
                              enabledBorder: _status == false
                                  ? borderEnabledBorder
                                  : borderEnabledBorderblck,
                              focusedBorder: borderfocusedBorder,
                              hintText: "Store Name"),
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
                          style: _status == false
                              ? textStyle2
                              : TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: secondaryColor),
                              hintStyle: _status == false
                                  ? textStyle2
                                  : TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.normal),
                              enabledBorder: _status == false
                                  ? borderEnabledBorder
                                  : borderEnabledBorderblck,
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
                          style: _status == false
                              ? textStyle2
                              : TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal),
                          obscureText: true,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: secondaryColor),
                              hintStyle: _status == false
                                  ? textStyle2
                                  : TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.normal),
                              enabledBorder: _status == false
                                  ? borderEnabledBorder
                                  : borderEnabledBorderblck,
                              focusedBorder: borderfocusedBorder,
                              hintText: "Password"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: locationController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter a valid Location";
                            }
                          },
                          style: _status == false
                              ? textStyle2
                              : TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                              errorStyle: TextStyle(color: secondaryColor),
                              hintStyle: _status == false
                                  ? textStyle2
                                  : TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.normal),
                              enabledBorder: _status == false
                                  ? borderEnabledBorder
                                  : borderEnabledBorderblck,
                              focusedBorder: borderfocusedBorder,
                              hintText: "Location"),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(

                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('category').where('status',isEqualTo:1)

                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox.shrink();
                              }

                              if (snapshot.hasData &&
                                  snapshot.data!.docs.length == 0) {
                                return SizedBox.shrink();
                              }
                              if(snapshot.hasData && snapshot.data!.docs.length!=0){
                                return Column(
                                  children: [
                                    DropdownButtonFormField<String>(
                                        value: _category,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                            errorStyle: TextStyle(color: secondaryColor),
                                            hintStyle: textStyleblk,
                                            enabledBorder: borderEnabledBorderblck,
                                            focusedBorder: borderfocusedBorderblack,
                                            hintText: "Select Store"),
                                        onChanged: (value) => setState(() {
                                          _category = value;
                                          print(_category.toString());
                                        }),
                                        validator: (value) => value == null
                                            ? 'field required'
                                            : null,
                                        items: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          return DropdownMenuItem<String>(
                                              value: document['title'],
                                              child: Text(
                                                  '${document['title']}'));
                                        }).toList()),
                                  ],
                                );
                              }

                              return SizedBox.shrink();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        _status == false
                            ? AppText(
                                data: "Add Iamage",
                                txtColor: Colors.white,
                              )
                            : AppText(
                                data: "Add Iamage",
                                txtColor: Colors.black87,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            onTap: () {
                              showimage();
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              color: Colors.transparent,
                              child: _image != null
                                  ? ClipRRect(
                                      child: Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                    ))
                                  : Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // CircleAvatar(
                                          //   radius: 45.0,
                                          //   backgroundImage: NetworkImage(widget.imgurl),
                                          //   backgroundColor: Colors.transparent,
                                          // ),

                                          Icon(
                                            Icons.upload_file,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Center(
                          child: AppButton(
                            onTap: () {
                              if (_regKey.currentState!.validate()) {
                                String fileName = DateTime.now().toString();
                                var ref = FirebaseStorage.instance
                                    .ref()
                                    .child("stores/$fileName");
                                UploadTask uploadTask =
                                    ref.putFile(File(_image!.path));

                                uploadTask.then((res) async {
                                  imageurl =
                                      (await ref.getDownloadURL()).toString();
                                }).then((value) {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: userNameController.text.trim(),
                                          password:
                                              passwordController.text.trim())
                                      .then((value) {
                                    var storeid = value.user!.uid;

                                    FirebaseFirestore.instance
                                        .collection('stores')
                                        .doc(value.user!.uid)
                                        .set({
                                      'storeid': value.user!.uid,
                                      'storename': nameController.text,
                                      'email': userNameController.text,
                                      'phone': phoneController.text,
                                      'category': _category,
                                      'status': 0,
                                      'promote': 0,
                                      'trending': 0,
                                      'storeImg': imageurl,
                                      'location': locationController.text,
                                      'createdAt': DateTime.now(),
                                    }).then((value) {
                                      FirebaseFirestore.instance
                                          .collection('storepayments')
                                          .doc(storeid)
                                          .set({
                                        'accId': storeid,
                                        'acname': nameController.text,
                                        'storeid': storeid,
                                        'balance': 0,
                                        'status': 1,
                                        'createdat': DateTime.now()
                                      }).then((value) {
                                        FirebaseFirestore.instance
                                            .collection('login')
                                            .doc(storeid)
                                            .set({
                                          'id':storeid,
                                          'usertype':'store',
                                          'createdat':DateTime.now(),
                                          'status':0

                                        }).then((value) {
                                          FirebaseFirestore.instance.collection('wallet').doc(storeid).set({


                                            'walletid':storeid,
                                            'amount':0,
                                            'status':1,
                                            'createdat':DateTime.now()
                                          }).then((value) {

                                            _status == false
                                                ? Navigator.pushAndRemoveUntil(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder:
                                                        (_, __, ___) =>
                                                        LoginPage(),
                                                    transitionDuration:
                                                    Duration(
                                                        milliseconds:
                                                        400),
                                                    transitionsBuilder:
                                                        (context,
                                                        animation,
                                                        anotherAnimation,
                                                        child) {
                                                      animation =
                                                          CurvedAnimation(
                                                              curve: Curves
                                                                  .easeIn,
                                                              parent:
                                                              animation);
                                                      return Align(
                                                          child:
                                                          SlideTransition(
                                                            position: Tween(
                                                                begin: Offset(
                                                                    1.0, 0.0),
                                                                end: Offset(
                                                                    0.0, 0.0))
                                                                .animate(
                                                                animation),
                                                            child: child,
                                                          ));
                                                    }),
                                                    (route) => false)
                                                : Navigator.pop(context);
                                          });
                                        });
                                      });
                                    });
                                  });
                                });
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
                        _status == false
                            ? Row(
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
                                            pageBuilder: (_, __, ___) =>
                                                LoginPage(),
                                            transitionDuration:
                                                Duration(milliseconds: 400),
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
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  // add these function at the bottom of the extended class
  _imagefromgallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  _imagefromcamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
  }

  showimage() {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromcamera();
                          },
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.purple,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromgallery();
                          },
                          icon: Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
