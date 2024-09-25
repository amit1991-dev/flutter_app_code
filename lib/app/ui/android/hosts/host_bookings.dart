import 'package:async_builder/async_builder.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getx/app/data/model/booking.dart';
import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../widgets/miscellaneous.dart';

class HostBookings extends StatefulWidget {
  const HostBookings({Key? key}) : super(key: key);

  @override
  State<HostBookings> createState() => _HostBookingsState();
}

class _HostBookingsState extends State<HostBookings> {
  late String eventId;

  @override
  void initState() {
    eventId  = Get.arguments as String;
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: appColors["background"]!,
      child: SafeArea(
        child: Column(
          children: [
            headerBar("All Bookings",parent: true),
            AsyncBuilder<APIResponse>(
              future: Get.find<HostController>().getMyBookings(eventId,test: false),
              waiting: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              builder: (context,apiResponse){
                if(apiResponse!.status == TextMessages.SUCCESS)
                {
                  print("yes");
                  List<Booking> bookings = apiResponse.data as List<Booking>;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        if(bookings.isNotEmpty)
                          ...List.generate(bookings.length, (index){
                            return hostBookingListTile(bookings[index]);
                          })
                        else
                          Center(
                            child: Column(
                              children: [
                                Image.asset("assets/images/logo_title.png",width: Get.width/1.5,),
                                const Text("Seems like You have 0 Bookings"),
                              ],
                            ),
                          )
                      ],
                    ),
                  );
                }
                else
                {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(ErrorMessages.SOMETHINGS_WRONG),
                      // Text(error.toString()),
                    ],
                  );
                }

              },
              error: (context, error, stackTrace) {
                return Column(
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
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
