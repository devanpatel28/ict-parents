import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../Helper/Colors.dart';
import '../Helper/Components.dart';

class TapIcon extends StatelessWidget {
      final String name;
      final double nameSize = 2;
      final IconData iconData;
      final double iconSize = 40;
      final String route;
      final routeArg;

      TapIcon({
        super.key,
        required this.name,
        // required this.nameSize,
        required this.iconData,
        // required this.iconSize,
        required this.route,
        this.routeArg});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(route, arguments: routeArg),
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              color: muGrey,
              borderRadius: BorderRadius.circular(15), // rounded corners
            ),
            child: Center(
              child: HugeIcon(
                icon: iconData,
                color: Colors.black,
                size: iconSize,
              ),
            ),
          ),
          SizedBox(
            height: getHeight(Get.context!, 0.01),
          ),
          SizedBox(
              height: getHeight(Get.context!, 0.05),
              width: getWidth(Get.context!, 0.25),
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'mu_reg',
                    color: muColor,
                    height: 1,
                    fontSize: getSize(Get.context!, nameSize)),
                // softWrap: true,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
