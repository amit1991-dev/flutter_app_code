import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../data/constants/errors.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/constants/request_paths.dart';
import '../../../../data/model/api_response.dart';
import '../../../../data/model/gravity/dpp_result.dart';
import '../../../../routes/app_pages.dart';
import '../../widgets/gravity/dpp_test_result_questions.dart';
import '../../widgets/gravity/test_result_questions.dart';
import '../../widgets/miscellaneous.dart';

class DppTestResultPage extends StatefulWidget {
  DppTestResultPage({Key? key}) : super(key: key) {
    // Get.put<HostController>(HostController());
  }
  @override
  State<DppTestResultPage> createState() => _State();
}

class _State extends State<DppTestResultPage> {
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
          future: Get.find<StudentsController>().getDppTestResult(testResultId),
          waiting: (context) {
            return Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context, apiResponse) {
            if (apiResponse!.status == TextMessages.SUCCESS) {
              DppResult testResult = apiResponse.data as DppResult;
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
                            getDppResultWidget(context, testResult)

                          // if (testResult.declarationTime == null ||
                          //     (DateTime.tryParse(testResult.declarationTime!) !=
                          //             null &&
                          //         DateTime.tryParse(
                          //                     testResult.declarationTime!)!
                          //                 .compareTo(DateTime.now()) <
                          //             0))
                          //   getDppResultWidget(context, testResult)
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


Widget getDppResultWidget(BuildContext context, DppResult result) {
  Map<String, double> dataMap = {
    "Answered": result.resultInfo.b.toDouble(),
    "Not Answered": result.resultInfo.f.toDouble(),
    "Not Visited": result.resultInfo.h.toDouble(),
  };

  List<List<dynamic>> data = [
    ["Answered", result.resultInfo.b.toDouble(), appColors['green']],
    ["Not Answered", result.resultInfo.f.toDouble(), appColors['red']],
    ["Not Visited", result.resultInfo.h.toDouble(), appColors['grey']],
  ];

  var testUrl = RequestPaths.GET_STUDENT_TEST_PDF;
  return SingleChildScrollView(
    child: Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // headerBar("Test Results",parent:true),
          Center(
              child: clumsyTextLabel("Result Declaration Time",
                  fontsize: 20, color: Colors.blue)),
          if (result.declarationTime != null)
            Center(
                child: clumsyTextLabel(DateTime.parse(result.declarationTime!)
                    .toLocal()
                    .toString())),
          // clumsyTextLabel(DateTime.parse(result.declarationTime!).toLocal().isBefore(DateTime.now()).toString()),
          // if(result.declarationTime!=null?DateTime.parse(result.declarationTime!).toLocal().isBefore(DateTime.now()):true)
          Column(
            children: [
              SfCircularChart(
                  title: ChartTitle(
                      text: "Questions Analysis",
                      textStyle: TextStyle(color: appColors['blue'])),
                  legend: Legend(
                      isVisible: true,
                      textStyle: TextStyle(color: appColors['primary']),
                      iconHeight: 50),
                  series: <CircularSeries>[
                    // Renders radial bar chart
                    RadialBarSeries<List<dynamic>, String>(
                        useSeriesColor: true,
                        trackOpacity: 0.3,
                        cornerStyle: CornerStyle.bothCurve,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                        radius: "100%",
                        dataSource: data,
                        xValueMapper: (data, _) => data[0],
                        yValueMapper: (data, _) => data[1],
                        pointColorMapper: (data, _) => data[2],
                        gap: '10%')
                  ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    // await launch(testUrl);
                  },
                  child: const Text("Download PDF"),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      // decoration: BoxDecoration(color:appColors['primary'],boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
                      child: Center(
                          child: Column(
                        children: [
                          const Text(
                            "Marks",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            result.total.toString() +
                                "/" +
                                result.maxMarks.toString(),
                            style: const TextStyle(
                                color: Colors.green, fontSize: 50),
                          ),
                        ],
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      // decoration: BoxDecoration(color: appColors['primary'],boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
                      child: Center(
                          child: Column(
                        children: [
                          const Text(
                            "Percentage-" + "%",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            (result.total.toDouble() * 100 / result.maxMarks)
                                    .toStringAsFixed(2) +
                                "%",
                            style: const TextStyle(
                                color: Colors.green, fontSize: 50),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Total # of questions ',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                            text: result.qml.length.toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        // TextSpan(text: ' world!'),
                      ],
                    ),
                  ),
                ),
              ),
              // Center(child: clumsyTextLabel("View Questions and Solutions",color: appColors['primary'],fontsize: 25)),
              DppTestResultQuestions(result.subjectWiseMarking),
            ],
          ),
        ],
      ),
    ),
  );
}
