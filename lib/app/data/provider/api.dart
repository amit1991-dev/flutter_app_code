import 'package:get/get.dart';
import 'package:getx/app/data/constants/errors.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/request_response.dart';

import '../../controller/authentication/authentication.dart';
import '../../controller/networking/networking.dart';
import '../constants/request_paths.dart';
import '../model/user.dart';

class APIProvider {
  late Authentication auth;
  late Networking networking;

  APIProvider(){
    auth = Get.find<Authentication>();
    networking = Get.find<Networking>();
  }

  Future<APIResponse> whoami() async {
    if(!auth.isLoggedIn.value)
      {
        return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
      }

   try{
     RequestResponse res = await networking.get(RequestPaths.WHOAMI);

     if(res.status == TextMessages.SUCCESS)
     {
       User user = User.fromJson(res.data as Map<String,dynamic>);
       return Future.value(APIResponse.fromSuccess(hasData: true,data:user));
     }
     else {
       return Future.value(APIResponse.fromFailed(info:res.message));
     }
   }
   catch(err) {
     return Future.value(APIResponse.fromFailed(info:err.toString()));
   }
  }

  Future<APIResponse> requestOTP(String phone,String signature) async {
    print("attempting login with phone number:"+phone);
    print("adfdfad");
    try{
      await auth.logout();
      RequestResponse res = await networking.post(RequestPaths.SENDOTP,data:{"phone":phone,"signature":signature});
      print(res);
      print("adfdfad");
      if(res.status == TextMessages.SUCCESS)
      {
        print("Request executed successfully");
        String otpId = res.data as String;
        return Future.value(APIResponse.fromSuccess(hasData: true,data:otpId));
      }
      else {
        print("Request execution failed");
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print(err.toString());
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> resendOtp(String verificationId) async {
    try{
      // await auth.logout();
      RequestResponse res = await networking.post(RequestPaths.LOGIN,data:{"verification_id":verificationId});
      if(res.status == TextMessages.SUCCESS)
      {
        // String otpId = res.data as String;
        return Future.value(APIResponse.fromSuccess(hasData: false));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }



  Future<APIResponse> verifyOTP(String otp,String otpId,String role) async {
    try{
      RequestResponse res = await networking.post(RequestPaths.LOGIN,data:{"otp":otp,"verification_id":otpId,"role":role});

      if(res.status == TextMessages.SUCCESS)
      {
        print(res.data);
        User user = User.fromJson(res.data as Map<String,dynamic>);
        await auth.login(user);
        return Future.value(APIResponse.fromSuccess(hasData: true,data:user));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> logout(String otp,String otpId,String role) async {
    try{
      RequestResponse res = await networking.post(RequestPaths.LOGOUT);

      if(res.status == TextMessages.SUCCESS)
      {
        await auth.logout();
        return Future.value(APIResponse.fromSuccess(hasData: false));
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
