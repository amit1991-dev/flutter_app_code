import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../controller/gravity/student_controller.dart';
import '../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../data/constants/miscellaneous.dart';
import '../../../../data/model/api_response.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../../data/model/gravity/question.dart';
import '../../widgets/gravity/quiz_question_widgets/question_widget.dart';
import '../../widgets/miscellaneous.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}):super(key: key){
  }
  @override
  State<QuizPage> createState() => _State();
}

class _State extends State<QuizPage> {
  // late String testStateId;

  // TextEditingController controller=TextEditingController();
  // bool agreed = false;
  late Question question;

  _State(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    // testStateId = Get.arguments;
    // print("testStateId: $testStateId");

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question = Get.arguments as Question;
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
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: headerBar("Exam Question",parent: true),
              ),
                QuizQuestionWidget(question:question)
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

