String Host = "https://895b-119-160-199-91.ngrok-free.app";
// String Host = "http://localhost";
String Path = "/ict-server/api.php";

String validateLoginAPI = '$Host$Path/LoginParent';
String totalAttendanceAPI = '$Host$Path/TotalAttendance';
String attendanceByDateAPI = '$Host$Path/AttendanceByDate';

String studentImageAPI(gr){
  String api = "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(f_id){
  String api = "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$f_id";
  return api;
}