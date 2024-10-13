String Host = "https://255d-2409-40c1-3018-9397-45e6-321b-61ba-8142.ngrok-free.app";
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