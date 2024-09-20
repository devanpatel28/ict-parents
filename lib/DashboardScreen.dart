import 'package:flutter/material.dart';
import 'package:ict_mu_parents/Helper/Components.dart';

import 'Helper/Colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard",style: TextStyle(color: Colors.black,fontFamily: "mu_reg",fontSize: 23)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlackTag(
              Dark1,
              null,
              null,
              "Devan Bhensdadiya",
              "Sem: 7  ""  Class: TK1 - A",
                Image.asset(
                  "assets/images/prof.png",
                  fit: BoxFit.cover,
                ),
              true
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Light3,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: GridView.count(
                  crossAxisCount: 3, // Number of items in a row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  padding: EdgeInsets.all(20),
                  children: [
                    TapIcons("Placement",15,"placement.png",50,"/placement"),
                    TapIcons("Leaves",15,"leaves.png",50,"/placement"),
                    TapIcons("Result",15,"result.png",50,"/placement"),
                    TapIcons("Exams",15,"exam.png",50,"/placement"),
                    TapIcons("Holidays",15,"holiday.png",50,"/placement"),
                    TapIcons("Timetable",15,"timetable.png",50,"/placement"),
                    TapIcons("Faculties",15,"faculty.png",50,"/placement"),
                    TapIcons("Noticeboard",15,"noticeboard.png",50,"/placement"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            BlackTag(
                Dark1,
                null,
                null,
                "Upcoming Event",
                "Engineer's Day Celebration",
                Image.asset(
                  "assets/images/arrow_right.png",
                  fit: BoxFit.cover,
                ),
                false
            ),
          ],
        ),
      ),
    );
  }
}
