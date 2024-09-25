import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/gravity/test_series/test_state_controller.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/data/model/gravity/test_question.dart';
import '../../../../data/model/gravity/question.dart';
import '../../../../data/model/gravity/question_status.dart';
import 'dart:math' as math;
final rnd = math.Random();

class SubjectWiseTestQuestions extends StatelessWidget {
  SubjectWiseTestQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color c;
            switch(Get.find<TestStateController>().currentSubject.value.toLowerCase())
            {
              case "chemistry":
                c=Colors.green;
                break;
              case "physics":
                c=Colors.blue;
                break;
              case "mathematics":
              case  "maths":
                c=Colors.red;
                break;
              case "biology":
                c=Colors.purple;
                break;
              case "botany":
                c=Colors.pink;
                break;
              case "zoology":
                c=Colors.orange;
                break;
              default:
                c=Color(rnd.nextInt(0xffffffff));
                break;
            }
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: appColors['black']!,
                        // border: Border.all(color: appColors['primary']!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                           //   //  golu
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                  // child: Text(Get.find<TestStateController>().currentSubject.value.toUpperCase(), style: const TextStyle(color: Colors.white),),
                                // ),
                                // const Spacer(),
// // golu
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: appColors['primary']!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: Get.height*0.30,
                      child: Obx(
                            ()=> GridView.count(shrinkWrap: true, crossAxisCount: 6,
                          children: List.generate(Get.find<TestStateController>().testContext.testWithSections!.subjectWise![(Get.find<TestStateController>().currentSubject.value)]!.length, (index){
                            String image = "assets/images/empty.png";
                            TestQuestion question = Get.find<TestStateController>().testContext.testWithSections!.subjectWise![(Get.find<TestStateController>().currentSubject.value)]![index];
                            QuestionStatus qs = Get.find<TestStateController>().selected[question.testQuestionIndex];

                            if(qs.vstate.value==VisitState.VISITED && qs.astate.value != AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.UN_MARKED)
                            {
                              image = "assets/images/not_saved.png";
                            }
                            else if(qs.vstate.value==VisitState.VISITED && qs.astate.value == AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.UN_MARKED)
                            {
                              image = "assets/images/saved.png";
                            }
                            else if(qs.vstate.value==VisitState.VISITED && qs.astate.value == AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.MARKED)
                            {
                              image = "assets/images/ans_marked.png";
                            }
                            else if(qs.vstate.value==VisitState.VISITED && qs.astate.value != AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.MARKED)
                            {
                              image = "assets/images/review_latr.png";
                            }
                            return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  decoration: BoxDecoration(image: DecorationImage(image:AssetImage(image))),
                                  child: Center(child:
                                  TextButton(
                                    // child:Text("1",style:TextStyle(color:Colors.white)),
                                      child:Text((Get.find<TestStateController>().testContext.testWithSections!.subjectWise![Get.find<TestStateController>().currentSubject.value]![index].testQuestionIndex+1).toString(),style:const TextStyle(color:Colors.white)),
                                      onPressed: (){
                                        Get.find<TestStateController>().setCurrentQuestion((Get.find<TestStateController>().testContext.testWithSections!.subjectWise![Get.find<TestStateController>().currentSubject.value]![index].testQuestionIndex));
                                        // print(tsp.currentQuestion);
                                        // Navigator.push(context,MaterialPageRoute(builder: (context) => TestQuestion()),);
                                      }

                                  )
                                  )
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    // Divider(color: Colors.black,),
                  ],
                )

              ),
            );
          }
    }


