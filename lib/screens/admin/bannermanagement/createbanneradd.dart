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

import '../../../common/formborder.dart';

class CreateBannerAdd extends StatefulWidget {
  String?reqFrom;
  String?id;
  String?name;

   CreateBannerAdd({Key? key,this.reqFrom='admin',this.id,this.name}) : super(key: key);

  @override
  State<CreateBannerAdd> createState() => _CreateBannerAddState();
}

class _CreateBannerAddState extends State<CreateBannerAdd> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productId = TextEditingController();
  TextEditingController dayController = TextEditingController();

// daclare these variables inthe extendedstate class

  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?
  final _addkey = GlobalKey<FormState>();
  var imageurl;

  var uuid=Uuid();
  var _addid;

  String?_store;
  var _query;

  List<String> category = ["Offers", "Prebook"];
  String? _selectedCategory;





  @override
  initState(){
    _addid=uuid.v1();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(""
            "Create Add"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _addkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: "Create New Add",
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
                GestureDetector(
                  onTap: () {
                    showimage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black87
                      )
                    ),
                    height: 150,

                    //color: Colors.transparent,
                    child: _image != null
                        ? ClipRRect(
                            child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          ))
                        : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // CircleAvatar(
                                //   radius: 45.0,
                                //   backgroundImage: NetworkImage(widget.imgurl),
                                //   backgroundColor: Colors.transparent,
                                // ),

                                Icon(
                                  Icons.upload_file,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                  ),
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

                widget.reqFrom=='admin'? Container(

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
                ):
                SizedBox(height:20),



                TextFormField(
                  controller: dayController,
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
                      hintText: "No of Days"),
                ),
                SizedBox(
                  height: 20,
                ),
               widget.reqFrom=="admin"? Center(
                  child: AppButton(
                    onTap: () {
                      if (_addkey.currentState!.validate()) {
                        print("helo");
                        String fileName = DateTime.now().toString();
                        var ref =
                            FirebaseStorage.instance.ref().child("ads/$fileName");
                        UploadTask uploadTask = ref.putFile(File(_image!.path));

                        uploadTask.then((res) async {
                          imageurl = (await ref.getDownloadURL()).toString();
                        }).then((value) {
                          FirebaseFirestore.instance
                              .collection('ads')
                              .doc(_addid)
                              .set({
                            'addid': _addid,
                            'title': titleController.text,
                            'description': descriptionController.text,
                            'imgurl': imageurl,
                            'category': _selectedCategory,
                            'storeid':widget.reqFrom=='admin'?_store:widget.id,
                            'status': 1,
                            'createdby':widget.reqFrom,
                            'createdAt': DateTime.now(),
                            'paymentstatus':1,
                            'delstatus':0,
                            'totaldays':dayController.text
                          }).then((value) {
                            Navigator.pop(context);
                          });
                        });
                      }
                    },
                    data: "Create Add",
                    height: 48,
                    width: 250,
                  ),
                ):
               Center(
                 child: AppButton(
                   onTap: () {
                     if (_addkey.currentState!.validate()) {
                       print("helo");
                       String fileName = DateTime.now().toString();
                       var ref =
                       FirebaseStorage.instance.ref().child("ads/$fileName");
                       UploadTask uploadTask = ref.putFile(File(_image!.path));

                       uploadTask.then((res) async {
                         imageurl = (await ref.getDownloadURL()).toString();
                       }).then((value) {
                         FirebaseFirestore.instance
                             .collection('ads')
                             .doc(_addid)
                             .set({
                           'addid': _addid,
                           'title': titleController.text,
                           'description': descriptionController.text,
                           'imgurl': imageurl,
                           'category': _selectedCategory,
                           'storeid':widget.reqFrom=='admin'?_store:widget.id,
                           'status': 1,
                           'createdby':widget.reqFrom,
                           'createdAt': DateTime.now(),
                           'paymentstatus':0,
                           'delstatus':0,
                           'totaldays':dayController.text
                         }).then((value) {
                           Navigator.pop(context);
                         });
                       });
                     }
                   },
                   data: "Create Add",
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
  _imagefromgallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  _imagefromcamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
  }

  showimage() {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromcamera();
                          },
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.purple,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromgallery();
                          },
                          icon: Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
