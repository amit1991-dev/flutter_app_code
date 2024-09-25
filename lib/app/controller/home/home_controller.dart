import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx/app/data/model/city_state.dart';
import 'package:getx/app/routes/app_pages.dart';
import '../../data/constants/errors.dart';
import '../../data/constants/miscellaneous.dart';
import '../../data/constants/request_paths.dart';
import '../../data/model/api_response.dart';
import '../../data/model/cart.dart';
import '../../data/model/event.dart';
import '../../data/provider/user_api.dart';
import '../../ui/android/widgets/miscellaneous.dart';

class HomeController extends GetxController {

  late final UserAPIProvider userAPIProvider;
  final Rx<Cart> cart=Cart(body:{}).obs;
  final Rx<CityState> cityState = CityState.defaultCity().obs;
  
  Event? cartEvent;

  HomeController(){
    
    userAPIProvider = UserAPIProvider();
    String? cartJSONString = GetStorage(StorageKeys.CART_STORAGE_KEY).read(StorageKeys.CART_KEY);
    if (cartJSONString != null) {
      print("found cart");
      print(cartJSONString);
      cart.value = Cart.fromJson(jsonDecode(cartJSONString));
    }
    else
      {
        print("could not find cart stored in preferences");
      }
  }
  // Cart functions
  // addToCart(String ticketId,Event event)
  // {
  //   setCartItem(ticketId, 1,event);
  // }
  //
  // setCartItem(String ticketId,int quantity,Event event)
  // {
  //   cart.value.body[ticketId]=quantity;
  //   saveCart();
  // }
  clearCartItem(String ticketId,Event event){
    cartPrecaution(event);
    cart.value.body.remove(ticketId);
    saveCart();
  }
  //Dangerous function!!
  cartClear(){
    cart.value.body={};
    saveCart();
  }

  incrementCart(CategoryTicket ticket,Event event,int totalAvailable)
  {
    // print("Increment");
    String ticketId = ticket.id;
    cartPrecaution(event);
    // print(cart.value.body[ticketId]);
    if(cart.value.body[ticketId]==null)
    {
      cart.value.body[ticketId] = CartItem(ticket:ticket);
    }

    if((cart.value.body[ticketId]!.quantity) < 10 && (cart.value.body[ticketId]!.quantity) < totalAvailable)
    {
      // print("all fine");


      cart.value.body[ticketId]!.quantity=(cart.value.body[ticketId]!.quantity)+1;
      saveCart();
      update();
    }
    else {

          showSnackbar("Info:", "Maximum Ticket Limit Reached");


    }
  }

  decrementCart(String ticketId,Event event)
  {
    // print("decrement");
    cartPrecaution(event);
    // print(cart.value.body[ticketId]);

    // if((cart.value.body[ticketId]??0) - 1 > 0){print((cart.value.body[ticketId]??0));}else{print("No");}

    if(cart.value.body[ticketId]!=null && (cart.value.body[ticketId]!.quantity) > 0)
      {
        // print("all fine");
        cart.value.body[ticketId]!.quantity=(cart.value.body[ticketId]!.quantity)-1;
        if(cart.value.body[ticketId]!.quantity==0)
        {
           cart.value.body.remove(ticketId);
        }
        saveCart();
        update();
      }
    else
    {
      // cart.value.body[ticketId]=0;
      // showSnackbar("Info:", "Should use delete function here instead!");
    }
  }

  saveCart() async
  {
    String cartJSONString=jsonEncode(cart.value.toJson());
    print("trying to save");

    await GetStorage(StorageKeys.CART_STORAGE_KEY).write(StorageKeys.CART_KEY, cartJSONString);
    // print(t.toS);
  }

  int cartGetQuantity(String ticketId,Event event){
   cartPrecaution(event);
   return cart.value.body[ticketId]?.quantity??0;
  }

  int cartTotal(Event event){
    cartPrecaution(event);
    Map<String,CartItem> temp = cart.value.body;
    int total = 0;
    for(String a in temp.keys)
      {
        total += temp[a]!.quantity * temp[a]!.ticket.price;
      }
    return total;
  }

  // Events functions
  // Future<APIResponse> getAllEvents({bool test = false}) async{
  //   APIResponse res ;
  //   if(test)
  //   {
  //     var fakeData = [];
  //     fakeData.addAll(List.generate(5, (index) => {Event(id: index.toString(),name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions")}));
  //     res = APIResponse(status: "success",data: fakeData);
  //     return res;
  //   }
  //   else{
  //     res =  await userAPIProvider.getEvents(searchString: "");
  //   }
  //
  //   if(res.status == TextMessages.SUCCESS)
  //   {
  //
  //     List<dynamic> eventsJson = res.data;
  //     List<Event> events =[];
  //     eventsJson.map((e) => {events.add(Event.fromJson(e))});
  //     return APIResponse(status: "success",data: events);
  //   }
  //   else
  //   {
  //     showSnackbar("Error", res.info!);
  //     if(res.info == ErrorMessages.NLI)
  //     {
  //       Get.offNamed(Routes.LOGIN);
  //     }
  //
  //     return APIResponse.fromFailed(info: res.info);
  //   }
  // }

  Future<APIResponse> getEvents() async {
    return await userAPIProvider.getEventsForPath(RequestPaths.GET_EVENTS);
  }

  Future<APIResponse> getNotifications(String id) async {
    return await userAPIProvider.getNotifications(id);
  }

  Future<APIResponse> switchToHost() async{
    APIResponse res ;
    res =  await userAPIProvider.switchToHost();
    return res;
  }


  Future<APIResponse> createOrder(Map<String,dynamic> data) async {
    return await userAPIProvider.createOrder(data);
  }


  Future<APIResponse> getEventsFeatured() async {
    return await userAPIProvider.getEventsForPath(RequestPaths.GET_EVENTS_FEATURED);
  }

  // Future<APIResponse> getGravityResults() async {
  //   return await userAPIProvider.getGravityResults();
  // }

  Future<APIResponse> getEventsTodays() async {
    return await userAPIProvider.getEventsForPath(RequestPaths.GET_EVENTS_TODAY);
  }

  Future<APIResponse> getEventsUpcoming() async {
    return await userAPIProvider.getEventsForPath(RequestPaths.GET_EVENTS_UPCOMING);
  }

  Future<APIResponse> getEventsByTypes(String eventType) async {
    return await userAPIProvider.getEventsByTypes(eventType.toLowerCase());
  }

  Future<APIResponse> searchEvents(String searchString) async {
    return await userAPIProvider.searchEvents(searchString);
  }


  // Future<APIResponse> getDashboardEvents({bool test = false}) async{
  //   APIResponse res ;
  //   if(test)
  //   {
  //     Map<String,List<Event>> dashboard={};
  //     var categories = ['upcoming',];
  //     var fakeData = [];
  //     fakeData.addAll(List.generate(5, (index) => {Event(id: index.toString(),name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions")}));
  //     res = APIResponse(status: "success",data: fakeData);
  //     return res;
  //   }
  //   else{
  //     res =  await getEvents();
  //   }
  //
  //   if(res.status == TextMessages.SUCCESS)
  //   {
  //
  //     List<dynamic> eventsJson = res.data;
  //     List<Event> events =[];
  //     eventsJson.map((e) => {events.add(Event.fromJson(e))});
  //     return APIResponse(status: "success",data: events);
  //   }
  //   else
  //   {
  //     showSnackbar("Error", res.info!);
  //     if(res.info == ErrorMessages.NLI)
  //     {
  //       Get.offNamed(Routes.LOGIN);
  //     }
  //     return APIResponse.fromFailed(info: res.info);
  //   }
  // }


  Future<APIResponse> getEvent(String eventId,{bool test = false}) async{
    APIResponse res ;
    // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
    res =  await userAPIProvider.getEvent(eventId);

    if(res.status == TextMessages.SUCCESS)
    {
      return res;
    }
    else
    {
      showSnackbar("Error", res.info!);
      if(res.info == ErrorMessages.NLI)
      {
        Get.offNamed(Routes.LOGIN);
      }
      return res;
    }
  }

  Future<APIResponse> getBooking(String bookingId,{bool test = false}) async{
    APIResponse res ;
    // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
    res =  await userAPIProvider.getBooking(bookingId);

    if(res.status == TextMessages.SUCCESS)
    {
      return res;
    }
    else
    {
      showSnackbar("Error", res.info!);
      if(res.info == ErrorMessages.NLI)
      {
        Get.offNamed(Routes.LOGIN);
      }
      return res;
    }
  }

  Future<APIResponse> getBookings() async{
    APIResponse res ;
    // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
    res =  await userAPIProvider.getBookings();

    if(res.status == TextMessages.SUCCESS)
    {
      print("successfully aquired bookings");
      return res;
    }
    else
    {
      showSnackbar("Error", res.info!);
      if(res.info == ErrorMessages.NLI)
      {
        Get.offNamed(Routes.LOGIN);
      }
      return res;
    }
  }

  Future<APIResponse> setEmail(String email) async{
    APIResponse res ;
    // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
    res =  await userAPIProvider.saveUserEmail(email);

    if(res.status == TextMessages.SUCCESS)
    {
      return res;
    }
    else
    {
      showSnackbar("Error", res.info!);
      if(res.info == ErrorMessages.NLI)
      {
        Get.offNamed(Routes.LOGIN);
      }
      return res;
    }
  }


  Future<APIResponse> getCategoryEvents(String category,{bool test = false}) async{
    APIResponse res ;
    // res = APIResponse(status: "success",data: Event(id: eventId,name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions"));
    if(test)
    {
      var fakeData = [];
      fakeData.addAll(List.generate(5, (index) => {Event(id: index.toString(),name:"test Event",phases:[],medias: [],enabled: true,venue: "ventu",artist: "A.k Artist",bookingStatus: "Booking Open",category: "Category",subcategory: "Subcategory",city: "City",state: "State",description: "Description",eventDuration: "Event Duration",eventStatus: "Event Status",eventStatusExtra: "Event Status Extra",eventTimestamp: DateTime.now().toString(),eventType: "Concert",pincode: "243002",recurring: "none",termsConditions: "Terms and Conditions")}));
      res = APIResponse(status: "success",data: fakeData);
      return res;
    }
    else{
      res =  await userAPIProvider.getcategoricalEvents(category);
    }
    if(res.status == TextMessages.SUCCESS)
    {
      return res.data;
    }
    else
    {
      showSnackbar("Error", res.info!);
      if(res.info == ErrorMessages.NLI)
      {
        Get.offNamed(Routes.LOGIN);
      }
      return APIResponse.fromFailed(info: res.info);
    }
  }

  void cartPrecaution(Event event) {
    if(cartEvent == null || cartEvent!.id != event.id)
    {
      cartClear();
      cartEvent=event;
    }
  }
}