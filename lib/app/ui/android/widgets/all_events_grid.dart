import 'package:async_builder/async_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/gravity/student_controller.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/model/gravity/stream.dart';
import 'package:getx/app/ui/android/widgets/category_item.dart';
import '../../../controller/authentication/authentication.dart';
import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../routes/app_pages.dart';
import 'miscellaneous.dart';

class AllEventsGrid extends StatefulWidget {
  AllEventsGrid({Key? key}) : super(key: key);

  @override
  State<AllEventsGrid> createState() => _AllEventsGridState();
}

class _AllEventsGridState extends State<AllEventsGrid> {
  TextEditingController categoryController = TextEditingController();
  bool categoryWait = false;
  @override
  Widget build(BuildContext context) {
    print("events.length");
    return AsyncBuilder<APIResponse>(
      future: Get.find<StudentsController>().getStreams(),
      waiting: (context) {
        return Center(
          child: clumsyWaitingBar(),
        );
      },
      builder: (context,apiResponse){
        // print(apiResponse!.info);
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          List<GravityStream> streams = apiResponse.data as List<GravityStream>;
          // print("events.length");
          // print(events.length);
          return grid(streams,crossAxisCount: 3);
        }
        else
        {
          // showSnackbar("Error", apiResponse!.info!);

          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // headerBar("All Phases",parent: false),
                  clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
                  // Text(apiResponse!.info!),
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