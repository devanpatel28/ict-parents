import 'package:flutter/material.dart';
import 'package:ict_mu_parents/Helper/Colors.dart';
import 'package:ict_mu_parents/Helper/Style.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance",style:AppbarStyle),
        backgroundColor: muColor,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
