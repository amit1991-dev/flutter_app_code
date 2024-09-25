

import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';

import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import '../../../../data/model/event.dart';
import '../miscellaneous.dart';

class UpcomingEventsWidget extends StatelessWidget {
  const UpcomingEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
      future: Get.find<HomeController>().getCategoryEvents("upcoming",test: true),
      waiting: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          List<Event> events = apiResponse.data as List<Event>;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15, left: 15, top: 15),
                child: Text(
                  "Upcoming Events",
                  style: TextStyle(
                      color: appColors["primary"]!,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(events.length, (index) {
                        return InkWell(
                        splashColor: appColors["primary"]!,
                        onTap: (){print(1);},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 225,
                            height: 200,
                            decoration: BoxDecoration(
                                border: Border.all(color:appColors["primary"]!,style: BorderStyle.solid,width: 2),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: getThumbnail(events[index]), fit: BoxFit.cover)),
                          ),
                        ),
                      );
                    })

                  ],
                ),
              )
            ],
          );
        }
        else
          {
            return Text("Ops, Something Went Wrong");
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



