import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceService{


  setOnBoarding() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('times', "value");
  }
  getOnBoarding() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('times');
  }

  setToken( String?token)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token',token.toString());
  }
  setData(String id,String name,String phone, String email,String?type)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid',id.toString());
    prefs.setString('name',name.toString());
    prefs.setString('email',email.toString());
    prefs.setString('phone',phone.toString());
    prefs.setString('type',phone.toString());
  }


}