import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ict_mu_parents/Controllers/zoom_link_controller.dart';
import 'package:ict_mu_parents/Model/zoom_link_model.dart';
import 'package:ict_mu_parents/Widgets/meeting_card.dart';

import '../../Helper/Colors.dart';
import '../../Widgets/adaptive_refresh_indicator.dart';
import '../Exception/data_not_found.dart';
import '../Loading/adaptive_loading_screen.dart';

class ZoomLink extends GetView<ZoomLinkController> {
  const ZoomLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meeting"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: backgroundColor),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body:Obx(
            () => controller.isLoadingZoomLinkList.value
            ? const AdaptiveLoadingScreen()
            : AdaptiveRefreshIndicator(
          onRefresh: () =>
              controller.fetchZoomLinkList(sid: controller.studentId),
          child: controller.zoomLinkList.isNotEmpty
              ? ListView.builder(
            shrinkWrap: true,
            itemCount: controller.zoomLinkList.length,
            itemBuilder: (context, index) {
              ZoomLinkModel zoom =
              controller.zoomLinkList[index];
              return Expanded(
                child:MeetingCard(
                    meetingLink: zoom.zoomLink,
                    meetingDate: zoom.zoomDate,
                    meetingTime: zoom.zoomTime,
                    meetingTitle: zoom.zoomTitle,
                    facultyName: zoom.facultyName)
              );
            },
          )
              : const DataNotFound(),
        ),
      ),
    );
  }
}
