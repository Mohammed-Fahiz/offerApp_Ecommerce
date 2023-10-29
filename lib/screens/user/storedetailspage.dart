import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/map/mapexample.dart';
import 'package:offerapp/screens/user/offerdetailspage.dart';
import 'package:offerapp/screens/user/productdetails.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/apptext.dart';

class StoreDetailsPage extends StatefulWidget {
  String? storeid;
  String? promote;

  List<QuerySnapshot>? stores;
  StoreDetailsPage({Key? key, this.storeid, this.stores, this.promote})
      : super(key: key);

  @override
  State<StoreDetailsPage> createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  bool? _promoteStatus = false;
  String? _category;
  late Map<dynamic, dynamic> data;
  Future<Map<dynamic, dynamic>> fetchData() async {
    DocumentSnapshot value = await FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeid)
        .get();
    final data = value.data() as Map<String, dynamic>;
    return data;
  }

  String? id, email, name, phone;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('uid');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    name = prefs.getString('name');

    print(id);
    print(email);
  }

  @override
  void initState() {
    getdata();
    //print(fetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: AppText(
          data: "Store Details",
          txtColor: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: fetchData(),
            builder: (_, snapshop) {
              if (snapshop.hasData) {
                final _stores = snapshop.data as Map;
                _category = _stores['category'];
                List<String>? fav;

                print(_stores);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        //color: Colors.red,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      //fav!.add(id!);
                                      // print(fav);

                                      var fav = {
                                        'storeid': _stores['storeid'],
                                        'storename': _stores['storename'],
                                        'storecategory': _stores['category'],
                                        'storeimg': _stores['storeImg'],
                                        'userid': id,
                                        'createat': DateTime.now()
                                      };

// Retrieve the current value of the array field
                                      final docRef = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(id);
                                      docRef.get().then((doc) {
                                        if (doc.exists) {
                                          final myArray = doc.data()!['fav'];
print(myArray);
                                          // Modify the value of the array field


                                          final containsKeyValue = myArray.any((map) => map['storeid'] == _stores['storeid']);
                                          print(containsKeyValue );
                                          // Update the modified value of the array field
                                          if(!containsKeyValue || myArray.isEmpty){
                                            final newMapObject = fav;
                                            myArray.add(newMapObject);
                                            docRef.update({'fav': myArray}).then(
                                                    (value) {
                                                  print(
                                                      'Array field updated successfully!');
                                                }).catchError((error) {
                                              print(
                                                  'Error updating array field: $error');
                                            });
                                          }else{
                                            
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Alreday Added")));
                                          }
                                        } else {
                                          print('Document does not exist!');
                                        }
                                      }).catchError((error) {
                                        print('Error getting document: $error');
                                      });
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 33,
                                    )),
                              ],
                            ),
                            Center(
                                child: Container(
                                    height: MediaQuery.of(context).size.height -
                                        230,
                                    child: Image.network(
                                      _stores['storeImg'].toString(),
                                      height: 150,
                                      width: 250,
                                    ))),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data: _stores['storename'].toString(),
                                txtColor: Colors.black87,
                              ),
                              AppText(
                                data: _stores['location'].toString(),
                                txtColor: Colors.black45,
                                textSize: 12,
                              ),
                              AppText(
                                data: _stores['category'].toString(),
                                txtColor: Colors.black45,
                                textSize: 12,
                              )
                            ],
                          ),
                          _stores['status'] == 1
                              ? Image.asset(
                                  'assets/images/verfied.png',
                                  scale: 4,
                                )
                              : IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.offline_pin,
                                    color: Colors.green,
                                  ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 0),
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final call = Uri.parse(
                                          'tel:+91 ${_stores['phone']}');
                                      if (await canLaunchUrl(call)) {
                                        launchUrl(call);
                                      } else {
                                        throw 'Could not launch $call';
                                      }
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      openwhatsapp(_stores['phone'].toString());
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            shape: BoxShape.circle),
                                        child: FaIcon(
                                          FontAwesomeIcons.whatsapp,
                                          color: Colors.white,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final email = Uri(
                                        scheme: 'mailto',
                                        path: '${_stores['email']}',
                                        query:
                                            'subject=Hello&body=Check out our new offers',
                                      );
                                      if (await canLaunchUrl(email)) {
                                        launchUrl(email);
                                      } else {
                                        throw 'Could not launch $email';
                                      }
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: secondaryColor,
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: AppButton(
                        data: "Get Directions",
                        width: 250,
                        height: 45,
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => MapSample(),
                                transitionDuration: Duration(milliseconds: 400),
                                transitionsBuilder: (context, animation,
                                    anotherAnimation, child) {
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
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>MapSample()));
                        },
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      AppText(
                        data: "Latest Offers",
                        txtColor: Colors.black87,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          //color: Colors.red,
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('products')
                                .where('category', isEqualTo: _category)
                                .where('status', isEqualTo: 1)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("Something went wrong"),
                                );
                              }

                              if (snapshot.hasData) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (_, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    ProductDetailsPage(
                                                      id: snapshot.data!
                                                          .docs[index]['pid'],
                                                    ),
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
                                                            begin: Offset(
                                                                1.0, 0.0),
                                                            end: Offset(
                                                                0.0, 0.0))
                                                        .animate(animation),
                                                    child: child,
                                                  ));
                                                }),
                                          );
                                        },
                                        child: Card(
                                          elevation: 5.0,
                                          child: Container(
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(20),
                                                    //color: Colors.teal,
                                                    width: 120,
                                                    height: 180,
                                                    child: Image.network(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['imgurl']),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment(1.2, 0.0),
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        //color: Colors.grey,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            160,
                                                        height: 180,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AppText(
                                                              data: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  'productName'],
                                                              txtColor: Colors
                                                                  .black87,
                                                            ),
                                                            AppText(
                                                              data: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index][
                                                                  'productDescription'],
                                                              txtColor: Colors
                                                                  .black45,
                                                              textSize: 12,
                                                            ),
                                                            AppText(
                                                              data: snapshot
                                                                          .data!
                                                                          .docs[
                                                                      index]
                                                                  ['category'],
                                                              txtColor: Colors
                                                                  .black45,
                                                              textSize: 12,
                                                            ),
                                                            Container(
                                                                height: 40,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    160,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    AppText(
                                                                      data:
                                                                          'RS.${snapshot.data!.docs[index]['unitPrice']}/-',
                                                                      textSize:
                                                                          20,
                                                                      txtColor:
                                                                          Colors
                                                                              .black87,
                                                                    )
                                                                  ],
                                                                )),
                                                            AppText(
                                                              data:
                                                                  "Add to Cart",
                                                              textSize: 16,
                                                              fw: FontWeight
                                                                  .w700,
                                                              txtColor:
                                                                  secondaryColor,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  // Positioned(
                                                  //   top: 50,
                                                  //   left: 0,
                                                  //   bottom: 50,
                                                  //   child: Container(
                                                  //     height: 20,
                                                  //     width: 30,
                                                  //     decoration: BoxDecoration(
                                                  //       color: primaryColor.withOpacity(0.5),
                                                  //       shape: BoxShape.rectangle
                                                  //     ),
                                                  //     child: Center(child: Text((index+1).toString())),
                                                  //   ),
                                                  // )
                                                ],
                                              )),
                                        ),
                                      );
                                    });
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ))
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  openwhatsapp(String phone) async {
    var whatsapp = '+91' + phone;
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=This is from Traven, ";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}
