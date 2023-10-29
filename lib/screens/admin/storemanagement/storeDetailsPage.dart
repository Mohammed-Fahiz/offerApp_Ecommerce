import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/widgets/appbutton.dart';

import '../../../widgets/apptext.dart';

class StoreDetailsPageAdmin extends StatefulWidget {
  String? storeid;
  String?promote;

  List<QuerySnapshot>? stores;
  StoreDetailsPageAdmin({Key? key, this.storeid, this.stores,this.promote})
      : super(key: key);

  @override
  State<StoreDetailsPageAdmin> createState() => _StoreDetailsPageAdminState();
}

class _StoreDetailsPageAdminState extends State<StoreDetailsPageAdmin> {

  bool?_promoteStatus=false;
  late Map<dynamic, dynamic> data;
  Future<Map<dynamic, dynamic>> fetchData() async {
    DocumentSnapshot value = await FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeid)
        .get();
    final data = value.data() as Map<String, dynamic>;
    return data;
  }

  @override
  void initState() {
    
    //print(fetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: AppText(
          data: "Store Details",
          txtColor: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: fetchData(),
            builder: (_, snapshop) {


             if(snapshop.hasData){
               final _stores = snapshop.data as Map;
               print(_stores);
               return Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Container(
                     padding: EdgeInsets.only(top: 50),
                     height: MediaQuery.of(context).size.height / 2,
                     //color: Colors.red,
                     child: Center(
                         child: Container(
                             height: MediaQuery.of(context).size.height - 230,
                             child: Image.network(
                               _stores['storeImg'].toString(),
                               height: 150,
                               width: 250,
                             ))),
                   ),
                 (  widget.promote=="promote" && _stores['status']==1)?
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Container(
                        // color: Colors.red,
                         width: 200,
                         child: CheckboxListTile(
                           controlAffinity: ListTileControlAffinity.leading,
                           value: _promoteStatus, onChanged: (value){
                             if(_promoteStatus==false && _stores['promote']==0){
                               setState(() {
                                 _promoteStatus=true;

                               });

                               FirebaseFirestore.instance.collection('stores').doc(widget.storeid).update({
                                 'promote':1
                               }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Store Promoted"))));
                             }
                             else{
                               setState(() {
                                 _promoteStatus=false;
                               });
                               FirebaseFirestore.instance.collection('stores').doc(widget.storeid).update({
                                 'promote':0
                               }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Store de Promoted"))));
                             }

                         },
                           title: _stores['promote']==0?Text("Promote Store"):Text("De-Promote"),),
                       ) ,

                     ],
                   ):SizedBox.shrink(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           AppText(
                             data: _stores['storename'].toString(),
                             txtColor: Colors.black87,
                           ),
                           AppText(
                             data: _stores['location'].toString(),
                             txtColor: Colors.black45,
                             textSize: 12,
                           ),
                           AppText(
                             data: _stores['category'].toString(),
                             txtColor: Colors.black45,
                             textSize: 12,
                           )
                         ],
                       ),
                       _stores['status'] == 0
                           ? IconButton(
                           onPressed: () {},
                           icon: Icon(
                             Icons.close_rounded,
                             color: Colors.red,
                           ))
                           : IconButton(
                           onPressed: () {},
                           icon: Icon(
                             Icons.offline_pin,
                             color: Colors.green,
                           ))
                     ],
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   _stores['status'] == 0
                       ? Row(
                     children: [
                       AppText(
                         data: "Not Verified",
                         txtColor: Colors.black87,
                         fw: FontWeight.bold,
                         textSize: 26,
                       ),
                       SizedBox(
                         width: 25,
                       ),
                       Text("Status", style: TextStyle(fontSize: 20)),
                       SizedBox(
                         width: 25,
                       ),
                       AppText(
                         data: "Pending",
                         txtColor: secondaryColor,
                         fw: FontWeight.bold,
                         textSize: 16,
                       ),
                     ],
                   )
                       : Row(
                     children: [
                       AppText(
                         data: "Verified",
                         txtColor: Colors.black87,
                         fw: FontWeight.bold,
                         textSize: 26,
                       ),
                       SizedBox(
                         width: 25,
                       ),
                       Text("Status", style: TextStyle(fontSize: 20)),
                       SizedBox(
                         width: 25,
                       ),
                       AppText(
                         data: "Active",
                         txtColor: secondaryColor,
                         fw: FontWeight.bold,
                         textSize: 16,
                       ),
                     ],
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Card(
                     child: Container(
                       padding: EdgeInsets.all(20),
                       height: 120,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15)),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               AppText(
                                 data: "Phone",
                                 txtColor: Colors.black87,
                               ),
                               AppText(
                                 data: _stores['phone'],
                                 txtColor: Colors.black87,
                               ),
                             ],
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               AppText(
                                 data: "Email",
                                 txtColor: Colors.black45,
                                 textSize: 12,
                               ),
                               AppText(
                                 data: _stores['email'],
                                 txtColor: Colors.black45,
                                 textSize: 12,
                               ),
                             ],
                           )
                         ],
                       ),
                     ),
                   ),
                   SizedBox(
                     height: 20,
                   ),
                   _stores['status'] == 0
                       ? Center(
                       child: AppButton(
                         data: "Approve",
                         width: 250,
                         height: 45,
                         onTap: () {
                           FirebaseFirestore.instance
                               .collection('stores')
                               .doc(_stores['storeid'])
                               .update({'status': 1}).then((value) {
                             FirebaseFirestore.instance
                                 .collection('login')
                                 .doc(_stores['storeid'])
                                 .update({'status': 1}).then((value){
                               ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(

                                   content: AppText(
                                     data: '${_stores['storename']} Approved',
                                     txtColor: Colors.white,
                                     textSize: 13,
                                   ),
                                   backgroundColor: Colors.green,
                                 ),
                               );
                               Navigator.pop(context);
                             } );


                           });
                         },
                       ))
                       : Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       AppText(
                         data: "Approved",
                         txtColor: Colors.green,
                         textSize: 15,
                       ),
                       SizedBox(width: 40,),
                       IconButton(onPressed: (){

                         FirebaseFirestore.instance
                             .collection('stores')
                             .doc(_stores['storeid'])
                             .update({'status': 0,'promote':0}).then((value) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(

                               content: AppText(
                                 data: '${_stores['storename']} Disabled',
                                 txtColor: Colors.white,
                                 textSize: 13,
                               ),
                               backgroundColor: Colors.red,
                             ),
                           );
                           Navigator.pop(context);
                         });


                       }, icon: CircleAvatar(
                           radius:40,
                           backgroundColor: Colors.redAccent,

                           child: Icon(Icons.delete,color: Colors.white,)))
                     ],
                   )
                 ],
               );
             }
             return Center(
               child: CircularProgressIndicator(),
             );
            },
          ),
        ),
      ),
    );
  }
}
