String Host = "https://882a-2409-40c1-3015-16c4-3449-30c6-4cc2-9f1b.ngrok-free.app";
String serverPath = "/ict-server/api/index.php";

String CurrentVersion = "1.0";
String validApiKey = "your-secure-api-key";
String updateURL = 'https://devanpatel28.blogspot.com/';

String updatePasswordAPI = '$Host$serverPath/Password/updatePassword';

String validateVersionAPI = '$Host$serverPath/AppVersion/check';
String validateLoginAPI = '$Host$serverPath/Parent/login';

String totalAttendanceAPI = '$Host$serverPath/Attendance/TotalAttendance';
String attendanceByDateAPI = '$Host$serverPath/Attendance/AttendanceByDate';

String facultyContactAPI = '$Host$serverPath/Parent/getFacultyContact';

String studentImageAPI(gr){
  String api = "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(fId){
  String api = "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$fId";
  return api;
}