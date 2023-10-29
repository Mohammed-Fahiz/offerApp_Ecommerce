
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:offerapp/screens/user/paymentpage.dart';
import 'package:offerapp/screens/user/shoppingitem.dart';
import 'package:offerapp/widgets/apptext.dart';


import 'package:shared_preferences/shared_preferences.dart';


import 'package:uuid/uuid.dart';

import '../../common/colors.dart';

class ShoppingCartScreen extends StatefulWidget {

  ShoppingCartScreen({Key? key,  }) : super(key: key);
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  var shoppingCart;
  var orderid;
  var uuid = Uuid();

  Future<void> initHive() async {
    await Hive.initFlutter();
    shoppingCart = await Hive.openBox<ShoppingItem>('shopping_cart');
  }

  void addToCart(ShoppingItem item) {
    shoppingCart.add(item);
  }

  void removeFromCart(int index) {
    shoppingCart.deleteAt(index);
  }

  Future<List<ShoppingItem>> getCartItems() {
    print("helo");

    return shoppingCart.values.toList();
  }

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


  var _total;

  @override
  void initState() {
    super.initState();
    initHive();
    getdata();
    orderid = uuid.v1();
  }

  @override
  Widget build(BuildContext context) {
    _total = getCartTotal();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Text('Shopping Cart'),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              child: FutureBuilder(
                  future: Hive.openBox<ShoppingItem>('shopping_cart'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        var shoppingCartBox = Hive.box<ShoppingItem>(
                            'shopping_cart');
                        return ListView.builder(
                          itemCount: shoppingCartBox.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cartItem = shoppingCartBox.getAt(index);

                            return ListTile(
                              isThreeLine: true,
                              title: Text(cartItem!.name.toString()),
                              subtitle: Text("${cartItem.price.toString()}"),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    shoppingCartBox.deleteAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),

            Container(
              height: 100,
              child: StreamBuilder<double>(
                stream: getCartTotal().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AppText(
                      txtColor: Colors.black87,
                     data: "Cart Total: ${snapshot.data}", textSize: 22,);
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            Container(
              height: 45,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(12)),

                child: InkWell(
                  onTap: () async {
                    var shoppingCartBox = await Hive.openBox<ShoppingItem>('shopping_cart');
                    var items = await getCartItem();
                    var cattoal = await getCartTotal();
                    var idlist=[];
                    int i = 0; // )));
                    for (i = 0; i < items.length; i++) {


                      idlist!.add(orderid);
                      FirebaseFirestore.instance
                          .collection('orders')
                          .doc(orderid)
                          .set({
                        'orderid': orderid,
                        'itemname': items[i]['name'],
                        'itemid': items[i]['id'],
                        'price': items[i]['price'],

                        'sellerid': items[i]['storeid'],
                        'status': 0,
                        'paymentstatus': 0,
                        'deladdress1': "",
                        'deladdress2': "",
                        'customerid': id,
                        'customername': name,
                        'customeremail': email,
                      }).then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreditCardClass(

                          item: idlist,
                        )));



                      });

                      orderid = uuid.v1();


                    }

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment_Page(
                    //   carttotal:cattoal ,
                    //   shoppingItems:  items,
                    //   shopid: widget.shopid,
                    //   items: widget.itemselected,
                    //   from: widget.from,
                    //
                    // )));


                  },
                  child: Text("Proceed to Checkout",style: TextStyle(color: Colors.white),),
                )
            )
          ],
        ));
  }


  Future<double> getCartTotal() async {
    var box = await Hive.openBox<ShoppingItem>("shopping_cart");
    _total = 0.0;
    for (var item in box.values) {
      _total += item.price!;
    }

    print("Total is ${_total}");
    return _total;
  }

  Future<List<Map<String, dynamic>>> getCartItem() async {
    var box = await Hive.openBox<ShoppingItem>("shopping_cart");
    var items = box.values.map((item) =>
    {
      "name": item.name,
      "price": item.price,
      "id": item.id,
     'storeid':item.storeid
    }).toList();

    return items;


    var id, email, name, phone, type;
    getdata() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('uid');
      email = prefs.getString('email');
      phone = prefs.getString('phone');
      name = prefs.getString('name');
      type = prefs.getString('type');


      print(name);
      print(email);
    }
  }
}


