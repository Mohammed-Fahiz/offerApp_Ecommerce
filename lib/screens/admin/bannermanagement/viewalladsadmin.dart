import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/admin/storemanagement/storeDetailsPage.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:uuid/uuid.dart';

class ViewAllAddsAdmin extends StatefulWidget {
  String? reqFrom;
  String? id;
  ViewAllAddsAdmin({Key? key, this.reqFrom = "admin", this.id})
      : super(key: key);

  @override
  State<ViewAllAddsAdmin> createState() => _ViewAllAddsAdminState();
}

class _ViewAllAddsAdminState extends State<ViewAllAddsAdmin> {
  var uuid = Uuid();
  var paymentid;

  String? amount;
  fetchData(String? id) async {
    final value =
        await FirebaseFirestore.instance.collection('wallet').doc(id).get();
    setState(() {
      amount = value['amount'];
    });
    print(amount);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentid = uuid.v1();
  }

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
              AppText(
                data: "All Ads",
                txtColor: Colors.black87,
                textSize: 18,
              ),
              SizedBox(
                height: 20,
              ),
              widget.reqFrom == 'admin'
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('ads')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            List<QueryDocumentSnapshot> stores =
                                snapshot.data!.docs;

                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: () {
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
                                          decoration: BoxDecoration(),
                                          height: 120,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Stack(
                                            children: [

                                              // stores[index]['status'] ==
                                              //     1 &&
                                              //     stores[index]['paymentstatus'] ==
                                              //         1    && stores[index]['delstatus'] ==
                                              //     0    ?              Align(
                                              //   alignment: Alignment(1.0, -1.5),
                                              //   child: IconButton(
                                              //       onPressed:
                                              //           () {
                                              //
                                              //         FirebaseFirestore.instance.collection('ads').doc(stores[index]['addid']).update({
                                              //           'delstatus':1
                                              //         });
                                              //       },
                                              //       icon:
                                              //       Icon(
                                              //
                                              //         Icons
                                              //             .dangerous,
                                              //         size: 35,
                                              //         color:
                                              //         Colors.red,
                                              //       )),
                                              // ):Align(
                                              //   alignment: Alignment(0.9, 0.8),
                                              //   child: Container(
                                              //     padding: EdgeInsets.all(10),
                                              //     decoration: BoxDecoration(
                                              //       color: Colors.red,
                                              //       borderRadius: BorderRadius.circular(10)
                                              //     ),
                                              //     child: AppText(data: "Deleted",txtColor: Colors.white,),
                                              //   ),
                                              // ),


                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                child: Container(

                                                    //color: Colors.teal,
                                                    width: 100,
                                                    height: 180,
                                                    child: Image.network(

                                                      snapshot.data!
                                                          .docs[index]['imgurl']
                                                          .toString(),
                                                      height: 150,
                                                      width: 250,
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              Align(
                                                alignment: Alignment(0.8, 0.0),
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    //color: Colors.grey,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            160,
                                                    height: 150,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppText(
                                                          data: stores[index]
                                                              ['title'],
                                                          txtColor:
                                                              Colors.black87,
                                                        ),
                                                        AppText(
                                                          data: stores[index]
                                                              ['description'],
                                                          txtColor:
                                                              Colors.black45,
                                                          textSize: 12,
                                                        ),
                                                        AppText(
                                                          data: stores[index]
                                                              ['createdby'],
                                                          txtColor:
                                                              Colors.blueGrey,
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
                                                                stores[index]['status'] ==
                                                                            1 &&
                                                                        stores[index]['paymentstatus'] ==
                                                                            1
                                                                    ? AppText(
                                                                        data:
                                                                            "Verified & Paid",
                                                                        textSize:
                                                                            16,
                                                                        fw: FontWeight
                                                                            .w700,
                                                                        txtColor:
                                                                            Colors.green,
                                                                      )
                                                                    : AppText(
                                                                        data:
                                                                            "Not Verified & \nPayment Pending",
                                                                        textSize:
                                                                            12,
                                                                        fw: FontWeight
                                                                            .w700,
                                                                        txtColor:
                                                                            Colors.red,
                                                                      ),
                                                                stores[index]['status'] ==
                                                                            1 &&
                                                                        stores[index]['paymentstatus'] ==
                                                                            0
                                                                    ? IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                              () {
                                                                            fetchData(stores[index]['storeid'].toString());
                                                                          });
                                                                      print(
                                                                          amount);

                                                                      var deduction =
                                                                          int.parse(stores[index]['totaldays'].toString()) * 10;
                                                                      print(
                                                                          deduction);
                                                                      print(
                                                                          amount);
                                                                      var newamount =
                                                                          int.parse(amount.toString()) - deduction;
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                          'wallet')
                                                                          .doc(stores[index][
                                                                      'storeid'])
                                                                          .update({
                                                                        'amount':
                                                                        newamount.toString()
                                                                      }).then((value) {
                                                                        FirebaseFirestore.instance.collection('ads').doc(stores[index]['addid']).update({
                                                                          'paymentstatus': 1
                                                                        }).then((value) {
                                                                          FirebaseFirestore.instance.collection('adminacc').doc(paymentid).set({
                                                                            'id': paymentid,
                                                                            'payfrom': stores[index]['storeid'],
                                                                            'amount':
                                                                            newamount.toString(),
                                                                            'type':"ads",
                                                                            'status':1,
                                                                            'createdat':DateTime.now()
                                                                          }).then((value) {

                                                                            setState(() {
                                                                              paymentid=uuid.v1();
                                                                            });
                                                                          });
                                                                        });
                                                                      });
                                                                    },
                                                                    icon:
                                                                    Icon(
                                                                      Icons
                                                                          .offline_pin,
                                                                      color:
                                                                      Colors.green,
                                                                    )):SizedBox.shrink()





                                                              ],
                                                            )),
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
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('ads')
                            .where('storeid', isEqualTo: widget.id)
                            .where('createdby', isEqualTo: 'store')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            List<QueryDocumentSnapshot> stores =
                                snapshot.data!.docs;

                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: () {
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
                                          decoration: BoxDecoration(),
                                          height: 120,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  //color: Colors.teal,
                                                  width: 80,
                                                  height: 80,
                                                  child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Color(0xffDC498D),
                                                    child: Center(
                                                      child: Text((index + 1)
                                                          .toString()),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment(0.2, 0.0),
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    //color: Colors.grey,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            160,
                                                    height: 150,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppText(
                                                          data: stores[index]
                                                              ['title'],
                                                          txtColor:
                                                              Colors.black87,
                                                        ),
                                                        Container(
                                                          width:MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                              160,
                                                          child: AppText(
                                                            data: stores[index]
                                                                ['description'],
                                                            txtColor:
                                                                Colors.black45,
                                                            textSize: 12,
                                                          ),
                                                        ),
                                                        AppText(
                                                          data: stores[index]
                                                              ['category'],
                                                          txtColor:
                                                              Colors.black87,
                                                          textSize: 12,
                                                        ),

                                                        // Container(
                                                        //     height: 40,
                                                        //     width: MediaQuery.of(context).size.width - 160,
                                                        //     child: Row(
                                                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //       children: [
                                                        //         stores[index]['status']==1?      AppText(data: "Verified",textSize: 16,fw: FontWeight.w700,txtColor: Colors.green,):AppText(data: "Not Verified",textSize: 16,fw: FontWeight.w700,txtColor: Colors.red,),
                                                        //         stores[index]['status']==1?    IconButton(onPressed: (){}, icon: Icon(Icons.offline_pin,color: Colors.green,)):IconButton(onPressed: (){}, icon: Icon(Icons.dangerous,color: Colors.red,))
                                                        //       ],
                                                        //     )),
                                                      ],
                                                    )),
                                              ),
                                              Align(
                                                alignment: Alignment(0.9, 0.0),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      //color: primaryColor.withOpacity(0.5),
                                                      shape:
                                                          BoxShape.rectangle),
                                                  child: Center(
                                                      child: CircleAvatar(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('ads')
                                                            .doc(snapshot.data!
                                                                    .docs[index]
                                                                ['addid'])
                                                            .delete();
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                              )
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
        ),
      ),
    );
  }
}
