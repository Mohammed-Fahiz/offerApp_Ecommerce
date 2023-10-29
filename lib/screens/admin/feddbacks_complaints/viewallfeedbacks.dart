import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/admin/storemanagement/storeDetailsPage.dart';
import 'package:offerapp/widgets/apptext.dart';

import '../../../common/formborder.dart';
import '../../../common/testStyle.dart';

class ViewAllFeedbacks extends StatefulWidget {
  ViewAllFeedbacks({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewAllFeedbacks> createState() => _ViewAllFeedbacksState();
}

class _ViewAllFeedbacksState extends State<ViewAllFeedbacks> {
  
  TextEditingController replyController=TextEditingController();
  final key=GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    replyController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("All Feedbacks"),
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
                data: "All Feedbacks",
                txtColor: Colors.black87,
                textSize: 18,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('feedbackstore')
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<QueryDocumentSnapshot> feed = snapshot.data!.docs;

                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: 200,
                                  //color: Colors.red,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment(0.0, 0.0),
                                        child: Card(
                                          elevation: 5.0,
                                          child: Container(
                                              //color: Colors.red,
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment(-0.9, 0.0),
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
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AppText(
                                                              data: feed[index]
                                                                  ['title'],
                                                              txtColor: Colors
                                                                  .black87,
                                                            ),
                                                            AppText(
                                                              data: feed[index]
                                                                  ['storename'],
                                                              txtColor: Colors
                                                                  .black45,
                                                              textSize: 12,
                                                            ),
                                                            AppText(
                                                              data: feed[index][
                                                                  'description'],
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
                                                                    feed[index]['replystatus'] ==
                                                                            1
                                                                        ? AppText(
                                                                            data:
                                                                                "Replied",
                                                                            textSize:
                                                                                16,
                                                                            fw: FontWeight.w700,
                                                                            txtColor:
                                                                                Colors.green,
                                                                          )
                                                                        : AppText(
                                                                            data:
                                                                                "Not Replied",
                                                                            textSize:
                                                                                16,
                                                                            fw: FontWeight.w700,
                                                                            txtColor:
                                                                                Colors.red,
                                                                          ),
                                                                    feed[index]['replystatus'] ==
                                                                            0
                                                                        ? IconButton(
                                                                            onPressed:
                                                                                () {
                                                                                  showDialog<void>(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: const Text('Send Reply'),
                                                                                        content: Container(
                                                                                          height: 100,
                                                                                          child: Form(
                                                                                            key: key,
                                                                                            child: Column(
                                                                                              children: [
                                                                                                TextFormField(
                                                                                                  controller: replyController,
                                                                                                  validator: (value) {
                                                                                                    if (value!.isEmpty) {
                                                                                                      return "Enter  Valid Days";
                                                                                                    }
                                                                                                  },
                                                                                                  style: textStyleblk,
                                                                                                  decoration: InputDecoration(
                                                                                                      errorStyle: TextStyle(color: secondaryColor),
                                                                                                      hintStyle: textStyleblk,
                                                                                                      enabledBorder: borderEnabledBorderblck,
                                                                                                      focusedBorder: borderfocusedBorderblack,
                                                                                                      hintText: "Reply Message"),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        actions: <Widget>[

                                                                                          TextButton(
                                                                                            style: TextButton.styleFrom(
                                                                                                textStyle: TextStyle(color: Colors.white),

                                                                                                backgroundColor: primaryColor
                                                                                            ),
                                                                                            child: const Text('Cancel'),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                          TextButton(
                                                                                            style: TextButton.styleFrom(
                                                                                                textStyle: TextStyle(color: Colors.white),

                                                                                                backgroundColor: primaryColor
                                                                                            ),
                                                                                            child: const Text('Send Reply'),
                                                                                            onPressed: () {
                                                                                            if(key.currentState!.validate()){
                                                                                              
                                                                                              FirebaseFirestore.instance.collection('feedbackstore').doc(feed[index]['fdid']).update({

                                                                                                'replystatus':1,
                                                                                                'reply':replyController.text
                                                                                              }).then((value) {

                                                                                                Navigator.pop(context);
                                                                                              });
                                                                                            }
                                                                                            },
                                                                                          ),

                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );

                                                                                },
                                                                            icon:
                                                                                Icon(
                                                                              Icons.message_sharp,
                                                                              color: Colors.green,
                                                                            ))
                                                                        : SizedBox.shrink()
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
                                      ),
                                      feed[index]['category'] == "Store"
                                          ? Align(
                                              alignment: Alignment(0.8, -0.9),
                                              child: Container(
                                                height: 30,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: Colors.purple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                    child: AppText(
                                                  data: "Store",
                                                  txtColor: Colors.white,
                                                )),
                                              ),
                                            )
                                          : SizedBox.shrink(),
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
