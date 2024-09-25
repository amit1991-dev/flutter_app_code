
import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx/app/data/constants/errors.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/host_info.dart';
import 'package:getx/app/data/model/request_response.dart';

import '../../controller/authentication/authentication.dart';
import '../../controller/networking/networking.dart';
import '../constants/request_paths.dart';
import '../model/booking.dart';
import '../model/event.dart';
import '../model/user.dart';
import '../model/wallet.dart';

class HelperAPIProvider {
  late Authentication auth;
  late Networking networking;

  HelperAPIProvider(){
    auth = Get.find<Authentication>();
    networking = Get.find<Networking>();
  }

  //search or find events
  Future<APIResponse> getMyEvents({String searchString = ""}) async {
    if(!auth.isLoggedIn.value)
      {
        //please go to the LOGIN page from here after return!
        return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
      }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

   try{
     RequestResponse res = await networking.get(RequestPaths.GET_HELPER_EVENTS,headers: headers);
     if(res.status == TextMessages.SUCCESS)
     {

       List<Event> events = [];
       List<dynamic> evs=res.data as List;

       for (var element in evs) {
         print("heere");
         // print(element['_id']);
         events.add(Event.fromJson(Map<String,dynamic>.from(element)));
       }
       return Future.value(APIResponse.fromSuccess(hasData: true,data:events));
     }
     else {
       print("Got no results");
       return Future.value(APIResponse.fromFailed(info:res.message));
     }
   }
   catch(err) {
     print("Get my events Error");
     print(err);
     return Future.value(APIResponse.fromFailed(info:err.toString()));
   }
  }

  Future<APIResponse> getMyWallet() async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get(RequestPaths.GET_USER_WALLET,headers: headers);
      if(res.status == TextMessages.SUCCESS)
      {
        print(res.data);
        Wallet wallet =  Wallet.fromJson(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true,data:wallet));
      }
      else {
        print("Got no results");
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print("Get my wallet Error");
      print(err);
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getEventPhases(String eventId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_HOST_EVENT_PHASES}/$eventId",headers: headers);
      print(res.status);
      if(res.status == TextMessages.SUCCESS)
      {

        List<EventPhase> phases = [];
        List<dynamic> evs=res.data as List;

        for (var element in evs) {
          phases.add(EventPhase.fromJson(Map<String,dynamic>.from(element)));
        }
        return Future.value(APIResponse.fromSuccess(hasData: true,data:phases));
      }
      else {
        print("Got nothing");
        print(res.message);
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print("Get my events phases Error");
      print(err);
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }
  Future<APIResponse> getPhaseCategories(String phaseId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_HOST_PHASE_CATEGORIES}/$phaseId",headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {

        List<PhaseCategory> categories = [];
        List<dynamic> evs=res.data as List;

        for (var element in evs) {
          categories.add(PhaseCategory.fromJson(Map<String,dynamic>.from(element)));
        }
        return Future.value(APIResponse.fromSuccess(hasData: true,data:categories));
      }
      else {
        print("Got no results");
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print("Get my events phases Error");
      print(err);
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getPhase(String phaseId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_HOST_PHASE}/$phaseId",headers: headers);
      print("Phase from host api");
      if(res.status == TextMessages.SUCCESS)
      {
        EventPhase evs= EventPhase.fromJson(res.data);
        print("Phase from host api");
        print(evs);
        return Future.value(APIResponse.fromSuccess(hasData: true,data:evs));
      }
      else {
        print("Got no results");
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print("Get my events phases Error");
      print(err);
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getHostInfo(String hostId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_HOST_INFO}/$hostId",headers: headers);
      // print("Phase from host api");
      if(res.status == TextMessages.SUCCESS)
      {
        HostInfo hi= HostInfo.fromJson(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true,data:hi));
      }
      else {
        print("Got no results");
        print(res.message);
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print("Get my events phases Error");
      print(err);
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getCategory(String categoryId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_HOST_CATEGORY}/$categoryId",headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {

        PhaseCategory evs=PhaseCategory.fromJson(res.data);

        
        return Future.value(APIResponse.fromSuccess(hasData: true,data:evs));
      }
      else {
        print("Got no results");
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print("Get my events phases Error");
      print(err);
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> getTicket(String ticketId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };

    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_HOST_TICKET}/$ticketId",headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        CategoryTicket evs=CategoryTicket.fromJson(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true,data:evs));
      }
      else {
        print("Got no ticket");
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      print("Get my Ticket Error");
      print(err);
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }

  Future<APIResponse> saveMedia(String eventId,String url,bool image) async{

    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}','Content-Type':'application/json'};
      var data = {'path':url,'media_type':image?"image":"video"};
    try{
      RequestResponse res = await networking.post("${RequestPaths.POST_HOST_EVENT_ADD_MEDIA}/$eventId",data:data,headers: headers);

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

  Future<APIResponse> removeMedia(String eventId,String mediaId) async{

    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}','Content-Type':'application/json'};
    // var data = {'path':url,'media_type':image?"image":"video"};
    try{
      RequestResponse res = await networking.post("${RequestPaths.POST_HOST_EVENT_REMOVE_MEDIA}/$eventId/$mediaId",headers: headers);

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

  Future<APIResponse> editHostInformation(Map<String,dynamic> data) async{

    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}','Content-Type':'application/json'};
    try{
      String hostId = auth.user!.id;
      String path = "${RequestPaths.POST_HOST_INFO_EDIT}/$hostId";
      print(path);
      RequestResponse res = await networking.post(path,data:data,headers: headers);

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

  Future<APIResponse> saveDP(String eventId,String url) async{

    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}','Content-Type':'application/json'};
      var data = {'picture_path':url};
    try{
      RequestResponse res = await networking.post("${RequestPaths.POST_HOST_EVENT_ADD_DP}/$eventId",data:data,headers: headers);

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

  Future<APIResponse> getMyBookings(String eventId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    try{
      Map<String,dynamic> query = {"event":eventId};
      RequestResponse res = await networking.get(RequestPaths.GET_HOST_BOOKINGS,headers: headers,query: query);

      if(res.status == TextMessages.SUCCESS)
      {
        List<Booking> bookings = [];
        List<dynamic> bkngs=res.data as List;

        bkngs.forEach((element) {
          bookings.add(Booking.fromJson(element));
        });
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

  Future<APIResponse> getMyBooking(String bookingId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_HOST_BOOKINGS}/single/$bookingId",headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        Booking booking = Booking.fromJson(res.data);
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

  Future<APIResponse> getMyEvent(String eventId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    try{
      RequestResponse res = await networking.get("${RequestPaths.GET_HELPER_EVENTS}/single/$eventId",headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        // Event event=Event.fromJson(Map<String,dynamic>.from(res.data));
        Event event=Event.fromJson(res.data);
        return Future.value(APIResponse.fromSuccess(hasData: true,data:event));
      }
      else {
        return Future.value(APIResponse.fromFailed(info:res.message));
      }
    }
    catch(err) {
      return Future.value(APIResponse.fromFailed(info:err.toString()));
    }
  }




  Future<APIResponse> updateMyEvent(Map<String,dynamic> eventJson,String eventId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}','Content-Type':'application/json'};

    try{
      RequestResponse res = await networking.post("${RequestPaths.POST_HOST_EVENT_UPDATE}/$eventId",data:eventJson,headers: headers);

      if(res.status == TextMessages.SUCCESS)
      {
        // Event event=res.data as Event;
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


  Future<APIResponse> createEvent(Map<String,dynamic> eventJson) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    print(auth.token);
    var headers = {'Authorization':'Bearer ${auth.token}',
      'content-Type':'application/json'
    };

    try{
      print("2 ${RequestPaths.POST_CREATE_EVENT}");
      RequestResponse res = await networking.post(RequestPaths.POST_CREATE_EVENT,data:eventJson,headers:headers );

      if(res.status == TextMessages.SUCCESS)
      {
        // List<Event> events = [];
        print("3");
        print(res.data);
        Event e = Event.fromJson(res.data);
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

  Future<APIResponse> createPhase(Map<String,dynamic> eventJson) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    print(auth.token);
    var headers = {'Authorization':'Bearer ${auth.token}',
      'content-Type':'application/json'
    };
    try{
      RequestResponse res = await networking.post(RequestPaths.POST_HOST_CREATE_PHASE,data:eventJson,headers:headers );
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

  Future<APIResponse> createCategory(Map<String,dynamic> eventJson) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'Authorization':'Bearer ${auth.token}','content-Type':'application/json'};
    try{
      RequestResponse res = await networking.post(RequestPaths.POST_HOST_CREATE_CATEGORY,data:eventJson,headers:headers);
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

  Future<APIResponse> createTicket(Map<String,dynamic> eventJson) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'Authorization':'Bearer ${auth.token}','content-Type':'application/json'};
    try{
      RequestResponse res = await networking.post(RequestPaths.POST_HOST_CREATE_TICKET,data:eventJson,headers:headers);
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

  Future<APIResponse> deleteTicket(String ticketId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'Authorization':'Bearer ${auth.token}','content-Type':'application/json'};
    try{
      RequestResponse res = await networking.post("${RequestPaths.POST_HOST_DELETE_TICKET}/$ticketId",headers:headers);
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

  Future<APIResponse> deletePhase(String phaseId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'Authorization':'Bearer ${auth.token}','content-Type':'application/json'};
    try{
      RequestResponse res = await networking.post("${RequestPaths.POST_HOST_DELETE_PHASE}/$phaseId",headers:headers);
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

  Future<APIResponse> deleteCategory(String categoryId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'Authorization':'Bearer ${auth.token}','content-Type':'application/json'};
    try{
      RequestResponse res = await networking.post("${RequestPaths.POST_HOST_DELETE_CATEGORY}/$categoryId",headers:headers);
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

  Future<APIResponse> getBooking(String bookingId) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer ${auth.token}',
      // 'Content-Type':'application/json'
    };
    try{

      RequestResponse res = await networking.get("${RequestPaths.GET_BOOKING}/$bookingId",headers:headers);
      if(res.status == TextMessages.SUCCESS)
      {
        Booking booking=res.data as Booking;
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


  Future<APIResponse> setEntry(int numberPeople, Event event) async {
    if(!auth.isLoggedIn.value)
    {
      //please go to the LOGIN page from here after return!
      return Future.value(APIResponse.fromFailed(info:ErrorMessages.NLI));
    }
    var headers = {'authorization':'Bearer $auth.token',
      'Content-Type':'application/json'
    };
    try{
      dynamic data= {"entry":numberPeople,"event_id":event.id};
      RequestResponse res = await networking.post(RequestPaths.POST_ENTRY,data:data,headers: headers);
      if(res.status == TextMessages.SUCCESS)
      {
        Booking booking=res.data as Booking;
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


}
