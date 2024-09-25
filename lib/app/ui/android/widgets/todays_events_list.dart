import 'package:async_builder/async_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/ui/android/widgets/category_item.dart';
import '../../../controller/authentication/authentication.dart';
import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../routes/app_pages.dart';
import 'miscellaneous.dart';

class TodaysEventsList extends StatefulWidget {
  TodaysEventsList({Key? key}) : super(key: key);

  @override
  State<TodaysEventsList> createState() => _TodaysEventsListState();
}

class _TodaysEventsListState extends State<TodaysEventsList> {
  TextEditingController categoryController = TextEditingController();
  bool categoryWait = false;
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
      future: Get.find<HomeController>().getEventsTodays(),
      waiting: (context) {
        return Center(
          child: clumsyWaitingBar(),
        );
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          List<Event> events = apiResponse.data as List<Event>;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                if (events.isNotEmpty)
                   Padding(
                      padding: EdgeInsets.only(bottom: 15, left: 15, top: 15),
                      child: clumsyTextLabel("Today's Events",color: appColors["primary"]!)
                    // child: ("Today's Events"),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    for( var e in events)
                      eventNormalList(e),
                  ],
                ),
              ],
            ),
          );
        }
        else
        {
          // showSnackbar("Error", apiResponse!.info!);
          print(apiResponse!.info!);
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // headerBar("All Phases",parent: false),
                  Text(ErrorMessages.SOMETHINGS_WRONG),
                  ClumsyFinalButton("Retry", Get.width*0.6, () {
                    setState(() {

                    });
                  }, false)
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
    );
  }


}