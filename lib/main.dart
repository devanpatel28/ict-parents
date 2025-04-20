import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ict_mu_parents/Bindings/attendance_show_binding.dart';
import 'package:ict_mu_parents/Bindings/faculty_contact_binding.dart';
import 'package:ict_mu_parents/Bindings/holiday_list_binding.dart';
import 'package:ict_mu_parents/Bindings/profile_binding.dart';
import 'package:ict_mu_parents/Firebase/firebase_messaging_service.dart';
import 'package:ict_mu_parents/Preference/preference_manager.dart';
import 'package:ict_mu_parents/Screens/Authentication/forgot_password.dart';
import 'package:ict_mu_parents/Screens/Holiday/holiday_list.dart';
import 'package:ict_mu_parents/Screens/Placement/placements.dart';
import 'package:ict_mu_parents/Screens/Splash/main_splash.dart';
import 'package:ict_mu_parents/Screens/Timetable/timetable.dart';
import 'package:ict_mu_parents/Screens/ZoomLink/zoom_link.dart';
import 'Bindings/campus_drive_bindings.dart';
import 'Bindings/change_password_binding.dart';
import 'Bindings/event_binding.dart';
import 'Bindings/exam_list_binding.dart';
import 'Bindings/leave_binding.dart';
import 'Bindings/placement_binding.dart';
import 'Bindings/student_rounds_binding.dart';
import 'Bindings/timetable_binding.dart';
import 'Bindings/zoom_link_binding.dart';
import 'Helper/colors.dart';
import 'Screens/Attendance/attendance_show.dart';
import 'Screens/Authentication/change_password.dart';
import 'Screens/Events/event.dart';
import 'Screens/Events/event_details.dart';
import 'Screens/Examination/exam_list.dart';
import 'Screens/Faculty/faculty_contact.dart';
import 'Screens/Home/dashboard_home.dart';
import 'Screens/Authentication/login.dart';
import 'Screens/Leave/leaves.dart';
import 'Screens/Placement/campus_drive.dart';
import 'Screens/Placement/campus_drive_details.dart';
import 'Screens/Placement/students_rounds.dart';
import 'Screens/Profile/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //For Local Storage
  await SharedPrefs().init();

  //Firebase notification config
  await configureFirebasePushNotifications();

  // Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(cursorColor: muColor,selectionColor: muColor50,selectionHandleColor: muColor),
        colorScheme: ColorScheme.light(primary: muColor,),
        fontFamily: "mu_reg",
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: muColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontFamily: "mu_reg", color: backgroundColor, fontSize: 20),
        ),
      ),
      getPages: [
        GetPage(
            name: "/splashscreen",
            transition: Transition.fadeIn,
            page: () => const SplashScreen()),
        GetPage(
            name: "/login",
            transition: Transition.fadeIn,
            page: () => const LoginScreen()),
        GetPage(
            name: "/forgotPass",
            transition: Transition.fadeIn,
            page: () => const ForgotPasswordScreen()),
        GetPage(
            name: "/dashboard",
            transition: Transition.fadeIn,
            page: () => const DashboardScreen()),
        GetPage(
            name: "/placement",
            transition: Transition.fadeIn,
            page: () => const PlacementScreen()),
        GetPage(
            name: "/attendance",
            transition: Transition.fadeIn,
            binding: AttendanceShowBinding(),
            page: () => const StudentAttendanceScreen()),
        GetPage(
            name: "/faculty_contact",
            transition: Transition.fadeIn,
            binding: FacultyContactBinding(),
            page: () => const FacultyContactScreen()),
        GetPage(
            name: "/profile",
            transition: Transition.fadeIn,
            binding: ProfileBinding(),
            page: () => const ProfilePage()),
        GetPage(
            name: "/changePassword",
            transition: Transition.fadeIn,
            binding: ChangePasswordBinding(),
            page: () => const ChangePasswordScreen()),
        GetPage(
            name: "/studentTimetable",
            transition: Transition.fadeIn,
            binding: TimetableBinding(),
            page: () => const TimetableScreen()),
        GetPage(
            name: "/examList",
            transition: Transition.fadeIn,
            binding: ExamListBinding(),
            page: () => const ExamList()),
        GetPage(
            name: "/holidayList",
            transition: Transition.fadeIn,
            binding: HolidayListBinding(),
            page: () => const HolidayList()),
        GetPage(
            name: "/meetingList",
            transition: Transition.fadeIn,
            binding: ZoomLinkBinding(),
            page: () => const ZoomLink()),
        GetPage(
            name: "/placements",
            transition: Transition.fadeIn,
            binding: PlacementBinding(),
            page: () => const PlacementScreen()),
        GetPage(
            name: "/campusDriveList",
            transition: Transition.fadeIn,
            binding: CampusDriveBindings(),
            page: () => const CampusDriveScreen()),
        GetPage(
            name: "/campusDriveDetail",
            transition: Transition.fadeIn,
            binding: CampusDriveBindings(),
            page: () => const CampusDriveDetailScreen()),
        GetPage(
            name: "/leave",
            transition: Transition.fadeIn,
            binding: LeaveBinding(),
            page: () => const LeaveScreen()),
        GetPage(
            name: "/studentRoundsDetail",
            transition: Transition.fadeIn,
            binding: StudentRoundsBinding(),
            page: () => const StudentRoundsScreen()),
        GetPage(
            name: "/events",
            transition: Transition.fadeIn,
            binding: EventBinding(),
            page: () => const EventList()),
        GetPage(
            name: "/eventDetails",
            transition: Transition.fadeIn,
            binding: EventBinding(),
            page: () => const EventDetails()),
      ],
      initialRoute: "/splashscreen",
    );
  }
}
