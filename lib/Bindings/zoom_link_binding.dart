import 'package:get/get.dart';
import 'package:ict_mu_parents/Controllers/zoom_link_controller.dart';
import '../Controllers/internet_connectivity.dart';

class ZoomLinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetConnectivityController());
    Get.put(ZoomLinkController());
  }
}
