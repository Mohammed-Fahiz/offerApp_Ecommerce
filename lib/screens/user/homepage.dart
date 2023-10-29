import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/testStyle.dart';
import 'package:offerapp/data/category.dart';
import 'package:offerapp/screens/admin/storemanagement/storeDetailsPage.dart';
import 'package:offerapp/screens/user/notification.dart';
import 'package:offerapp/screens/user/offerdetailspage.dart';
import 'package:offerapp/screens/user/offersbycategory.dart';
import 'package:offerapp/screens/user/storedetailspage.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/colors.dart';

class UserHomePage extends StatefulWidget {

   UserHomePage({Key? key,}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late PageController _pageController;
  int count=0;
  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];

  int activePage = 0;
  Timer? _timer;

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


  @override
  void initState() {
    getdata();

    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (activePage < 2) {
        activePage++;
      } else {
        activePage = 0;
      }

      _pageController.animateToPage(
        activePage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             SizedBox(
               height: 60,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width*0.75,
                     child: Row(
                       children: [
                         AppText(data: "Welcome",txtColor: Colors.black87,textSize: 18,),
                         SizedBox(width: 15,),
                         AppText(data: name??"Guest",txtColor: Colors.black87,textSize: 22,fw: FontWeight.w700,),
                       ],
                     ),
                   ),

                   InkWell(
                     onTap: (){
                       Navigator.push(
                         context,
                         PageRouteBuilder(
                             pageBuilder: (_, __, ___) => AllNotification(

                             ),
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
                       child: CircleAvatar(child: Icon(Icons.notification_important,color: secondaryColor,size: 28,)))
                 ],
               ),
             ),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('ads').snapshots(),
                  builder: (_,snapshot){

                  if(snapshot.hasData){
                   count= snapshot.data!.docs.length;
                    return  PageView.builder(
                        itemCount: snapshot.data!.docs.length,
                        pageSnapping: true,
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            activePage = page;
                          });
                        },
                        itemBuilder: (context, pagePosition) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => OfferDetailsPage(
                                     id: snapshot.data!.docs[pagePosition]['addid'],
                                    ),
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
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 200,
                              //color: Colors.red,
                              child: Stack(
                                children: [

                                  Align(
                                    alignment: Alignment(0.0,0.0),
                                    child: Card(
                                      elevation: 5.0,
                                      child: Container(
                                        //color: Colors.red,
                                          height: 150,
                                          width: MediaQuery.of(context).size.width,
                                          child: Stack(
                                            children: [
                                              Container(

                                                //color: Colors.teal,
                                                width: 130,
                                                height: 180,
                                                child: Image.network(snapshot.data!.docs[pagePosition]['imgurl'],fit: BoxFit.contain,),
                                              ),
                                              Align(
                                                alignment: Alignment(1.8, 0.0),
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    //color: Colors.grey,
                                                    width:
                                                    MediaQuery.of(context).size.width - 160,
                                                    height: 180,

                                                    child:
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        AppText(data: snapshot.data!.docs[pagePosition]['title'],txtColor: Colors.black87,)
                                                        ,AppText(data: snapshot.data!.docs[pagePosition]['title'],txtColor: Colors.black45,textSize: 12,)
                                                        ,AppText(data: snapshot.data!.docs[pagePosition]['category'],txtColor: Colors.black45,textSize: 12,)
                                                        ,




                                                      ],
                                                    )
                                                ),
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
                                  ),

                                ],
                              ),
                            ),
                          );
                        });

                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
         count>1?     Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: count,
                  axisDirection: Axis.horizontal,
                  effect: SlideEffect(
                      spacing: 8.0,
                      radius: 8.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1,
                      dotColor: Colors.grey,
                      activeDotColor: primaryColor),
                ),
              ):SizedBox.shrink(),
              SizedBox(
                height: 20,
              ),
              AppText(
                data: "Stores by Category",
                txtColor: Colors.black87,
                textSize: 18,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){

                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => OffersByCategory(keyword: category[index],),
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
                          child: Chip(
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.all(10),
                            labelStyle: TextStyle(color: Colors.white),
                            label: AppText(
                              data: category[index],
                              txtColor: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              AppText(
                data: "Currently Trending",
                txtColor: Colors.black87,
                textSize: 18,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 220,
                //color: Colors.red,
                child:
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('stores').where('promote',isEqualTo:1).where('status',isEqualTo:1).snapshots(),
                  builder: (_,snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text("Something went wrong"),);
                    }

                    if(snapshot.hasData){
                      var stores=snapshot.data;

                      return  ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            return Card(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => StoreDetailsPage(
                                          storeid: stores!.docs[index]['storeid'],
                                        ),
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
                                child: Container(
                                  color: primaryColor,
                                  height: 180,
                                  width: 150,
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        height: 150,
                                        width: 150,
                                        color: Colors.white,
                                        child: Image.network(stores!.docs[index]['storeImg']),
                                      ),
                                      Align(
                                          alignment: Alignment(0.0, 0.8),
                                          child: AppText(
                                            data: stores.docs[index]['storename'],
                                            txtColor: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )




              ),

              //recommendations
              SizedBox(
                height: 20,
              ),
              AppText(
                data: "Recommendations",
                txtColor: Colors.black87,
                textSize: 18,
              ),
              SizedBox(
                height: 10,
              ),
          Container(
              padding: EdgeInsets.all(20),
              height: 260,
              width: double.infinity,
              child:FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(id.toString()).get(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Something went wrong"),);
                  }

                  if (snapshot.hasData) {
                    final snap = snapshot.data!.data() as Map<String, dynamic>?;
                    List<Map<String, dynamic>> favList = List<Map<String, dynamic>>.from(snap?['fav'] ?? []);

                    // Debugging: Print the list of maps to the console
                    favList.forEach((map) => print(map));
                    print(favList);

                    return
                      ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: favList.length,
                          itemBuilder: (_, index) {
                            final doc = favList[index];
                            return Card(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => StoreDetailsPage(
                                          storeid: doc['storeid'],
                                        ),
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
                                child: Container(
                                  color: primaryColor,
                                  height: 180,
                                  width: 150,
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        height: 150,
                                        width: 150,
                                        color: Colors.white,
                                        child: Image.network(doc['storeimg']),
                                      ),
                                      Align(
                                          alignment: Alignment(0.0, 0.8),
                                          child: AppText(
                                            data: doc['storename'],
                                            txtColor: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )


          ),


              SizedBox(
                height: 20,
              ),
              // AppText(
              //   data: "Recently Viewed",
              //   txtColor: Colors.black87,
              //   textSize: 18,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 220,
              //   //color: Colors.red,
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: 5,
              //       itemBuilder: (_, index) {
              //         return Card(
              //           child: Container(
              //             color: primaryColor,
              //             height: 180,
              //             width: 150,
              //             child: Stack(
              //               children: [
              //                 Container(
              //                   padding: EdgeInsets.all(6),
              //                   height: 150,
              //                   width: 150,
              //                   color: Colors.white,
              //                   child: Image.asset('assets/images/img4.png'),
              //                 ),
              //                 Align(
              //                     alignment: Alignment(0.0, 0.8),
              //                     child: AppText(
              //                       data: "Image Mobiles",
              //                       txtColor: Colors.white,
              //                     )),
              //               ],
              //             ),
              //           ),
              //         );
              //       }),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<DocumentSnapshot>> getUniqueDocs() {
    return  FirebaseFirestore.instance.collection('fav').where('userid',isEqualTo:id).snapshots()
        .map((snapshot) => snapshot.docs)
        .map((docs) => docs.toSet().toList()); // use a set to remove duplicates and convert back to list
  }


}
