class ExamListModel {
  String examType;
  String examDate;
  String subjectName;
  String subjectShortname;

  ExamListModel({
    required this.examType,
    required this.examDate,
    required this.subjectName,
    required this.subjectShortname
  });

  factory ExamListModel.fromJson(Map<String, dynamic> json) {
    return ExamListModel(
        examType :json['exam_type'],
        examDate: json['exam_date'],
        subjectName :json['subject_name'],
        subjectShortname :json['short_name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_type': examType,
      'exam_date': examDate,
      'subject_name': subjectName,
      'short_name': subjectShortname
    };
  }
}