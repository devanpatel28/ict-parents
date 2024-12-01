import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ict_mu_parents/Helper/Components.dart';
import '../../Helper/colors.dart';
import '../../Model/user_data_model.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Dashboard",
            style: TextStyle(
                color: Colors.black, fontFamily: "mu_reg", fontSize: 23)),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            blackTag(
                context,
                Dark1,
                "${userData.studentDetails?.firstName} ${userData.studentDetails?.lastName}",
                "Sem: ${userData.classDetails?.semester}  Class: ${userData.classDetails?.className} - ${userData.classDetails?.batch?.toUpperCase()}",
                CachedNetworkImage(
                  imageUrl: studentImageAPI(userData.studentDetails!.grNo),
                  placeholder: (context, url) => const HugeIcon(
                    icon: HugeIcons.strokeRoundedUser,
                    size: 30,
                    color: Colors.black,
                  ),
                  errorWidget: (context, url, error) => const HugeIcon(
                    icon: HugeIcons.strokeRoundedUser,
                    size: 30,
                    color: Colors.black,
                  ),
                  fit: BoxFit.cover,
                ),
                true,
                '/profile',
                userData),
            const SizedBox(height: 20),
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
                  shrinkWrap:
                      true, // Ensures the GridView takes only as much space as it needs
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.85,
                  padding: const EdgeInsets.all(10),
                  children: [
                    tapIcons(
                        context,
                        "Attendance",
                        2,
                        HugeIcons.strokeRoundedDocumentValidation,
                        40,
                        "/attendance",
                        {'student_id': userData.studentDetails?.studentId}),
                    tapIcons(
                        context,
                        "Faculty Contact",
                        2,
                        HugeIcons.strokeRoundedContact01,
                        40,
                        "/faculty_contact",
                        {'student_id': userData.studentDetails?.studentId}),
                    tapIcons(
                        context,
                        "Timetable",
                        2,
                        HugeIcons.strokeRoundedCalendar02,
                        40,
                        "/studentTimetable",
                        {'student_id': userData.studentDetails?.studentId}),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            blackTag(
                context,
                Dark1,
                "Upcoming Event",
                "Engineer's Day Celebration",
                Image.asset(
                  "assets/images/arrow_right.png",
                  fit: BoxFit.cover,
                ),
                false,
                "null",
                null),
          ],
        ),
      ),
    );
  }
}
