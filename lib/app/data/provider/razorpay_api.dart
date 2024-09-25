
import 'package:get/get.dart';
import 'package:getx/app/data/constants/errors.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/request_response.dart';

import '../../controller/authentication/authentication.dart';
import '../../controller/networking/networking.dart';
import '../constants/request_paths.dart';
import '../model/event.dart';
import '../model/user.dart';

class RazorpayAPIProvider {
  late Authentication auth;
  late Networking networking;

  RazorpayAPIProvider(){
    auth = Get.find<Authentication>();
    networking = Get.find<Networking>();
  }


  Future<APIResponse> createOrder(Map<String,dynamic> order) async {
    RequestResponse res = await networking.post(RequestPaths.RZP_CREATE_ORDER,data:order);
    try{
      if(res.status == TextMessages.SUCCESS)
      {
        String otpId = res.data as String;
        return Future.value(APIResponse.fromSuccess(hasData: true,data:otpId));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }


}
