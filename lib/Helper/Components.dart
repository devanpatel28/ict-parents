import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ict_mu_parents/Helper/Colors.dart';

import 'Style.dart';

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



Widget BlackTag(
    Color? color,
    double? height,
    double? width,
    String? Line1,
    String? Line2,
    Image? img,
    bool isReverse) {
  return Container(
    alignment: Alignment.centerRight,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Conditional alignment
      children: isReverse
          ? [
        Container(
          height: height ?? 65,
          width: width ?? 50,
          decoration: BoxDecoration(
            color: color ?? Colors.black,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(500),
            ),
          ),
        ),
        Container(
          height: height ?? 65,
          width: width ?? 300,
          decoration: BoxDecoration(
            color: color ?? Colors.black,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(500),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500), // Clipping the image into a circle
                  child: img
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Line1??"Loading...",
                      style: tagStyle(Colors.white, 18, true),
                    ),
                    Text(
                      Line2??"Loading...",
                      style: tagStyle(Light2, 15, false),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]
          : [
        Container(
          height: height ?? 65,
          width: width ?? 300,
          decoration: BoxDecoration(
            color: color ?? Colors.black,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(500),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Line1??"Loading...",
                      style: tagStyle(Colors.white, 18, true),
                    ),
                    Text(
                      Line2??"Loading...",
                      style: tagStyle(Light2, 15, false),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500), // Clipping the image into a circle
                  child: img
                ),
              ),
            ],
          ),
        ),
        Container(
          height: height ?? 65,
          width: width ?? 50,
          decoration: BoxDecoration(
            color: color ?? Colors.black,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(500),
            ),
          ),
        ),
      ],
    ),
  );
}
