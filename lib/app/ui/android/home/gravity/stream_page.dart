import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../data/constants/errors.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import '../../../../data/model/gravity/test_with_sections.dart';
import '../../widgets/miscellaneous.dart';

class StreamPage extends StatefulWidget {
  StreamPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<StreamPage> createState() => _State();
}

class _State extends State<StreamPage> {
  late String streamId;
  bool agreed = false;
  _State(){
    streamId = Get.arguments;
  }
  @override
  Widget build(BuildContext context) {
    // printCity();
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          future: Get.find<StudentsController>().getTests(streamId),
          waiting: (context) {
            return  Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
              {
                List<TestWithSections> tests = apiResponse.data as List<TestWithSections>;
                return Scaffold(
                  backgroundColor: appColors["background"]!,
                  extendBodyBehindAppBar: true,
                  body: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        headerBar("Stream Tests",parent: true),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                if(tests.length==0) clumsyTextLabel("Sorry, there are currently no tests available in this stream!"),
                                ...List.generate(tests.length, (index) {
                                  return gravityTestsListTile(tests[index]);
                                }),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            else
              {
                return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        headerBar("Tests",parent: true),
                        clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
                        clumsyTextLabel(apiResponse.info!,fontsize: 10),
                        // Text(error.toString()),
                      ],
                    )
                );
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
                )
            );
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

