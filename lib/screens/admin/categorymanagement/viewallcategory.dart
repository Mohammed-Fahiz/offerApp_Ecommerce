import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/admin/storemanagement/storeDetailsPage.dart';
import 'package:offerapp/widgets/apptext.dart';

class ViewAllCategory extends StatefulWidget {
  const ViewAllCategory({Key? key}) : super(key: key);

  @override
  State<ViewAllCategory> createState() => _ViewAllCategoryState();
}

class _ViewAllCategoryState extends State<ViewAllCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("All Ads"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(data:"All Category",txtColor: Colors.black87,textSize: 18,),
              SizedBox(height: 20,),
              Container(
                  height: MediaQuery.of(context).size.height*0.75,
                  child:StreamBuilder<QuerySnapshot>(

                    stream: FirebaseFirestore.instance.collection('category').snapshots(),

                    builder: (_,snapshot){


                      if(snapshot.hasData){

                        List<QueryDocumentSnapshot> cat = snapshot.data!.docs;


                        return  ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: (){
                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //       pageBuilder: (_, __, ___) => StoreDetailsPageAdmin(
                                  //         storeid:stores[index]['name'],
                                  //       ),
                                  //       transitionDuration: Duration(milliseconds: 400),
                                  //       transitionsBuilder:
                                  //           (context, animation, anotherAnimation, child) {
                                  //         animation = CurvedAnimation(
                                  //             curve: Curves.easeIn, parent: animation);
                                  //         return Align(
                                  //             child: SlideTransition(
                                  //               position: Tween(
                                  //                   begin: Offset(1.0, 0.0),
                                  //                   end: Offset(0.0, 0.0))
                                  //                   .animate(animation),
                                  //               child: child,
                                  //             ));
                                  //       }),
                                  // );
                                },
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                      decoration: BoxDecoration(

                                      ),
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top:0,
                                            bottom: 0,

                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              //color: Colors.teal,
                                              width: 80,
                                              height: 80,
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Color(0xffDC498D),
                                                child: Center(
                                                  child: Text((index+1).toString()),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(0.3, 0.0),
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                //color: Colors.grey,
                                                width:
                                                MediaQuery.of(context).size.width - 160,
                                                height: 150,

                                                child:
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(data: cat[index]['title'],txtColor: Colors.black87,)
                                                    ,AppText(data: cat[index]['description'],txtColor: Colors.black45,textSize: 12,)

                                                    ,

                                                    Container(
                                                        height: 40,
                                                        width: MediaQuery.of(context).size.width - 160,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            cat[index]['status']==1?      AppText(data: "Active",textSize: 16,fw: FontWeight.w700,txtColor: Colors.green,):AppText(data: "Not Active",textSize: 16,fw: FontWeight.w700,txtColor: Colors.red,),
                                                            cat[index]['status']==1?    IconButton(onPressed: (){

                                                              FirebaseFirestore.instance.collection('category').doc(cat[index]['catid'].toString()).update({
                                                                'status':0
                                                              });
                                                            }, icon: Icon(Icons.delete_outline_rounded,color: Colors.red,)):IconButton(onPressed: (){

                                                              FirebaseFirestore.instance.collection('category').doc(cat[index]['catid'].toString()).update({
                                                                'status':1
                                                              });

                                                            }, icon: Icon(Icons.offline_pin,color: Colors.green,))
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
