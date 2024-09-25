import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/gravity/subject.dart';
import 'package:getx/app/routes/app_pages.dart';
import '../../../../../controller/gravity/student_controller.dart';
import '../../../../../data/constants/errors.dart';
import '../../../../../data/constants/miscellaneous.dart';
import '../../../../../data/model/api_response.dart';
import '../../../../../data/model/gravity/test_with_sections.dart';
import '../../../widgets/miscellaneous.dart';

class ModulesSubjectsPage extends StatefulWidget {
  ModulesSubjectsPage({Key? key}):super(key: key){
    // Get.put<HostController>(HostController());
  }
  @override
  State<ModulesSubjectsPage> createState() => _State();
}

class _State extends State<ModulesSubjectsPage> {
  late String batchId;
  bool agreed = false;
  _State(){
    batchId = Get.arguments;
  }
  @override
  Widget build(BuildContext context) {
    // printCity();
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: AsyncBuilder<APIResponse>(
          // future: Get.find<StudentsController>().getTests(streamId),
          future: Get.find<StudentsController>().getBatchSubjectsForModules(batchId),
          waiting: (context) {
            return  Center(
              child: clumsyWaitingBar(),
            );
          },
          builder: (context,apiResponse){
            if(apiResponse!.status == TextMessages.SUCCESS)
              {
                List<Subject> subjects = apiResponse.data as List<Subject>;
                return Scaffold(
                  backgroundColor: appColors["background"]!,
                  extendBodyBehindAppBar: true,
                  body: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        headerBar("Subjects",parent: true),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                if(subjects.length==0) clumsyTextLabel("Sorry, there are currently no modules available in this Batch!"),
                                ...List.generate(subjects.length, (index) {
                                  // return gravityTestsListTile(subjects[index]);
                                  return ListTile(
                                    onTap: (){
                                      Get.toNamed(Routes.BATCH_SUBJECT_MODULES_PAGE,arguments: {"subject":subjects[index].id,"batch":batchId});
                                    },
                                    tileColor: appColors['white'],
                                    trailing: Icon(Icons.arrow_circle_right,color: appColors['primary'],),
                                    title: clumsyTextLabel(subjects[index].name.toUpperCase(),color: appColors['primary']),
                                    subtitle: clumsyTextLabel(subjects[index].id,color: appColors['primary'],fontsize: 12)
                                  );
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
                        headerBar("Subjects",parent: true),
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

