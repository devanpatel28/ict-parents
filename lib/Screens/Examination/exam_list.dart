import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_mu_parents/Controllers/exam_list_controller.dart';
import 'package:ict_mu_parents/Model/exam_list_model.dart';
import 'package:ict_mu_parents/Widgets/exam_detail_card.dart';
import '../../Helper/Colors.dart';
import '../../Widgets/adaptive_refresh_indicator.dart';
import '../Exception/data_not_found.dart';
import '../Loading/adaptive_loading_screen.dart';

class ExamList extends GetView<ExamListController> {
  const ExamList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Examination and Results"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: backgroundColor),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
            () => controller.isLoadingExamList.value
            ? const AdaptiveLoadingScreen()
            : AdaptiveRefreshIndicator(
          onRefresh: () =>
              controller.fetchExamList(sid: controller.studentId),
          child: controller.examDataList.isNotEmpty
              ? ListView.builder(
            shrinkWrap: true,
            itemCount: controller.examDataList.length,
            itemBuilder: (context, index) {
              ExamListModel exam =
              controller.examDataList[index];
              return Expanded(
                child: ExamDetailCard(
                    subjectShortName: exam.subjectShortname,
                    subjectName: exam.subjectName,
                    examDate: exam.examDate,
                    examType: exam.examType,
                    examResultStatus: exam.examResultStatus,
                    totalMarks: exam.totalMarks,
                    obtainMarks: exam.obtainMarks,
                    grade: exam.grade
                ),
              );
            },
          )
              : const DataNotFound(),
        ),
      ),
    );
  }
}
