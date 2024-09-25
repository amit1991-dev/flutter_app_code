import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../widgets/miscellaneous.dart';

class AIPage extends StatefulWidget {
  AIPage({Key? key}):super(key: key){
  }
  @override
  State<AIPage> createState() => _State();
}

class _State extends State<AIPage> {
  // late String testStateId;

  TextEditingController controller=TextEditingController();
  // bool agreed = false;


  _State(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    // testStateId = Get.arguments;
    // print("testStateId: $testStateId");

  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Material(
          color: appColors["white"]!,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: headerBar("AI Page",parent: true),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: SizedBox(
                            height:50,
                            child: Image.asset('assets/images/glogoB.png')),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // clumsyTextLabel("Introducing Gravity AI",fontsize:30,color: appColors['primary']),
                    clumsyTextLabel("Personal AI Helper",color: appColors['primary']),
                    // clumsyTextLabel("10 Questions/day/account",fontsize: 10,color: appColors['white']),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex:4,
                      child: Container(
                        margin:const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: appColors['black'],
                          border: Border.all(color: appColors['primary']!),
                        ),
                        child: TextField(
                          style: TextStyle(color: appColors['primary']),
                          // expands: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your Question...',
                            hintStyle: TextStyle(color: appColors['grey']!,fontSize:14),
                          ),
                          controller: controller,
                        ),
                      ),
                    ),
                    Flexible(
                      flex:1,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            
                          });
                          // Get.find<Authentication>().logout();
                          // Get.offAllNamed(Routes.INITIAL);
                        },
                        color: appColors["primary"]!,
                        textColor: appColors['white'],
                        child: Column(
                          children: [

                            Icon(
                              Icons.keyboard_double_arrow_right_sharp,
                              size: 34,
                            ),
                            clumsyTextLabel("Go",fontsize: 10,color: Colors.white)
                          ],
                        ),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      ),
                    )
                    
                    
                  ],
                ),
                // Text("Powered by OpenAI",textAlign: TextAlign.start,style: TextStyle(color: appColors['grey']),),
                // ClumsyRealButton("Go", Get.width*0.8, () {
                //   setState(() {
                //
                //   });
                // }, false),
                AsyncBuilder<APIResponse>(
                  future: Get.find<StudentsController>().submitAI(controller.text),
                  waiting: (context) {
                    return  Center(
                      child: clumsyWaitingBar(),
                    );
                  },
                  builder: (context,apiResponse) {
                    if(apiResponse!.status == TextMessages.SUCCESS)
                      {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              // clumsyTextLabel(apiResponse.data),
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: AnimatedTextKit(
                                  isRepeatingAnimation: false,

                                    animatedTexts: [
                                      TyperAnimatedText(apiResponse.data.toString(),textStyle: TextStyle(color: appColors['primary']!,fontSize: 14),textAlign: TextAlign.center)
                                ]
                                ),
                              ),
                            ],
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

                            const Text("Some error Occured"),
                            Text(error.toString()),

                          ],
                        )
                    );
                  },
                ),
              ],
            ),
          ),
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

