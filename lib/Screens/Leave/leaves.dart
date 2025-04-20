import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import '../../Animations/slide_zoom_in_animation.dart';
import '../../Controllers/leave_controller.dart';
import '../../Helper/Components.dart';
import '../../Helper/Style.dart';
import '../../Helper/colors.dart';
import '../../Helper/size.dart';
import '../../Model/leave_model.dart';
import '../../Widgets/adaptive_refresh_indicator.dart';
import '../../Widgets/heading_1.dart';
import '../Loading/adaptive_loading_screen.dart';
import '../Loading/apply_leave_loading.dart';

class LeaveScreen extends GetView<LeaveController> {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    RxMap<int, bool> expandedReasons = <int, bool>{}.obs;

    String statusTagText(String? status) {
      return status ?? 'Pending';
    }

    Color statusTagBG(String? status) {
      switch (status) {
        case 'approved':
          return Colors.green;
        case 'declined':
          return Colors.red;
        case 'pending':
        default:
          return Colors.amber;
      }
    }
    void viewDocument(String documentPath) {
      // Implement PDF viewing logic here
      // For example, you could use a package like flutter_pdfview or open a URL
      controller.viewPDF(documentPath);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leave History",
          style: appbarStyle(context),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: backgroundColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
            () => controller.isLoadingLeaveHistory.value
            ? const AdaptiveLoadingScreen()
            : AdaptiveRefreshIndicator(
          onRefresh: () => controller.fetchLeaveHistory(studentId: controller.studentId),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.leaveHistory.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.leaveHistory.length,
                          itemBuilder: (context, index) {
                            LeaveModel leave = controller.leaveHistory[index];
                            String? dateStr;
                            String? timeStr;
                            if (leave.createdAt.isNotEmpty) {
                              DateTime dateTime = DateTime.parse(leave.createdAt);
                              dateStr = DateFormat('dd-MM-yyyy').format(dateTime);
                              timeStr = DateFormat('hh:mm a').format(dateTime);
                            }

                            return SlideZoomInAnimation(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: muGrey,
                                        borderRadius: BorderRadius.circular(borderRad),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Obx(
                                                () {
                                              bool isExpanded = expandedReasons[leave.id] ?? false;
                                              bool needsExpansion =
                                                  (leave.reason.length) > 50 || (leave.reason.contains('\n'));

                                              return GestureDetector(
                                                onTap: () {
                                                  if (needsExpansion) {
                                                    expandedReasons[leave.id] = !isExpanded;
                                                  }
                                                },
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    HugeIcon(
                                                      icon: HugeIcons.strokeRoundedAbacus,
                                                      color: muColor,
                                                    ),
                                                    const SizedBox(width: 7),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Reason: ${leave.reason}",
                                                            maxLines: isExpanded ? null : 1,
                                                            overflow: isExpanded ? null : TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              fontSize: getSize(context, 2),
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          if (needsExpansion)
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 2),
                                                              child: Text(
                                                                isExpanded ? "show less" : "show more...",
                                                                style: TextStyle(
                                                                  fontSize: getSize(context, 1.8),
                                                                  color: muColor,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  HugeIcon(
                                                    icon: HugeIcons.strokeRoundedCalendar03,
                                                    color: muColor,
                                                  ),
                                                  const SizedBox(width: 7),
                                                  Text(
                                                    dateStr!,
                                                    style: TextStyle(
                                                      fontSize: getSize(context, 2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 25),
                                              Row(
                                                children: [
                                                  HugeIcon(
                                                    icon: HugeIcons.strokeRoundedTime04,
                                                    color: muColor,
                                                  ),
                                                  const SizedBox(width: 7),
                                                  Text(
                                                    timeStr!,
                                                    style: TextStyle(
                                                      fontSize: getSize(context, 2),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          if (leave.documentProof.isNotEmpty) ...[
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () => viewDocument(leave.documentProof),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: muColor,
                                                    shape: ContinuousRectangleBorder(
                                                      borderRadius: BorderRadius.circular(borderRad + 10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "View Document",
                                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          const SizedBox(height: 5),
                                          if (leave.leaveStatus != 'pending' && leave.reply.isNotEmpty) ...[
                                            const SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: leave.leaveStatus == "approved" ? Colors.green[100] : Colors.red[100],
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  HugeIcon(
                                                    icon: HugeIcons.strokeRoundedComment01,
                                                    color: leave.leaveStatus == "approved" ? Colors.green : Colors.red,
                                                  ),
                                                  const SizedBox(width: 7),
                                                  Flexible(
                                                    child: Text(
                                                      leave.reply.trim(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: getSize(context, 2),
                                                        color: leave.leaveStatus == "approved" ? Colors.green : Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 100,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: statusTagBG(leave.leaveStatus),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            statusTagText(leave.leaveStatus),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: getSize(context, 1.8),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      else
                        Center(
                          child: Text(
                            "No leave history found",
                            style: TextStyle(
                              fontSize: getSize(context, 2),
                              color: muGrey2,
                            ),
                          ),
                        ),
                    ],
                  ),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}