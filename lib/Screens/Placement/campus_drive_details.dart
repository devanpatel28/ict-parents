import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Controllers/campus_drive_controller.dart';
import '../../Helper/Components.dart';
import '../../Helper/Style.dart';
import '../../Helper/colors.dart';
import '../../Helper/size.dart';
import '../../Model/campus_drive_model.dart';
import '../../Widgets/clickable_text.dart';
import '../../Widgets/placement_details_card.dart';
import '../Loading/campus_drive_update_loading.dart';

class CampusDriveDetailScreen extends GetView<CampusDriveController> {
  const CampusDriveDetailScreen({super.key});
  Widget build(BuildContext context) {

    CampusDriveModel campusDrive = Get.arguments['drive'];

    Future<void> _launchUrl(String? url, {bool isLinkedIn = false}) async {
      if (url == null || url.isEmpty) return;

      final Uri uri = Uri.parse(url);
      if (isLinkedIn) {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      } else {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } else {
          Get.snackbar("Error", "Could not launch $url");
        }
      }
    }

    String DateAndTime()
    {
      if(campusDrive.campusDriveDate.isNotEmpty && campusDrive.campusDriveTime.isNotEmpty){
        return "${DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(campusDrive.campusDriveDate))} - ${DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(campusDrive.campusDriveTime))}";
      }
      else
      {
        return "Will be declared";
      }
    }

    Widget statusShow(){
      return campusDrive.campusDriveStatus=="pending"?
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: muGrey,
          border: Border.all(color: muGrey2),
          borderRadius: BorderRadius.circular(borderRad),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,10,0),
                    child: HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkCircle02, color: Colors.yellow),
                  ),
                  Flexible(child: Text("Student have pending to appyly.",style: TextStyle(fontSize: 16,color: Colors.yellow,fontWeight: FontWeight.bold),textAlign:TextAlign.center)),
                ],
              ),
            ),
          ],
        ),
      ):
      campusDrive.campusDriveStatus=="yes"?
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: muGrey,
          border: Border.all(color: muGrey2),
          borderRadius: BorderRadius.circular(borderRad),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,10,0),
                    child: HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkCircle02, color: Colors.green),
                  ),
                  Flexible(child: Text("Student have already applied.",style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),textAlign:TextAlign.center)),
                ],
              ),
            ),
          ],
        ),
      ):
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: muGrey,
          border: Border.all(color: muGrey2),
          borderRadius: BorderRadius.circular(borderRad),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,10,0),
                    child: HugeIcon(icon: HugeIcons.strokeRoundedCancelCircle, color: Colors.red),
                  ),
                  Flexible(child: Text("Student were not interested to apply.",style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),textAlign:TextAlign.center)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Campus Drive Details",
          style: appbarStyle(context),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: backgroundColor),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      campusDrive.campusDriveCompanyName,
                      style: TextStyle(
                        fontFamily: "mu_bold",
                        fontSize: getSize(context, 2.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Divider(color: muGrey2, indent: 10, endIndent: 10),
                  ),


                  statusShow(),

                  const SizedBox(height: 10),

                  PlacementDetailsCard(
                    headingName: "Date & Time",
                    details: DateAndTime(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PlacementDetailsCard(
                          headingName: "Work Location",
                          details: campusDrive.campusDriveLocation,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: PlacementDetailsCard(
                          headingName: "Company Type",
                          details: campusDrive.campusDriveCompanyType ?? "No Company",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PlacementDetailsCard(
                          headingName: "Job Profile",
                          details: campusDrive.campusDriveJobProfile,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: PlacementDetailsCard(
                          headingName: "Package",
                          details: campusDrive.campusDrivePackage,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  PlacementDetailsCardWidgets(
                    headingName: 'Selection Progress',
                    child: ListView.builder(
                      itemCount: campusDrive.rounds.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        RoundsModel round = campusDrive.rounds[index];
                        return Text(
                          '${round.roundIndex} - ${round.roundName} (${round.mode})',
                          style: TextStyle(fontSize: 16),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  PlacementDetailsCardWidgets(
                    headingName: 'Other Info',
                    child: ClickableText(campusDrive.campusDriveOtherInfo),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        label: Text("Website",style: TextStyle(color: Colors.white,fontSize: 16),),
                        onPressed: campusDrive.campusDriveCompanyWebsite
                            .isEmpty
                            ? null
                            : () => _launchUrl(
                            campusDrive.campusDriveCompanyWebsite),
                        icon: HugeIcon(
                          icon: HugeIcons
                              .strokeRoundedLink02,
                          color: campusDrive.campusDriveCompanyWebsite
                              .isEmpty
                              ? Colors.grey
                              : Colors.white,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: campusDrive.campusDriveCompanyWebsite.isEmpty
                              ? Colors.grey
                              : Colors.lightGreen,
                          disabledBackgroundColor:
                          Colors.grey,
                        ),

                      ),
                      const SizedBox(width: 5),
                      ElevatedButton.icon(
                        label: Text("LinkedIn",style: TextStyle(color: Colors.white,fontSize: 16),),
                        onPressed: campusDrive.campusDriveCompanyLinkedin
                            .isEmpty
                            ? null
                            : () => _launchUrl(
                            campusDrive.campusDriveCompanyLinkedin,
                            isLinkedIn: true),
                        icon: HugeIcon(
                          icon: HugeIcons
                              .strokeRoundedLinkedin01,
                          color: campusDrive.campusDriveCompanyLinkedin
                              .isEmpty
                              ? Colors.white54
                              : Colors.white,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: campusDrive.campusDriveCompanyLinkedin.isEmpty
                              ? Colors.grey
                              : LinkedinColor,
                          disabledBackgroundColor:
                          Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),

                    ],
                  ),
                ],
              ),
            ),
          ),
          controller.isLoadingStatusUpdate.value?const CampusDriveUpdateLoading():Container(),
        ],
      ),

    );
  }
}
