

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/map/mapexample.dart';
import 'package:offerapp/screens/map/mapscreen.dart';
import 'package:offerapp/screens/user/storedetailspage.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';

class OfferDetailsPage extends StatefulWidget {
  String?id;
   OfferDetailsPage({Key? key,this.id}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {

  late Map<dynamic, dynamic> data;
  Future<Map<dynamic, dynamic>> fetchData() async {
    DocumentSnapshot value = await FirebaseFirestore.instance
        .collection('ads')
        .doc(widget.id)
        .get();
    final data = value.data() as Map<String, dynamic>;
    return data;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: AppText(data: "Offer Details",txtColor: Colors.black,),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
          future: fetchData(),
          builder: (_,snapshot){

            if(snapshot.hasData){
              final _offer = snapshot.data as Map;
              print(_offer);
            return  SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      height: MediaQuery.of(context).size.height/2,
                      //color: Colors.red,
                      child: Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height-200,
                            child: Image.network(_offer['imgurl'].toString(),height: 150,width: 250,)),
                      ),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(child: AppText(data:_offer['title'],txtColor: Colors.black87,))
                            ,Container(
                             // color: Colors.red,
                                width: MediaQuery.of(context).size.width*0.85,

                                child: FittedBox(child: AppText(data: _offer['description'],txtColor: Colors.black45,textSize: 12,)))

                          ],  
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    // Row(
                    //
                    //   children: [
                    //     AppText(data: "\$ ${_offer['unitprice']}",txtColor: Colors.black87,fw: FontWeight.bold,textSize: 26,),
                    //     SizedBox(width: 25,),
                    //     Text("\$499",style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 20))
                    //     ,
                    //     SizedBox(width: 25,),
                    //     AppText(data: "You Save \$249",txtColor: secondaryColor,fw: FontWeight.bold,textSize: 16,),
                    //
                    //   ],
                    // )

                    // Card(
                    //   child: Container(
                    //     height: 150,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15)
                    //     ),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         AppText(data: "Nike Blazer Mid 77",txtColor: Colors.black87,)
                    //         ,AppText(data: "Women's Shoes",txtColor: Colors.black45,textSize: 12,)
                    //         ,AppText(data: "Sold by: Image Mobiles",txtColor: Colors.black45,textSize: 12,)
                    //       ],
                    //     ),
                    //
                    //   ),
                    // ),
                    // SizedBox(height: 20,),

                    Center(child: AppButton(data: "Visit Store",width: 250,height: 45,
                      onTap: (){

                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => StoreDetailsPage(
                                storeid: _offer['storeid'],
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
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>MapSample()));
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

        )
      ),
    );
  }
}
