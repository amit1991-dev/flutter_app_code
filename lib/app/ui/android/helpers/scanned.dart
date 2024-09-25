import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/data/model/api_response.dart';
import 'package:getx/app/data/model/booking.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/provider/host_api.dart';
import 'package:getx/app/ui/android/widgets/event_phases.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../widgets/miscellaneous.dart';

class HelperScannedBookingPage extends StatefulWidget {
  HelperScannedBookingPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<HelperScannedBookingPage> createState() => _State();
}

class _State extends State<HelperScannedBookingPage> {
  late String bookingId;
  late double _selectedEntryCount = 1.0;
  _State(){
    bookingId = Get.arguments;
  }
  @override
  Widget build(BuildContext context) {


    return Container(
      child: Material(
        child: Column(
          children: [
            AsyncBuilder<APIResponse>(
              future: Get.find<HostController>().getBooking(bookingId),
              waiting: (context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              builder: (context,response){
                // RangeValues _currentRangeValues = RangeValues(0, booking!.personCount.toDouble());
                Booking booking = response!.data as Booking;
                int remaining = booking.personCount - booking.verified;
                _selectedEntryCount = booking!.personCount.toDouble();
                return Container(
                  child: Column(
                    children: [
                      //booking is available show event details
                      if(Get.find<Authentication>().user!.id == booking.host.id) TicketVerificationSlider(booking: booking),
                      EventInfoWidget(event: booking.event)
                    ],
                  )
                );
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
            )
          ],
        ),
      ),
    );
  }
}

