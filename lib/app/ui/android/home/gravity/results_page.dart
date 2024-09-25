import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../data/constants/errors.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import '../../../../data/model/gravity/result.dart';
import '../../../../routes/app_pages.dart';
import '../../widgets/miscellaneous.dart';

class TestResultPage extends StatefulWidget {
  TestResultPage({Key? key}) : super(key: key) {
    // Get.put<HostController>(HostController());
  }
  @override
  State<TestResultPage> createState() => _State();
}

class _State extends State<TestResultPage> {
  late String testResultId;
  bool agreed = false;
  _State() {
    testResultId = Get.arguments;
    print("Test id on report page:$testResultId");
  }
  @override
  Widget build(BuildContext context) {
    // printCity();
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          future: Get.find<StudentsController>().getTestResult(testResultId),
          waiting: (context) {
            return Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context, apiResponse) {
            if (apiResponse!.status == TextMessages.SUCCESS) {
              Result testResult = apiResponse.data as Result;
              return Column(
                children: [
                  headerBar("Test Results", parent: true),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                            getResultWidget(context, testResult)

                          // if (testResult.declarationTime == null ||
                          //     (DateTime.tryParse(testResult.declarationTime!) !=
                          //             null &&
                          //         DateTime.tryParse(
                          //                     testResult.declarationTime!)!
                          //                 .compareTo(DateTime.now()) <
                          //             0))
                          //   getResultWidget(context, testResult)
                          // else
                          //   clumsyText(
                          //       "Declation date is ${testResult.declarationTime!.split("T")[0]}"),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  headerBar("Test Results", parent: false),
                  clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
                  clumsyTextLabel(apiResponse.info!.toString(), fontsize: 10),
                  ClumsyRealButton("Head Home", Get.width, () {
                    Get.offAllNamed(Routes.HOME);
                  }, false)
                ],
              ));
            }
          },
          error: (context, error, stackTrace) {
            print(error.runtimeType);
            print(error);
            return Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Some error Occured"),
                Text(error.toString()),
              ],
            ));
          },
        ),
      ),
    );
    // return Container(
    //   child: Column(
    //     children: [
    //       ClumsyMediaList(event.medias),
    //       EventPhasesWidget(eventId: event.id, phases: event.phases)
    //     ],
    //   )
    // );
  }
}
