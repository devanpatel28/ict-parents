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
  _StudentAttendanceScreenState createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen>
    with SingleTickerProviderStateMixin {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
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
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchAttendance() async {
    setState(() {
      isLoadingTotal = true;
    });
    int studentId = Get.arguments['student_id'];
    List<TotalAttendance>? fetchedAttendanceList =
        await attendanceController.totalAttendance(studentId);
    if (!mounted) return;
    setState(() {
      if (fetchedAttendanceList != null) {
        attendanceList = fetchedAttendanceList;
      }
      isLoadingTotal = false;
    });
  }

  Future<void> fetchTodayAttendance() async {
    setState(() {
      isLoadingToday = true;
    });
    int studentId = Get.arguments['student_id'];
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("DATE=$todayDate");
    List<AttendanceByDate>? fetchedTodayAttendanceList =
        await attendanceController.attendanceByDate(studentId, todayDate);
    if (!mounted) return;
    setState(() {
      if (fetchedTodayAttendanceList != null) {
        todayAttendanceList = fetchedTodayAttendanceList;
      }
      isLoadingToday = false;
    });
  }

  Future<void> _refreshData() async {
    await fetchAttendance();
    await fetchTodayAttendance();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total attendance and present lectures
    double totalAttendance = 0;
    double totalPresent = 0;
    double totalLecL = 0;
    double attendLecL = 0;
    double totalLecT = 0;
    double attendLecT = 0;

    if (attendanceList != null) {
      for (var attendance in attendanceList!) {
        totalAttendance += attendance.totalLec;
        totalPresent += attendance.attendLec;
      }
    }

    List<TableRow> _buildMergedTableRows() {
      Map<String, List<TotalAttendance>> groupedAttendance = {};

      // Group attendance by subjectShortName
      for (var attendance in attendanceList!) {
        if (!groupedAttendance.containsKey(attendance.subjectShortName)) {
          groupedAttendance[attendance.subjectShortName] = [];
        }
        groupedAttendance[attendance.subjectShortName]!.add(attendance);
      }

      List<TableRow> rows = [];

      groupedAttendance.forEach((subject, attendances) {
        for (int i = 0; i < attendances.length; i++) {
          var attendance = attendances[i];

          // Add to the total and attended lectures based on lecture type (L/T)
          if (attendance.lec_type == 'L') {
            totalLecL += attendance.totalLec;
            attendLecL += attendance.attendLec;
          } else if (attendance.lec_type == 'T') {
            totalLecT += attendance.totalLec;
            attendLecT += attendance.attendLec;
          }

          // Calculate percentage, handle zero to avoid NaN
          double percentage = 0.0;
          if (attendance.totalLec != 0) {
            percentage = (attendance.attendLec / attendance.totalLec) * 100;
          }

          rows.add(
            TableRow(
              children: [
                // Merge subjectShortName cells if subject is same as the previous row
                i == 0
                    ? Tooltip(
                  preferBelow: false,
                  message: attendance.subjectName,
                        child: TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                attendance.subjectShortName,
                                style: TextStyle(
                                  fontFamily: 'mu_bold',
                                  fontSize: getSize(context, 2),
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ),
                      )
                    : TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child:
                            Container(), // Empty cell to visually merge the rows
                      ),
                // Lec type
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Center(
                    child: Text(
                      attendance.lec_type,
                      style: TextStyle(
                          fontFamily: 'mu_reg', fontSize: getSize(context, 2)),
                    ),
                  ),
                ),
                // Total lectures
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Center(
                    child: Text(
                      attendance.totalLec.toString(),
                      style: TextStyle(
                          fontFamily: 'mu_reg',
                          fontSize: getSize(context, 2.5)),
                    ),
                  ),
                ),
                // Present lectures
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Center(
                    child: Text(
                      attendance.attendLec.toString(),
                      style: TextStyle(
                          fontFamily: 'mu_reg',
                          fontSize: getSize(context, 2.5)),
                    ),
                  ),
                ),
                // Percentage (handle NaN and format)
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Center(
                    child: Text(
                      percentage == 0.0
                          ? "0" // Display 0 instead of NaN
                          : percentage.toStringAsFixed(
                              0), // Remove decimals if it's a whole number
                      style: TextStyle(
                          fontFamily: 'mu_reg',
                          fontSize: getSize(context, 2.5)),
                    ),
                  ),
                ),
              ],
              decoration: BoxDecoration(
                border: i > 0 &&
                        attendances[i - 1].subjectShortName ==
                            attendance.subjectShortName
                    ? Border(
                        // Remove border between same subject rows
                        top: BorderSide.none,
                        bottom: BorderSide.none,
                        left: BorderSide.none,
                        right: BorderSide.none,
                      )
                    : Border(
                        top: BorderSide(),
                      ),
              ),
            ),
          );
        }
      });

      // Add final total row
      rows.add(
        TableRow(
          decoration: BoxDecoration(border: Border(top: BorderSide())),
          children: [
            TableCell(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Total',
                    style: TextStyle(
                        fontFamily: 'mu_bold',
                        fontSize: getSize(context, 2.25)),
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  "L",
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2)),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  totalLecL.toStringAsFixed(0),
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  attendLecL.toStringAsFixed(0),
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  totalLecL != 0
                      ? ((attendLecL / totalLecL) * 100).toStringAsFixed(0)
                      : "0", // Avoid division by zero
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                ),
              ),
            ),
          ],
        ),
      );

      rows.add(
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  "",
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  "T",
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2)),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  totalLecT.toStringAsFixed(0),
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  attendLecT.toStringAsFixed(0),
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(
                  totalLecT != 0
                      ? ((attendLecT / totalLecT) * 100).toStringAsFixed(0)
                      : "0", // Avoid division by zero
                  style: TextStyle(
                      fontFamily: 'mu_reg', fontSize: getSize(context, 2.5)),
                ),
              ),
            ),
          ],
        ),
      );

      rows.add(
        TableRow(
          decoration: BoxDecoration(
              color: muColor50.withOpacity(0.5),
              border: Border(top: BorderSide())),
          children: [
            TableCell(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Final Total',
                    style: TextStyle(
                      fontFamily: 'mu_bold',
                      fontSize: getSize(context, 2.25),
                    ),
                  ),
                ),
              ),
            ),
            TableCell(child: Container()), // Empty cell for lec_type
            TableCell(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    totalAttendance.toStringAsFixed(0),
                    style: TextStyle(
                        fontFamily: 'mu_bold', fontSize: getSize(context, 2.5)),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    totalPresent.toStringAsFixed(0),
                    style: TextStyle(
                        fontFamily: 'mu_bold', fontSize: getSize(context, 2.5)),
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                color: muColor,
                child: Padding(
                  padding: EdgeInsets.all(getSize(context, 0.6)),
                  child: Center(
                    child: Text("${totalAttendance != 0
                        ? ((totalPresent / totalAttendance) * 100)
                        .toStringAsFixed(0)
                        : "0"}%", // Avoid division by zero
                      style: TextStyle(
                          fontFamily: 'mu_bold',color: Colors.white
                          , fontSize: getSize(context, 3)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      return rows;
    }

    double avgAttendance =
        totalAttendance > 0 ? totalPresent / totalAttendance * 100 : 0;
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
          child: RefreshIndicator(
            backgroundColor: muColor,
            color: Colors.white,
            onRefresh: () => _refreshData(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceAround, // Space between icon and percentage
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
                                    color: Colors
                                        .red, // Text color for 'Till Yesterday'
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: getHeight(context, 0.08),
                        width: getWidth(context, 0.005),
                        color: muGrey2,
                      ),
                      RadialIndicator(context, avgAttendance),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Divider(),
                ),
                avgAttendance > 0 && avgAttendance < 75
                    ? Column(
                        children: [
                          AnimatedBuilder(
                            animation: _controller, // Listen to the animation
                            builder: (BuildContext context, Widget? child) {
                              return Opacity(
                                opacity: _controller
                                    .value, // Use the controller's value directly for opacity
                                child: Card(
                                  color: Colors.red,
                                  child: Container(
                                    width: double.infinity,
                                    height: getHeight(context, 0.07),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Students with attendance below 75% will not be allowed to appear for the examinations.",
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
                      )
                    : Container(),
                // Inside the build method, after your existing content
                Column(
                  children: [
                    Heading1(context,
                        "Today's Attendance  -  ( $formattedDate )", 2.5, 8),
                    isLoadingToday
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: muColor,
                              strokeWidth: 3,
                            ),
                          ))
                        : todayAttendanceList != null &&
                                todayAttendanceList!.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: todayAttendanceList!.length,
                                itemBuilder: (context, index) {
                                  AttendanceByDate attendance =
                                      todayAttendanceList![index];
                                  return AttendanceCard(
                                      context,
                                      attendance.subjectName,
                                      attendance.facultyName,
                                      attendance.startTime.substring(0, 5),
                                      attendance.endTime.substring(0, 5),
                                      attendance.status,
                                      attendance.lecType);
                                },
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('No attendance today',
                                      style: TextStyle(
                                          fontFamily: "mu_reg",
                                          fontSize: getSize(context, 2))),
                                ),
                              ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Divider(),
                ),
                Heading1(context, "Attendance Report", 2.5, 8),
                isLoadingTotal
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: muColor,
                          strokeWidth: 3,
                        ),
                      ))
                    : attendanceList != null && attendanceList!.isNotEmpty
                        ? Center(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Table(
                                    columnWidths: {
                                      0: FlexColumnWidth(
                                          getSize(context, 0.1)), // Subject
                                      1: FlexColumnWidth(
                                          getSize(context, 0.04)), // Lec Type
                                      2: FlexColumnWidth(
                                          getSize(context, 0.07)), // Total
                                      3: FlexColumnWidth(
                                          getSize(context, 0.08)), // Present
                                      4: FlexColumnWidth(
                                          getSize(context, 0.07)), // Present
                                    },
                                    border: TableBorder(
                                      verticalInside: BorderSide(),
                                    ),
                                    children: [
                                      // Table Heading
                                      TableRow(
                                        decoration: BoxDecoration(
                                            color:
                                                muColor), // Header background color
                                        children: [
                                          Center(
                                            child: TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Subject',
                                                  style: TextStyle(
                                                    fontFamily: 'mu_bold',
                                                    fontSize:
                                                        getSize(context, 2.25),
                                                    color: Colors
                                                        .white, // Set text color to black
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(''),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Total',
                                                  style: TextStyle(
                                                    fontFamily: 'mu_bold',
                                                    fontSize:
                                                        getSize(context, 2.25),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Present',
                                                  style: TextStyle(
                                                    fontFamily: 'mu_bold',
                                                    fontSize:
                                                        getSize(context, 2.25),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  '%',
                                                  style: TextStyle(
                                                    fontFamily: 'mu_bold',
                                                    fontSize:
                                                        getSize(context, 2.25),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Table Rows with merged subjectShortName and custom border handling
                                      ..._buildMergedTableRows(),
                                    ],
                                  ),
                                )),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No attendance data found',
                                    style: TextStyle(
                                        fontFamily: "mu_reg",
                                        fontSize: getSize(context, 2))),
                              ],
                            ),
                          ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Divider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
