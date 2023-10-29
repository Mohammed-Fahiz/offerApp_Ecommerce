import 'package:flutter/material.dart';
import 'package:offerapp/common/decorationStyles.dart';
import 'package:offerapp/widgets/apptext.dart';

class AppButton extends StatelessWidget {
  String? data;
  double? width;
  double?height;
  Function? onTap;
   AppButton({Key? key,this.data,this.height,this.width,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap!();
      },
      child: Container(

        height: height,
        width: width,
        decoration: btnDecoration4,
        child: Center(
          child: AppText(
            data: data,
            textSize: 18,
            txtColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
