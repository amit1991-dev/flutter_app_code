import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:get/get.dart';
import '../../../controller/home/home_controller.dart';
import '../../../controller/authentication/authentication.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/notification.dart';
import 'miscellaneous.dart';

class UserNotifications extends StatefulWidget {
  late String userId;
  UserNotifications({required this.userId,Key? key}) : super(key: key);

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  // TextEditingController accountController = TextEditingController();
  bool bookingWait = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AsyncBuilder<APIResponse>(
        future: Get.find<HomeController>().getNotifications(Get
            .find<Authentication>()
            .user!
            .id),
        waiting: (context) {
          return Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context, apiResponse) {
          if (apiResponse!.status == TextMessages.SUCCESS) {
            List<Notification> nots = apiResponse.data as List<Notification>;
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
                      if(nots.isEmpty)
                        clumsyTextLabel(
                            "Looks like there are none...", color: appColors["white"]!,
                            fontsize: 12),


                      ...List.generate(nots.length, (index) {
                        return Center(
                          child: clumsyTextLabel(
                              nots[index].body, color: appColors["primary"]!, fontsize: 22),
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
          else {
            // showSnackbar("Error", apiResponse!.info!);
            print(apiResponse!.info!);
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // headerBar("Host Information",parent: false),
                    Text(ErrorMessages.SOMETHINGS_WRONG),
                    ClumsyFinalButton("Retry", Get.width * 0.6, () {
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
}