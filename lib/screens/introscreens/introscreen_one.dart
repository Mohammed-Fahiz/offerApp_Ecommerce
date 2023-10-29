import 'package:flutter/material.dart';
import 'package:offerapp/widgets/apptext.dart';

class IntroScreenOne extends StatefulWidget {
  const IntroScreenOne({Key? key}) : super(key: key);

  @override
  State<IntroScreenOne> createState() => _IntroScreenOneState();
}

class _IntroScreenOneState extends State<IntroScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Image.asset('assets/images/img1.png',height: 250),
          SizedBox(height: 40,),
          AppText(data: "Never Miss an Offer",textSize: 20,txtColor: Colors.black,),
          SizedBox(height: 10,),
          AppText(data: "iLoveIMG is your simple solution for editing images online. Access all the tools you need to enhance your images easily, straight from the web, with 100% security.",txtColor: Colors.black87,textSize: 16,)
        ],
      ),
    );
  }
}
