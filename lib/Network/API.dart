String host = "https://trivially-active-bream.ngrok-free.app";
String serverPath = "/ict-server/api/index.php";

String currentVersion = "1.0";
String validApiKey = "your-secure-api-key";
String updateURL = 'https://devanpatel28.blogspot.com/';

String updatePasswordAPI = '$host$serverPath/Password/updatePassword';

String validateVersionAPI = '$host$serverPath/AppVersion/check';
String validateLoginAPI = '$host$serverPath/Parent/login';
String validateLogoutAPI = '$host$serverPath/Parent/logout';

String totalAttendanceAPI = '$host$serverPath/Attendance/TotalAttendance';
String attendanceByDateAPI = '$host$serverPath/Attendance/AttendanceByDate';

String facultyContactAPI = '$host$serverPath/Parent/getFacultyContact';
String timetableAPI = '$host$serverPath/Parent/getStudentTimetable';

String examListAPI = '$host$serverPath/Exam/getExamList';

String holidayListAPI = '$host$serverPath/Holiday/getAllHolidays';
String upcomingHolidayAPI = '$host$serverPath/Holiday/getNextUpcomingHoliday';

String zoomLinkListAPI = '$host$serverPath/ZoomLink/getUpcomingLinks';

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
