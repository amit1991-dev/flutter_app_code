import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/constants/errors.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/provider/host_api.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/event_phases.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/event_page_caraousal.dart';
import '../widgets/host_event_media_list.dart';
import '../widgets/miscellaneous.dart';

class EventPage extends StatefulWidget {
  EventPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<EventPage> createState() => _State();
}

class _State extends State<EventPage> {
  late String eventId;
  bool agreed = false;
  _State(){
    eventId = Get.arguments;
    // eventId = "asdsad";
  }
  @override
  Widget build(BuildContext context) {
    // printCity();
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          future: Get.find<HomeController>().getEvent(eventId,test: true),
          waiting: (context) {
            return  Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
              {
                Event event = apiResponse.data as Event;
                return Column(
                  children: [
                    headerBar("Event Details",parent: true),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            clientEventHeader(event,showBooking: false),
                            if(event.medias.isNotEmpty)
                              EventMediaCarausal(eventId: event.id,),
                            clientEventDescription(event),
                            if(event.highlights.isNotEmpty) clientEventHighlights(event),
                            // Image.network(event.thumbnail!),
                            // ClumsyMediaList(event.medias),//images
                            // HostEventMediaListWidget(eventId: event.id,medias: event.medias),
                            // EventPhasesWidget(eventId: event.id, phases: event.phases)

                            // Text("Information",style: GoogleFonts.alatsi(fontSize: 22),),
                            SizedBox(
                              width: Get.width,
                              child: EventInfoWidget(event: event),
                            ),//info
                            clientEventTermsConditions(event),
                            // CheckboxListTile(
                            //   subtitle: Text("Please Read and Accept"),
                            //   // subtitle: Text("Please Read and Accept"),
                            //   activeColor: appColors["primary"]!,
                            //   checkColor: appColors["background"]!,
                            //   // tileColor: appColors["primary"]!,
                            //   title: Text("I accept the Terms & Conditions"),
                            //   value: agreed,
                            //   selectedTileColor: appColors["primary"]!,
                            //   onChanged: (newValue) {
                            //     setState(() {
                            //       agreed = newValue!;
                            //     });
                            //   },
                            //   controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                            // ),
                            SizedBox(
                              height: 50,
                            ),
                            clumsyTextLabel("*By proceeding you accept the Host's Terms and Conditions",fontsize: 12),
                            ClumsyFinalButton("Book Tickets!", Get.width*0.8, () {
                              Get.toNamed(Routes.EVENT_TICKETS,arguments: eventId);
                              // if(agreed) Get.toNamed(Routes.EVENT_TICKETS,arguments: eventId);
                              // else showSnackbar("Error", "Please Accept Host's Terms and Conditions");
                            }, false),
                            // TicketBookingWidget(event:event),//booking
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                );
              }
            else
              {
                return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(ErrorMessages.SOMETHINGS_WRONG),
                        // Text(error.toString()),
                      ],
                    )
                );
              }

          },
          error: (context, error, stackTrace) {
            print(error.runtimeType);
            print(error);
            return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text("Some error Occured"),
                    Text(error.toString()),

                  ],
                )
            );
          },
        ),
      ),
    );
    // return Container(
    //   child: Column(
    //     children: [
    //       ClumsyMediaList(event.medias),
    //       EventPhasesWidget(eventId: event.id, phases: event.phases)
    //     ],
    //   )
    // );
  }
}

