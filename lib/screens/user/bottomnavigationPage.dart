import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/common/loginpage.dart';
import 'package:offerapp/screens/user/addfeedback.dart';
import 'package:offerapp/screens/user/allstores.dart';
import 'package:offerapp/screens/user/favorites.dart';
import 'package:offerapp/screens/user/homepage.dart';
import 'package:offerapp/screens/user/notification.dart';
import 'package:offerapp/screens/user/offersbycategory.dart';
import 'package:offerapp/screens/user/orders.dart';
import 'package:offerapp/screens/user/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var id, email, name, phone;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('uid');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    name = prefs.getString('name');

    print(name);
    print(email);
  }

  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    getdata();

    _widgetOptions = [
      UserHomePage(

      ),
     FavoritesPage(),
     Allstores(),
     ProfilePage(),

    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
        ),
        drawer: Drawer(

          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor
                ),
                child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 20,),
                  Text(name??"hi",style: TextStyle(color: Colors.white),)
                ],
              ),),
              ListTile(
                onTap: () {

                  FirebaseAuth.instance.signOut().then((value) async {


                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.remove('token');
                    preferences.remove('uid');
                    preferences.remove('name');
                    preferences.remove('phone');
                    preferences.remove('email');
                    preferences.remove('type');

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);

                  });

                },
                title: Text("Logout"),
              ),
              ListTile(
                onTap: () {
Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => AllNotification(

                        ),
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
                title: Text("Notification"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => AllOrders(id: id,

                        ),
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
                title: Text("Orders"),
              ),
              ListTile(
                onTap: () {
Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => AddFeedBack(

                        ),
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
                title: Text("Feedback"),
              ),

            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: primaryColor,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.home),
                label: "Home"),
            BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.favorite),
                label: "Favorite"),
            BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.store), label: "Store"),
            BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.person_pin), label: "Profile"),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
