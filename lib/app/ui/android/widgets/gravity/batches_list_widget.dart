import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/gravity/student_controller.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/data/model/gravity/batch.dart';
import 'package:getx/app/ui/android/widgets/category_item.dart';
import '../../../../controller/authentication/authentication.dart';
import '../../../../controller/host_controller.dart';
import '../../../../data/constants/errors.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
// import '../../../../data/model/booking.dart';
import '../../../../data/model/host_info.dart';
import '../../../../routes/app_pages.dart';
import '../miscellaneous.dart';

class BatchListWidget extends StatefulWidget {
  BatchListWidget({Key? key}) : super(key: key);

  @override
  State<BatchListWidget> createState() => _BatchListWidgetState();
}

class _BatchListWidgetState extends State<BatchListWidget> {
  // TextEditingController accountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
      future: Get.find<StudentsController>().getBatches(),
      waiting: (context) {
        return Center(
          child: clumsyWaitingBar(),
        );
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          List<Batch> batches = apiResponse.data as List<Batch>;
          // print(booking.id);
          // List<PhaseCategory> categories = phase.categories;
          return Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),

            decoration: BoxDecoration(
              // border: Border.all(color: appColors["grey"]!),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      clumsyTextLabel("All Batches",fontsize: 20,color: appColors['primary']),
                      Spacer(),
                      // InkWell(
                      //     onTap: (){},
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: clumsyTextLabel("View All",fontsize: 14,color: appColors['blue']),
                      //     )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: clumsyTextLabel("Session: 2023-2024",fontsize: 14,color: appColors['grey']),
                ),


                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:Row(
                    children: [
                      ...List.generate(batches.length, (index){
                        return  InkWell(
                          onTap: (){
                            // Get.toNamed("");
                            Get.toNamed(Routes.BATCH_PAGE,arguments: batches[index].id);
                          },
                          customBorder: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          splashColor: appColors["primary"],
                          child: Container(
                            width: Get.width*0.35,
                            height: 100,
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: appColors['white'],
                                // border: Border.all(color: appColors['primary']!),
                                boxShadow: const [BoxShadow(color: Colors.grey,spreadRadius: 0,blurRadius: 5,offset: Offset(2,2))]
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: SizedBox(
                                        height:20,
                                        child: Image.asset('assets/images/glogoB.png')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: clumsyTextLabel(batches[index].name,color: appColors['primary']),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ],
            )
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