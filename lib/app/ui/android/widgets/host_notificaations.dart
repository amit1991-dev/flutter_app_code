import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/ui/android/widgets/category_item.dart';
import '../../../controller/authentication/authentication.dart';
import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/booking.dart';
import '../../../data/model/host_info.dart';
import 'miscellaneous.dart';

class HostNotifications extends StatefulWidget {
  late String hostId;
  HostNotifications({required this.hostId,Key? key}) : super(key: key);

  @override
  State<HostNotifications> createState() => _HostNotificationsState();
}

class _HostNotificationsState extends State<HostNotifications> {
  // TextEditingController accountController = TextEditingController();
  bool bookingWait = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AsyncBuilder<APIResponse>(
        future: Get.find<HostController>().getHostInfo(widget.hostId),
        waiting: (context) {
          return Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context,apiResponse){
          if(apiResponse!.status == TextMessages.SUCCESS)
          {
            HostInfo hi = apiResponse.data as HostInfo;
            // print(booking.id);
            // List<PhaseCategory> categories = phase.categories;
            return Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),

              decoration: BoxDecoration(
                // border: Border.all(color: appColors["grey"]!),
                borderRadius: BorderRadius.circular(20)
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // clumsyTextLabel("Notifications",color: appColors["primary"]!,fontsize: 22),
                    if(hi.notifications.isEmpty)
                      clumsyTextLabel("Looks like there are none...",color: appColors["white"]!,fontsize: 12),


                    ...List.generate(hi.notifications.length, (index){
                      return Center(
                        child: clumsyTextLabel(hi.notifications[index],color: appColors["primary"]!,fontsize: 22),
                      );
                    }),
                    SizedBox(
                      height: 20,
                    ),
                  ]
                ),
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
                    headerBar("Host Information",parent: false),
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
      ),
    );
  }

  Future<bool> attemptSaveHostDetails(Map<String,dynamic> data) async{
    print("attempting to save host data");
    // eventJson['event_id'] = widget.eventId;

    APIResponse res = await Get.find<HostController>().editHostInformation(data);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully saved");
      // Get.find<Authentication>().user!.email = text;
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }
    return true;
  }


}