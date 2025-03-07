import 'package:get/get.dart';
import 'package:ict_mu_parents/Controllers/logout_controller.dart';
import 'package:ict_mu_parents/Controllers/timetable_controller.dart';
import '../Controllers/internet_connectivity.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetConnectivityController());
    Get.put(LogoutController());
  }
}
