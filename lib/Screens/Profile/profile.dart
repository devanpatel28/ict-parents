import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ict_mu_parents/Model/user_data_model.dart';
import 'package:ict_mu_parents/Widgets/titled_container.dart';
import '../../Helper/Colors.dart';
import '../../Helper/Components.dart';
import '../../Helper/images_path.dart';
import '../../Helper/size.dart';
import '../../Network/API.dart';
import '../../Widgets/detail_with_heading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData userData = Get.arguments;
  onLogout() {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.question,
        sizeSuccessIcon: 70,
        showCancelBtn: true,
        confirmButtonText: "Yes",
        confirmButtonColor: muColor,
        cancelButtonColor: Colors.redAccent,
        cancelButtonText: "No",
        onConfirm: () async {
          final box = GetStorage();
          await CachedNetworkImage.evictFromCache(studentImageAPI(userData.studentDetails!.studentId));
          await box.write('loggedin', false);
          await box.write('userdata', null);
          Get.offNamed('/login');
        },
        title: "Are you sure to Logout?",
        dialogDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: backgroundColor),
              onPressed: () => Get.back()),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => onLogout(),
                child: Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(borderRad)),
                    child: Center(
                        child: Text(
                      "Logout",
                      style: TextStyle(
                          color: backgroundColor, fontWeight: FontWeight.bold),
                    ))),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: getHeight(context, 0.2),
                    width: getWidth(context, 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRad),
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(MuMainBuilding),
                            opacity: 0.3,
                            fit: BoxFit.cover)),
                    child: Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: muGrey2,
                            border: Border.all(
                                color: muGrey2,
                                width: 2,
                                strokeAlign: BorderSide.strokeAlignOutside)),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                          imageUrl: studentImageAPI(userData.studentDetails!.grNo),
                          placeholder: (context, url) => HugeIcon(
                            icon: HugeIcons.strokeRoundedUser,
                            color: muColor,
                            size: 40,
                          ),
                          errorWidget: (context, url, error) => HugeIcon(
                            icon: HugeIcons.strokeRoundedUser,
                            color: muColor,
                            size: 40,
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                DetailWithHeading(
                    HeadingName: "Student Name",
                    Details: "${userData.studentDetails!.firstName} ${userData.studentDetails!.lastName}"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: DetailWithHeading(
                          HeadingName: "Sem-Class-Batch",
                          Details: "${userData.classDetails!.semester} - ${userData.classDetails!.className} - ${userData.classDetails!.batch!.toUpperCase()}"
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: DetailWithHeading(
                          HeadingName: "Academic Batch",
                        Details: "${userData.studentDetails!.batchStartYear} - ${userData.studentDetails!.batchEndYear.toString().substring(2)}",
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      child: DetailWithHeading(
                          HeadingName: "Enrollment No.",
                          Details: userData.studentDetails!.enrollmentNo
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: DetailWithHeading(
                          HeadingName: "GR No.",
                        Details: userData.studentDetails!.grNo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                DetailWithHeading(
                    HeadingName: "Student Mobile No.", Details: userData.studentDetails!.phone),
                const SizedBox(
                  height: 10,
                ),
                DetailWithHeading(
                    HeadingName: "Student Institute Email Id", Details: userData.studentDetails!.email),
            
                Divider(height: 30,color: muGrey2,thickness: 2,indent: 15,endIndent: 15,),
            
                DetailWithHeading(
                    HeadingName: "Parent Name",
                    Details: "${userData.parentDetails!.parentName} ${userData.studentDetails!.lastName}"),
                const SizedBox(
                  height: 10,
                ),
                DetailWithHeading(
                    HeadingName: "Parent Occupation",
                    Details: userData.parentDetails!.profession),
                const SizedBox(
                  height: 10,
                ),
                DetailWithHeading(
                    HeadingName: "Parent Mobile No.",
                    Details: userData.parentDetails!.phone),
                const SizedBox(
                  height: 10,
                ),
                DetailWithHeading(
                    HeadingName: "Parent Email Id",
                    Details: userData.parentDetails!.email),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => Get.toNamed("/changePassword",arguments: userData),
                  child: Container(
                    height: getHeight(context, 0.06),
                    decoration: BoxDecoration(
                        color: muGrey,
                        border: Border.all(color: muGrey2),
                        borderRadius: BorderRadius.circular(borderRad)),
                    child: Center(child: Text("Change Password",style: TextStyle(color: muColor,fontSize: 20),)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
