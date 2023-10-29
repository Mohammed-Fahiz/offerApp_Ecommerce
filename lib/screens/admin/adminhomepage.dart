import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/loginpage.dart';
import 'package:offerapp/screens/admin/categorymanagement/viewallcategory.dart';
import 'package:offerapp/screens/admin/feddbacks_complaints/viewallfeedbacks.dart';
import 'package:offerapp/screens/admin/notifications/addnotifications.dart';
import 'package:offerapp/screens/admin/notifications/viewallnotification.dart';
import 'package:offerapp/screens/admin/usermanagement/ViewAllUsers.dart';
import 'package:offerapp/screens/admin/categorymanagement/addcategory.dart';
import 'package:offerapp/screens/admin/bannermanagement/createbanneradd.dart';
import 'package:offerapp/screens/admin/bannermanagement/viewalladsadmin.dart';
import 'package:offerapp/screens/admin/storemanagement/viewallstoreadmin.dart';
import 'package:offerapp/screens/admin/payments/viewallpayments.dart';
import 'package:offerapp/screens/stores/soreregistration.dart';
import 'package:offerapp/widgets/apptext.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Color> get availableColors =>  <Color>[
        Colors.purpleAccent,
        Colors.yellow,
        Colors.lightBlue,
        Colors.orange,
        Colors.pink,
        Colors.redAccent,
      ];
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final List<String>items=[
    "Stores","Users","Earnings","Transactions"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.remove('token').then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                });
              },
              icon: Icon(Icons.logout_sharp))
        ],
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("Admin Dashbord"),
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

//               AppText(data: "Over View",txtColor: Colors.black87,textSize: 18,),
//               SizedBox(height: 20,),
//               Container(
// height: 150,
//                 width: MediaQuery.of(context).size.width,
//                 child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 8/3
//                     ),
//                     itemCount: 4,
//                     itemBuilder: (_, index) {
//
//                       return Container(
//
//                         height: 48,
//                         width: 100,
//                         child: Center(
//                           child: Text(items[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
//                         ),
//                         color: (index%2==0)?availableColors[index]:availableColors[index],
//                       );
//                     }),
//               ),
//               Divider(
//                 height: 1,
//                 thickness: 1,
//                 endIndent: 50,
//                 indent: 0,
//                 color: primaryColor,
//               ),
              SizedBox(height: 20,),
              AppText(data: "Dashboard",txtColor: Colors.black87,textSize: 18,),
              SizedBox(height: 20,),

              //store Management
              AppText(data: "Store Management",textSize: 16,
              txtColor: Colors.black87,),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreRegistration(
                          status: true,
                        )));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: barBackgroundColor,
                        child: Center(
                          child: AppText(data: "Add Store",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllStoresAdmin(

                        )));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: availableColors[2],
                        child: Center(
                          child: AppText(data: "View Stores",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  )
                ],
              ),


//User Management

              SizedBox(height: 20,),

              //store Management
              AppText(data: "User Management",textSize: 16,
                txtColor: Colors.black87,),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllUsers(

                        )));

                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: availableColors[4],
                        child: Center(
                          child: AppText(data: "View Users",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  // Expanded(
                  //   child: Container(
                  //     height: 80,
                  //     width: 100,
                  //     color: availableColors[0],
                  //     child: Center(
                  //       child: AppText(data: "View Stores",txtColor: Colors.black87,),
                  //     ),
                  //   ),
                  // )
                ],
              ),

//banner Management
              SizedBox(height: 20,),
              AppText(data: "Banner Add Management",textSize: 16,
                txtColor: Colors.black87,),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateBannerAdd(
                          reqFrom: "admin",
                        )));

                            },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "New Banner Add",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllAddsAdmin(reqFrom: "admin",)));


                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "View Adds",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              //Category Management

              SizedBox(height: 20,),
              AppText(data: "Category Management",textSize: 16,
                txtColor: Colors.black87,),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateCategory()));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "Add Category",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllCategory()));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "View Category",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              //payment Management
              SizedBox(height: 20,),
              AppText(data: "Payment Management",textSize: 16,
                txtColor: Colors.black87,),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: InkWell(

                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllPayments()));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "View Payments",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 10,),
                  // Expanded(
                  //   child: Container(
                  //     height: 80,
                  //     width: 100,
                  //     color: Colors.yellow,
                  //     child: Center(
                  //       child: AppText(data: "By Store",txtColor: Colors.black87,),
                  //     ),
                  //   ),
                  // )
                ],
              ),
//Feedbacks
              SizedBox(height: 20,),
              AppText(data: "Feedbacks and Complaints",textSize: 16,
                txtColor: Colors.black87,),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllFeedbacks()));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "Feedbacks",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      height: 80,
                      width: 100,
                      color: Colors.yellow,
                      child: Center(
                        child: AppText(data: "Complaints",txtColor: Colors.black87,),
                      ),
                    ),
                  )
                ],
              ),

              //
              //Notifications



              SizedBox(height: 20,),
              AppText(data: "Notifications Management",textSize: 16,
                txtColor: Colors.black87,),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNotification()));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "Add Notifications",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllNotifications()));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "View Notifications",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              //Store Promotions

              SizedBox(height: 20,),
              AppText(data: "Store Promotions",textSize: 16,
                txtColor: Colors.black87,),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllStoresAdmin(
                          promote: "Promote",
                        )));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "Add Promotions",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllStoresAdmin(
                          promote: "Promote",
                        )));
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: AppText(data: "View Promotions",txtColor: Colors.black87,),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 80,
                      width: 100,
                      color: Colors.yellow,
                      child: Center(
                        child: AppText(data: "View Trending",txtColor: Colors.black87,),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      height: 80,
                      width: 100,
                      color: Colors.yellow,
                      child: Center(
                        child: AppText(data: "Most Rated",txtColor: Colors.black87,),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
