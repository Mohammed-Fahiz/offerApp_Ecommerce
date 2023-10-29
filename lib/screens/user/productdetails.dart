import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/map/mapexample.dart';
import 'package:offerapp/screens/map/mapscreen.dart';
import 'package:offerapp/screens/user/shoppingitem.dart';
import 'package:offerapp/screens/user/storedetailspage.dart';
import 'package:offerapp/screens/user/viewcartpage.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class ProductDetailsPage extends StatefulWidget {
  String? id;
  ProductDetailsPage({Key? key, this.id}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Map<dynamic, dynamic> data;
  Future<Map<dynamic, dynamic>> fetchData() async {
    DocumentSnapshot value = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.id)
        .get();
    final data = value.data() as Map<String, dynamic>;
    return data;
  }

  var shoppingCart;

  Future<Box<ShoppingItem>> _openShoppingCartBox() async {
    var shoppingCartBox = await Hive.openBox<ShoppingItem>('shopping_cart');
    return shoppingCartBox;
  }

  void addToCart(ShoppingItem item) {
    bool itemExists = false;
    int? itemIndex;
    for (int i = 0; i < shoppingCart.length; i++) {
      ShoppingItem currentItem = shoppingCart.getAt(i);
      if (currentItem.name == item.name) {
        itemExists = true;
        itemIndex = i;
        break;
      }
    }
    if (itemExists) {
      shoppingCart.putAt(itemIndex, item);
    } else {
      shoppingCart.add(item);
    }
  }

  void removeFromCart(int index) {
    shoppingCart.deleteAt(index);
  }

  List<ShoppingItem> getCartItems() {
    return shoppingCart.values.toList();
  }

  List<String>? _items;

  int itemCount = 0;

  void updateItemCount() async {
    var shoppingCartBox = await Hive.openBox<ShoppingItem>('shopping_cart');
    setState(() {
      itemCount = Hive.box<ShoppingItem>('shopping_cart').length;
    });
  }

  var item;
  List cart = [];

  bool? isItemSelected;
  String? selecteditem;



  int? _selectedItemIndex;
  @override
  void initState() {



    _openShoppingCartBox();
    updateItemCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: AppText(
          data: "Product Details",
          txtColor: Colors.black,
        ),

        actions: <Widget>[

          Container(
            margin: EdgeInsets.only(right: 10,top: 10),
            child: Badge(
              label: Text(
                itemCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingCartScreen(


                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.shopping_cart)),
            ),
          ),
        ],


      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: FutureBuilder(
            future: fetchData(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final _offer = snapshot.data as Map;
                print(_offer);
                //double unitprice=double.parse(_offer['unitprice'].toString());
                var saving = ((double.parse(_offer['offer'].toString()) *
                    double.parse(_offer['unitPrice'].toString()) /
                    100));
                print(_offer['unitprice'].toString());
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 50),
                        height: MediaQuery.of(context).size.height / 2,
                        //color: Colors.red,
                        child: Center(
                          child: Container(
                              height: MediaQuery.of(context).size.height - 200,
                              child: Image.network(
                                _offer['imgurl'].toString(),
                                height: 150,
                                width: 250,
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data: _offer['productName'],
                                txtColor: Colors.black87,
                              ),
                              Container(
                                  // color: Colors.red,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: AppText(
                                    data: _offer['productDescription'],
                                    txtColor: Colors.black45,
                                    textSize: 12,
                                  )),
                              Row(
                                children: [
                                  AppText(
                                    data: 'RS. ${_offer['unitPrice']}',
                                    textSize: 20,
                                    txtColor: Colors.black87,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  AppText(
                                    data: 'Offer ${_offer['offer']}%',
                                    textSize: 20,
                                    txtColor: secondaryColor,
                                  )
                                ],
                              ),
                              AppText(
                                data: 'You Saved:  Rs.${saving}/-',
                                textSize: 20,
                                txtColor: Colors.black87,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //
                      //   children: [
                      //     AppText(data: "\$ ${_offer['unitprice']}",txtColor: Colors.black87,fw: FontWeight.bold,textSize: 26,),
                      //     SizedBox(width: 25,),
                      //     Text("\$499",style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 20))
                      //     ,
                      //     SizedBox(width: 25,),
                      //     AppText(data: "You Save \$249",txtColor: secondaryColor,fw: FontWeight.bold,textSize: 16,),
                      //
                      //   ],
                      // )

                      // Card(
                      //   child: Container(
                      //     height: 150,
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(15)
                      //     ),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         AppText(data: "Nike Blazer Mid 77",txtColor: Colors.black87,)
                      //         ,AppText(data: "Women's Shoes",txtColor: Colors.black45,textSize: 12,)
                      //         ,AppText(data: "Sold by: Image Mobiles",txtColor: Colors.black45,textSize: 12,)
                      //       ],
                      //     ),
                      //
                      //   ),
                      // ),
                      // SizedBox(height: 20,),

                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton(
                            data: "Add to Cart",
                            width: 250,
                            height: 45,
                            onTap: () async {
                              var shoppingCartBox =
                                  await Hive.openBox<ShoppingItem>(
                                      'shopping_cart');
                              shoppingCartBox.add(ShoppingItem(
                                  name: _offer['productName'],
                                  id: _offer['productID'],
                                  storeid: _offer['storeid'],
                                  price: saving));

                              updateItemCount();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Item added")));
                            },
                          ),
                        ],
                      ))
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
