import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String? data;
  double? textSize;
  FontWeight? fw;
  Color? txtColor;

  AppText({Key? key, required this.data, this.textSize, this.txtColor, this.fw})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

      data ?? "Test",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: (txtColor) ?? Colors.white12,
        fontSize: textSize ?? 15,
        fontWeight: fw ?? FontWeight.w700,
      ),
    );
  }
}
