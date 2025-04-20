import 'package:get/get.dart';
import '../Controllers/internet_connectivity.dart';
import '../Controllers/leave_controller.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetConnectivityController());
    Get.put(LeaveController());
  }
}
