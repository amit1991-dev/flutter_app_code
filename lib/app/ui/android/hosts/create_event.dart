import 'dart:convert';
import 'dart:ui';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/model/city_state.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/event.dart';
import '../../../routes/app_pages.dart';
import '../widgets/google_places.dart';
import 'package:http/http.dart' as http;

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});


  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  bool createWait=false,cityLoading = false;
  String? _range,_dateCount,_rangeCount;
  bool multiDay = false;
  var eventMode = DateRangePickerSelectionMode.single;
  late String city,state;
  DateTime? eventDate,endDate;
  CityState defaultcitystate = CityState.defaultCity();
  // TextEditingController cityController = TextEditingController();
  // TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  // List<String> cityNames = ["a","b","c","d"];
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  _CreateEventPageState(){
    city = defaultcitystate.city;
    state = defaultcitystate.state;
  }

  dynamic attemptCreateEvent() async {
    if (kDebugMode) {
      print("attempting to create the event");
    }
    Map<String,dynamic> eventJson = {};
    if(nameController.text.isEmpty)
      {
        showSnackbar("Error", "Please enter a NAME for the event");
        return;
      }
    eventJson['name'] = nameController.text;

    if(venueController.text.isEmpty)
    {
      showSnackbar("Error", "Please enter a VENUE for the event");
      return;
    }

    eventJson['venue'] = venueController.text;



    if(pincodeController.text.isEmpty || pincodeController.text.length != 6)
    {
      showSnackbar("Error", "Please enter a proper PINCODE");
      return;
    }
    eventJson['pincode'] = pincodeController.text;
    if(city== "Any City" || state == "Any State")
    {
      showSnackbar("Error", "Could not find a city/state from the pincode, make sure it is correct");
      return;
    }
    eventJson['city'] = city;
    eventJson['state'] = state;


    if(eventDate == null)
      {
        showSnackbar("Error", "Please enter a proper DATE");
        return;
      }
    eventJson['event_timestamp'] = eventDate.toString();
    if(multiDay)
      {

        eventJson['event_duration'] = _range;
      }
    setState(() {
      createWait = true;
    });

    APIResponse res = await Get.find<HostController>().createEvent(eventJson);
    if(res.status == TextMessages.SUCCESS)
      {
        Event event= res.data as Event;
        showSnackbar(TextMessages.SUCCESS,"Successfully created the Event!");
        Get.toNamed(Routes.HOST_EVENT_DETAILS,arguments: event.id);
      }
    else
      {
        showSnackbar("Error", res.info!);
      }
    if (kDebugMode) {
      print("finished creating the event");
    }

    setState(() {
      createWait = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        if (args.value is PickerDateRange) {
          eventDate = args.value.startDate;
          endDate = args.value.endDate;
          _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        } else {
          eventDate = args.value;
        }

        // if (args.value is PickerDateRange) {
        //   eventDate = args.value.startDate;
        //   _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        // } else if (args.value is DateTime) {
        //   eventDate = args.value;
        // } else if (args.value is List<DateTime>) {
        //   eventDate = args.value.startDate;
        //   _dateCount = args.value.length.toString();
        // } else {
        //   eventDate = args.value.startDate;
        //   _rangeCount = args.value.length.toString();
        // }
      });
    }

    void toggleSwitch(bool value) {
      if(!multiDay)
      {
        setState(() {
          multiDay = true;
          eventMode = DateRangePickerSelectionMode.range;
        });
        print('Switch Button is ON');
      }
      else
      {
        setState(() {
          multiDay = false;
          eventMode = DateRangePickerSelectionMode.single;
        });
        print('Switch Button is OFF');
      }
    }

    void callDialog(){
      Get.defaultDialog(
          title: "Search Google Places",
          // middleText: "Select A place",
          backgroundColor: appColors["background"]!,
          titleStyle: TextStyle(color: appColors["white"]!),
          middleTextStyle: TextStyle(color: appColors["white"]!),
          radius: 20,

          content: WidgetGooglePlaces()
      );
    }

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
                  headerBar("Create Event",parent: false),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Please Note: Venue & Date cannot be changed later on", style:GoogleFonts.ubuntu(color: appColors["grey"]!,fontSize: 12)),
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
                        controller: nameController,
                        autofocus: false,
                        cursorColor: appColors["primary"]!,
                        cursorRadius: Radius.circular(10),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Name of the Event",
                          labelStyle: TextStyle(color: appColors["primary"]!),
                        ),
                      ),
                    ),
                  ),
                  // Center(child: Text("Venue",style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 20),)),
                  Divider(color: appColors["primary"]!,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Venue", style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 22)),
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
                        controller: venueController,
                        autofocus: false,
                        cursorColor: appColors["primary"]!,
                        cursorRadius: Radius.circular(10),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Address",
                          labelStyle: TextStyle(color: appColors["primary"]!),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Color(0xff36363D),
                      border: Border.all(color:appColors["grey"]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child:TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 6,

                        controller: pincodeController,
                        onChanged: (value) async {
                          if(value!=null && value.length ==6)
                            {
                              setState(() {
                                cityLoading = true;
                              });
                              var url = Uri.http('postalpincode.in', 'api/pincode/$value');
                              var response = await http.get(url);
                              print(response.body);
                              if(response.statusCode==200)
                                {
                                  Map<String,dynamic> pincodeData = jsonDecode(response.body);
                                  if(pincodeData['Status']=="Success")
                                    {
                                      dynamic data = pincodeData['PostOffice'][0];
                                      String localCity = data['District'];
                                      String localState = data['State'];
                                      bool found= false;
                                      for(var c in cities)
                                        {
                                          if(c.city == localCity && c.state == localState)
                                            {
                                              city = c.city;
                                              state = c.state;
                                              found = true;
                                              break;
                                            }
                                        }
                                      if(!found)
                                        {
                                          showSnackbar("Error", "$localCity: Not yet allowed for the city");
                                          pincodeController.clear();
                                        }



                                    }
                                }
                              setState(() {
                                cityLoading = false;
                              });
                              // print('Response status: ${response.statusCode}');
                              // print('Response body: ${response.body}');
                              //
                              // print(await http.read(Uri.https('example.com', 'foobar.txt')));
                            }
                        },
                        autofocus: false,
                        cursorColor: appColors["primary"]!,
                        cursorRadius: Radius.circular(10),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Pincode",
                          labelStyle: TextStyle(color: appColors["primary"]!),
                        ),
                      ),

                    ),
                  ),
                  if(cityLoading) Center(child: clumsyWaitingBar(),),
                  if(!cityLoading)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        clumsyTextLabel(city,color: appColors["primary"]!),
                        clumsyTextLabel(state,color:appColors["primary"]!),
                      ],
                  ),
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
                  // DropdownButtonFormField2(
                  //   value: "${cityController.text}:${stateController.text}",
                  //
                  //   // value: "${Get.find<HomeController>().cityState.value.city}:${Get.find<HomeController>().cityState.value.state}",
                  //   decoration: InputDecoration(
                  //     //Add isDense true and zero Padding.
                  //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  //     // isDense: true,
                  //     contentPadding: EdgeInsets.all(10),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     //Add more decoration as you want here
                  //     //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  //   ),
                  //   isExpanded: true,
                  //   onChanged: (value) {
                  //     cityController.text = value!.split(":")[0];
                  //     stateController.text = value!.split(":")[1];
                  //     print("values changes");
                  //     print("${cityController.text}");
                  //     //Do something when changing the item if you want.
                  //     // Get.find<HomeController>().cityState.value = CityState(city: value!.split(":")[0], state: value!.split(":")[1]);
                  //   },
                  //   // focusColor: appColors["primary"]!,
                  //   // buttonHighlightColor: appColors["primary"]!,
                  //   // selectedItemHighlightColor: appColors["primary"]!,
                  //   onSaved: (value) {
                  //     print(value);
                  //     // selectedValue = value.toString();
                  //   },
                  //   hint: const Text(
                  //     'Select Your City',
                  //     style: TextStyle(fontSize: 14),
                  //   ),
                  //   items: cities.map((e){
                  //     print(e.city);
                  //     return DropdownMenuItem(
                  //
                  //         value:"${e.city}:${e.state}",
                  //         child:Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             clumsyTextLabel(e.city,fontsize: 12,color: appColors["primary"]!),
                  //             // clumsyTextLabel(e.state,fontsize: 10),
                  //           ],
                  //         ));
                  //   }).toList(),
                  // ),
                      // Container(
                      //   width: Get.width*0.4,
                      //   margin: EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //     // color: Color(0xff36363D),
                      //     border: Border.all(color:appColors["grey"]!),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Padding(
                      //       padding: const EdgeInsets.all(18.0),
                      //       child:TextFormField(
                      //         controller: stateController,
                      //         autofocus: false,
                      //         // maxLength: 20,
                      //         cursorColor: appColors["primary"]!,
                      //         cursorRadius: Radius.circular(10),
                      //         decoration: InputDecoration(
                      //           border: InputBorder.none,
                      //           labelText: "State",
                      //           labelStyle: TextStyle(color: appColors["primary"]!),
                      //         ),
                      //       ),
                      //   ),
                      // ),
                  //   ],
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
                  Divider(color: appColors["primary"]!,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(multiDay?"Select Dates":"Select a Date", style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 22)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // color: appColors["grey"]!
                      //   color: Color(0xff36363D),
                      border: Border.all(color: appColors["grey"]!)
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Multi Day event?",style:GoogleFonts.ubuntu(color: appColors["grey"]!,fontSize: 16)),
                        ),
                        Switch(
                          onChanged: toggleSwitch,
                          value: multiDay,
                          activeColor: appColors["primary"]!,
                          activeTrackColor: appColors["white"]!,
                          inactiveThumbColor: appColors["grey"]!,
                          inactiveTrackColor: appColors["grey"]!,
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: eventMode,
                      initialDisplayDate: DateTime.now(),
                      enablePastDates: false,
                      selectionTextStyle: TextStyle(color:appColors["background"]!),
                      selectionColor: appColors["primary"]!,
                      todayHighlightColor: appColors["blue"]!,
                      startRangeSelectionColor: appColors["primary"]!,
                      endRangeSelectionColor: appColors["primary"]!,
                      showTodayButton: false,
                      rangeSelectionColor: appColors["white"]!.withOpacity(0.1),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 200),
                    child: Center(
                      child: ClumsyFinalButton("Create Event", Get.width*0.8, () async {
                        HapticFeedback.lightImpact();
                        setState(() {
                          createWait = true;
                        });
                        // await Future.delayed(const Duration(seconds: 2));
                        await attemptCreateEvent();

                        // Map<String,dynamic>? eventJson = eventFromForm();
                        //   if(eventJson != null)
                        //   {
                        //     APIResponse res= await Get.find<HostController>().createEvent(eventJson);
                        //     if(res.status == TextMessages.SUCCESS)
                        //     {
                        //       var event = res.data as Event;
                        //       showSnackbar(res.status,"Event Created");
                        //       Get.offAndToNamed(Routes.HOST_EVENT,arguments: event.id);
                        //     }
                        //     else{
                        //       showSnackbar("Error", res.info!);
                        //     }
                        //   }
                        //   else
                        //   {
                        //     showSnackbar("***", "Please fill all the required details");
                        //   }
                        setState(() {
                          createWait = false;
                        });
                      }, createWait),
                    ),
                  )
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
}
