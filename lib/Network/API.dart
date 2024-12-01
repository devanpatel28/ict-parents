String host =
    "https://d6bf-2409-40c1-3014-f0c6-a50e-deb2-1d74-4126.ngrok-free.app";
String serverPath = "/ict-server/api/index.php";

String currentVersion = "1.0";
String validApiKey = "your-secure-api-key";
String updateURL = 'https://devanpatel28.blogspot.com/';

String updatePasswordAPI = '$host$serverPath/Password/updatePassword';

String validateVersionAPI = '$host$serverPath/AppVersion/check';
String validateLoginAPI = '$host$serverPath/Parent/login';

String totalAttendanceAPI = '$host$serverPath/Attendance/TotalAttendance';
String attendanceByDateAPI = '$host$serverPath/Attendance/AttendanceByDate';

String facultyContactAPI = '$host$serverPath/Parent/getFacultyContact';
String timetableAPI = '$host$serverPath/Parent/getStudentTimetable';

String studentImageAPI(gr) {
  String api =
      "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(fId) {
  String api =
      "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$fId";
  return api;
}
