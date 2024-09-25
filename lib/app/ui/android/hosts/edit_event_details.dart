import 'dart:ui';

import 'package:async_builder/async_builder.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/ui/android/widgets/highlight_item.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../controller/authentication/authentication.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/event.dart';
import '../../../routes/app_pages.dart';
import '../widgets/event_phases.dart';
import '../widgets/google_places.dart';
import '../widgets/host_event_picture_main.dart';

class HostDetailsEventPage extends StatefulWidget {
  const HostDetailsEventPage({super.key});


  @override
  State<HostDetailsEventPage> createState() => _HostDetailsEventPageState();
}

class _HostDetailsEventPageState extends State<HostDetailsEventPage> {
  bool createWait = false;
  String? _range,_dateCount,_rangeCount;
  bool multiDay = false;
  var eventMode = DateRangePickerSelectionMode.single;
  /*

        artist:{type:String,required:true,default:"none"}, SS
        event_status_extra:{type:String,required:true,default:"-"},//extra details like Day:2 SS
        description:{type:String,required:true,default:"-"}, SS
        category:{type:String,required:true,default:"-"}, SS
        subcategory:{type:String,required:true,default:"-"}, SS
        terms_conditions:{type:String,default:"Clumzy Terms And Conditions apply"}, SS BIG
        
        helpers:[{type:ObjectId,ref:"users"}],//to be able to add ticket scan helper guys!, LL
        highlights:{type:[String],default:[],required:true},LL
        thumbnail:{type:String,default:"/images/c_logo.png",required:true}, IMG
        event_type:{type:String,required:true,enum:['party','concert','gathering','meet','other'],default:"party"},// digital or physical DD
        google_places_id:{type:String,required:true,default:"-"}, picker
        

   */
  TextEditingController artistController = TextEditingController(text: "-");
  // TextEditingController eventExtraController = TextEditingController(text: "-");
  TextEditingController descriptionController = TextEditingController(text: "-");
  TextEditingController highlightController = TextEditingController(text: "-");
  TextEditingController categoryController = TextEditingController(text: categories[0]);
  // TextEditingController subcategoryController = TextEditingController(text: "-");
  TextEditingController termsConditionsController = TextEditingController(text: "-");
  TextEditingController currentPhaseController = TextEditingController(text: "-");

  // String selectedEventType = "party";
  // String selectedEventStatus = "upcoming";
  String selectedBookingStatus= "booking_not_started";

  // List<String> eventTypes = ['party','concert','gathering','meet','other'];
  List<String> bookingStatus = ['booking_starting_soon','booking_terminated','booking_open','booking_closed'];
  // List<String> eventStatus = [ 'running','upcoming' ];// have to be finished when the user says it is finished!

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  late String eventId;

  _HostDetailsEventPageState(){
    eventId = Get.arguments as String;
  }

  dynamic attemptSaveEvent() async {
    if (kDebugMode) {
      print("attempting to save the event");
    }
    Map<String,dynamic> eventJson = {};
    if(artistController.text.isNotEmpty)
      {
        eventJson['artist'] = artistController.text;
      }
    // if(eventExtraController.text.isNotEmpty)
    // {
    //   eventJson['event_status_extra'] = eventExtraController.text;
    // }
    if(descriptionController.text.isNotEmpty)
    {
      eventJson['description'] = descriptionController.text;
    }
    if(categoryController.text.isNotEmpty)
    {
      eventJson['category'] = categoryController.text;
    }
    // if(subcategoryController.text.isNotEmpty)
    // {
    //   eventJson['subcategory'] = subcategoryController.text;
    // }
    if(termsConditionsController.text.isNotEmpty)
    {
      eventJson['terms_conditions'] = termsConditionsController.text;
    }
    if(currentPhaseController.text!="-")
    {
      eventJson['active_phase'] = currentPhaseController.text;
    }


    // setState(() {
    //   createWait = true;
    // });
    // eventJson['event_type']=selectedEventType.toLowerCase();
    eventJson['_id'] = eventId;

    APIResponse res = await Get.find<HostController>().saveEvent(eventJson);
    if(res.status == TextMessages.SUCCESS)
      {
        // Event event= res.data as Event;
        showSnackbar(TextMessages.SUCCESS,"Successfully saved the details!");
        //Get.toNamed(Routes.HOST_EVENT,arguments: eventId);
      }
    else
      {
        showSnackbar("Error", res.info!);
      }
    if (kDebugMode) {
      print("finished saving the event");
    }

    // setState(() {
    //   createWait = false;
    // });
  }

  dynamic attemptTogglePublishEvent(bool publish,Event event) async {
    if (kDebugMode) {
      print("attempting to save the event");
    }
    Map<String,dynamic> eventJson = {};

    if(publish)
      {
        if(getTicketCount(event.currentPhase)==0)
          {
            showSnackbar("Please", "Select Or create a phase with tickets to publish!");
            return;
          }
      }

    eventJson['_id'] = eventId;
    eventJson['published'] = publish;

    APIResponse res = await Get.find<HostController>().saveEvent(eventJson);
    if(res.status == TextMessages.SUCCESS)
    {
      // Event event= res.data as Event;
      showSnackbar(TextMessages.SUCCESS,"Successfully Altered Published state");
      setState(() {
      });
    }
    else
    {
      showSnackbar("Error", res.info!);
    }
    if (kDebugMode) {
      print("finished toggling published variable");
    }
  }

  dynamic attemptFinishEvent() async {
    if (kDebugMode) {
      print("attempting to finish the event");
    }
    Map<String,dynamic> eventJson = {};

    eventJson['_id'] = eventId;
    eventJson['event_status'] = "finished";

    APIResponse res = await Get.find<HostController>().saveEvent(eventJson);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully finished event");
      setState(() {

      });
    }
    else
    {
      showSnackbar("Error", res.info!);
    }
    if (kDebugMode) {
      print("finished toggling published variable");
    }
  }



  @override
  Widget build(BuildContext context) {

    // void callDialog(){
    //   Get.defaultDialog(
    //       title: "Search Google Places",
    //       // middleText: "Select A place",
    //       backgroundColor: appColors["background"]!,
    //       titleStyle: TextStyle(color: appColors["white"]!),
    //       middleTextStyle: TextStyle(color: appColors["white"]!),
    //       radius: 20,
    //
    //       content: WidgetGooglePlaces()
    //   );
    // }

    return Scaffold(
      backgroundColor: appColors["background"]!,
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          color: appColors["background"]!,
          axisDirection: AxisDirection.down,
          child: SingleChildScrollView(

            child: Container(
                decoration: BoxDecoration(

                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: appColors["background"]!
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height*0.05,
                  ),
                  headerBar("Event Details"),
                  AsyncBuilder<APIResponse>(
                    future: Get.find<HostController>().getMyEvent(eventId,test: false),

                    waiting: (context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    builder: (context,apiResponse){

                      if(apiResponse!.status == TextMessages.SUCCESS)
                      {
                        Event event = apiResponse.data as Event;
                        print("Event artist: "+event.artist!);
                        artistController.text = event.artist??"-";
                        currentPhaseController.text = (event.currentPhaseId!=null)?event.currentPhaseId!:event.phases.isNotEmpty?event.phases[0].id:"-";
                        // eventExtraController.text = event.eventStatusExtra??"-";
                        termsConditionsController.text = event.termsConditions??"-";
                        categoryController.text = event.category??"-";
                        // subcategoryController.text = event.subcategory??"-";
                        descriptionController.text = event.description??"-";
                        // selectedEventType = event.eventType??"party";
                        // selectedEventStatus = event.eventStatus??"upcoming";
                        selectedBookingStatus = event.bookingStatus??"booking_not_started";
                        if(event.phases.isNotEmpty)
                          {
                            //make data ready
                          }
                        return SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("Event ID:"+eventId, style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 12))),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Text("Event ID:"+eventId, style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 12)),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Text("Event Type", style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 16)),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: DropdownButtonFormField2(
                              //     value: selectedEventType.toLowerCase(),
                              //     decoration: InputDecoration(
                              //       //Add isDense true and zero Padding.
                              //       //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              //       isDense: true,
                              //       contentPadding: EdgeInsets.zero,
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(15),
                              //       ),
                              //       //Add more decoration as you want here
                              //       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              //     ),
                              //     isExpanded: true,
                              //     hint: const Text(
                              //       'Select Event Type',
                              //       style: TextStyle(fontSize: 14),
                              //     ),
                              //     icon: const Icon(
                              //       Icons.arrow_drop_down,
                              //       color: appColors["background"]!45,
                              //     ),
                              //     iconSize: 30,
                              //     buttonHeight: 60,
                              //     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              //     dropdownDecoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     items: eventTypes
                              //         .map((item) =>
                              //         DropdownMenuItem<String>(
                              //           value: item,
                              //           child: Text(
                              //             item,
                              //             style: const TextStyle(
                              //               fontSize: 14,
                              //             ),
                              //           ),
                              //         ))
                              //         .toList(),
                              //     validator: (value) {
                              //       if (value == null) {
                              //         return 'Please select a type.';
                              //       }
                              //     },
                              //     onChanged: (value) {
                              //       selectedEventType = value.toString();
                              //       //Do something when changing the item if you want.
                              //     },
                              //     onSaved: (value) {
                              //       //selectedEventType = value.toString();
                              //     },
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Text("Event Status", style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 16)),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: DropdownButtonFormField2(
                              //     value: selectedEventStatus.toLowerCase(),
                              //     decoration: InputDecoration(
                              //       //Add isDense true and zero Padding.
                              //       //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              //       isDense: true,
                              //       contentPadding: EdgeInsets.zero,
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(15),
                              //       ),
                              //       //Add more decoration as you want here
                              //       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              //     ),
                              //     isExpanded: true,
                              //     hint: const Text(
                              //       'Select Event Status',
                              //       style: TextStyle(fontSize: 14),
                              //     ),
                              //     icon: const Icon(
                              //       Icons.arrow_drop_down,
                              //       color: appColors["background"]!45,
                              //     ),
                              //     iconSize: 30,
                              //     buttonHeight: 60,
                              //     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              //     dropdownDecoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     items: eventStatus
                              //         .map((item) =>
                              //         DropdownMenuItem<String>(
                              //           value: item,
                              //           child: Text(
                              //             item,
                              //             style: const TextStyle(
                              //               fontSize: 14,
                              //             ),
                              //           ),
                              //         ))
                              //         .toList(),
                              //     validator: (value) {
                              //       if (value == null) {
                              //         return 'Please select a Status.';
                              //       }
                              //     },
                              //     onChanged: (value) {
                              //       selectedEventStatus = value.toString();
                              //       //Do something when changing the item if you want.
                              //     },
                              //     onSaved: (value) {
                              //       selectedEventStatus = value.toString();
                              //     },
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Active Booking Phase", style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 16)),
                              ),
                              Row(
                                children: [
                                  if(event.phases.isEmpty)
                                    Flexible(
                                      flex:5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("There are currently no available phases for you, please create one from the Event page", style:GoogleFonts.ubuntu(color: appColors["white"]!,fontSize: 10)),
                                      ),
                                    ),
                                  if(event.phases.isNotEmpty)
                                    Flexible(
                                      flex:5,
                                      child: DropdownButtonFormField2(
                                        value: currentPhaseController.text,

                                        // value: "${Get.find<HomeController>().cityState.value.city}:${Get.find<HomeController>().cityState.value.state}",
                                        decoration: InputDecoration(
                                          //Add isDense true and zero Padding.
                                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                          // isDense: true,
                                          contentPadding: EdgeInsets.all(10),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          //Add more decoration as you want here
                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          if(value!=null && value.length >0)
                                            currentPhaseController.text = value!;
                                          else
                                            currentPhaseController.text = "-";
                                          print("values changes");
                                          print("${value}");
                                          //Do something when changing the item if you want.
                                          // Get.find<HomeController>().cityState.value = CityState(city: value!.split(":")[0], state: value!.split(":")[1]);
                                        },
                                        // focusColor: appColors["primary"]!,
                                        // buttonHighlightColor: appColors["primary"]!,
                                        // selectedItemHighlightColor: appColors["primary"]!,
                                        onSaved: (value) {
                                          // print("Saveing"+value!);
                                          // currentPhaseController = value!;
                                          // selectedValue = value.toString();
                                        },
                                        hint: const Text(
                                          'Select Your Booking Phase',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: event.phases.map((phase){
                                          print(phase.name);
                                          return DropdownMenuItem(

                                              value:"${phase.id}",
                                              child:Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  clumsyTextLabel(phase.name,fontsize: 12,color: appColors["primary"]!),
                                                  // clumsyTextLabel(e.state,fontsize: 10),
                                                ],
                                              ));
                                        }).toList(),
                                      ),
                                    ),
                                  Flexible(
                                    flex: 1,
                                    child:MaterialButton(
                                      onPressed: () async {
                                        await Get.toNamed(Routes.HOST_EVENT_PHASES,arguments: eventId);
                                        setState(() {

                                        });
                                      },
                                      color: appColors["primary"]!,
                                      textColor: appColors["background"]!,
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            size: 24,
                                          ),
                                          clumsyTextLabel("Manage",fontsize: 10,color: appColors["background"]!)
                                        ],
                                      ),
                                      padding: EdgeInsets.all(16),
                                      shape: CircleBorder(),
                                    ),
                                  )
                                ],
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Text("Booking Status", style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 16)),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: DropdownButtonFormField2(
                              //     value: selectedBookingStatus.toLowerCase(),
                              //     decoration: InputDecoration(
                              //       isDense: true,
                              //       contentPadding: EdgeInsets.zero,
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(15),
                              //       ),
                              //     ),
                              //     isExpanded: true,
                              //     hint: const Text(
                              //       'Select Booking Status',
                              //       style: TextStyle(fontSize: 14),
                              //     ),
                              //     icon:  Icon(
                              //       Icons.arrow_drop_down,
                              //       color: appColors["background"]!,
                              //     ),
                              //     iconSize: 30,
                              //     buttonHeight: 60,
                              //     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              //     dropdownDecoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     items: bookingStatus.map((item) =>
                              //         DropdownMenuItem<String>(
                              //           value: item,
                              //           child: Text(
                              //             item,
                              //             style: const TextStyle(
                              //               fontSize: 14,
                              //             ),
                              //           ),
                              //         ))
                              //         .toList(),
                              //     validator: (value) {
                              //       if (value == null) {
                              //         return 'Please select a booking status';
                              //       }
                              //     },
                              //     onChanged: (value) {
                              //       selectedBookingStatus = value.toString();
                              //     },
                              //     onSaved: (value) {
                              //       //selectedEventType = value.toString();
                              //     },
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Information", style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 16)),
                              ),


                              Divider(),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // color: Color(0xff36363D),
                                  border: Border.all(color:appColors["grey"]!),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: TextFormField(
                                    controller: descriptionController,
                                    autofocus: false,
                                    cursorColor: appColors["primary"]!,
                                    cursorRadius: Radius.circular(10),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Description",
                                      labelStyle: TextStyle(color: appColors["primary"]!),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // color: Color(0xff36363D),
                                  border: Border.all(color:appColors["grey"]!),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: TextFormField(
                                    controller: artistController,
                                    autofocus: false,
                                    cursorColor: appColors["primary"]!,
                                    cursorRadius: Radius.circular(10),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Artist",
                                      labelStyle: TextStyle(color: appColors["primary"]!),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     // color: Color(0xff36363D),
                              //     border: Border.all(color:appColors["grey"]!),
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(18.0),
                              //     child: TextFormField(
                              //       controller: categoryController,
                              //       autofocus: false,
                              //       cursorColor: appColors["primary"]!,
                              //       cursorRadius: Radius.circular(10),
                              //       decoration: InputDecoration(
                              //         border: InputBorder.none,
                              //         labelText: "Category",
                              //         labelStyle: TextStyle(color: appColors["primary"]!),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              // Container(
                              //   margin: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     // color: Color(0xff36363D),
                              //     border: Border.all(color:appColors["grey"]!),
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(18.0),
                              //     child: TextFormField(
                              //       controller: subcategoryController,
                              //       autofocus: false,
                              //       cursorColor: appColors["primary"]!,
                              //       cursorRadius: Radius.circular(10),
                              //       decoration: InputDecoration(
                              //         border: InputBorder.none,
                              //         labelText: "Sub-Category",
                              //         labelStyle: TextStyle(color: appColors["primary"]!),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Padding(
                                padding:const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Event Category",color:appColors["primary"]!,),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField2(
                                    value:categoryController.text,
                                    decoration: InputDecoration(
                                      //Add isDense true and zero Padding.
                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      //Add more decoration as you want here
                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                    ),
                                    isExpanded: true,
                                    hint: const Text(
                                      'Select Event Category',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    // icon: Icon(
                                    //   Icons.arrow_drop_down,
                                    //   color: appColors["background"]!,
                                    // ),
                                    // iconSize: 30,
                                    // buttonHeight: 60,
                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                    // dropdownDecoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(15),
                                    // ),
                                    items: categories
                                        .map((item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select an event category.';
                                      }
                                    },
                                    onChanged: (value) {
                                      categoryController.text = value.toString();
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      //selectedEventType = value.toString();
                                    },
                                  ),
                                ),

                              // Center(child: Text("Venue",style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 20),)),

                              // Container(
                              //   margin: EdgeInsets.all(10),
                              //   decoration: BoxDecoration(
                              //     // color: Color(0xff36363D),
                              //     border: Border.all(color:appColors["grey"]!),
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(18.0),
                              //     child: TextFormField(
                              //       controller: eventExtraController,
                              //       autofocus: false,
                              //       cursorColor: appColors["primary"]!,
                              //       cursorRadius: Radius.circular(10),
                              //       decoration: InputDecoration(
                              //         border: InputBorder.none,
                              //         labelText: "Event Status Extra Information",
                              //         labelStyle: TextStyle(color: appColors["primary"]!),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // color: Color(0xff36363D),
                                  border: Border.all(color:appColors["grey"]!),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: TextFormField(
                                    controller: termsConditionsController,
                                    autofocus: false,
                                    cursorColor: appColors["primary"]!,
                                    cursorRadius: Radius.circular(10),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Terms and Conditions",
                                      labelStyle: TextStyle(color: appColors["primary"]!),
                                    ),
                                  ),
                                ),
                              ),

                              // SizedBox(
                              //   height: 100,
                              // ),
                                // ClumsyFinalButton("Save Details", Get.width*0.8, () { }, false,color: appColors["green"]!),
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Center(
                                  child: ClumsyRealButton("Save", Get.width*0.6, () async {
                                    HapticFeedback.lightImpact();
                                    await attemptSaveEvent();
                                  }, createWait
                                  ),
                                ),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                      flex: 3,
                                      child: clumsyTextLabel("Highlights",fontsize: 20,color: appColors["primary"]!)),
                                  Flexible(
                                    flex: 1,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        await callDialog("Add Highlight",
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    // color: Color(0xff36363D),
                                                    border: Border.all(color:appColors["grey"]!),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(18.0),
                                                    child: TextFormField(
                                                      controller: highlightController,
                                                      autofocus: false,
                                                      cursorColor: appColors["primary"]!,
                                                      cursorRadius: Radius.circular(10),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        labelText: "What's the highlight?",
                                                        labelStyle: TextStyle(color: appColors["primary"]!),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Row(
                                                  children: [
                                                    ClumsyFinalButton("Create", Get.width*0.4, () async {
                                                      Get.back();
                                                      if(await attemptCreateHightlight(eventId,highlightController.text)){
                                                        setState(() {});
                                                      }

                                                    }, false),
                                                    ClumsyFinalButton("Cancel", Get.width*0.4, () async {
                                                      Get.back();
                                                    }, false)
                                                  ],
                                                )
                                              ],
                                            )
                                        );
                                      },
                                      color: appColors["primary"]!,
                                      textColor: appColors["background"]!,
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 24,
                                          ),
                                          clumsyTextLabel("Create",fontsize: 10,color: appColors["background"]!)
                                        ],
                                      ),
                                      padding: EdgeInsets.all(16),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              // if(event.highlights.isNotEmpty) clientEventHighlights(event),
                              if(event.highlights.isEmpty) Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: clumsyTextLabel("No Highlights added...",fontsize: 10)),
                              ),
                              if(event.highlights.isNotEmpty)
                                ...List.generate(event.highlights.length, (index){
                                  print("listing Tickets Highlights");
                                  return Container(
                                    width: Get.width*0.8,
                                    // padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.only(top:18.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            flex:8,
                                            child: HightlightItem(highlight: event.highlights[index],)
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: InkWell(
                                              onTap: () async {
                                                await callDialog("Are you sure?", Row(
                                                  children: [
                                                    ClumsyFinalButton("No", Get.width*0.3, () {
                                                      Get.back();
                                                    }, false),
                                                    ClumsyFinalButton("Yes", Get.width*0.3, () async {
                                                      Get.back();
                                                      if(await attemptDeleteHighlight(eventId,event.highlights[index]))
                                                       {
                                                        setState(() {});
                                                       }
                                                    }, false)
                                                  ],
                                                )
                                                );
                                              },
                                              child: const Icon(Icons.delete,color: Colors.red,)
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        );
                      }
                      else
                      {
                        return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Some error Occured"),
                                Text(apiResponse.info!),
                              ],
                            )
                        );
                      }
                    },
                    error: (context, error, stackTrace) {
                      print(stackTrace.toString());
                      return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/favicon.png"),
                              Text("Some error Occured"),
                              // Text(error.toString()),
                              ClumsyRealButton("Retry", Get.width, () {
                                setState(() {

                                });
                              }, false),
                            ],
                          )
                      );
                    },
                  ),


                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Container(
                  //       width: Get.width*0.4,
                  //       margin: EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //         // color: Color(0xff36363D),
                  //         border: Border.all(color:appColors["grey"]!),
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(18.0),
                  //         child:SimpleAutoCompleteTextField(
                  //           keyboardType: TextInputType.streetAddress,
                  //           cursorColor: appColors["primary"]!,
                  //
                  //           decoration: InputDecoration(
                  //             border: InputBorder.none,
                  //             labelText: "City",
                  //             labelStyle: TextStyle(color: appColors["primary"]!),
                  //           ),
                  //           key:key,
                  //           controller: cityController,
                  //           suggestions: cityNames,
                  //         )
                  //
                  //       ),
                  //     ),
                  //     Container(
                  //       width: Get.width*0.4,
                  //       margin: EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //         // color: Color(0xff36363D),
                  //         border: Border.all(color:appColors["grey"]!),
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: Padding(
                  //           padding: const EdgeInsets.all(18.0),
                  //           child:TextFormField(
                  //             controller: stateController,
                  //             autofocus: false,
                  //             // maxLength: 20,
                  //             cursorColor: appColors["primary"]!,
                  //             cursorRadius: Radius.circular(10),
                  //             decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               labelText: "State",
                  //               labelStyle: TextStyle(color: appColors["primary"]!),
                  //             ),
                  //           ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Container(
                  //   width: Get.width,
                  //   margin: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     // color: Color(0xff36363D),
                  //     border: Border.all(color:appColors["grey"]!),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(18.0),
                  //     child:TextFormField(
                  //       keyboardType: TextInputType.number,
                  //       maxLength: 6,
                  //
                  //       controller: pincodeController,
                  //       autofocus: false,
                  //       cursorColor: appColors["primary"]!,
                  //       cursorRadius: Radius.circular(10),
                  //       decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         labelText: "Pincode",
                  //         labelStyle: TextStyle(color: appColors["primary"]!),
                  //       ),
                  //     ),
                  //
                  //   ),
                  // ),

                  // Container(
                  //   margin: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     // color: Color(0xff36363D),
                  //     border: Border.all(color:appColors["grey"]!),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(padding: EdgeInsets.all(10),
                  //       child: Text("Select a Google Location",style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 16),),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(18.0),
                  //         child: Container(
                  //           margin: EdgeInsets.all(10),
                  //           decoration: BoxDecoration(
                  //             // color: Color(0xff36363D),
                  //             border: Border.all(color:appColors["grey"]!),
                  //             borderRadius: BorderRadius.circular(20),
                  //           ),
                  //           child: Padding(
                  //               padding: const EdgeInsets.all(18.0),
                  //               child: InkWell(
                  //                 onTap: callDialog,
                  //                 child: Text("Search"),
                  //               )
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Center(child: Text("Date",style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 20),)),





                  // Container(
                  //   margin: EdgeInsets.only(bottom: 200),
                  //   child: Center(
                  //     child: ClumsyFinalButton("Save", Get.width*0.8, () async {
                  //       HapticFeedback.lightImpact();
                  //       // setState(() {
                  //       //   createWait = true;
                  //       // });
                  //       // await Future.delayed(const Duration(seconds: 2));
                  //       await attemptSaveEvent();
                  //
                  //       // Map<String,dynamic>? eventJson = eventFromForm();
                  //       //   if(eventJson != null)
                  //       //   {
                  //       //     APIResponse res= await Get.find<HostController>().createEvent(eventJson);
                  //       //     if(res.status == TextMessages.SUCCESS)
                  //       //     {
                  //       //       var event = res.data as Event;
                  //       //       showSnackbar(res.status,"Event Created");
                  //       //       Get.offAndToNamed(Routes.HOST_EVENT,arguments: event.id);
                  //       //     }
                  //       //     else{
                  //       //       showSnackbar("Error", res.info!);
                  //       //     }
                  //       //   }
                  //       //   else
                  //       //   {
                  //       //     showSnackbar("***", "Please fill all the required details");
                  //       //   }
                  //       // setState(() {
                  //       //   createWait = false;
                  //       // });
                  //     }, createWait
                  //     ),
                  //   ),
                  // ),

                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  // Map<String, dynamic>? eventFromForm() {
  //   // pending
  //   return {};
  // }

  Future<bool> attemptDeleteHighlight(String eventId,String highlight) async {
    APIResponse res = await Get.find<HostController>().deleteHighlight(eventId,highlight);
    if (res.status == TextMessages.SUCCESS) {
      showSnackbar(TextMessages.SUCCESS, "Successfully deleted the Highlight!");
      return true;
    }
    else {
      showSnackbar("Error", res.info!);
      return false;
    }
  }

  Future<bool> attemptCreateHightlight(String eventId,String highlight) async {
    APIResponse res = await Get.find<HostController>().createHighlight(eventId,highlight);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully created the Highlight!");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }

  }

}
