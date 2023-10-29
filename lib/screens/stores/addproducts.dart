import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/formborder.dart';
import 'package:offerapp/common/testStyle.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Addproducts extends StatefulWidget {
  String? storeid;
  Addproducts({Key? key, this.storeid}) : super(key: key);

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  String? id, email, name, phone;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('uid');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    name = prefs.getString('name');

    print(name);
    print(email);
  }

  String? _category;
  TextEditingController productIdController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productpriceController = TextEditingController();
  TextEditingController productOfferController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  final _productKey = GlobalKey<FormState>();

  // daclare these variables inthe extendedstate class
  var imageurl;
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image;

  var uuid = Uuid();
  var _pid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    _pid = uuid.v1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Text("Add Products"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _productKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: "Add New Product",
                    txtColor: Colors.black87,
                    textSize: 18,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: productIdController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a Valid ID";
                      }
                    },
                    style: textStyleblk,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: secondaryColor),
                        hintStyle: textStyleblk,
                        enabledBorder: borderEnabledBorderblck,
                        focusedBorder: borderfocusedBorderblack,
                        hintText: "Product ID"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: productNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a Valid Product Name";
                      }
                    },
                    style: textStyleblk,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: secondaryColor),
                        hintStyle: textStyleblk,
                        enabledBorder: borderEnabledBorderblck,
                        focusedBorder: borderfocusedBorderblack,
                        hintText: "Product Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: productDescriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a Valid description";
                      }
                    },
                    style: textStyleblk,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: secondaryColor),
                        hintStyle: textStyleblk,
                        enabledBorder: borderEnabledBorderblck,
                        focusedBorder: borderfocusedBorderblack,
                        hintText: "Product Description"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: productpriceController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a Valid Price";
                      }
                    },
                    style: textStyleblk,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: secondaryColor),
                        hintStyle: textStyleblk,
                        enabledBorder: borderEnabledBorderblck,
                        focusedBorder: borderfocusedBorderblack,
                        hintText: "Unit Price"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: productOfferController,
                    style: textStyleblk,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: secondaryColor),
                        hintStyle: textStyleblk,
                        enabledBorder: borderEnabledBorderblck,
                        focusedBorder: borderfocusedBorderblack,
                        hintText: "Product Offer (optional)"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('category')
                          .where('status', isEqualTo: 1)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox.shrink();
                        }

                        if (snapshot.hasData &&
                            snapshot.data!.docs.length == 0) {
                          return SizedBox.shrink();
                        }
                        if (snapshot.hasData &&
                            snapshot.data!.docs.length != 0) {
                          return Column(
                            children: [
                              DropdownButtonFormField<String>(
                                  value: _category,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: secondaryColor),
                                      hintStyle: textStyleblk,
                                      enabledBorder: borderEnabledBorderblck,
                                      focusedBorder: borderfocusedBorderblack,
                                      hintText: "Select Store"),
                                  onChanged: (value) => setState(() {
                                        _category = value;
                                        print(_category.toString());
                                      }),
                                  validator: (value) =>
                                      value == null ? 'field required' : null,
                                  items: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem<String>(
                                        value: document['title'],
                                        child: Text('${document['title']}'));
                                  }).toList()),
                            ],
                          );
                        }

                        return SizedBox.shrink();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: stockController,
                    style: textStyleblk,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: secondaryColor),
                        hintStyle: textStyleblk,
                        enabledBorder: borderEnabledBorderblck,
                        focusedBorder: borderfocusedBorderblack,
                        hintText: "Product Stock"),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(height: 20),
                  Center(
                    child: AppButton(
                      onTap: () {
                        if (_productKey.currentState!.validate()) {
                          print("helo");
                          String fileName = DateTime.now().toString();
                          var ref = FirebaseStorage.instance
                              .ref()
                              .child("products/$fileName");
                          UploadTask uploadTask =
                              ref.putFile(File(_image!.path));

                          uploadTask.then((res) async {
                            imageurl = (await ref.getDownloadURL()).toString();
                          }).then((value) {
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(_pid)
                                .set({
                              'pid': _pid,
                              'storeid': widget.storeid,
                              'productName': productNameController.text,
                              'productID': "PR${productIdController.text}",
                              'productDescription':
                                  productDescriptionController.text,
                              'unitPrice': productpriceController.text,
                              'offer': productOfferController.text,
                              'imgurl': imageurl,
                              'category': _category,
                              'soldby': name,
                              'sellerEmail': email,
                              'sellerContact': phone,
                              'status': 1,
                              'stock': stockController.text,
                              'createdAt': DateTime.now(),
                            }).then((value) {
                              Navigator.pop(context);
                            });
                          });
                        }
                      },
                      data: "Add Product",
                      height: 48,
                      width: 250,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
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
