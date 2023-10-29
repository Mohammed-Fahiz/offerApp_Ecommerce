import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/admin/storemanagement/storeDetailsPage.dart';
import 'package:offerapp/widgets/apptext.dart';

class ViewAllNotifications extends StatefulWidget {
  const ViewAllNotifications({Key? key}) : super(key: key);

  @override
  State<ViewAllNotifications> createState() => _ViewAllNotificationsState();
}

class _ViewAllNotificationsState extends State<ViewAllNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("All Notification"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(data:"All Notifications",txtColor: Colors.black87,textSize: 18,),
              SizedBox(height: 20,),
              Container(
                  height: MediaQuery.of(context).size.height*0.75,
                  child:StreamBuilder<QuerySnapshot>(

                    stream: FirebaseFirestore.instance.collection('notification').snapshots(),

                    builder: (_,snapshot){


                      if(snapshot.hasData){

                        List<QueryDocumentSnapshot> notification = snapshot.data!.docs;


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


                                                child:
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(data: notification[index]['title'],txtColor: Colors.black87,)
                                                    ,AppText(data: notification[index]['description'],txtColor: Colors.black45,textSize: 12,)
                                                    ,AppText(data: notification[index]['category'],txtColor: Colors.black87,textSize: 16,fw: FontWeight.w700,)

                                                    ,

                                                    Container(
                                                        height: 40,
                                                        width: MediaQuery.of(context).size.width - 160,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            notification[index]['status']==1?      AppText(data: "Active",textSize: 16,fw: FontWeight.w700,txtColor: Colors.green,):AppText(data: "Expired",textSize: 16,fw: FontWeight.w700,txtColor: Colors.red,),
                                                            notification[index]['status']==1?    IconButton(onPressed: (){
                                                              updateNotification(0, notification[index]['notid'].toString());
                                                            }, icon: Icon(Icons.delete_outline_outlined,color: Colors.red,)):IconButton(onPressed: (){

                                                            updateNotification(1, notification[index]['notid'].toString());

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


  updateNotification(int? status,String? id){

    FirebaseFirestore.instance.collection('notification').doc(id.toString()).update(
        {
          'status':status,
        });


  }
}

