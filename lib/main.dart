import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ict_mu_parents/DashboardScreen.dart';
import 'package:ict_mu_parents/ForgotPasswordScreen.dart';
import 'package:ict_mu_parents/LoginScreen.dart';
import 'package:ict_mu_parents/PlacementScreen.dart';
import 'package:ict_mu_parents/SplashScreen.dart';
import 'package:ict_mu_parents/StudentAttendanceScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
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
            page: () => const StudentAttendanceScreen()
        ),
      ],
      initialRoute:"/splashscreen",
    );
  }
}
