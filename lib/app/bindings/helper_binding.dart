import 'package:get/get.dart';
import '../controller/helper_controller.dart';

class HelperBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelperController>(() {return HelperController(); });
  }
}