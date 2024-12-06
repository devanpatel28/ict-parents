import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ict_mu_parents/Model/holiday_list_model.dart';
import '../Helper/Utils.dart';
import '../Network/API.dart';
import 'internet_connectivity.dart';

class HolidayListController extends GetxController {
  final internetController = Get.find<InternetConnectivityController>();
  RxList<HolidayListModel> holidayDataList = <HolidayListModel>[].obs;
  RxBool isLoadingHolidayList = true.obs;

  /// Make the ScrollController public
  final ScrollController scrollController = ScrollController();
  int? highlightedIndex;

  @override
  void onInit() {
    super.onInit();
    fetchHolidayList();
  }
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 500), () {
      scrollToUpcomingHoliday(holidayDataList);
    });
  }
  void scrollToUpcomingHoliday(List<HolidayListModel> holidays) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DateTime today = DateTime.now();
      for (int i = 0; i < holidays.length; i++) {
        DateTime holidayDate = DateFormat('yyyy-MM-dd').parse(holidays[i].holidayDate);
        if (holidayDate.isAfter(today)) {
          highlightedIndex = i;
          scrollController.animateTo(
            i * 100,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
          break;
        }
      }
    });
  }


  Future<void> fetchHolidayList() async {
    isLoadingHolidayList.value = true;
    await internetController.checkConnection();
    if (!internetController.isConnected.value) {
      isLoadingHolidayList.value = false;
      Utils().showInternetAlert(
        context: Get.context!,
        onConfirm: () => fetchHolidayList(),
      );
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(holidayListAPI),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': validApiKey,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as List<dynamic>;
        holidayDataList.assignAll(
          responseData.map((data) => HolidayListModel.fromJson(data)).toList(),
        );
        // After data is fetched, trigger scroll to upcoming holiday
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToUpcomingHoliday(holidayDataList);
        });
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
        "Error", "Failed to get holidays",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingHolidayList.value = false;
    }
  }

}
