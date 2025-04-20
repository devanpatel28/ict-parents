import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Helper/Utils.dart';
import '../Model/leave_model.dart';
import '../Network/API.dart';
import '../Screens/PDF/pdf_viewer_screen.dart';
import 'internet_connectivity.dart';

class LeaveController extends GetxController {
  final internetController = Get.find<InternetConnectivityController>();
  RxList<LeaveModel> leaveHistory = <LeaveModel>[].obs;
  final TextEditingController reasonController = TextEditingController(); // Add this
  int studentId = Get.arguments['student_id'];
  RxBool isLoadingLeaveHistory = true.obs;
  RxString selectedFilePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaveHistory(studentId: studentId);
  }

  void viewPDF(String documentPath) {
    Get.to(() => PDFViewerScreen(documentPath: documentPath));
  }

  Future<void> fetchLeaveHistory({required int studentId}) async {
    isLoadingLeaveHistory.value = true;
    await internetController.checkConnection();
    if (!internetController.isConnected.value) {
      isLoadingLeaveHistory.value = false;
      Utils().showInternetAlert(
        context: Get.context!,
        onConfirm: () => fetchLeaveHistory(studentId: studentId),
      );
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            '$leaveHistoryAPI/getLeaveHistory?student_info_id=$studentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': validApiKey,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status']) {
          leaveHistory.assignAll(
            (responseData['data'] as List).map((data) =>
                LeaveModel.fromJson(data)).toList(),
          );
        } else {
          Get.snackbar(
              "No Data", responseData['message'], backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Failed to fetch leave history: ${response.body}",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to get leave history: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoadingLeaveHistory.value = false;
    }
  }
}