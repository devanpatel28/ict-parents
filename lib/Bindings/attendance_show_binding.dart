import 'package:get/get.dart';
import 'package:ict_mu_parents/Controllers/attendance_show_controller.dart';

class AttendanceShowBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AttendanceShowController());
  }
}