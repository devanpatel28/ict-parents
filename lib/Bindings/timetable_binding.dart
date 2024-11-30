import 'package:get/get.dart';
import 'package:ict_mu_parents/Controllers/timetable_controller.dart';
import '../Controllers/internet_connectivity.dart';

class TimetableBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(InternetConnectivityController());
    Get.put(TimeTableController());
  }
}