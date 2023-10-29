import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/user/storedetailspage.dart';

import '../../widgets/apptext.dart';

class AllOrdersStores extends StatefulWidget {
  String?id;
  AllOrdersStores({Key? key,this.id}) : super(key: key);

  @override
  State<AllOrdersStores> createState() => _AllOrdersStoresState();
}

class _AllOrdersStoresState extends State<AllOrdersStores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: AppText(data: "Orders",txtColor: Colors.black,),
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
                data: "All Orders",
                txtColor: Colors.black87,
                textSize: 18,
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('orders').where('sellerid',isEqualTo: widget.id).snapshots(),
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

                                },
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                    //color: Colors.red,

                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        children: [

                                          Align(
                                            alignment: Alignment(0.0, 0.0),
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                color: Colors.white54,
                                                width:
                                                MediaQuery.of(context).size.width,
                                                height: 100,

                                                child:
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      child: Text((index+1).toString()),
                                                    ),
                                                    SizedBox(width: 25,),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        AppText(data:snapshot.data!.docs[index]['itemname'],txtColor: Colors.black87,)
                                                        ,AppText(data: snapshot.data!.docs[index]['itemid'],txtColor: Colors.black45,textSize: 12,)

                                                        ,



                                                      ],
                                                    ),
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
