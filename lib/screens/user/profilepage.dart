import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';
import 'package:offerapp/widgets/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String? id, email, name, phone;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('uid');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    name = prefs.getString('name');

    print(id);
    print(email);

    setState(() {

    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          AppText(data: "Your Profile",txtColor: primaryColor,textSize: 22,),

          ///SizedBox(height: 25,),Image.asset('assets/images/verfied.png'),
          AppText(data: name,txtColor: primaryColor,),
          AppText(data: email,txtColor: primaryColor,),
          AppText(data: phone,txtColor: primaryColor,),


        ],
      ),
    );
  }
}
