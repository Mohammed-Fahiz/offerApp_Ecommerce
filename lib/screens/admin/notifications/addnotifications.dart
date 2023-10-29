import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/testStyle.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/formborder.dart';

class CreateNotification extends StatefulWidget {
  const CreateNotification({Key? key}) : super(key: key);

  @override
  State<CreateNotification> createState() => _CreateNotificationState();
}

class _CreateNotificationState extends State<CreateNotification> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final notifkey = GlobalKey<FormState>();

// daclare these variables inthe extendedstate class

  var uuid = Uuid();
  var _notid;
  List<String>category=["Store","Common"];
  String?_selectedCategory;

  @override
  initState() {
    _notid = uuid.v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(""
            "Create Notification"),
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
                  data: "Create New Notification",
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
                Center(
                  child: AppButton(
                    onTap: () {
                      if (notifkey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('notification')
                            .doc(_notid)
                            .set({
                          'notid': _notid,
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'category':_selectedCategory,
                          'status': 1,
                          'createdAt': DateTime.now(),
                        }).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    data: "Create Notification",
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
