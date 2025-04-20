import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../Animations/slide_zoom_in_animation.dart';
import '../../Controllers/placement_controller.dart';
import '../../Helper/Components.dart';
import '../../Helper/Style.dart';
import 'package:intl/intl.dart';
import '../../Helper/colors.dart';
import '../../Model/recently_placed_student_model.dart';
import '../../Widgets/dashboard_icon.dart';
import '../../Widgets/heading_1.dart';
import '../Loading/adaptive_loading_screen.dart';

class PlacementScreen extends GetView<PlacementController> {
  const PlacementScreen({super.key});

  String _formatPackage(double packageStart, double packageEnd) {
    String formatNumber(double number) {
      if (number % 1 == 0) {
        return number.toInt().toString();
      }
      return number.toString();
    }

    if (packageStart == packageEnd) {
      return "${formatNumber(packageStart)} LPA";
    } else {
      return "${formatNumber(packageStart)} - ${formatNumber(packageEnd)} LPA";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Placements",
          style: appbarStyle(context),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: backgroundColor),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
            () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TapIcon2(
                    name: "Campus Drives",
                    iconData: HugeIcons.strokeRoundedUniversity,
                    route: "/campusDriveList",
                    routeArg: {
                      'student_id': controller.studentId,
                      'batch_id': controller.batchId
                    },
                ),
                TapIcon2(
                  name: "Round Status",
                  iconData: HugeIcons.strokeRoundedStatus,
                  route: "/studentRoundsDetail",
                  routeArg: {
                    'student_id': controller.studentId,
                    'batch_id': controller.batchId
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
            child: Divider(indent: 20,endIndent: 20,color:muGrey ,),
          ),
          const Heading1(text: "Recently Placed",fontSize: 2.5,leftPadding: 20,),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: controller.isLoadingPlacedStudentList.value?const AdaptiveLoadingScreen():
            ListView.builder(
              itemCount: controller.recentlyPlacedStudentList.length,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              itemBuilder: (context, index) {
                RecentlyPlacedStudentModel student = controller.recentlyPlacedStudentList[index];
                return SlideZoomInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: muGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  HugeIcon(icon: HugeIcons.strokeRoundedUserCircle, color: muColor),
                                  const SizedBox(width: 7), // Add spacing between icon and text
                                  Flexible(
                                    child: Text(
                                      student.studentName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: getSize(context, 2)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  HugeIcon(icon: HugeIcons.strokeRoundedMoneyBag02, color: muColor),
                                  const SizedBox(width: 7), // Add spacing between icon and text
                                  Text(
                                    _formatPackage(student.packageStart, student.packageEnd),
                                    style: TextStyle(
                                      fontSize: getSize(context, 2),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  HugeIcon(icon: HugeIcons.strokeRoundedHouse01, color: muColor),
                                  const SizedBox(width: 7), // Add spacing between icon and text
                                  Flexible(
                                    child: Text(
                                      student.companyName,
                                      style: TextStyle(fontSize: getSize(context, 2)),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 100,
                            height: 25,
                            decoration: BoxDecoration(
                              color: muColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                (student.placedDate.isNotEmpty)
                                    ? DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(student.placedDate))
                                    : "",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    ));
  }
}
