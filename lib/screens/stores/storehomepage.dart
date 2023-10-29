import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/loginpage.dart';
import 'package:offerapp/screens/admin/bannermanagement/createbanneradd.dart';
import 'package:offerapp/screens/admin/bannermanagement/viewalladsadmin.dart';
import 'package:offerapp/screens/stores/addproducts.dart';
import 'package:offerapp/screens/stores/orders.dart';
import 'package:offerapp/screens/stores/viewallproducts.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreHomePage extends StatefulWidget {
  String?id;
StoreHomePage({Key? key,this.id}) : super(key: key);

  @override
  State<StoreHomePage> createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  String? id, email, name, phone, type;
  bool?lodaing=true;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('uid');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    name = prefs.getString('name');
    type = prefs.getString('type');

    print(name);
    print(email);
    print(id);

    setState(() {
      lodaing=true;
    });
  }

  TextEditingController amountControlelr=TextEditingController();
  final _key=GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getdata();
  }

  int? balance;
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
                  preferences.remove('uid');
                  preferences.remove('name');
                  preferences.remove('phone');
                  preferences.remove('email');
                  preferences.remove('type');

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
        title: Text("Store Dashbord"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: "Dashboard",
              txtColor: Colors.black87,
              textSize: 18,
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 100,
                child: Row(
                  children: [
                    Container(
                      child: AppText(
                        data: "Wallet Balance",
                        txtColor: Colors.black87,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           Container(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('wallet')
                                    .where('walletid', isEqualTo: widget.id)
                                    .snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    balance = snapshot.data!.docs[0]['amount'] as int ;
                                    print(balance.toString());
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AppText(
                                          data: snapshot.data!.docs[0]['amount']
                                              .toString(),
                                          txtColor: Colors.black87,
                                          textSize: 20,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        snapshot.data!.docs[0]['amount'] < 100
                                            ? Container(
                                                //color:Colors.red,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    AppText(
                                                      data: "Refill Now",
                                                      txtColor: Colors.black87,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(context: context, builder: (context){
                                                            return AlertDialog(
                                                              
                                                              content: Container(
                                                                height: 80,
                                                                child: Form(
                                                                  key: _key,
                                                                  child: Column(
                                                                    children: [
                                                                      
                                                                      TextFormField(
                                                                        validator: (value){
                                                                          if(value!.isEmpty){
                                                                            return "Enter a Valid amount";
                                                                          }
                                                                        },
                                                                        controller: amountControlelr,
                                                                        decoration: InputDecoration(
                                                                          hintText: "Enter Amount"
                                                                        ),
                                                                      ),
                                                                      
                                                                      
                                                                    ],
                                                                    
                                                                  ),
                                                                ),
                                                                
                                                              ),
                                                              actions: [
                                                                AppButton(
                                                                  onTap: (){
                                                                   if(_key.currentState!.validate()){
                                                                     FirebaseFirestore
                                                                         .instance
                                                                         .collection(
                                                                         'wallet')
                                                                         .doc(snapshot
                                                                         .data!
                                                                         .docs[0][
                                                                     'walletid']
                                                                         .toString())
                                                                         .update({
                                                                       'amount':balance!+int.parse(amountControlelr.text.toString())
                                                                     });
                                                                   }
                                                                  },
                                                                  height: 40,
                                                                  width: 250,
                                                                  
                                                                )
                                                              ],
                                                            );
                                                          });
                                                        },
                                                        icon: Icon(Icons.add))
                                                  ],
                                                ),
                                              )
                                            : SizedBox.shrink()
                                      ],
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //store Management
            AppText(
              data: "Store Management",
              textSize: 16,
              txtColor: Colors.black87,
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Addproducts(
                                    storeid: id,
                                  )));
                    },
                    child: Container(
                      height: 80,
                      width: 100,
                      color: primaryColor,
                      child: Center(
                        child: AppText(
                          data: "Add Product",
                          txtColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllProducts(
                                    keyword: id.toString(),
                                  )));
                    },
                    child: Container(
                      height: 80,
                      width: 100,
                      color: primaryColor,
                      child: Center(
                        child: AppText(
                          data: "View Products",
                          txtColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (balance !< 100) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Refill Wallet")));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateBannerAdd(
                                      id: id,
                                      name: name,
                                      reqFrom: "store",
                                    )));
                      }
                    },
                    child: Container(
                      height: 80,
                      width: 100,
                      color: primaryColor,
                      child: Center(
                        child: AppText(
                          data: "Create Ads",
                          txtColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllAddsAdmin(
                                    reqFrom: 'store',
                                    id: id,
                                  )));
                    },
                    child: Container(
                      height: 80,
                      width: 100,
                      color: primaryColor,
                      child: Center(
                        child: AppText(
                          data: "View adds",
                          txtColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllOrdersStores(
                                id: id,

                              )));
                    },
                    child: Container(
                      height: 80,
                      width: 100,
                      color: primaryColor,
                      child: Center(
                        child: AppText(
                          data: "View Orders++",
                          txtColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
