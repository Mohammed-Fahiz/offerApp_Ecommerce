import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/admin/storemanagement/storeDetailsPage.dart';
import 'package:offerapp/widgets/apptext.dart';

class ViewAllStoresAdmin extends StatefulWidget {
  String?promote;
  ViewAllStoresAdmin({Key? key,this.promote}) : super(key: key);

  @override
  State<ViewAllStoresAdmin> createState() => _ViewAllStoresAdminState();
}

class _ViewAllStoresAdminState extends State<ViewAllStoresAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("All Stores"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(data:"All Stores",txtColor: Colors.black87,textSize: 18,),
            SizedBox(height: 20,),
              Container(
                height: MediaQuery.of(context).size.height*0.75,
                child:StreamBuilder<QuerySnapshot>(

                  stream: FirebaseFirestore.instance.collection('stores').snapshots(),

                builder: (_,snapshot){


                  if(snapshot.hasData){

                    List<QueryDocumentSnapshot> stores = snapshot.data!.docs;


                    return  ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => StoreDetailsPageAdmin(
                                      promote: "promote",
                                      storeid:stores[index]['storeid'],
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
                                              padding: EdgeInsets.all(20),
                                              //color: Colors.teal,
                                              width: 120,
                                              height: 180,
                                              child: Image.network(stores[index]['storeImg']),
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
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppText(data: stores[index]['storename'],txtColor: Colors.black87,)
                                                      ,AppText(data: stores[index]['location'],txtColor: Colors.black45,textSize: 12,)
                                                      ,AppText(data: stores[index]['category'],txtColor: Colors.black45,textSize: 12,)
                                                      ,

                                                      Container(
                                                          height: 40,
                                                          width: MediaQuery.of(context).size.width - 160,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              stores[index]['status']==1?      AppText(data: "Verified",textSize: 16,fw: FontWeight.w700,txtColor: Colors.green,):AppText(data: "Not Verified",textSize: 16,fw: FontWeight.w700,txtColor: Colors.red,),
                                                              stores[index]['status']==1?    IconButton(onPressed: (){}, icon: Icon(Icons.offline_pin,color: Colors.green,)):IconButton(onPressed: (){}, icon: Icon(Icons.dangerous,color: Colors.red,))
                                                            ],
                                                          )),


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
                                stores[index]['promote']==1? Align(
                                  alignment: Alignment(0.8,-0.9),
                                  child: Container(
                                    height: 30,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(child: AppText(data: "Promoted",txtColor: Colors.white,)),
                                  ),
                                ):SizedBox.shrink(),
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

                )
              )

            ],
          ),
        ),
      ),
    );
  }
}
