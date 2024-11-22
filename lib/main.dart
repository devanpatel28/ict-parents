
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ict_mu_parents/Bindings/attendance_show_binding.dart';
import 'package:ict_mu_parents/Screens/Authentication/forgot_password.dart';
import 'package:ict_mu_parents/Screens/Splash/main_splash.dart';
import 'Screens/Attendance/attendance_show.dart';
import 'Screens/Home/dashboard_home.dart';
import 'Screens/Authentication/login.dart';
import 'Screens/PlacementScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: "/splashscreen",
            transition: Transition.fadeIn,
            page: () => SplashScreen()
        ),
        GetPage(
            name: "/login",
            transition: Transition.fadeIn,
            page: () => const LoginScreen()
        ),
        GetPage(
            name: "/forgotPass",
            transition: Transition.fadeIn,
            page: () => const ForgotPasswordScreen()
        ),
        GetPage(
            name: "/dashboard",
            transition: Transition.fadeIn,
            page: () => const DashboardScreen()
        ),
        GetPage(
            name: "/placement",
            transition: Transition.fadeIn,
            page: () => const PlacementScreen()
        ),
        GetPage(
            name: "/attendance",
            transition: Transition.fadeIn,
            binding: AttendanceShowBinding(),
            page: () => const StudentAttendanceScreen()
        ),
      ],
      initialRoute:"/splashscreen",
    );
  }
}
