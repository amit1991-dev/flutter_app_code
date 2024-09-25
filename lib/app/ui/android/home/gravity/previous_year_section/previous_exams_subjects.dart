import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/gravity/subject.dart';
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

class PreviousYearExamSubjectsPage extends StatefulWidget {
  PreviousYearExamSubjectsPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<PreviousYearExamSubjectsPage> createState() => _State();
}

class _State extends State<PreviousYearExamSubjectsPage> {
  late String examId;
  bool agreed = false;
  _State(){
    examId = Get.arguments;
  }
  @override
  Widget build(BuildContext context) {
    // printCity();
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          future: Get.find<StudentsController>().getExamSubjects(examId),
          waiting: (context) {
            return  Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
              {

                List<Subject> subjects = apiResponse.data as List<Subject>;
                // List<Question> questions = exam.questions;
                return Scaffold(
                  backgroundColor: appColors["background"]!,
                  extendBodyBehindAppBar: true,
                  body: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerBar("Subjects",parent: true),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                // clumsyTextLabel("# Questions: ${questions.length}",fontsize: 20,color: appColors['primary']),
                                if(subjects.isEmpty) clumsyTextLabel("Sorry, there are currently no Questions in this exam!",fontsize: 12),
                                ...List.generate(subjects.length, (index) {
                                  return Container(
                                    // height: 60,
                                    margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 4) ,
                                    // padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.grey),
                                      // borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Card(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

                                      child: ListTile(

                                        onTap: () async{
                                          await Get.toNamed(Routes.CHAPTERS_EXAM_PAGE,arguments: {'subject':subjects[index].id,'exam':examId});
                                        },
                                      tileColor: appColors['white'],
                                      trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

                                      title: clumsyTextLabel(subjects[index].name.toUpperCase(),color: appColors['primary']),
                                      subtitle: clumsyTextLabel(subjects[index].id,color: appColors['grey'],fontsize: 12) ,
                                  ),
                                    ),
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

