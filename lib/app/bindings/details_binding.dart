import 'package:get/get.dart';
import 'package:getx/app/controller/details/details_controller.dart';
import 'package:getx/app/data/provider/api.dart';
import 'package:getx/app/data/repository/posts_repository.dart';
import 'package:http/http.dart' as http;

class DetailsBinding implements Bindings{
  @override
  void dependencies() {
    // Get.lazyPut<DetailsController>(() {
      // return DetailsController(
          // repository:
              // MyRepository(apiClient: MyApiClient(httpClient: http.Client())));
    // });
  }

}