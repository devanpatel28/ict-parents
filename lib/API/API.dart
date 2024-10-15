String Host = "https://e278-2409-40c1-302b-b113-5995-cad3-4130-89b7.ngrok-free.app";
// String Host = "http://localhost";

String validateLoginAPI = '$Host/icttest/api.php/LoginParent';
String totalAttendanceAPI = '$Host/icttest/api.php/TotalAttendance';
String attendanceByDateAPI = '$Host/icttest/api.php/AttendanceByDate';

String studentImageAPI(gr){
  String api = "https://student.marwadiuniversity.ac.in:553/handler/getImage.ashx?SID=$gr";
  return api;
}

String facultyImageAPI(f_id){
  String api = "https://marwadieducation.edu.in/MEFOnline/handler/getImage.ashx?Id=$f_id";
  return api;
}