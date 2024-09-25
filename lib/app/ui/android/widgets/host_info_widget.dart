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

class HostInfoWidget extends StatefulWidget {
  late String hostId;
  HostInfoWidget({required this.hostId,Key? key}) : super(key: key);

  @override
  State<HostInfoWidget> createState() => _HostInfoWidgetState();
}

class _HostInfoWidgetState extends State<HostInfoWidget> {
  TextEditingController accountController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  // TextEditingController accountController = TextEditingController();
  bool bookingWait = false;
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
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
          accountController.text = hi.account;
          ifscController.text = hi.ifsc;
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
                  clumsyTextLabel("Host Information",color: appColors["primary"]!,fontsize: 22),
                  clumsyTextLabel("Account Number"),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: appColors["primary"]!,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // clumsyTextLabel("Email"),
                        clumsyTextLabel(accountController.text,color: appColors["background"]!),
                        // if(hi.account=="-")
                          InkWell(
                            child: Icon(Icons.edit,color: appColors["background"]!,),
                            onTap: () async {
                              var ret = await callDialog("Account Number",
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: appColors["background"]!,
                                          border: Border.all(color:appColors["grey"]!),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: TextFormField(
                                            controller:accountController,
                                            autofocus: false,
                                            cursorColor: appColors["primary"]!,
                                            cursorRadius: Radius.circular(10),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: "Account Number",
                                              labelStyle: TextStyle(color: appColors["primary"]!),
                                            ),
                                          ),
                                        ),
                                      ),

                                      ClumsyFinalButton("Save", Get.width*0.7, () async {
                                        Get.back();
                                        Map<String,dynamic> data = {"account_number":accountController.text} ;
                                        // await attemptSaveHostDetails(data);
                                        await attemptSaveHostDetails(data);

                                        setState(() {
                                          // phaseWait=false;
                                        });
                                      }, false),
                                      ClumsyRealButton("Cancel", Get.width*0.7, () async {
                                        Get.back();
                                      }, false)
                                    ],
                                  )
                              );
                            },
                          ),
                        if(Get.find<Authentication>().user!.email!=null)
                          InkWell(
                            child: Icon(Icons.edit_note_outlined,color: appColors["primary"]!,),
                            onTap: () async {
                            },
                          )

                      ],
                    ),
                  ),
                  clumsyTextLabel("IFSC Code"),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: appColors["primary"]!,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // clumsyTextLabel("Email"),
                        clumsyTextLabel(ifscController.text,color: appColors["background"]!),
                        // if(hi.account=="-")
                        InkWell(
                          child: Icon(Icons.edit,color: appColors["background"]!,),
                          onTap: () async {
                            var ret = await callDialog("IFSC Code",
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: appColors["background"]!,
                                        border: Border.all(color:appColors["grey"]!),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: TextFormField(
                                          controller:ifscController,
                                          autofocus: false,
                                          cursorColor: appColors["primary"]!,
                                          cursorRadius: Radius.circular(10),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "IFSC",
                                            labelStyle: TextStyle(color: appColors["primary"]!),
                                          ),
                                        ),
                                      ),
                                    ),

                                    ClumsyFinalButton("Save", Get.width*0.7, () async {
                                      Get.back();
                                      Map<String,dynamic> data = {"ifsc":ifscController.text} ;
                                      // await attemptSaveHostDetails(data);
                                      await attemptSaveHostDetails(data);

                                      setState(() {
                                        // phaseWait=false;
                                      });
                                    }, false),
                                    ClumsyRealButton("Cancel", Get.width*0.7, () async {
                                      Get.back();
                                    }, false)
                                  ],
                                )
                            );
                          },
                        ),
                        if(Get.find<Authentication>().user!.email!=null)
                          InkWell(
                            child: Icon(Icons.edit_note_outlined,color: appColors["primary"]!,),
                            onTap: () async {
                            },
                          )

                      ],
                    ),
                  ),
                  // clumsyTextLabel("Notifications",color: appColors["primary"]!,fontsize: 22),
                  // if(hi.notifications.isEmpty)
                  //   clumsyTextLabel("Looks like there are none...",color: appColors["white"]!,fontsize: 12),
                  //
                  //
                  // ...List.generate(hi.notifications.length, (index){
                  //   return Center(
                  //     child: clumsyTextLabel(hi.notifications[index],color: appColors["primary"]!,fontsize: 22),
                  //   );
                  // }),
                  // SizedBox(
                  //   height: 20,
                  // ),

                ],
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