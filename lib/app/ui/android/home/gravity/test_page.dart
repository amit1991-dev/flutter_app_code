import 'package:async_builder/async_builder.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../data/constants/errors.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import '../../../../data/model/gravity/test_context.dart';
import '../../widgets/gravity/question_types/test_question_widget.dart';
import '../../widgets/gravity/test_drawer.dart';
import '../../widgets/miscellaneous.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key) {}
  @override
  State<TestPage> createState() => _State();
}

class _State extends State<TestPage> {
  late String testStateId;
  bool initialized = false;
  bool agreed = false;

  _State() {
    disposeController();
    testStateId = Get.arguments;
    print("testStateId: $testStateId");
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.remove(myInterceptor);

    disposeController();
    super.dispose();
  }

  void disposeController() {
    if (initialized) {
      Get.delete<TestStateController>();
      initialized = false;
    }
  }

  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   showSnackbar("Cannot Go Back!", "Submit the Test");
  //   stopDefaultButtonEvent = true; // Prevent default back action
  //   return stopDefaultButtonEvent;
  // }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // Get the current route name using Get.currentRoute
    String currentRoute = Get.currentRoute;

    // Check if the current route is your TestPage route
    if (currentRoute == Routes.TEST_PAGE) {
      // Compare to the route value
      showSnackbar("Cannot Go Back!", "Submit the Test!");

      stopDefaultButtonEvent = true; // Prevent back navigation
      return stopDefaultButtonEvent;
    } else {
      // Allow back navigation on other routes
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // printCity();

    return
        //  WillPopScope(
        //   onWillPop: () async {
        //     showSnackbar("Cannot Go Back!", "Submit the Test");
        //     // Fluttertoast.showToast(
        //     //   msg: 'Cannot go Back just press Submit!',
        //     //   toastLength: Toast.LENGTH_SHORT,
        //     //   gravity: ToastGravity.BOTTOM,
        //     // );
        //     return false;
        //   },
        SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          future: Get.find<StudentsController>()
              .getTestState(testStateId, questions: true),
          waiting: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: clumsyTextLabel(
                        "Please wait while we fetch the Test for you..."),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: clumsyTextLabel(
                        "Make sure you have a strong internet connectivity!",
                        color: appColors['primary'],
                        fontsize: 12),
                  ),
                  clumsyWaitingBar(),
                ],
              ),
            );
          },
          builder: (context, apiResponse) {
            if (apiResponse!.status == TextMessages.SUCCESS) {
              TestContext testContext = apiResponse.data as TestContext;
              Get.put<TestStateController>(
                  TestStateController(testContext: testContext));
              print(
                  "Initialized Controller${Get.find<TestStateController>().initialized}");
              return Scaffold(
                drawerEnableOpenDragGesture: true,
                drawer:
                    getSideMenuPortrait(testContext.testWithSections!, context),
                backgroundColor: appColors['background'],
                appBar: AppBar(
                  toolbarHeight: 100,
                  titleSpacing: 10,
                  backgroundColor: appColors['background'],
                  iconTheme: IconThemeData(color: appColors['primary']),
                  elevation: 0,
                  title: Container(
                    padding: const EdgeInsets.all(8.0),
                    // decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // TestStatusReport(),
                        Spacer(),
                        TestClockWidget(),
                        // Container(
                        //   padding: EdgeInsets.all(10),
                        //   decoration: BoxDecoration(
                        //     color: appColors['primary'],
                        //     borderRadius: BorderRadius.circular(20),
                        //     boxShadow:[ BoxShadow(color: Colors.black,blurRadius: 3)]
                        //
                        //   ),
                        //     child: Column(
                        //       children: [
                        //         clumsyTextLabel(formatTime(Get.find<TestStateController>().time),fontsize: 20,color: appColors['white']),
                        //         clumsyTextLabel("Time Remaining",fontsize: 12,color: appColors['white']),
                        //
                        //       ],
                        //     )
                        //       ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            callDialog(
                                "Are you sure you want to submit?",
                                Column(
                                  children: [
                                    TestClockWidget(),
                                    TestStatusReport(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClumsyRealButton("No", Get.width * 0.2,
                                            () {
                                          // Get.back();
                                          Get.close();
                                        }, false, color: appColors['black']),
                                        ClumsyRealButton("Yes", Get.width * 0.2,
                                            () async {
                                          await Get.find<TestStateController>()
                                              .submitTest();
                                          // Get.back();
                                        }, false),
                                      ],
                                    ),
                                  ],
                                ));
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: appColors['white'],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.green, blurRadius: 2)
                                  ]),
                              child: Column(
                                children: [
                                  Icon(Icons.published_with_changes_sharp,
                                      size: 30),
                                  clumsyTextLabel("Submit", fontsize: 12),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TestQuestionWidget(),
                ),
                // body:Text("asd"),
              );
            } else {
              return Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  headerBar("Test", parent: true),
                  clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
                  clumsyTextLabel(apiResponse.info!.toString(), fontsize: 10),
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
