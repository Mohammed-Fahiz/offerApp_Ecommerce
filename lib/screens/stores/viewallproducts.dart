import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/user/offerdetailspage.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';

class ViewAllProducts extends StatefulWidget {
  String keyword;
  ViewAllProducts({Key? key, required this.keyword}) : super(key: key);

  @override
  State<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          data: "All Products",
          txtColor: Colors.white,
        ),
        backgroundColor: primaryColor,
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
                data: "All Products",
                txtColor: Colors.black87,
                textSize: 18,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('products').where('storeid',isEqualTo:widget.keyword).snapshots(),
                    builder: (_,snapshot){
                      bool _loading=true;
                      if(snapshot.hasError){
                        return Center(child: Text("Something went wrong"),);
                      }

                      if(snapshot.hasData){
                        List<QueryDocumentSnapshot> _products = snapshot.data!.docs;
_loading=false;
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => OfferDetailsPage(),
                                        transitionDuration: Duration(milliseconds: 400),
                                        transitionsBuilder:
                                            (context, animation, anotherAnimation, child) {
                                          animation = CurvedAnimation(
                                              curve: Curves.easeIn, parent: animation);
                                          return Align(
                                              child: SlideTransition(
                                                position: Tween(
                                                    begin: Offset(1.0, 0.0),
                                                    end: Offset(0.0, 0.0))
                                                    .animate(animation),
                                                child: child,
                                              ));
                                        }),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment(0.0,0.0),
                                        child: Card(
                                          elevation: 5.0,
                                          child: Container(
                                            //color: Colors.red,
                                              height: 180,
                                              width: MediaQuery.of(context).size.width,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(20),
                                                    //color: Colors.teal,
                                                    width: 120,
                                                    height: 180,
                                                    child: _loading==true?Image.asset('assets/images/nike.png'):Image.network(_products[index]['imgurl']),
                                                  ),
                                                  Align(
                                                    alignment: Alignment(1.0, 0.0),
                                                    child: Container(
                                                        padding: EdgeInsets.all(10),
                                                        color: Colors.grey,
                                                        width:
                                                        MediaQuery.of(context).size.width - 160,
                                                        height: 180,

                                                        child:
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            AppText(data: _products[index]['productName'],txtColor: Colors.black87,)
                                                            ,AppText(data: _products[index]['productDescription'],txtColor: Colors.black45,textSize: 12,)
                                                            ,AppText(data: "Sold by:${_products[index]['soldby']}",txtColor: Colors.black45,textSize: 12,)
                                                            ,

                                                            Container(
                                                                height: 40,
                                                                padding: EdgeInsets.only(right: 10),
                                                                width: MediaQuery.of(context).size.width - 160,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    AppText(data: _products[index]['unitPrice'],txtColor: Colors.black87,fw: FontWeight.bold,),
                                                                   _products[index]['status']==1?
                                                                   IconButton(onPressed: (){
                                                                      FirebaseFirestore.instance.collection('products').doc(_products[index]['pid']).update({
                                                                        'status':0
                                                                      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Deleted"))));
                                                                    }, icon: Icon(Icons.delete,color: Colors.red,)): InkWell(

                                                                       onTap: (){

                                                                         FirebaseFirestore.instance.collection('products').doc(_products[index]['pid']).update({
                                                                           'status':1
                                                                         }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Activated"))));
                                                                       },
                                                                       child: AppText(data: "Activate",txtColor: Colors.black87,))
                                                                  ],
                                                                )),
                                                            AppText(data: "View Details",textSize: 14,fw: FontWeight.w700,txtColor: secondaryColor,)

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
                                     int.parse(_products[index]['stock'].toString())>=0?
                                      Align(
                                        alignment: Alignment(0.9,1.1),
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Center(child: AppText(data: _products[index]['stock'],txtColor: Colors.white,)),
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
