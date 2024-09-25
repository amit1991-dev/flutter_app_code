// SfCircularChart(
// series: <CircularSeries>[
// // Renders radial bar chart
// RadialBarSeries<ChartData, String>(
// dataSource: chartData,
// xValueMapper: (ChartData data, _) => data.x,
// yValueMapper: (ChartData data, _) => data.y
// )
// ]
// )
import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../data/constants/errors.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import '../../../../data/model/gravity/dpp_question.dart';

import 'dart:convert' as convert;
import '../../widgets/miscellaneous.dart';
convert.Codec<String, String> stringToBase64 = convert.utf8.fuse(convert.base64);


class DppSingleQuestionPage extends StatefulWidget {
  DppSingleQuestionPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<DppSingleQuestionPage> createState() => _State();
}

class _State extends State<DppSingleQuestionPage> {
  // late QuestionMarking qm;
  late String questionId;
  late YoutubePlayerController _youtube_controller;
  bool agreed = false;
  _State(){
    questionId = Get.arguments as String;
    // print("Test id on report page:${qm.answer}");
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays:[SystemUiOverlay.bottom]);
    _youtube_controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // printCity();

    return Material(
      color: appColors["background"]!,
      child: AsyncBuilder<APIResponse>(
        future: Get.find<StudentsController>().getDppTestQuestion(questionId),
        waiting: (context) {
          return  Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context,apiResponse){
          if(apiResponse!.status == TextMessages.SUCCESS)
          {
            DppQuestion question = apiResponse.data as DppQuestion;
            if(question.media!=null){
              _youtube_controller = YoutubePlayerController(
                initialVideoId: question.media!,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: true,
                ),
              );
            }

            return Column(
              children: [
                // headerBar("Question",parent: true),
                if(question.media!=null) YoutubePlayerBuilder(
                // YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _youtube_controller,
                    showVideoProgressIndicator: true,
                    aspectRatio: Get.height/Get.width*0.99,
                    // width: Get.width*0.95,
                    onReady: () {
                    },
                  ), builder: (BuildContext , player ) {
                  return Column(
                    children: [
                      SizedBox(
                          child: player
                      ),
                    ],
                  );
                },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.all(16.0),
                            width: double.infinity,
                            decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(5.0),boxShadow: [BoxShadow(color: Colors.black,blurRadius: 1.0)]),
                            child: Text("Question Type: "+question.questionType.toUpperCase(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: appColors['white']!),
                            )
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          width: double.infinity,
                          decoration: BoxDecoration(color: appColors['white']!),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: TeXView(
                                      child: TeXViewColumn(children: [
                                        TeXViewDocument(stringToBase64.decode(question.question),
                                            // style: TeXViewStyle(textAlign: TeXViewTextAlign.left,),

                                        ),


                                      ]),
                                      style: TeXViewStyle(
                                        elevation: 10,
                                        backgroundColor: appColors['white']!,
                                        fontStyle: TeXViewFontStyle(fontWeight: TeXViewFontWeight.bolder)
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //     margin: EdgeInsets.all(8.0),
                                  //     child: Image.asset("assets/images/diag.png")),
                                  if(question.questionType=="scq")  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(16.0),
                                        // margin: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(color:appColors['white']!,borderRadius: BorderRadius.circular(5.0)),
                                        child: ListTile(

                                          contentPadding: EdgeInsets.all(2.0),
                                          leading: clumsyTextLabel("A"),
                                          title: TeXView(child: TeXViewDocument(stringToBase64.decode(question.options[0].option_value),
                                              // style: TeXViewStyle(textAlign: TeXViewTextAlign.center)
                                          ),
                                            style: TeXViewStyle(backgroundColor: appColors['white']!,),
                                          ),
                                        ),
                                      ),
                                      // Divider(color: Theme.of(context).primaryColor,),
                                      Container(
                                        // margin: EdgeInsets.all(8.0),
                                        padding: EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(color:appColors['white']!),
                                        child: ListTile(

                                          contentPadding: EdgeInsets.all(2.0),
                                          leading: clumsyTextLabel("B"),
                                          title: TeXView(child: TeXViewDocument(stringToBase64.decode(question.options[1].option_value),
                                              // style: TeXViewStyle(textAlign: TeXViewTextAlign.center)
                                          ),
                                            style: TeXViewStyle(backgroundColor: appColors['white']!,),
                                          ),
                                        ),
                                      ),
                                      // Divider(color: Theme.of(context).primaryColor,),
                                      Container(
                                        padding: EdgeInsets.all(16.0),
                                        // margin: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(color:appColors['white']!),
                                        child: ListTile(

                                          contentPadding: EdgeInsets.all(2.0),
                                          leading: clumsyTextLabel("C"),
                                          title: TeXView(child: TeXViewDocument(stringToBase64.decode(question.options[2].option_value),
                                              // style: TeXViewStyle(textAlign: TeXViewTextAlign.center)
                                          ),
                                            style: TeXViewStyle(backgroundColor: appColors['white']!,),
                                          ),
                                        ),
                                      ),
                                      // Divider(color: Theme.of(context).primaryColor,),
                                      Container(
                                        padding: EdgeInsets.all(16.0),
                                        // margin: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(color:appColors['white']!),
                                        child: ListTile(

                                          contentPadding: EdgeInsets.all(2.0),
                                          leading: clumsyTextLabel("D"),
                                          title: TeXView(child: TeXViewDocument(stringToBase64.decode(question.options[3].option_value),
                                              // style: TeXViewStyle(textAlign: TeXViewTextAlign.center)
                                          ),
                                            style: TeXViewStyle(backgroundColor: appColors['white']!,),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                              clumsyTextLabel("Correct Answer: ${question.correctAns}"),
                              Container(
                                  padding: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.all(16.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(5.0),boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
                                  child: Text("EXPLANATION",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: appColors['white']!),
                                  )
                              ),

                              // if(question.media!=null) YoutubePlayerBuilder(
                              //   player: YoutubePlayer(
                              //     controller: _youtube_controller,
                              //     showVideoProgressIndicator: true,
                              //     aspectRatio: Get.height/Get.width,
                              //     // width: Get.width*0.95,
                              //     onReady: () {
                              //     },
                              //   ), builder: (BuildContext , player ) {
                              //   return Column(
                              //     children: [
                              //       SizedBox(
                              //           child: player
                              //       ),
                              //     ],
                              //   );
                              // },
                              // ),
                              if(question.solution!.isNotEmpty) TeXView(
                                child: TeXViewColumn(children: [
                                  TeXViewDocument(stringToBase64.decode(question.solution!),
                                  ),
                                ]),
                                style: TeXViewStyle(
                                  elevation: 10,
                                  backgroundColor: appColors['white']!,
                                ),
                              )
                              // else Center(child: clumsyTextLabel("Solution Not Present.",color: appColors['black']),),
                            ],
                          ),
                        ),







                      ],
                      )],
                    ),
                  ),
                )
              ],
            );
          }
          else
          {
            return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    headerBar("Test Results",parent: true),
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

