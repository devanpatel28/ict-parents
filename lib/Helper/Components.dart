import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

double getHeight(context, double i) {
  double result = MediaQuery.of(context).size.height * i;
  return result;
}

double getWidth(context, double i) {
  double result = MediaQuery.of(context).size.width * i;
  return result;
}

double getSize(context, double i) {
  double result = MediaQuery.of(context).size.width * i / 50;
  return result;
}


Widget BlackTag(double? height,double? width,double? leftRad,double? rightRad) {
  return Container(
    height: height??65,
    width: width??300,
    decoration: BoxDecoration(
        color: Colors.black,
      borderRadius: BorderRadius.horizontal(left: Radius.circular())
    ),
  );
}