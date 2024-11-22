import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ict_mu_parents/Helper/Components.dart';
import '../../Helper/Colors.dart';
import '../../Model/UserDataModel.dart';
import '../../Network/API.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final box = GetStorage();
  late UserData userData;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> storedData = box.read('userdata');
    userData = UserData.fromJson(storedData);
    print('user data == ${userData.studentDetails?.grNo}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:() async {
          await CachedNetworkImage.evictFromCache(
              studentImageAPI(userData.studentDetails!.grNo));
          box.write('loggedin', false);
          box.write('userdata', null);
          Get.offNamed('/login');
        },
        child: Icon(Icons.exit_to_app),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(color: Colors.black, fontFamily: "mu_reg", fontSize: 23)),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlackTag(
              context,
              Dark1,
              "${userData.studentDetails?.firstName} ${userData.studentDetails?.lastName}",
              "Sem: ${userData.classDetails?.semester}  Class: ${userData.classDetails?.className} - ${userData.classDetails?.batch?.toUpperCase()}",
              CachedNetworkImage(
                imageUrl: studentImageAPI(userData.studentDetails!.grNo),
                placeholder: (context, url) =>  Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.black45,
                ),
                errorWidget: (context, url,error) =>  Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.black87,
                ),
                fit: BoxFit.cover,
              ),
              true,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GridView.count(
                  shrinkWrap: true,  // Ensures the GridView takes only as much space as it needs
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.85,
                  padding: EdgeInsets.all(10),
                  children: [
                    TapIcons(context,"Attendance", 2, "attendance.png", 45,"/attendance",{'student_id': userData.studentDetails?.studentId}),
                    TapIcons(context,"Placement", 2, "placement.png", 45,"/placement",null),
                    TapIcons(context,"Leaves", 2, "leaves.png", 45, "/placement",null),
                    TapIcons(context,"Result", 2, "result.png", 45, "/placement",null),
                    TapIcons(context,"Exams", 2, "exam.png", 45, "/placement",null),
                    TapIcons(context,"Holidays", 2, "holiday.png", 45, "/placement",null),
                    TapIcons(context,"Timetable", 2, "timetable.png", 45, "/placement",null),
                    TapIcons(context,"Faculties", 2, "faculty.png", 45, "/placement",null),
                    TapIcons(context,"Noticeboard", 2, "noticeboard.png", 45, "/placement",null),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            BlackTag(
              context,
              Dark1,
              "Upcoming Event",
              "Engineer's Day Celebration",
              Image.asset(
                "assets/images/arrow_right.png",
                fit: BoxFit.cover,
              ),
              false,
            ),
          ],
        ),
      ),
    );
  }
}
