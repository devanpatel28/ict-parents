import 'package:get/get.dart';
import '../Controllers/internet_connectivity.dart';
import '../Controllers/placement_controller.dart';

class PlacementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetConnectivityController());
    Get.put(PlacementController());
  }
}
