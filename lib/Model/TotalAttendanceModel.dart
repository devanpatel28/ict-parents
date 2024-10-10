class TotalAttendance {
  String subjectName;
  int totalLec;
  int attendLec;

  TotalAttendance({required this.subjectName, required this.totalLec, required this.attendLec});

  factory TotalAttendance.fromJson(Map<String, dynamic> json) {
    return TotalAttendance(
      subjectName: json['subject_name'],
      totalLec: json['total_lec'],
      attendLec: json['attend_lec'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_name': subjectName,
      'total_lec': totalLec,
      'attend_lec': attendLec,
    };
  }
}