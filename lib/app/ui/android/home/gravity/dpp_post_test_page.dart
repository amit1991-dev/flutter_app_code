import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:getx/app/data/model/gravity/dpp_test_with_sections.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../data/constants/errors.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import '../../../../data/model/gravity/dpp_test_context.dart';

import '../../widgets/miscellaneous.dart';

class DppPostTestPage extends StatefulWidget {
  DppPostTestPage({Key? key}):super(key: key){}
  @override
  State<DppPostTestPage> createState() => _State();
}

class _State extends State<DppPostTestPage> {
  late String testStateId;
  late String resultId;
  bool initialized=false;
  bool agreed = false;

  _State(){
    var data = Get.arguments as Map<String,dynamic>;
    resultId=data['result_id']??"-";
    testStateId=data['test_state_id']??"-";
    print("testStateId: $testStateId");
  }

    @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor); // Add the interceptor
  }

  @override
  void dispose() {
     BackButtonInterceptor.remove(myInterceptor); // Remove the interceptor
    
    super.dispose();
  }

   bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // Get the current route name using the static method
    String currentRoute = Get.currentRoute;

    // Check if the current route is your TestPage route
    if (currentRoute == Routes.POST_DPP_TEST_PAGE) { // Replace with your actual TestPage route name
      showSnackbar("sorry!","Cannot Go Back to the Test Page!");
      stopDefaultButtonEvent = true; // Prevent back navigation
      return stopDefaultButtonEvent;
    } else {
      // Allow back navigation on other routes
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Material(
          color: appColors["background"]!,
          child: AsyncBuilder<APIResponse>(
            future: Get.find<StudentsController>().getDppTestState(testStateId,questions: true),
            waiting: (context) {
              return  Center(
                child: clumsyWaitingBar(),
              );
            },
            builder: (context,apiResponse) {
              if(apiResponse!.status == TextMessages.SUCCESS)
                {
                  DppTestContext testContext = apiResponse.data as DppTestContext;
                  DppTestWithSections tws = testContext.testWithSections!;
                  return Scaffold(
                    backgroundColor: appColors['background'],

                    body:SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              // headerBar("",parent: false),
                              gravityDppTestsListTile(tws),
                              legends(),
                              DppTestStatusReport(tc: testContext),

                              // QuotesWidget(
                              //   width: 300,
                              //   height: 200,
                              //   quoteFontSize: 10,
                              //   authorFontSize: 18,
                              // ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClumsyRealButton("View Results Now!", Get.width*0.8, () {
                                  Get.toNamed(Routes.DPP_TEST_RESULT_PAGE,arguments: resultId);
                                }, false),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClumsyRealButton("Home Page", Get.width*0.8, () {
                                  Get.offNamedUntil(Routes.HOME,(route) => false);
                                }, false),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                    // body:Text("asd"),
                  );
                }
              else
                {
                  return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          headerBar("Test Completed",parent: false),
                          clumsyTextLabel(ErrorMessages.SOMETHINGS_WRONG),
                          clumsyTextLabel(apiResponse.info!.toString(),fontsize: 10),
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
  }

}

