import 'package:flutter/material.dart';
import 'package:offerapp/common/colors.dart';


final borderEnabledBorder = OutlineInputBorder(
    borderSide:const BorderSide(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(5));

final borderfocusedBorder = OutlineInputBorder(
    borderSide:  BorderSide(
      color: secondaryColor,
      width: 2
    ),
    borderRadius: BorderRadius.circular(5));

final borderEnabledBorderblck = OutlineInputBorder(
    borderSide:const BorderSide(
      color: Colors.black87,
    ),
    borderRadius: BorderRadius.circular(5));

final borderfocusedBorderblack = OutlineInputBorder(
    borderSide:  BorderSide(
        color: secondaryColor,
        width: 2
    ),
    borderRadius: BorderRadius.circular(5));