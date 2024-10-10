import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../API/API.dart';
import '../Model/AttendanceByDateModel.dart';
import '../Model/TotalAttendanceModel.dart';

class AttendanceController extends GetxController {
  Future<List<TotalAttendance>?> totalAttendance(int sid) async {
    try {
      Map<String, int> body = {'s_id': sid};

      final response = await http.post(
        Uri.parse(totalAttendanceAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        // Convert the response data into a list of TotalAttendance
        List<TotalAttendance> attendanceList = responseData
            .map((attendanceData) => TotalAttendance.fromJson(attendanceData))
            .toList();

        return attendanceList;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  Future<List<AttendanceByDate>?> attendanceByDate(int sid,String date) async {
    try {
      Map<String, dynamic> body = {
        's_id': sid,
        'date':date
      };

      final response = await http.post(
        Uri.parse(attendanceByDateAPI),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        // Convert the response data into a list of TotalAttendance
        List<AttendanceByDate> attendanceDataList = responseData
            .map((attendanceData) => AttendanceByDate.fromJson(attendanceData))
            .toList();

        return attendanceDataList;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
