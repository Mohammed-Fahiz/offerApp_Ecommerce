import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/screens/user/offerdetailspage.dart';
import 'package:offerapp/screens/user/storedetailspage.dart';
import 'package:offerapp/widgets/appbutton.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {

  FavoritesPage({Key? key, }) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  String? id, email, name, phone;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('uid');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    name = prefs.getString('name');

    print(name);
    print(email);
    setState(() {

    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child:FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(id.toString()).get(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"),);
          }

          if (snapshot.hasData) {
            final snap = snapshot.data!.data() as Map<String, dynamic>?;
            List<Map<String, dynamic>> favList = List<Map<String, dynamic>>.from(snap?['fav'] ?? []);

            // Debugging: Print the list of maps to the console
            favList.forEach((map) => print(map));
            print(favList);

            return ListView.builder(
              itemCount: favList.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(favList[index]['storename']),

                  leading: Image.network(favList[index]['storeimg']),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )


    );
  }
}
