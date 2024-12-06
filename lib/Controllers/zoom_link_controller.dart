import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ict_mu_parents/Model/zoom_link_model.dart';
import '../Helper/Utils.dart';
import '../Network/API.dart';
import 'internet_connectivity.dart';

class ZoomLinkController extends GetxController {
  final internetController = Get.find<InternetConnectivityController>();
  RxList<ZoomLinkModel> zoomLinkList = <ZoomLinkModel>[].obs;
  int studentId = Get.arguments['student_id'];
  RxBool isLoadingZoomLinkList = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchZoomLinkList(sid: studentId);
  }

  Future<void> fetchZoomLinkList({required int sid}) async {
    isLoadingZoomLinkList.value = true;
    await internetController.checkConnection();
    if (!internetController.isConnected.value) {
      isLoadingZoomLinkList.value = false;
      Utils().showInternetAlert(
        context: Get.context!,
        onConfirm: () => fetchZoomLinkList(sid: sid),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(zoomLinkListAPI),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': validApiKey,
        },
        body: json.encode({'s_id': sid}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as List<dynamic>;
        zoomLinkList.assignAll(
          responseData.map((data) => ZoomLinkModel.fromJson(data)).toList(),
        );
      } else {
        final message = json.decode(response.body)['message'] ?? 'An error occurred';
        Get.snackbar(
          "No data available",
          message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error","Failed to get meeting data",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingZoomLinkList.value = false;
    }
  }

}
