import 'package:async_builder/async_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/authentication/authentication.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/model/booking.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:getx/app/ui/android/widgets/phase_item.dart';

import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/event.dart';
import '../../../data/model/user.dart';
import '../../../routes/app_pages.dart';
import 'booking_item.dart';
import 'event_phase.dart';

class UserBookingList extends StatefulWidget {
  const UserBookingList();
  @override
  State<UserBookingList> createState() => _UserBookingListState();
}

class _UserBookingListState extends State<UserBookingList> {
  late User u;
  @override
  void initState() {
    if(Get.find<Authentication>().user != null)
      {
        u = Get.find<Authentication>().user!;
      }
    else
      {
        showSnackbar("Error", "User not logged in!");
      }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
      future: Get.find<HomeController>().getBookings(),
      waiting: (context) {
        return clumsyWaitingBar();
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          List<Booking> bookings = apiResponse.data as List<Booking>;
          print(bookings);
          return SingleChildScrollView(
            child: Column(
              children: [
                // clumsyTextLabel("Bookings",fontsize: 22),
                if(bookings.isNotEmpty)
                  ...List.generate(bookings.length, (index){
                    return BookingItem(booking: bookings[index]);
                  }),
                if (bookings.isEmpty) const Text("Seems like You have no bookings yet"),
              ],
            ),
          );
        }
        else
        {
          print(apiResponse!.info!);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // clumsyTextLabel("My Bookings",color: appColors["primary"]!,fontsize: 18),
                    Text(ErrorMessages.SOMETHINGS_WRONG),
                    ClumsyFinalButton("Retry", Get.width*0.6, () {
                      setState(() {
                      });
                    }, false)
                    // Text(error.toString()),
                  ],
                )
            ),
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
    );
  }

}
