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

import '../../../data/model/booking.dart';
import '../widgets/event_page_caraousal.dart';
import '../widgets/host_event_media_list.dart';
import '../widgets/miscellaneous.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key? key}):super(key: key){
  }
  @override
  State<BookingPage> createState() => _State();
}

class _State extends State<BookingPage> {
  late String bookingId;
  bool agreed = false;
  _State(){
    bookingId = Get.arguments;
  }


  @override
  Widget build(BuildContext context) {
    // printCity();
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          future: Get.find<HomeController>().getBooking(bookingId),
          waiting: (context) {
            return  Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
              {
                Booking booking = apiResponse.data as Booking;
                Event event = booking.event;
                List<Ticket> tickets = booking.tickets;


                return Column(
                  children: [
                    headerBar("Booking Details",parent: true),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                // getQRCode(booking),
                                Container(
                                  width: Get.width*0.8,
                                    padding: EdgeInsets.all(0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      clumsyTextLabel("Tickets",color: appColors["primary"]!,fontsize: 25),
                                      Padding(
                                        padding: EdgeInsets.all(00),
                                        child:Column(
                                          children: [
                                            ...List.generate(tickets.length, (index){
                                              return clumsyTextLabel(color: appColors["white"]!,"${tickets[index]!.count.toString()!}x ${tickets[index].phase} ${tickets[index].category} ${tickets[index].ticket}");

                                            })
                                          ],

                                        ) ,
                                      )
                                    ],
                                  ),
                                ),
                                clientVenueItem(event),

                                clientEventListTile(event,showBook: false),
                                clientTransactionItem(booking.transaction),

                                clientEventTermsConditions(event),

                                // Container(
                                //   padding: EdgeInsets.all(20),
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       clumsyTextLabel("Venue",color: appColors["primary"]!),
                                //       Padding(
                                //         padding: EdgeInsets.all(20),
                                //         child:Column(
                                //           children: [
                                //             ...List.generate(tickets.length, (index){
                                //               return Text("${tickets[index]!.count.toString()!}x:${tickets[index].phase} ${tickets[index].category} ${tickets[index].ticket}");
                                //
                                //             })
                                //           ],
                                //
                                //         ) ,
                                //       )
                                //     ],
                                //   ),
                                // ),

                                SizedBox(
                                  height: 50,
                                ),



                                SizedBox(
                                  height: 100,
                                ),
                              ],
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        headerBar("Booking Details",parent: true),
                        Spacer(),
                        Text(ErrorMessages.SOMETHINGS_WRONG),
                        Spacer()
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
                    headerBar("Booking Details",parent: true),
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

