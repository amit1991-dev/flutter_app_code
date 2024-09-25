import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';
import '../../../../../controller/gravity/student_controller.dart';
import '../../../../../data/constants/errors.dart';
import '../../../../../data/constants/miscellaneous.dart';
import '../../../../../data/model/api_response.dart';
import '../../../../../data/model/gravity/exam.dart';
import '../../../../../data/model/gravity/question.dart';
import '../../../../../data/model/gravity/test_with_sections.dart';
import '../../../widgets/gravity/question_types/test_question_widget.dart';
import '../../../widgets/miscellaneous.dart';

class PreviousYearExamPage extends StatefulWidget {
  PreviousYearExamPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<PreviousYearExamPage> createState() => _State();
}

class _State extends State<PreviousYearExamPage> {
  late String examId,subjectId,chapterId;
  bool agreed = false;
  _State(){
    // examId = Get.arguments;
    Map<String,String> data = Get.arguments;
    examId = data['exam_id']!;
    subjectId = data['subject_Id']!;
    chapterId = data['chapter_id']!;
  }
  @override
  Widget build(BuildContext context) {
    // printCity();
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          future: Get.find<StudentsController>().getExamQuestions(examId,subjectId,chapterId),
          waiting: (context) {
            return  Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
              {
                List<Question> questions = apiResponse.data as List<Question>;
                return Scaffold(
                  backgroundColor: appColors["background"]!,
                  extendBodyBehindAppBar: true,
                  body: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerBar("Exam",parent: true),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                clumsyTextLabel("# Questions: ${questions.length}",fontsize: 20,color: appColors['primary']),
                                if(questions.isEmpty) clumsyTextLabel("Sorry, there are currently no Questions available in this Exam!",fontsize: 12),
                                ...List.generate(questions.length, (index) {
                                  return Container(
                                    // height: 60,
                                    margin:const EdgeInsets.all(20) ,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            clumsyTextLabel("Question# :${index+1}",fontsize: 12),
                                            clumsyTextLabel(questions[index].topic??"-".toUpperCase(),fontsize: 12),
                                            clumsyTextLabel(questions[index].questionType.toUpperCase(),fontsize: 12),
                                            // ClumsyRealButton("View", Get.width*0.2, () { }, false)
                                            InkWell(
                                              onTap: (){
                                                Get.toNamed(Routes.QUIZ_PAGE,arguments: questions[index]);
                                              },
                                              child: Icon(Icons.arrow_circle_right,color: appColors['primary'],size: 30,),
                                            )

                                          ],
                                        ),
                                        Divider(color:appColors['primary']),
                                        TeXView(
                                          child: TeXViewColumn(children: [
                                            TeXViewDocument(stringToBase64.decode(questions[index].question),
                                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.left,),

                                            ),
                                          ]),
                                          style: TeXViewStyle(
                                              elevation: 10,
                                              backgroundColor: appColors['white']!,
                                              fontStyle: TeXViewFontStyle(fontWeight: TeXViewFontWeight.bolder)
                                          ),
                                        ),


                                      ],
                                    ),
                                    // child: ListTile(
                                    //   tileColor: appColors['white'],
                                    //   leading: const Icon(Icons.help_center_outlined),
                                    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    //   subtitle: clumsyTextLabel(questions[index].questionType,fontsize: 18,color: appColors['primary']),
                                    //   title:
                                    //   // subtitle: clumsyTextLabel(DateTime.parse(exam.examDate).toIso8601String().split("T")[0],color: appColors['white'],fontsize: 12),
                                    // ),
                                  );
                                }),
                                const SizedBox(
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
                        headerBar("Exam",parent: true),
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

                    const Text("Some error Occured"),
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

