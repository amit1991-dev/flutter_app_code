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
import '../../../data/model/media.dart';
import '../../../routes/app_pages.dart';
import 'miscellaneous.dart';

class EventMediaCarausal extends StatefulWidget {
  late String eventId;
  EventMediaCarausal({required this.eventId,Key? key}) : super(key: key);
  @override
  State<EventMediaCarausal> createState() => _EventMediaCarausalState();
}

class _EventMediaCarausalState extends State<EventMediaCarausal> {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AsyncBuilder<APIResponse>(
      future: Get.find<HomeController>().getEvent(widget.eventId),
      waiting: (context) {
        return Center(
          child: clumsyWaitingBar(),
        );
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          Event event = apiResponse.data as Event;
          List<Media> medias = event.medias;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // clumsyTextLabel("Gallary",color: appColors["primary"]!),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(medias.length, (itemIndex) => Center(
                        child: InkWell(
                          onTap: (){
                            Get.toNamed(Routes.IMAGE_VIEWER,arguments: medias[itemIndex].url);
                          },
                          child: Container(
                            height: 200,
                            width: Get.width*0.3,
                            margin: EdgeInsets.all(10),
                            decoration:  BoxDecoration(
                                color: appColors["background"]!,
                                border: Border.all(color: appColors["grey"]!),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  // image: NetworkImage("https://picsum.photos/100/550"),
                                    image: NetworkImage(medias[itemIndex].url),
                                    // image: AssetImage("assets/images/pager.jpg"),
                                    fit: BoxFit.cover)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                      ),),
                    ],
                  ),
                ),
                // CarouselSlider.builder(
                //   itemCount: medias.length,
                //   itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                //       Stack(
                //         children: [
                //           Center(
                //             child: Container(
                //               height: 200,
                //               width: Get.width*0.3,
                //               margin: EdgeInsets.all(10),
                //               decoration:  BoxDecoration(
                //                   color: appColors["background"]!12,
                //                   border: Border.all(color: appColors["primary"]!),
                //                   borderRadius: BorderRadius.circular(20),
                //                   image: DecorationImage(
                //                     // image: NetworkImage("https://picsum.photos/100/550"),
                //                       image: NetworkImage(medias[itemIndex].url),
                //                       fit: BoxFit.cover)),
                //               child: const Padding(
                //                 padding: EdgeInsets.all(8.0),
                //               ),
                //             ),
                //           ),
                //           Container(
                //             // height: 350.0,
                //             decoration: BoxDecoration(
                //                 color: appColors["background"]!,
                //                 gradient: LinearGradient(
                //                     begin: FractionalOffset.topCenter,
                //                     end: FractionalOffset.bottomCenter,
                //                     colors: [
                //                       appColors["background"]!.withOpacity(0.1),
                //                       appColors["background"]!.withOpacity(0.8),
                //                     ],
                //                     stops: const [
                //                       0.0,
                //                       1.0
                //                     ])),
                //           ),
                //         ],
                //       ),
                //   options:CarouselOptions(autoPlay: true),
                // ),
                // Center(
                //   child: Column(
                //     children: [
                //       // Image.asset("assets/images/logo_title.png",width: Get.width/1.5,),
                //       if(events.isEmpty)
                //         Image.asset("assets/images/c_logo.png")
                //
                //     ],
                //   ),
                // )
            ],
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