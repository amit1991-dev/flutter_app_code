import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/controller/payments/razorpay.dart';
import 'package:getx/app/data/constants/errors.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/provider/host_api.dart';
import 'package:getx/app/ui/android/widgets/event_phases.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/event_page_caraousal.dart';
import '../widgets/host_event_media_list.dart';
import '../widgets/miscellaneous.dart';
import '../widgets/ticket_categories.dart';

class TicketSelection extends StatefulWidget {
  TicketSelection({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<TicketSelection> createState() => _State();
}

class _State extends State<TicketSelection> {
  late String eventId;
  _State(){
    eventId = Get.arguments;
    // eventId = "asdsad";
  }

  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    headerBar("Book Ticket!!",parent: true),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            clientEventListTile(event,showBook: false),

                            // TicketBookingWidget(event:event),//booking
                            SizedBox(
                              height: 50,
                            ),

                            // clumsyTextLabel("Event"),
                            // clumsyTextLabel(event.name),
                            // if(event.currentPhase!=null) clumsyTextLabel("Current Active Booking Phase"+event.currentPhase!.name),
                            if(event.currentPhase!=null) TicketCategories(event: event),
                            // TicketCategories(event: event),
                            // SizedBox(
                            //   height: 50,
                            // ),
                            // Spacer(),
                            SizedBox(
                              height: 100,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                clumsyTextLabel("Total"),
                                GetBuilder<HomeController>(builder: (controller){
                                  return clumsyTextLabel("Rs. ${controller.cartTotal(event)}",fontsize: 30,color: appColors["primary"]!);
                                })
                              ],
                            ),

                            ClumsyFinalButton("Checkout", Get.width*0.7, () async {
                              showSnackbar("Checkout", "Opening Transaction");
                              await Get.find<RazorPayments>().attemptPayment( Get.find<HomeController>().cartTotal(event), "Tickets");
                            }, false)
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

