import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:offerapp/common/splashpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:offerapp/screens/user/adapter.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Hive.registerAdapter(ShoppingItemAdapter());
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(



      ),


      debugShowCheckedModeBanner: false,
      home:SplashPage() ,
    );
  }



}
