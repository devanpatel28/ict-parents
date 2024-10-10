import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_mu_parents/Helper/Components.dart';
import 'package:ict_mu_parents/Model/AttendanceByDateModel.dart';
import '../Controller/AttendanceController.dart';
import '../Helper/Colors.dart';
import '../Helper/Style.dart';
import '../Model/TotalAttendanceModel.dart';
import 'package:intl/intl.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  _StudentAttendanceScreenState createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> with SingleTickerProviderStateMixin{
  final AttendanceController attendanceController = Get.put(AttendanceController());
  List<TotalAttendance>? attendanceList;
  List<AttendanceByDate>? todayAttendanceList;
  bool isLoadingTotal = true;
  bool isLoadingToday = true;
  late AnimationController _controller;
  String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    fetchAttendance();
    fetchTodayAttendance();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), vsync: this,
    )..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void fetchAttendance() async {
    setState(() {
      isLoadingTotal=true;
    });
    int studentId = Get.arguments['student_id'];
    List<TotalAttendance>? fetchedAttendanceList = await attendanceController.totalAttendance(studentId);
    if (!mounted) return;
    setState(() {
      if (fetchedAttendanceList != null) {
        attendanceList = fetchedAttendanceList;
      }
      isLoadingTotal = false;
    });
  }
  void fetchTodayAttendance() async {
    setState(() {
      isLoadingToday=true;
    });
    int studentId = Get.arguments['student_id'];
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("DATE=$todayDate");
    List<AttendanceByDate>? fetchedTodayAttendanceList = await attendanceController.attendanceByDate(studentId,todayDate);
    if (!mounted) return;
    setState(() {
      if (fetchedTodayAttendanceList != null) {
        todayAttendanceList= fetchedTodayAttendanceList;
      }
      isLoadingToday = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total attendance and present lectures
    double totalAttendance = 0;
    double totalPresent = 0;

    if (attendanceList != null) {
      for (var attendance in attendanceList!) {
        totalAttendance += attendance.totalLec;
        totalPresent += attendance.attendLec;
      }
    }
    double avgAttendance = totalAttendance > 0 ? totalPresent / totalAttendance * 100 : 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance", style: AppbarStyle(context)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Light1),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: muColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // Space between icon and percentage
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Attendance',
                                style: TextStyle(
                                  fontSize: getSize(context, 2.5),
                                  fontFamily: "mu_reg",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Text color
                                ),
                              ),
                              Text(
                                'Till Today',
                                style: TextStyle(
                                  fontSize: getSize(context, 2),
                                  fontFamily: "mu_reg",
                                  color: Colors.red, // Text color for 'Till Yesterday'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(height: getHeight(context, 0.08),width: getWidth(context, 0.005),color: muGrey2,),
                    RadialIndicator(context,avgAttendance),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Divider(),
              ),
              avgAttendance>0&&avgAttendance<75?
                  Column(
                    children: [
                      AnimatedBuilder(
                        animation: _controller, // Listen to the animation
                        builder: (BuildContext context, Widget? child) {
                          return Opacity(
                            opacity: _controller.value, // Use the controller's value directly for opacity
                            child: Card(
                              color: Colors.red,
                              child: Container(
                                width: double.infinity,
                                height: getHeight(context, 0.07),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Student Attendance is less than 75%, So student will not be allowed to appear in exams.",
                                    style: TextStyle(
                                      fontFamily: "mu_reg",
                                      color: Colors.white,
                                      fontSize: getSize(context, 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Divider(),
                      ),
                    ],
                  ):Container(),
              // Inside the build method, after your existing content
              Column(
                children: [
                  Heading1(context, "Today's Attendance  -  ( $formattedDate )", 2.5, 8),
                  isLoadingToday
                      ? Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: muColor, strokeWidth: 3,),
                      ))
                      : todayAttendanceList != null && todayAttendanceList!.isNotEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: todayAttendanceList!.length,
                    itemBuilder: (context, index) {
                      AttendanceByDate attendance = todayAttendanceList![index];
                      return AttendanceCard(
                          context,
                          attendance.subjectName,
                          attendance.facultyName,
                          attendance.startTime.substring(0,5),
                          attendance.endTime.substring(0,5),
                          attendance.status
                      );
                    },
                  ): Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('No attendance today', style: TextStyle(fontFamily: "mu_reg",fontSize: getSize(context, 2))),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Divider(),
              ),
              Heading1(context, "All Attendance", 2.5, 8),
              isLoadingTotal
                  ? Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: muColor, strokeWidth: 3,),
              ))
                  : attendanceList != null && attendanceList!.isNotEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: DataTable(
                      headingRowColor: WidgetStateColor.resolveWith((states) => muColor50),
                      dataRowColor: WidgetStateColor.resolveWith((states) => muGrey),
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(getSize(context, 1),),
                          color: Colors.black.withOpacity(0.25)
                      ),
                      clipBehavior: Clip.antiAlias,
                      columnSpacing: getWidth(context, 0.08),
                      columns: [
                        DataColumn(
                          label: Text(
                            'Subject',
                            style: TextStyle(
                                fontFamily: 'mu_bold',
                                fontSize: getSize(context, 2.25),
                                color: Colors.black  // Set text color to black
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Total',
                            style: TextStyle(
                                fontFamily: 'mu_bold',
                                fontSize: getSize(context, 2.25),
                                color: Colors.black  // Set text color to black
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Present',
                            style: TextStyle(
                                fontFamily: 'mu_bold',
                                fontSize: getSize(context, 2.25),
                                color: Colors.black  // Set text color to black
                            ),
                          ),
                        ),
                      ],
                      rows: attendanceList!.map((attendance) {
                        return DataRow(cells: [
                          DataCell(
                            Container(
                              width: getWidth(context, 0.4), // Manage cell width
                              child: Text(
                                attendance.subjectName,
                                style: TextStyle(fontFamily: 'mu_reg', fontSize: getSize(context, 2)),
                                overflow: TextOverflow.fade, // Handle overflow
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                attendance.totalLec.toString(),
                                style: TextStyle(fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                attendance.attendLec.toString(),
                                style: TextStyle(fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                              ),
                            ),
                          ),
                        ]);
                      }).toList()
                        ..add(
                          DataRow(cells: [
                            DataCell(
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Final Total',
                                  style: TextStyle(fontFamily: 'mu_bold', fontSize: getSize(context, 2.25)),
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: Text(
                                  totalAttendance.toStringAsFixed(0),
                                  style: TextStyle(fontFamily: 'mu_bold', fontSize: getSize(context, 2.5)),
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: Text(
                                  totalPresent.toStringAsFixed(0),
                                  style: TextStyle(fontFamily: 'mu_bold', fontSize: getSize(context, 2.5)),
                                ),
                              ),
                            ),
                          ]),
                        )
                  ),
                ),
              ):Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No attendance data found', style: TextStyle(fontFamily: "mu_reg",fontSize: getSize(context, 2))),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: (){
                        fetchAttendance();
                        fetchTodayAttendance();
                      },
                      child: Container(
                        width: getWidth(context, 0.2),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.autorenew_rounded,weight: 10,color: Colors.white,),
                            ),
                            Text('Re-Try',style: TextStyle(color:Colors.white,fontFamily: "mu_",fontSize: getSize(context, 2))),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: muColor, // Button color
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
