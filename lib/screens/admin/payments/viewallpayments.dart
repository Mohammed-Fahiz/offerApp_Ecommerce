import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/admin/storemanagement/storeDetailsPage.dart';
import 'package:offerapp/widgets/apptext.dart';

class ViewAllPayments extends StatefulWidget {

  ViewAllPayments({Key? key,}) : super(key: key);

  @override
  State<ViewAllPayments> createState() => _ViewAllPaymentsState();
}

class _ViewAllPaymentsState extends State<ViewAllPayments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("All Payments"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(data:"All Payemnts",txtColor: Colors.black87,textSize: 18,),
              SizedBox(height: 20,),
              Container(
                  height: MediaQuery.of(context).size.height*0.75,
                  child:StreamBuilder<QuerySnapshot>(

                    stream: FirebaseFirestore.instance.collection('adminacc').snapshots(),

                    builder: (_,snapshot){


                      if(snapshot.hasData){

                        List<QueryDocumentSnapshot> payment = snapshot.data!.docs;


                        return  ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: (){

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

                                                  Align(
                                                    alignment: Alignment(-0.9, 0.0),
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
                                                            AppText(data: payment[index]['amount'],txtColor: Colors.black87,)
                                                            ,AppText(data: payment[index]['payfrom'],txtColor: Colors.black45,textSize: 12,)
                                                            ,AppText(data: payment[index]['type'],txtColor: Colors.black45,textSize: 12,)
                                                            ,

                                                            Container(
                                                                height: 40,
                                                                width: MediaQuery.of(context).size.width - 160,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    payment[index]['status']==1?      AppText(data: "Verified",textSize: 16,fw: FontWeight.w700,txtColor: Colors.green,):AppText(data: "Not Verified",textSize: 16,fw: FontWeight.w700,txtColor: Colors.red,),
                                                                    payment[index]['status']==1?    IconButton(onPressed: (){}, icon: Icon(Icons.offline_pin,color: Colors.green,)):IconButton(onPressed: (){}, icon: Icon(Icons.dangerous,color: Colors.red,))
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
                                      payment[index]['type']=="ads"? Align(
                                        alignment: Alignment(0.8,-0.9),
                                        child: Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Center(child: AppText(data: "Store",txtColor: Colors.white,)),
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
