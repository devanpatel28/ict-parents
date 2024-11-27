String Host = "https://882a-2409-40c1-3015-16c4-3449-30c6-4cc2-9f1b.ngrok-free.app";
String Path = "/ict-server/api/index.php";

String CurrentVersion = "1.0";
String validApiKey = "your-secure-api-key";
String updateURL = 'https://devanpatel28.blogspot.com/';


String validateVersionAPI = '$Host$Path/AppVersion/check';
String validateLoginAPI = '$Host$Path/Parent/login';

String totalAttendanceAPI = '$Host$Path/Attendance/TotalAttendance';
String attendanceByDateAPI = '$Host$Path/Attendance/AttendanceByDate';

String facultyContactAPI = '$Host$Path/Parent/getFacultyContact';

String studentImageAPI(gr){
  String api = "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(fId){
  String api = "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$fId";
  return api;
}