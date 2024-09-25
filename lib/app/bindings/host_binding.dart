import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/provider/api.dart';
import 'package:getx/app/data/repository/posts_repository.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HostController>(() {return HostController(); });
  }

}