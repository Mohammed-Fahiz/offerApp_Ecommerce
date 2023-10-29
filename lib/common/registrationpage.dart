import 'package:flutter/material.dart';
import 'package:offerapp/screens/stores/soreregistration.dart';
import 'package:offerapp/screens/user/userregistration.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  
  String type="user";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
           Row(
             children: [

               Container(
                 width: MediaQuery.of(context).size.width/2,
                child:  RadioListTile(value:"user", groupValue: type, onChanged: (value){
                  setState(() {
                    type=value.toString();
                  });

                },

                  title: Text("User Registration"),),

               ),
               Container(
                 width: MediaQuery.of(context).size.width/2,
                 child:   RadioListTile(value:"store", groupValue: type, onChanged: (value){
                   setState(() {
                     type=value.toString();
                   });

                 },

                   title: Text("Store Registration"),),
               )
             ],
           ),
            type=="user"?Container(
              height: MediaQuery.of(context).size.height*0.85,
              child: UserRegistration(),
            ):StoreRegistration()
          ],
        ),
      ),
    );
  }
}
