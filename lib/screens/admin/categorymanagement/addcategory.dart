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

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final catkey = GlobalKey<FormState>();

// daclare these variables inthe extendedstate class

  var uuid = Uuid();
  var _catid;

  @override
  initState() {
    _catid = uuid.v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(""
            "Create Category"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: catkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: "Create New Category",
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
                Center(
                  child: AppButton(
                    onTap: () {
                      if (catkey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('category')
                            .doc(_catid)
                            .set({
                          'catid': _catid,
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'status': 1,
                          'createdAt': DateTime.now(),
                        }).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    data: "Create Category",
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
