import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/user/offerdetailspage.dart';
import 'package:offerapp/screens/user/storedetailspage.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';

class OffersByCategory extends StatefulWidget {
  String? keyword;
  OffersByCategory({Key? key,  this.keyword}) : super(key: key);

  @override
  State<OffersByCategory> createState() => _OffersByCategoryState();
}

class _OffersByCategoryState extends State<OffersByCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          data: widget.keyword,
          txtColor: Colors.white,
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: "Offers in ${widget.keyword} Category",
                txtColor: Colors.black87,
                textSize: 18,
              ),
              SizedBox(
                height: 20,
              ),
             widget.keyword!=null? Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('stores').where('category',isEqualTo:widget.keyword).where('status',isEqualTo:1).snapshots(),
                  builder: (_,snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text("Something went wrong"),);
                    }

                    if(snapshot.hasData){

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => StoreDetailsPage(
                                        storeid: snapshot.data!.docs[index]['storeid'],
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
                              child: Card(
                                elevation: 5.0,
                                child: Container(
                                  //color: Colors.red,
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          //color: Colors.teal,
                                          width: 120,
                                          height: 180,
                                          child: Image.network(
                                          snapshot.data!.docs[index]['storeImg'].toString(),
                                            height: 150,
                                            width: 250,
                                          )
                                        ),
                                        Align(
                                          alignment: Alignment(1.2, 0.0),
                                          child: Container(
                                              padding: EdgeInsets.all(10),
                                              //color: Colors.grey,
                                              width:
                                              MediaQuery.of(context).size.width - 160,
                                              height: 180,

                                              child:
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppText(data:snapshot.data!.docs[index]['storename'],txtColor: Colors.black87,)
                                                  ,AppText(data: snapshot.data!.docs[index]['category'],txtColor: Colors.black45,textSize: 12,)
                                                  ,AppText(data: snapshot.data!.docs[index]['location'],txtColor: Colors.black45,textSize: 12,)
                                                  ,

                                                  Container(
                                                      height: 40,
                                                      width: MediaQuery.of(context).size.width - 160,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          AppText(data: "\$250",txtColor: Colors.black87,fw: FontWeight.bold,),
                                                          IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red,))
                                                        ],
                                                      )),
                                                  AppText(data: "View Details",textSize: 16,fw: FontWeight.w700,txtColor: secondaryColor,)

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
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ):
             Container(
                 height: MediaQuery.of(context).size.height * 0.75,
                 child: StreamBuilder<QuerySnapshot>(
                   stream: FirebaseFirestore.instance.collection('stores').where('status',isEqualTo:1).snapshots(),
                   builder: (_,snapshot){
                     if(snapshot.hasError){
                       return Center(child: Text("Something went wrong"),);
                     }

                     if(snapshot.hasData){

                       return ListView.builder(
                           itemCount: snapshot.data!.docs.length,
                           itemBuilder: (_, index) {
                             return InkWell(
                               onTap: (){
                                 Navigator.push(
                                   context,
                                   PageRouteBuilder(
                                       pageBuilder: (_, __, ___) => StoreDetailsPage(
                                         storeid: snapshot.data!.docs[index]['storeid'],
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
                               child: Card(
                                 elevation: 5.0,
                                 child: Container(
                                   //color: Colors.red,
                                     height: 150,
                                     width: MediaQuery.of(context).size.width,
                                     child: Stack(
                                       children: [
                                         Container(
                                             padding: EdgeInsets.all(20),
                                             //color: Colors.teal,
                                             width: 120,
                                             height: 180,
                                             child: Image.network(
                                               snapshot.data!.docs[index]['storeImg'].toString(),
                                               height: 150,
                                               width: 250,
                                             )
                                         ),
                                         Align(
                                           alignment: Alignment(1.2, 0.0),
                                           child: Container(
                                               padding: EdgeInsets.all(10),
                                               //color: Colors.grey,
                                               width:
                                               MediaQuery.of(context).size.width - 160,
                                               height: 180,

                                               child:
                                               Column(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   AppText(data:snapshot.data!.docs[index]['storename'],txtColor: Colors.black87,)
                                                   ,AppText(data: snapshot.data!.docs[index]['category'],txtColor: Colors.black45,textSize: 12,)
                                                   ,AppText(data: snapshot.data!.docs[index]['location'],txtColor: Colors.black45,textSize: 12,)
                                                   ,

                                                   Container(
                                                       height: 40,
                                                       width: MediaQuery.of(context).size.width - 160,
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           AppText(data: "\$250",txtColor: Colors.black87,fw: FontWeight.bold,),
                                                           IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red,))
                                                         ],
                                                       )),
                                                   AppText(data: "View Details",textSize: 16,fw: FontWeight.w700,txtColor: secondaryColor,)

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
                             );
                           });
                     }
                     return Center(
                       child: CircularProgressIndicator(),
                     );
                   },
                 )
             )

            ],
          ),
        ),
      ),
    );
  }
}
