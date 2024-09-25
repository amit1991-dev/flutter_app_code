
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/constants/errors.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/city_state.dart';
import 'package:getx/app/data/model/gravity/gravity_result.dart';
import 'package:getx/app/data/model/request_response.dart';
import 'package:getx/app/routes/app_pages.dart';

import '../../controller/authentication/authentication.dart';
import '../../controller/networking/networking.dart';
import '../constants/request_paths.dart';
import '../model/booking.dart';
import '../model/event.dart';
import '../model/notification.dart';
import '../model/user.dart';

class UserAPIProvider {
  late Authentication auth;
  late Networking networking;

  UserAPIProvider(){
    auth = Get.find<Authentication>();
    networking = Get.find<Networking>();
  }



  //search or find events
  Future<APIResponse> getEventsForPath(String path,{String searchString=""}) async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    Map<String,dynamic> query={};
    if(Get.find<HomeController>().cityState.value!.city != CityState.defaultCity().city)
      {
        query = {"city":Get.find<HomeController>().cityState.value!.city};
      }

    print(query.toString());

    try{
      RequestResponse res = await networking.get(path,headers: headers,query:query );
      print(res.data);

      if(res.status == TextMessages.SUCCESS)
      {
        List<Event> events = [];
        List<dynamic> evs=res.data as List;

        for (var element in evs) {
          print("ASd");
          events.add(Event.fromJson(element));
        }
        return Future.value(APIResponse.fromSuccess(hasData: true,data:events));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> searchEvents(String searchString) async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    var query;
    if(Get.find<HomeController>().cityState.value.city != CityState.defaultCity().city)
    {
      query = {"city":Get.find<HomeController>().cityState.value.city};
    }
    print("query");
    print(query);
    print(searchString);

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_EVENTS_SEARCH}/$searchString",headers: headers,query: query);
      print(res.data);

      if(res.status == TextMessages.SUCCESS)
      {
        List<Event> events = [];
        List<dynamic> evs=res.data as List;

        for (var element in evs) {
          events.add(Event.fromJson(element));
        }
        return Future.value(APIResponse.fromSuccess(hasData: true,data:events));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getNotifications(String userId) async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_NOTIFICATIONS}/$userId",headers: headers);
      print(res.data);

      if(res.status == TextMessages.SUCCESS)
      {
        List<Notification> notifications = [];
        List<dynamic> evs=res.data as List;

        for (var element in evs) {
          notifications.add(Notification.fromJson(element));
        }
        return Future.value(APIResponse.fromSuccess(hasData: true,data:notifications));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> saveUserEmail(String email) async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    Map<String,dynamic> data = {"email":email};

    try{
      RequestResponse res = await networking.post(RequestPaths.POST_SAVE_EMAIL,headers: headers,data:data);
      // print(res.data);

      if(res.status == TextMessages.SUCCESS)
      {
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

  Future<APIResponse> switchToHost() async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.post(RequestPaths.POST_USER_SWITCH_TO_CLIENT,headers: headers);
      // print("Phase from host api");
      if(res.status == TextMessages.SUCCESS)
      {
        String token= res.data as String;
        return Future.value(APIResponse.fromSuccess(hasData: true,data:token));
      }
      else {
        print("Request failed");
        print(res.message);
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print("Somethign went wrong");
      print(err);
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getEventsByTypes(String eventType) async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      Map<String,dynamic> query = {"category":eventType};
      RequestResponse res = await networking.get(RequestPaths.GET_EVENTS,query:query,headers: headers);
      print(res.data);

      if(res.status == TextMessages.SUCCESS)
      {
        List<Event> events = [];
        List<dynamic> evs=res.data as List;

        for (var element in evs) {
          events.add(Event.fromJson(element));
        }
        return Future.value(APIResponse.fromSuccess(hasData: true,data:events));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getcategoricalEvents(String category) async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get(RequestPaths.GET_EVENTS_CATEGORY+"/${category}",headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        List<Event> events = [];
        List<dynamic> evs=res.data as List;

        for (var element in evs) {
          events.add(Event.fromJson(element));
        }
        return Future.value(APIResponse.fromSuccess(hasData: true,data:events));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getEvent(String eventId) async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_EVENT}/$eventId",headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        print("evensss");
        Event e=Event.fromJson(res.data);
        print("evensss");
        print(e.phases);
        return Future.value(APIResponse.fromSuccess(hasData: true,data:e));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getBookings() async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get(RequestPaths.GET_BOOKINGS,headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        List<Booking> bookings = [];
        List<dynamic> evs=res.data as List;

        for (var element in evs) {
          bookings.add(Booking.fromJson(element));
        }
        return Future.value(APIResponse.fromSuccess(hasData: true,data:bookings));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getBooking(String bookingId) async {
    if(!auth.isLoggedIn.value)
    {
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_BOOKING}/$bookingId",headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        Booking booking=Booking.fromJson(res.data);
        print(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true,data:booking));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }


// not tried and tested!
  Future<APIResponse> createOrder(Map<String,dynamic> data) async {
    try{
      var headers = {'authorization':'Bearer ${auth.token}',
        // 'Content-Type':'application/json'
      };
      RequestResponse res = await networking.post(RequestPaths.CREATE_ORDER,data:data,headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        String orderId = res.data as String;
        return Future.value(APIResponse.fromSuccess(hasData: true,data:orderId));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> bookEvent(Map<String,int> tickets,) async {
    try{
      RequestResponse res = await networking.post(RequestPaths.LOGIN,data:{"tickets":tickets});

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
