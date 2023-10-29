import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/testStyle.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/formborder.dart';

class AddFeedBack extends StatefulWidget {
  const AddFeedBack({Key? key}) : super(key: key);

  @override
  State<AddFeedBack> createState() => _AddFeedBackState();
}

class _AddFeedBackState extends State<AddFeedBack> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final notifkey = GlobalKey<FormState>();

// daclare these variables inthe extendedstate class

  var uuid = Uuid();
  var _notid;
  List<String>category=["Store","Common"];
  String?_selectedCategory;
  String ?_store;
  String?_storename;
  String?_storeEmail;
  String?storePhone;
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
  initState() {
    _notid = uuid.v1();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(""
            "Create Feedback"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: notifkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: "Create New Feedback",
                  textSize: 18,
                  txtColor: Colors.black87,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a Valid Title";
                    }
                  },
                  style: textStyleblk,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: secondaryColor),
                      hintStyle: textStyleblk,
                      enabledBorder: borderEnabledBorderblck,
                      focusedBorder: borderfocusedBorderblack,
                      hintText: "Title"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a Valid Description";
                    }
                  },
                  style: textStyleblk,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: secondaryColor),
                      hintStyle: textStyleblk,
                      enabledBorder: borderEnabledBorderblck,
                      focusedBorder: borderfocusedBorderblack,
                      hintText: "Description"),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.black87),
                  //dropdownColor: primaryColor,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: secondaryColor),
                      hintStyle: textStyleblk,
                      enabledBorder: borderEnabledBorderblck,
                      focusedBorder: borderfocusedBorderblack,
                      hintText: "Select Category"),
                  items: category.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedCategory = newValue;
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                Container(

                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('stores')

                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox.shrink();
                      }

                      if (snapshot.hasData &&
                          snapshot.data!.docs.length == 0) {
                        return SizedBox.shrink();
                      }
                      if(snapshot.hasData && snapshot.data!.docs.length!=0){
                        return Column(
                          children: [
                            DropdownButtonFormField<String>(
                                value: _store,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: secondaryColor),
                                    hintStyle: textStyleblk,
                                    enabledBorder: borderEnabledBorderblck,
                                    focusedBorder: borderfocusedBorderblack,
                                    hintText: "Select Store"),
                                onChanged: (value) => setState(() {
                                  _store = value;
                                  print(_store.toString());
                                }),
                                validator: (value) => value == null
                                    ? 'field required'
                                    : null,
                                items: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {

                                  _storename=document['storeid'];
                                  _storeEmail=document['email'];
                                  _storename=document['storename'];
                                  return DropdownMenuItem<String>(


                                      value: document['storeid'],
                                      child: Text(
                                          '${document['storename']}'));
                                }).toList()),
                          ],
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: AppButton(
                    onTap: () {
                      if (notifkey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('feedbackstore')
                            .doc(_notid)
                            .set({
                          'fdid': _notid,
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'category':_selectedCategory,
                          'status': 1,
                          'storeid':_store,
                          'storename':_storename,
                          'storemail':_storeEmail,
                          'postedby':name,
                          'userphone':phone,
                          'userid':id,
                          'useremail':email,
                          'createdAt': DateTime.now(),
                          'reply':"",
                          'replystatus':0
                        }).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    data: "Submit",
                    height: 48,
                    width: 250,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// add these function at the bottom of the extended class




}
