import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx/app/data/constants/errors.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/model/model.dart';
import 'package:getx/app/data/repository/posts_repository.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:meta/meta.dart';

import '../data/model/booking.dart';
import '../data/provider/host_api.dart';
import '../ui/android/widgets/miscellaneous.dart';

class HostController extends GetxController {

  late HostAPIProvider hostAPIProvider;
  HostController(){
    hostAPIProvider = HostAPIProvider();
  }
  final page = RxInt(0);
  final _eventsList = <Event>[].obs;
  get eventsList => _eventsList.value;
  set eventsList(value) => _eventsList.value = value;

  Future<APIResponse> getMyEvents({bool test = false}) async{
    APIResponse res ;
    if(test)
      {
        var fakeData = <Event>[];
        fakeData.addAll(List.generate(5, (index) {return Event(id: index.toString(),name:"test Event",thumbnail: "/images/c_logo.png",phases:[],medias: [],enabled: true,venue: "venue",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions");}));
        res = APIResponse(status: "success",data: fakeData);
      }
    else{
    res =  await hostAPIProvider.getMyEvents();
    }
    return res;
  }

  Future<APIResponse> getMyWallet() async{
    return await hostAPIProvider.getMyWallet();
  }


  Future<APIResponse> createHighlight(String eventId,String highlight) async{
    return await hostAPIProvider.createHighlight(eventId,highlight);
  }
  Future<APIResponse> deleteHighlight(String eventId,String highlight) async{
    return await hostAPIProvider.deleteHighlight(eventId,highlight);
  }



  Future<APIResponse> getEventTypeEvents(String eventType) async{
    APIResponse res ;
    res =  await hostAPIProvider.getMyEvents();
    return res;
  }

  Future<APIResponse> switchToClient() async{
    APIResponse res ;
    res =  await hostAPIProvider.switchToClient();
    return res;
  }

  Future<APIResponse> getSearchEvents(String searchString) async{
    APIResponse res ;
    res =  await hostAPIProvider.getMyEvents();
    return res;
  }

  Future<APIResponse> getEventPhases(String eventId) async{
    APIResponse res ;
    res =  await hostAPIProvider.getEventPhases(eventId);
    return res;
  }

  Future<APIResponse> getUserBookings() async{
    APIResponse res ;
    res =  await hostAPIProvider.getEventPhases("");
    return res;
  }
  Future<APIResponse> getPhaseCategories(String phaseId) async{
    APIResponse res ;
    res =  await hostAPIProvider.getPhaseCategories(phaseId);
    return res;
  }

  Future<APIResponse> editHostInformation(Map<String,dynamic> data) async{
    APIResponse res ;
    res =  await hostAPIProvider.editHostInformation(data);
    return res;
  }

  Future<APIResponse> getPhase(String phaseId) async{
    APIResponse res ;
    res =  await hostAPIProvider.getPhase(phaseId);
    return res;
  }

  // Future<APIResponse> getBooking(String bookingId) async{
  //   APIResponse res ;
  //   res =  await hostAPIProvider.getPhase(bookingId);
  //   return res;
  // }

  Future<APIResponse> getCategory(String categoryId) async{
    APIResponse res ;
    res =  await hostAPIProvider.getCategory(categoryId);
    return res;
  }
  Future<APIResponse> getTicket(String ticketId) async{
    APIResponse res ;
    res =  await hostAPIProvider.getTicket(ticketId);
    return res;
  }

  Future<APIResponse> getMyBookings(String eventId,{bool test = false}) async{
    APIResponse res ;
    if(test)
    {
      var fakeData = <Booking>[];
      fakeData.addAll(List.generate(5, (index) {return Booking(id: index.toString());}));
      res = APIResponse(status: "success",data: fakeData);
    }
    else{
      res =  await hostAPIProvider.getMyBookings(eventId);
    }
    return res;
  }

  Future<APIResponse> getMyBooking(String bookingId,{bool test = false}) async{
    APIResponse res ;
    if(test)
    {
      res = APIResponse(status: "success",data: Booking(id: "Fake Id"));
    }
    else{
      res =  await hostAPIProvider.getMyBooking(bookingId);
    }
    return res;
  }




  Future<APIResponse> getMyEvent(String eventId,{bool test = false}) async{
    APIResponse res ;
    if(test)
    {
      res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",thumbnail: "/images/c_logo.png",phases:[],medias: [],enabled: true,venue: "venue",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
    }
    else{
      res =  await hostAPIProvider.getMyEvent(eventId);
    }

    return res;
  }

  Future<APIResponse> getBooking(String bookingId) async{
    return await hostAPIProvider.getBooking(bookingId);
  }

  Future<APIResponse> getHostInfo(String bookingId) async{
    return await hostAPIProvider.getHostInfo(bookingId);
  }

  Future<APIResponse> createEvent(Map<String,dynamic> eventJson,{bool test = false}) async{

    APIResponse res;
    if(test)
    {
      var id = "Random ID";
      eventJson['_id'] = id;
      var event = Event.fromJson(eventJson);
      res = APIResponse(status: "success",data: event);
    }
    else{
      print("1");
      res =  await hostAPIProvider.createEvent(eventJson);
    }

    return res;
    // if(res.status == TextMessages.SUCCESS)
    // {
    //   showSnackbar("Success", "Event Created Successfully");
    //   Event event = res.data as Event;
    //   Get.toNamed(Routes.HOST_EVENT,arguments: event );
    // }
    // else
    // {
    //   showSnackbar("Error", res.info!);
    //   if(res.info == ErrorMessages.NLI)
    //   {
    //     Get.offNamed(Routes.LOGIN);
    //   }
    //   else
    //   {
    //     throw(res.info!);
    //   }
    // }
  }

  Future<APIResponse> createPhase(Map<String,dynamic> eventJson) async{

    APIResponse res;
    res =  await hostAPIProvider.createPhase(eventJson);
    return res;
  }

  Future<APIResponse> addHelper(Map<String,dynamic> data,eventId) async{

    APIResponse res;
    res =  await hostAPIProvider.addHelper(data,eventId);
    return res;
  }

  Future<APIResponse> removeHelper(Map<String,dynamic> data,eventId) async{

    APIResponse res;
    res =  await hostAPIProvider.removeHelper(data,eventId);
    return res;
  }

  Future<APIResponse> createCategory(Map<String,dynamic> eventJson) async{

    APIResponse res;
    res =  await hostAPIProvider.createCategory(eventJson);
    return res;
  }

  Future<APIResponse> createTicket(Map<String,dynamic> eventJson) async{

    APIResponse res;
    res =  await hostAPIProvider.createTicket(eventJson);
    return res;
  }

  Future<APIResponse> deleteTicket(String ticketId) async{

    APIResponse res;
    res =  await hostAPIProvider.deleteTicket(ticketId);
    return res;
  }

  Future<APIResponse> deleteCategory(String categoryId) async{

    APIResponse res;
    res =  await hostAPIProvider.deleteCategory(categoryId);
    return res;
  }

  Future<APIResponse> deletePhase(String phaseId) async{

    APIResponse res;
    res =  await hostAPIProvider.deletePhase(phaseId);
    return res;
  }





  Future<bool> saveMedia(String eventId,String url,bool image) async{

    APIResponse res;
    res =  await hostAPIProvider.saveMedia(eventId,url,image);
    if(res.status == TextMessages.SUCCESS)
      {
        return true;
      }
    else
      {
        showSnackbar("Error", res.info!);
        return false;
      }
  }

  Future<bool> removeMedia(String eventId,String mediaId) async{

    APIResponse res;
    res =  await hostAPIProvider.removeMedia(eventId,mediaId);
    if(res.status == TextMessages.SUCCESS)
    {
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }
  }

  Future<bool> saveDP(String eventId,String url) async{

    APIResponse res;
    res =  await hostAPIProvider.saveDP(eventId,url);
    if(res.status == TextMessages.SUCCESS)
    {
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }
  }



  Future<APIResponse> saveEvent(Map<String,dynamic> eventJson,{bool test = false}) async{
    APIResponse res;
    res =  await hostAPIProvider.updateMyEvent(eventJson,eventJson['_id']);
    return res;
  }


  Future<bool> setEntry(int entry,Event event) async{
    APIResponse res=await hostAPIProvider.setEntry(entry,event);
    if(res.status == TextMessages.SUCCESS)
      {
        return true;
      }
    else
      {
        print(res.info);
        return false;
      }


  }

}