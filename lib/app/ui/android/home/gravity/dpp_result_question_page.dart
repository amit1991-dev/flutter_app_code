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
import '../../../../data/model/gravity/dpp_question_marking.dart';
import 'dart:convert' as convert;
import '../../widgets/miscellaneous.dart';
convert.Codec<String, String> stringToBase64 = convert.utf8.fuse(convert.base64);


class DppResultQuestionPage extends StatefulWidget {
  DppResultQuestionPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<DppResultQuestionPage> createState() => _State();
}

class _State extends State<DppResultQuestionPage> {
  late QuestionMarking qm;
  late YoutubePlayerController _youtube_controller;
  bool agreed = false;
  _State(){
    qm = Get.arguments as QuestionMarking;
    print("Test id on report page:${qm.answer}");
  }

  @override
  void initState() {
    _youtube_controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays:[SystemUiOverlay.bottom]);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    super.dispose();
  }

  TeXViewRenderingEngine renderingEngine = const TeXViewRenderingEngine.mathjax();

  @override
  Widget build(BuildContext context) {
    // printCity();

    return Material(
      color: appColors["background"]!,
      child: AsyncBuilder<APIResponse>(
        future: Get.find<StudentsController>().getDppTestQuestion(qm.questionId),
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
                // headerBar("Test Question Solution",parent: true),
                if(question.media!=null) YoutubePlayerBuilder(
                // YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _youtube_controller,
                    showVideoProgressIndicator: true,
                    aspectRatio: Get.height/(Get.width*0.99),
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
                        // SizedBox(
                        //   height: 50,
                        // ),
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
                          margin: EdgeInsets.all(8.0),
                          decoration:BoxDecoration(
                            color: appColors['white'],
                              borderRadius: BorderRadius.circular(20.0),
                              // gradient: LinearGradient(colors:[Colors.deepPurple, qm.attempted?(qm.correctly_marked?Colors.green:Colors.red):Colors.grey]),
                              boxShadow: [BoxShadow(color:appColors['primary']!,blurRadius: 2.0,spreadRadius: 0.0)]
                          ),
                          child: Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(0.0),
                              //   child: Row(
                              //
                              //     children: [
                              //       Expanded(
                              //           flex: 1,
                              //           child: Text("SUBJECT",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:appColors['white']!70),)
                              //       ),
                              //       Expanded(
                              //           flex: 1,
                              //           child: Text(question.subject.toUpperCase(),textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: appColors['white']!),)
                              //       ),
                              //
                              //
                              //     ],
                              //   ),
                              // ),
                              Divider(),
                              // Padding(
                              //   padding: const EdgeInsets.all(0.0),
                              //   child: Row(
                              //
                              //     children: [
                              //       Expanded(
                              //           flex: 1,
                              //           child: Text("CHAPTER",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: appColors['white']!70),)
                              //       ),
                              //       Expanded(
                              //           flex: 1,
                              //           child: Text(question.chapter!=null?question.chapter.toUpperCase():"-",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: appColors['white']!),)
                              //       ),
                              //
                              //
                              //     ],
                              //   ),
                              // ),
                              // Divider(),
                              // Padding(
                              //   padding: const EdgeInsets.all(0.0),
                              //   child: Row(
                              //
                              //     children: [
                              //       Expanded(
                              //           flex: 1,
                              //           child: Text("TOPIC",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:appColors['white']!70),)
                              //       ),
                              //       Expanded(
                              //           flex: 1,
                              //           child: Text(question.topic!=null?question.topic.toUpperCase():"-",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: appColors['white']!),)
                              //       ),
                              //
                              //
                              //     ],
                              //   ),
                              // ),
                              // Divider(),
                              // Padding(
                              //   padding: const EdgeInsets.all(0.0),
                              //   child: Row(
                              //
                              //     children: [
                              //       Expanded(
                              //           flex: 1,
                              //           child: Text("SUBTOPIC",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:appColors['white']!70),)
                              //       ),
                              //       Expanded(
                              //           flex: 1,
                              //           child: Text(question.subtopic!= null?question.subtopic.toUpperCase():"-",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: appColors['white']!),)
                              //       ),
                              //
                              //
                              //     ],
                              //   ),
                              // ),
                              // Divider(),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(

                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("ANSWER MARKED",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:appColors['primary']!),)
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(qm.answer!=null?qm.answer.toUpperCase():"-",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: appColors['primary']!),)
                                    ),


                                  ],
                                ),
                              ),
                              Divider(),

                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(

                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("CORRECT ANSWER",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:appColors['primary']!),)
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(question.correctAns!=null?question.correctAns!.toUpperCase():"-",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: appColors['primary']!),)
                                    ),


                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(

                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("MARKS OBTAINED",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:appColors['primary']!),)
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(qm.marksObtainted.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: appColors['primary']!),)
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),

                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(

                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("TIME ALLOTTED",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:appColors['primary']!),)
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(qm.timeAllotted.toString() +" Seconds",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: appColors['primary']!),)
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),


                            ],
                          ),
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
                                      renderingEngine: renderingEngine,
                                      child: TeXViewColumn(children: [
                                        TeXViewDocument(
                                                                      """
                            <div>
                             <style>
                             img{
                              max-width: 100%;
                              height: auto;
                             }
                                .custom-text {
                                 line-height: 1.5;
                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                                          <div class="custom-text">
                                          ${stringToBase64.decode(question.question)}
                                          </div>
                                          </div>
                                        """,
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
                                          title: TeXView(
                                           renderingEngine: renderingEngine,

                                            child: TeXViewDocument(
                                                                        """
                            <div>
                             <style>
                             img{
                              max-width: 100%;
                              height: auto;
                             }
                                .custom-text {
                                 line-height: 1.5;
                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                                          <div class="custom-text">
                                           ${ stringToBase64.decode(question.options[0].option_value)}
                                          </div>
                                          </div>
                                        """,
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
                                          title: TeXView(
                                      renderingEngine: renderingEngine,
                                            
                                            child: TeXViewDocument(
                                                                        """
                            <div>
                             <style>
                             img{
                              max-width: 100%;
                              height: auto;
                             }
                                .custom-text {
                                 line-height: 1.5;
                                 font-size: .7em;
                                 font-size: .7rem;
                                 font-family: Arial, sans-serif;
                                 font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                                          <div class="custom-text">
                                            ${stringToBase64.decode(question.options[1].option_value)}
                                          </div>
                                          </div>
                                        """,
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
                                          title: TeXView(
                                      renderingEngine: renderingEngine,
                                            
                                            child: TeXViewDocument(
                                                                        """
                            <div>
                             <style>
                             img{
                              max-width: 100%;
                              height: auto;
                             }
                                .custom-text {
                                 line-height: 1.5;
                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                                          <div class="custom-text">
                                           ${ stringToBase64.decode(question.options[2].option_value)}
                                          </div>
                                          </div>
                                        """,
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
                                          title: TeXView(
                                      renderingEngine: renderingEngine,
                                            
                                            child: TeXViewDocument(
                                                                        """
                            <div>
                             <style>
                             img{
                              max-width: 100%;
                              height: auto;
                             }
                                .custom-text {
                                 line-height: 1.5;
                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                                          <div class="custom-text">

                                            ${stringToBase64.decode(question.options[3].option_value)}
                                          </div>
                                          </div>
                                        """,
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

                              Container(
                                  padding: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.all(16.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(5.0),boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
                                  child: Text("EXPLANATION",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: appColors['white']!),
                                  )
                              ),


                              if(question.file !=null) ListTile(
                                onTap: () async{
                                  await openLink(question.file!.file.url);
                                },
                                tileColor: appColors['white'],
                                trailing: Icon(Icons.download_for_offline,color: appColors['primary'],),
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                                title: clumsyTextLabel(question.file!.file.name.toUpperCase(),color: appColors['primary']),
                                subtitle: clumsyTextLabel(question.file!.contentType,color: appColors['grey'],fontsize: 12) ,
                              ),


                              if(question.solution!.isNotEmpty) TeXView(
                                renderingEngine: renderingEngine,

                                child: TeXViewColumn(children: [
                                  TeXViewDocument(
                                                                """
                            <div>
                             <style>
                             img{
                              max-width: 100%;
                              height: auto;
                             }
                                .custom-text {
                                 line-height: 1.5;
                                 font-size: .7em;
                                 font-size: .7rem;
                                 font-family: Arial, sans-serif;
                                 font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                                          <div class="custom-text">
                                    ${stringToBase64.decode(question.solution!)}
                                    </div>
                                          </div>
                                  """,
                                      // style: TeXViewStyle(textAlign: TeXViewTextAlign.left)
                ),
                                ]),
                                style: TeXViewStyle(
                                  elevation: 10,
                                  backgroundColor: appColors['white']!,
                                ),
                              ) else Center(child: clumsyTextLabel("Solution Not Present.",color: appColors['black']),),
                              // Container(
                              //     padding: EdgeInsets.all(16.0),
                              //     margin: EdgeInsets.all(16.0),
                              //     width: double.infinity,
                              //     decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(5.0),boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
                              //     child: Text("KEY-CONCEPTS",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: appColors['white']!),
                              //     )
                              // ),
                              //
                              // Container(
                              //   //TODO: add additional details for a question
                              // )


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

