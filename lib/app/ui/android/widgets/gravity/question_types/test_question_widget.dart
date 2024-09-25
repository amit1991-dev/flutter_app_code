import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx/app/data/model/gravity/test_with_sections.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';

import 'dart:convert' as convert;

import '../../../../../controller/gravity/test_series/test_state_controller.dart';
import '../../../../../data/constants/miscellaneous.dart';
import '../../../../../data/model/gravity/question_status.dart';
import '../../../../../data/model/gravity/test_question.dart';

convert.Codec<String, String> stringToBase64 =
    convert.utf8.fuse(convert.base64);

// String encoded = stringToBase64.encode(credentials);      // dXNlcm5hbWU6cGFzc3dvcmQ=
// String decoded = stringToBase64.decode(encoded);

class TestQuestionWidget extends StatefulWidget {
  TestQuestionWidget({Key? key}) : super(key: key) {
    // Get.find<TestStateController>() = ;
    test = Get.find<TestStateController>().testWithSections;
    print("length${test.lq!.length.toString()}");
    if (test.lq != null) {
      print("lq is not null");
    }
  }
  // late TestStateController Get.find<TestStateController>();
  late TestWithSections test;
  // QuestionStatus qs;
  @override
  _TestQuestionWidgetState createState() {
    return _TestQuestionWidgetState();
  }
}

class _TestQuestionWidgetState extends State<TestQuestionWidget> {
  // TestStateProvider Get.find<TestStateController>();
  // Test test;
  late QuestionStatus qs;
  // dynamic answer = "";
  dynamic answer = "";

  void setQuestion(int questionIndex) {
    // setState(() {
    // Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value+1);
    Get.find<TestStateController>().setCurrentQuestion(questionIndex);
    // });
  }

  bool setAnswer(String answer) {
    TestQuestion tq = Get.find<TestStateController>()
        .questions[Get.find<TestStateController>().currentQuestion.value];
    if (tq.testSection == null) {
      print("test section is null from the question in the test list");
      return false;
    } else {
      if (!tq.testSection!.markQuestion(
          Get.find<TestStateController>().currentQuestion.value)) {
        showSnackbar("Sorry", "Optional Section Question limit reached");
        return false;
      } else {
        this.answer = answer;
        print("setting answer");
        qs.setAnswer(answer);
        return true;
      }
    }
  }

  void setToggleAnswer(String answer) {
    TestQuestion tq = Get.find<TestStateController>()
        .questions[Get.find<TestStateController>().currentQuestion.value];
    if (tq.testSection == null) {
      print("test section is null from the question in the test list");
    } else {
      if (!tq.testSection!.markQuestion(
          Get.find<TestStateController>().currentQuestion.value)) {
        showSnackbar("Sorry", "Optional Section Question limit reached");
        return;
      } else {
        List<String> tempAnswers = (this.answer as List<String>);
        if (tempAnswers.contains(answer)) {
          (this.answer as List<String>).remove(answer);
          print(this.answer);
        } else {
          (this.answer as List<String>).add(answer);
          print(this.answer);
        }
        qs.setToggleAnswer(this.answer);
      }
    }
  }

//golu

  void setToggleAnswerMcq(String answer) {
    TestQuestion tq = Get.find<TestStateController>()
        .questions[Get.find<TestStateController>().currentQuestion.value];
    if (tq.testSection == null) {
      print("test section is null from the test list");
    } else {
      if (!tq.testSection!.markQuestion(
          Get.find<TestStateController>().currentQuestion.value)) {
        showSnackbar("Sorry", "Optional Section Question limit reached");
        return;
      } else {
        // Multi-select logic
        if (this.answer is! List<String>) {
          this.answer = <String>[]; // Initialize as an empty list
        }
        
        if ((this.answer as List<String>).contains(answer)) {
          (this.answer as List<String>).remove(answer);
        } else {
          (this.answer as List<String>).add(answer);
        }
        qs.setToggleAnswer(this.answer);
      }
    }
  }

//golu

//golu

//golu

//golu

  void clearAnswer() {
    TestQuestion tq = Get.find<TestStateController>()
        .questions[Get.find<TestStateController>().currentQuestion.value];
    if (tq.testSection == null) {
      print("test section is null from the question in the test list");
    } else {
      if (tq.testSection!.unMarkQuestion(
          Get.find<TestStateController>().currentQuestion.value)) {
        qs.clearAnswer();
      }
    }
  }

  _TestQuestionWidgetState() {
    qs = Get.find<TestStateController>()
        .selected[Get.find<TestStateController>().currentQuestion.value];
    answer = qs.answer;
  }

  @override
  Widget build(BuildContext context) {
    print("TAG:${Get.find<TestStateController>().currentQuestion}");

    return generateQuestionBody(context);
  }

  Widget generateQuestionBody(
    BuildContext context,
  ) {
    TeXViewRenderingEngine renderingEngine;
    renderingEngine = const TeXViewRenderingEngine.mathjax();
    // renderingEngine = const TeXViewRenderingEngine.katex();


    // TeXViewRenderingEngine.katex()
    // String questionType=Get.find<TestStateController>().questions[Get.find<TestStateController>().currentQuestion.value].question.questionType;

    // if(questionType=="scq"){
    //   return getSCQuestion(context, image, renderingEngine);
    // }
    // else if(questionType=="integer")
    //   {
    //     return getIntegerQuestion(context, image, renderingEngine);
    //   }
    // else
    //   {
    //     return getUnknownQuestion(context,image,renderingEngine);
    //   }

    return SizedBox(
      height: Get.height,
      child: Obx(() {
        qs = Get.find<TestStateController>()
            .selected[Get.find<TestStateController>().currentQuestion.value];
        print("TAG:${qs.tempAnswer}");
        answer = qs.tempAnswer;
        qs.visit();
        String image = "assets/images/empty.png";

        if (qs.vstate.value == VisitState.VISITED &&
            qs.astate.value != AnsweredState.ANSWERED_SAVED &&
            qs.rstate.value == ReviewState.UN_MARKED) {
          image = "assets/images/not_saved.png";
        } else if (qs.vstate.value == VisitState.VISITED &&
            qs.astate.value == AnsweredState.ANSWERED_SAVED &&
            qs.rstate.value == ReviewState.UN_MARKED) {
          image = "assets/images/saved.png";
        } else if (qs.vstate.value == VisitState.VISITED &&
            qs.astate.value == AnsweredState.ANSWERED_SAVED &&
            qs.rstate.value == ReviewState.MARKED) {
          image = "assets/images/ans_marked.png";
        } else if (qs.vstate.value == VisitState.VISITED &&
            qs.astate.value != AnsweredState.ANSWERED_SAVED &&
            qs.rstate.value == ReviewState.MARKED) {
          image = "assets/images/review_latr.png";
        }
        print("done obx");
        String questionType = Get.find<TestStateController>()
            .questions[Get.find<TestStateController>().currentQuestion.value]
            .question
            .questionType;
        String? questionSubype = Get.find<TestStateController>()
            .questions[Get.find<TestStateController>().currentQuestion.value]
            .question
            .questionSubtype;
        if (questionType == "scq") {
          return getSCQuestion(context, image, renderingEngine);
        } else if (questionType == "integer") {
          return getIntegerQuestion(context, image, renderingEngine);
        } else if (questionType == "mcq") {
          return getMCQuestion(context, image, renderingEngine);
        } else if (questionType == "matrix") {
          return getMatrixQuestion(context, image, renderingEngine);
        } else if (questionType == "comprehension") {
          if (questionSubype == "scq" || questionSubype == "simple") {
            return getSCQuestion(context, image, renderingEngine,
                showComprehension: true, title: "Comprehension");
          } else if (questionSubype == "mcq") {
            return getMCQuestion(context, image, renderingEngine);
          } else {
            print(questionType);
            print(questionSubype);
            return getUnknownQuestion(context, image, renderingEngine);
          }
        } else {
          print(questionType);
          return getUnknownQuestion(context, image, renderingEngine);
        }
      }),
    );
  }

  Widget getSCQuestion(BuildContext context, String image,
      TeXViewRenderingEngine renderingEngine,
      {bool showComprehension = false, String title = "Single Choice"}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(right: 0.0),
          decoration: BoxDecoration(
            color: appColors["black"]!,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(() {
            TestQuestion question = Get.find<TestStateController>()
                .testContext
                .testWithSections!
                .lq![Get.find<TestStateController>().currentQuestion.value];
            QuestionStatus qs = Get.find<TestStateController>()
                .selected[question.testQuestionIndex];
            String image = "assets/images/empty.png";
            if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value != AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.UN_MARKED) {
              image = "assets/images/not_saved.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value == AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.UN_MARKED) {
              image = "assets/images/saved.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value == AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.MARKED) {
              image = "assets/images/ans_marked.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value != AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.MARKED) {
              image = "assets/images/review_latr.png";
            }
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q${Get.find<TestStateController>().currentQuestion.value + 1}: $title Question",
                      style: TextStyle(color: appColors["white"]!),
                    ),
                    Text(
                      "Subject:${Get.find<TestStateController>().testContext.lqs[Get.find<TestStateController>().currentQuestion.value].question.subject.name}",
                      style:
                          TextStyle(color: appColors["primary"]!, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
             GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Question Instructions"),
          content: Obx(() =>  // Wrap TeXView with Obx
            TeXView( 
              renderingEngine: renderingEngine, 
              child: TeXViewDocument(
                stringToBase64.decode(Get.find<TestStateController>()
                    .testContext
                    .lqs[Get.find<TestStateController>().currentQuestion.value]
                    .question
                    .instructions
                    .instructions),
                style: TeXViewStyle(
                  backgroundColor: appColors["white"]!,
                  padding: TeXViewPadding.all(10), 
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  },
  child: Icon(
    Icons.help_outline,
    color: appColors["white"]!,
  ),
),

                // Icon(
                //   Icons.help_outline,
                //   color: appColors["white"]!,
                // )
              ],
            );
          }),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: appColors["white"]!),
              child: Column(
                children: [
                  if (showComprehension)
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(20),
                      child: Obx(
                        () => TeXView(
                          loadingWidgetBuilder: (context) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: appColors['primary']!,
                            ));
                          },
                          renderingEngine: renderingEngine,
                          child: TeXViewDocument(
                              stringToBase64.decode(
                                  Get.find<TestStateController>()
                                      .testWithSections
                                      .lq![Get.find<TestStateController>()
                                          .currentQuestion
                                          .value]
                                      .question
                                      .comprehension!
                                      .content),
                              style: TeXViewStyle(
                                  padding: const TeXViewPadding.all(0),
                                  // textAlign: TeXViewTextAlign.center,
                                  fontStyle: TeXViewFontStyle(
                                      fontSize: 20,
                                      fontWeight: TeXViewFontWeight.bolder))),
                          style: TeXViewStyle(
                            elevation: 0,
                            backgroundColor: appColors["white"]!,
                          ),
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(20),
                    child: Obx(
                      () => TeXView(
                        loadingWidgetBuilder: (context) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: appColors['primary']!,
                          ));
                        },
                        renderingEngine: renderingEngine,
                        child: TeXViewDocument("""
                            <div>
                             <style>
                             img{
                              max-width: 100%;
                              height: auto;
                             }
                              .custom-text {
                              //  hyphens: auto;
                                 line-height: 1.5;
                                
                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                
                                
                                }
  // body {
  //                   -webkit-user-select: none; /* Disable text selection for Safari */
  //                   -moz-user-select: none; /* Disable text selection for Firefox */
  //                   -ms-user-select: none; /* Disable text selection for Internet Explorer/Edge */
  //                   user-select: none; /* Disable text selection for modern browsers */
  //                   -ms-touch-action: none; /* Prevent touch-based interactions for IE/Edge */
  //                   touch-action: none; /* Prevent touch-based interactions */
  //                 }

                              </style>
                              <div class="custom-text">
                            ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.question)}
                            </div>
                            </div>
                            """,
                            style: TeXViewStyle(
                                padding: const TeXViewPadding.all(0),
                                // textAlign: TeXViewTextAlign.center,
                                fontStyle: TeXViewFontStyle(
                                    fontSize: 20,
                                    fontWeight: TeXViewFontWeight.bolder))),
                        style: TeXViewStyle(
                          elevation: 0,
                          backgroundColor: appColors["white"]!,
                        ),
                        // style: TeXViewStyle.fromCSS("overflow:scroll;"),
                      ),
                    ),
                  ),

                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer == "A"
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer == "A" ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setAnswer("A");
                          setState(() {});
                        },
                        selected: true,
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("A",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                                //  font-size: 12px;
                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                }

                              </style>
                              <div class="custom-text">
                              
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[0].option_value)}
                            </div>
                            </div>

                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer == "B"
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer == "B" ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setAnswer("B");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("B",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                                //  font-size: 12px;

                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                              <div class="custom-text">

                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[1].option_value)}
                            </div>
                            </div>

                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer == "C"
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer == "C" ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setAnswer("C");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("C",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                                //  font-size: 12px;

                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                              <div class="custom-text">
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[2].option_value)}
                            </div>
                            </div>

                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer == "D"
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer == "D" ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        // tileColor: appColors['grey'],
                        onTap: () {
                          setAnswer("D");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("D",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                                //  font-size: 12px;

                                 font-size: .7em;
                                 font-size: .7rem;
                                //  font-family: Arial, sans-serif;
                                //  font-weight: bold;
                                  //  font-style: italic;
                                }
                              </style>
                              <div class="custom-text">
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[3].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value >
                        0) {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value -
                              1);
                      // setState(() {
                      //   Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value-1);
                      // });
                    }
                  },
                  child: const Icon(Icons.chevron_left, size: 25.0)),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.toggleReview();
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["purple"]!),
                    child: Text("Review Later",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    clearAnswer();

                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["red"]!),
                    child: Text("Clear",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                    }
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["green"]!),
                    child: Text("Save & next",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    print(Get.find<TestStateController>()
                        .currentQuestion
                        .value
                        .toString());
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      // setState(() {
                      //   Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value+1);
                      // });

                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                    }
                  },
                  child: const Icon(
                    Icons.chevron_right,
                    size: 25.0,
                  )),
            ],
          ),
        ),
      ],
    );
  }
//golu new code

//golu new code

//golu

  Widget getMCQuestion(BuildContext context, String image,
      TeXViewRenderingEngine renderingEngine,
      {bool showComprehension = false}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(right: 0.0),
          decoration: BoxDecoration(
            color: appColors["black"]!,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(() {
            TestQuestion question = Get.find<TestStateController>()
                .testContext
                .testWithSections!
                .lq![Get.find<TestStateController>().currentQuestion.value];
            QuestionStatus qs = Get.find<TestStateController>()
                .selected[question.testQuestionIndex];
            String image = "assets/images/empty.png";
            if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value != AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.UN_MARKED) {
              image = "assets/images/not_saved.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value == AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.UN_MARKED) {
              image = "assets/images/saved.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value == AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.MARKED) {
              image = "assets/images/ans_marked.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value != AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.MARKED) {
              image = "assets/images/review_latr.png";
            }
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q${Get.find<TestStateController>().currentQuestion.value + 1}: Multiple Choice Question",
                      style: TextStyle(color: appColors["white"]!),
                    ),
                    Text(
                      "Subject:${Get.find<TestStateController>().testContext.lqs[Get.find<TestStateController>().currentQuestion.value].question.subject.name}",
                      style:
                          TextStyle(color: appColors["primary"]!, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
               GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Question Instructions"),
          content: Obx(() =>  // Wrap TeXView with Obx
            TeXView( 
              renderingEngine: renderingEngine, 
              child: TeXViewDocument(
                stringToBase64.decode(Get.find<TestStateController>()
                    .testContext
                    .lqs[Get.find<TestStateController>().currentQuestion.value]
                    .question
                    .instructions
                    .instructions),
                style: TeXViewStyle(
                  backgroundColor: appColors["white"]!,
                  padding: TeXViewPadding.all(10), 
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  },
  child: Icon(
    Icons.help_outline,
    color: appColors["white"]!,
  ),
),

                // Icon(
                //   Icons.help_outline,
                //   color: appColors["white"]!,
                // )
              ],
            );
          }),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: appColors["white"]!),
              child: Column(
                children: [
                  if (showComprehension)
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(20),
                      child: Obx(
                        () => TeXView(
                          loadingWidgetBuilder: (context) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: appColors['primary']!,
                            ));
                          },
                          renderingEngine: renderingEngine,
                          child: TeXViewDocument(
                              stringToBase64.decode(
                                  Get.find<TestStateController>()
                                      .testWithSections
                                      .lq![Get.find<TestStateController>()
                                          .currentQuestion
                                          .value]
                                      .question
                                      .comprehension!
                                      .content),
                              style: TeXViewStyle(
                                  padding: const TeXViewPadding.all(0),
                                  // textAlign: TeXViewTextAlign.center,
                                  fontStyle: TeXViewFontStyle(
                                      fontSize: 20,
                                      fontWeight: TeXViewFontWeight.bolder))),
                          style: TeXViewStyle(
                            elevation: 0,
                            backgroundColor: appColors["white"]!,
                          ),
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(20),
                    child: Obx(
                      () => TeXView(
                        loadingWidgetBuilder: (context) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: appColors['primary']!,
                          ));
                        },
                        renderingEngine: renderingEngine,
                        child: TeXViewDocument("""
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
                           ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.question)}
                            </div>
                            </div>
                            """,
                            style: TeXViewStyle(
                                padding: const TeXViewPadding.all(0),
                                // textAlign: TeXViewTextAlign.center,
                                fontStyle: TeXViewFontStyle(
                                    fontSize: 20,
                                    fontWeight: TeXViewFontWeight.bolder))),
                        style: TeXViewStyle(
                          elevation: 0,
                          backgroundColor: appColors["white"]!,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer.contains("A")
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer.contains("A") ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setToggleAnswerMcq("A");
                          setState(() {});
                        },
                        selected: true,
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("A",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[0].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer.contains("B")
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer.contains("B") ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setToggleAnswerMcq("B");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("B",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[1].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer.contains("C")
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer.contains("C") ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setToggleAnswerMcq("C");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("C",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[2].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer.contains("D")
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer.contains("D") ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        // tileColor: appColors['grey'],
                        onTap: () {
                          setToggleAnswerMcq("D");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("D",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[3].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value >
                        0) {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value -
                              1);
                      // setState(() {
                      //   Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value-1);
                      // });
                    }
                  },
                  child: const Icon(Icons.chevron_left, size: 25.0)),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.toggleReview();
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["purple"]!),
                    child: Text("Review Later",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    clearAnswer();

                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["red"]!),
                    child: Text("Clear",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                    }
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["green"]!),
                    child: Text("Save & next",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    print(Get.find<TestStateController>()
                        .currentQuestion
                        .value
                        .toString());
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      // setState(() {
                      //   Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value+1);
                      // });

                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                    }
                  },
                  child: const Icon(
                    Icons.chevron_right,
                    size: 25.0,
                  )),
            ],
          ),
        ),
      ],
    );
  }

//golu
  Widget getMatrixQuestion(BuildContext context, String image,
      TeXViewRenderingEngine renderingEngine) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(right: 0.0),
          decoration: BoxDecoration(
            color: appColors["black"]!,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(() {
            TestQuestion question = Get.find<TestStateController>()
                .testContext
                .testWithSections!
                .lq![Get.find<TestStateController>().currentQuestion.value];
            QuestionStatus qs = Get.find<TestStateController>()
                .selected[question.testQuestionIndex];
            String image = "assets/images/empty.png";
            if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value != AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.UN_MARKED) {
              image = "assets/images/not_saved.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value == AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.UN_MARKED) {
              image = "assets/images/saved.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value == AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.MARKED) {
              image = "assets/images/ans_marked.png";
            } else if (qs.vstate.value == VisitState.VISITED &&
                qs.astate.value != AnsweredState.ANSWERED_SAVED &&
                qs.rstate.value == ReviewState.MARKED) {
              image = "assets/images/review_latr.png";
            }
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q${Get.find<TestStateController>().currentQuestion.value + 1}: Column Matching Question",
                      style: TextStyle(color: appColors["white"]!),
                    ),
                    Text(
                      "Subject:${Get.find<TestStateController>().testContext.lqs[Get.find<TestStateController>().currentQuestion.value].question.subject.name}",
                      style:
                          TextStyle(color: appColors["primary"]!, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
        GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Question Instructions"),
          content: Obx(() =>  // Wrap TeXView with Obx
            TeXView( 
              renderingEngine: renderingEngine, 
              child: TeXViewDocument(
                stringToBase64.decode(Get.find<TestStateController>()
                    .testContext
                    .lqs[Get.find<TestStateController>().currentQuestion.value]
                    .question
                    .instructions
                    .instructions),
                style: TeXViewStyle(
                  backgroundColor: appColors["white"]!,
                  padding: TeXViewPadding.all(10), 
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  },
  child: Icon(
    Icons.help_outline,
    color: appColors["white"]!,
  ),
),

                // Icon(
                //   Icons.help_outline,
                //   color: appColors["white"]!,
                // )
              ],
            );
          }),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: appColors["white"]!),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(20),
                    child: Obx(
                      () => TeXView(
                        loadingWidgetBuilder: (context) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: appColors['primary']!,
                          ));
                        },
                        renderingEngine: renderingEngine,
                        child: TeXViewDocument("""
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
                            ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.question)}
                            </div>
                            </div>
                            """,
                            style: TeXViewStyle(
                                padding: const TeXViewPadding.all(0),
                                // textAlign: TeXViewTextAlign.center,
                                fontStyle: TeXViewFontStyle(
                                    fontSize: 20,
                                    fontWeight: TeXViewFontWeight.bolder))),
                        style: TeXViewStyle(
                          elevation: 0,
                          backgroundColor: appColors["white"]!,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer == "A"
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer == "A" ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setAnswer("A");
                          setState(() {});
                        },
                        selected: true,
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("A",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[0].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer == "B"
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer == "B" ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setAnswer("B");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("B",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[1].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer == "C"
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer == "C" ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () {
                          setAnswer("C");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("C",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[2].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: appColors["primary"]!,),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: appColors["white"]!,
                          border: Border.all(
                              color: answer == "D"
                                  ? appColors["green"]!
                                  : appColors["grey"]!,
                              width: answer == "D" ? 3 : 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        // tileColor: appColors['grey'],
                        onTap: () {
                          setAnswer("D");
                          setState(() {});
                        },
                        contentPadding: const EdgeInsets.all(2.0),
                        leading: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                color: Colors.black38),
                            child: Text("D",
                                style: TextStyle(color: appColors["white"]!))),
                        title: IgnorePointer(
                          child: TeXView(
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
                              ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[3].option_value)}
                            </div>
                            </div>
                            """,
                              // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
                            ),
                            style: TeXViewStyle(
                              backgroundColor: appColors["white"]!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value >
                        0) {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value -
                              1);
                      // setState(() {
                      //   Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value-1);
                      // });
                    }
                  },
                  child: const Icon(Icons.chevron_left, size: 25.0)),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.toggleReview();
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["purple"]!),
                    child: Text("Review Later",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    clearAnswer();

                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["red"]!),
                    child: Text("Clear",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                    }
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["green"]!),
                    child: Text("Save & next",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    print(Get.find<TestStateController>()
                        .currentQuestion
                        .value
                        .toString());
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      // setState(() {
                      //   Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value+1);
                      // });

                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                    }
                  },
                  child: const Icon(
                    Icons.chevron_right,
                    size: 25.0,
                  )),
            ],
          ),
        ),
      ],
    );
  }
  //
  // Widget getComprehensionQuestion(BuildContext context,String image,TeXViewRenderingEngine renderingEngine){
  //   return Column(
  //     children: [
  //       Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.all(16.0),
  //         margin: const EdgeInsets.only(right: 0.0),
  //         decoration: BoxDecoration(color: appColors["black"]!,borderRadius: BorderRadius.circular(20), ),
  //         child:Obx(
  //                 (){
  //               TestQuestion question = Get.find<TestStateController>().testContext.testWithSections!.lq![Get.find<TestStateController>().currentQuestion.value];
  //               QuestionStatus qs = Get.find<TestStateController>().selected[question.testQuestionIndex];
  //               String image= "assets/images/empty.png";
  //               if(qs.vstate.value==VisitState.VISITED && qs.astate.value != AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.UN_MARKED)
  //               {
  //                 image = "assets/images/not_saved.png";
  //               }
  //               else if(qs.vstate.value==VisitState.VISITED && qs.astate.value == AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.UN_MARKED)
  //               {
  //                 image = "assets/images/saved.png";
  //               }
  //               else if(qs.vstate.value==VisitState.VISITED && qs.astate.value == AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.MARKED)
  //               {
  //                 image = "assets/images/ans_marked.png";
  //               }
  //               else if(qs.vstate.value==VisitState.VISITED && qs.astate.value != AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.MARKED)
  //               {
  //                 image = "assets/images/review_latr.png";
  //               }
  //               return Row(
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment:CrossAxisAlignment.start,
  //                     children: [
  //                       Text("Q${Get.find<TestStateController>().currentQuestion.value+1}: Single Choice Question",style: TextStyle(color: appColors["white"]!),),
  //                       Text("Subject:${Get.find<TestStateController>().testContext.lqs[Get.find<TestStateController>().currentQuestion.value].question.subject.name}",style: TextStyle(color: appColors["primary"]!,fontSize: 12),),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   Image.asset(image,height: 40,width: 40,),
  //                   Icon(Icons.help_outline,color: appColors["white"]!,)
  //                 ],
  //               );
  //             }
  //         ),
  //       ),
  //       Expanded(
  //         flex: 1,
  //         child: SingleChildScrollView(
  //           child: Container(
  //             decoration: BoxDecoration(color:appColors["white"]!),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.only(top:10),
  //                   padding: EdgeInsets.all(20),
  //                   child: Obx(
  //                         ()=> TeXView(
  //
  //                       loadingWidgetBuilder: (context){
  //                         return Center(child: CircularProgressIndicator(color: appColors['primary']!,));
  //                       },
  //                       renderingEngine: renderingEngine,
  //                       child: TeXViewDocument(stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.question),
  //                           style: TeXViewStyle(
  //                               padding: const TeXViewPadding.all(0),
  //                               // textAlign: TeXViewTextAlign.center,
  //                               fontStyle: TeXViewFontStyle(fontSize: 20,fontWeight: TeXViewFontWeight.bolder)
  //                           )
  //                       ),
  //                       style: TeXViewStyle(
  //                         elevation: 0,
  //                         backgroundColor: appColors["white"]!,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Obx(
  //                       ()=> Container(
  //                     margin: const EdgeInsets.all(8.0),
  //                     padding: const EdgeInsets.all(10),
  //                     decoration: BoxDecoration(
  //                         color:appColors["white"]!,
  //                         border: Border.all(color:answer=="A"?appColors["green"]!:appColors["grey"]!,width:answer=="A"?3:1 ),
  //                         borderRadius: BorderRadius.circular(20)
  //                     ),
  //                     child: ListTile(
  //                       onTap: (){
  //                         setAnswer("A");
  //                         setState(() {
  //
  //                         });
  //                       },
  //                       selected: true,
  //                       contentPadding: const EdgeInsets.all(2.0),
  //                       leading: Container(padding: const EdgeInsets.all(15.0),decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0)),color: Colors.black38), child: Text("A",style: TextStyle(color: appColors["white"]!))),
  //                       title: IgnorePointer(
  //                         child: TeXView(
  //                           renderingEngine: renderingEngine,
  //                           child: TeXViewDocument(stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[0].option_value),
  //                             // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
  //                           ),
  //                           style: TeXViewStyle(backgroundColor: appColors["white"]!,),
  //                         ),
  //
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 // Divider(color: appColors["primary"]!,),
  //                 Obx(
  //                       ()=> Container(
  //                     margin: const EdgeInsets.all(8.0),
  //                     padding: const EdgeInsets.all(10),
  //                     decoration: BoxDecoration(
  //                         color:appColors["white"]!,
  //                         border: Border.all(color:answer=="B"?appColors["green"]!:appColors["grey"]!,width:answer=="B"?3:1 ),
  //                         borderRadius: BorderRadius.circular(20)
  //                     ),
  //                     child: ListTile(
  //                       onTap: (){setAnswer("B");setState(() {});},
  //                       contentPadding: const EdgeInsets.all(2.0),
  //                       leading: Container(padding: const EdgeInsets.all(15.0),decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0)),color: Colors.black38), child: Text("B",style: TextStyle(color: appColors["white"]!))),
  //                       title: IgnorePointer(
  //                         child: TeXView(
  //                           renderingEngine: renderingEngine,child: TeXViewDocument(stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[1].option_value),
  //                           // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
  //                         ),
  //                           style: TeXViewStyle(backgroundColor: appColors["white"]!,),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 // Divider(color: appColors["primary"]!,),
  //                 Obx(
  //                       ()=> Container(
  //                     margin: const EdgeInsets.all(8.0),
  //                     padding: const EdgeInsets.all(10),
  //                     decoration: BoxDecoration(
  //                         color:appColors["white"]!,
  //                         border: Border.all(color:answer=="C"?appColors["green"]!:appColors["grey"]!,width:answer=="C"?3:1 ),
  //                         borderRadius: BorderRadius.circular(20)
  //                     ),
  //                     child: ListTile(
  //                       onTap: (){setAnswer("C");setState(() {});},
  //                       contentPadding: const EdgeInsets.all(2.0),
  //                       leading: Container(padding: const EdgeInsets.all(15.0),decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0)),color: Colors.black38), child: Text("C",style: TextStyle(color: appColors["white"]!))),
  //                       title: IgnorePointer(
  //                         child:TeXView(
  //                           renderingEngine: renderingEngine,child: TeXViewDocument(stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[2].option_value),
  //                           // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
  //                         ),
  //                           style: TeXViewStyle(backgroundColor: appColors["white"]!,),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 // Divider(color: appColors["primary"]!,),
  //                 Obx(
  //                       ()=> Container(
  //                     margin: const EdgeInsets.all(8.0),
  //                     padding: const EdgeInsets.all(10),
  //                     decoration: BoxDecoration(
  //                         color:appColors["white"]!,
  //                         border: Border.all(color:answer=="D"?appColors["green"]!:appColors["grey"]!,width:answer=="D"?3:1 ),
  //                         borderRadius: BorderRadius.circular(20)
  //                     ),
  //                     child: ListTile(
  //                       // tileColor: appColors['grey'],
  //                       onTap: (){setAnswer("D");setState(() {});},
  //                       contentPadding: const EdgeInsets.all(2.0),
  //                       leading: Container(padding: const EdgeInsets.all(15.0),decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0)),color: Colors.black38), child: Text("D",style: TextStyle(color: appColors["white"]!))),
  //                       title: IgnorePointer(
  //                         child: TeXView(
  //                           renderingEngine: renderingEngine,child: TeXViewDocument(stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.options[3].option_value),
  //                           // style: const TeXViewStyle(textAlign: TeXViewTextAlign.center)
  //                         ),
  //                           style: TeXViewStyle(backgroundColor: appColors["white"]!,),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //       ),
  //       Container(
  //         padding: const EdgeInsets.all(8.0),
  //         decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //                 onTap: (){
  //                   // qs.saveAnswer();
  //                   if(Get.find<TestStateController>().currentQuestion.value>0)
  //                   {
  //                     Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value-1);
  //                     // setState(() {
  //                     //   Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value-1);
  //                     // });
  //                   }
  //                 },
  //                 child: const Icon(Icons.chevron_left,size: 40.0)),
  //             GestureDetector(
  //                 onTap: (){
  //                   // setState(() {
  //                   qs.toggleReview();
  //                   // });
  //                 },
  //                 child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color: appColors["purple"]!),child: Text("Review Later",style: TextStyle(color: appColors["white"]!)),)),
  //
  //             GestureDetector(
  //                 onTap: (){
  //
  //                   // setState(() {
  //                   clearAnswer();
  //
  //                   // });
  //                 },
  //                 child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color: appColors["red"]!),child: Text("Clear",style: TextStyle(color: appColors["white"]!)),)),
  //
  //
  //             GestureDetector(
  //                 onTap: (){
  //                   // setState(() {
  //                   qs.saveAnswer();
  //                   if(Get.find<TestStateController>().currentQuestion.value < Get.find<TestStateController>().questions.length-1)
  //                   {
  //                     Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value+1);
  //                   }
  //                   // });
  //                 },
  //                 child: Container(padding: const EdgeInsets.all(10.0),decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25.0)),color:  appColors["green"]!),child: Text("Save & next",style: TextStyle(color: appColors["white"]!)),)),
  //             GestureDetector(
  //                 onTap: (){
  //                   // qs.saveAnswer();
  //                   print(Get.find<TestStateController>().currentQuestion.value.toString());
  //                   if(Get.find<TestStateController>().currentQuestion.value < Get.find<TestStateController>().questions.length-1)
  //                   {
  //                     // setState(() {
  //                     //   Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value+1);
  //                     // });
  //
  //                     Get.find<TestStateController>().setCurrentQuestion(Get.find<TestStateController>().currentQuestion.value+1);
  //                   }
  //                 },
  //                 child: const Icon(Icons.chevron_right,size: 40.0,)),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget getIntegerQuestion(BuildContext context, String image,
      TeXViewRenderingEngine renderingEngine,
      {bool showComprehension = false}) {
    print("initializing the integer answer");
    print(Get.find<TestStateController>()
        .testContext
        .lqs[Get.find<TestStateController>().currentQuestion.value]
        .answer);
    TextEditingController answerController = TextEditingController(
        text: Get.find<TestStateController>()
            .testContext
            .lqs[Get.find<TestStateController>().currentQuestion.value]
            .answer);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(right: 0.0),
          decoration: BoxDecoration(
            color: appColors["black"]!,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q${Get.find<TestStateController>().currentQuestion.value + 1}: Integer Type Question",
                    style: TextStyle(color: appColors["white"]!),
                  ),
                  Text(
                    "Subject:${Get.find<TestStateController>().testContext.lqs[Get.find<TestStateController>().currentQuestion.value].question.subject.name}",
                    style:
                        TextStyle(color: appColors["primary"]!, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                image,
                height: 40,
                width: 40,
              ),
     GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Question Instructions"),
          content: Obx(() =>  // Wrap TeXView with Obx
            TeXView( 
              renderingEngine: renderingEngine, 
              child: TeXViewDocument(
                stringToBase64.decode(Get.find<TestStateController>()
                    .testContext
                    .lqs[Get.find<TestStateController>().currentQuestion.value]
                    .question
                    .instructions
                    .instructions),
                style: TeXViewStyle(
                  backgroundColor: appColors["white"]!,
                  padding: TeXViewPadding.all(10), 
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  },
  child: Icon(
    Icons.help_outline,
    color: appColors["white"]!,
  ),
),

              // Icon(
              //   Icons.help_outline,
              //   color: appColors["white"]!,
              // )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (showComprehension)
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(20),
                    child: Obx(
                      () => TeXView(
                        loadingWidgetBuilder: (context) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: appColors['primary']!,
                          ));
                        },
                        renderingEngine: renderingEngine,
                        child: TeXViewDocument(
                            stringToBase64.decode(
                                Get.find<TestStateController>()
                                    .testWithSections
                                    .lq![Get.find<TestStateController>()
                                        .currentQuestion
                                        .value]
                                    .question
                                    .comprehension!
                                    .content),
                            style: TeXViewStyle(
                                padding: const TeXViewPadding.all(0),
                                // textAlign: TeXViewTextAlign.center,
                                fontStyle: TeXViewFontStyle(
                                    fontSize: 20,
                                    fontWeight: TeXViewFontWeight.bolder))),
                        style: TeXViewStyle(
                          elevation: 0,
                          backgroundColor: appColors["white"]!,
                        ),
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(),
                  child: TeXView(
                    loadingWidgetBuilder: (context) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: appColors['primary']!,
                      ));
                    },
                    renderingEngine: renderingEngine,
                    child: TeXViewDocument("""
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
                       ${stringToBase64.decode(Get.find<TestStateController>().testWithSections.lq![Get.find<TestStateController>().currentQuestion.value].question.question)}
                            </div>
                            </div>
                            """,
                        style: TeXViewStyle(
                            padding: const TeXViewPadding.all(0),
                            margin: TeXViewMargin.all(0),
                            // textAlign: TeXViewTextAlign.center,
                            // height: 200,
                            // sizeUnit: TeXViewSizeUnit.percent,
                            fontStyle: TeXViewFontStyle(
                                fontSize: 10,
                                fontWeight: TeXViewFontWeight.bolder))),
                    style: TeXViewStyle(
                      elevation: 0,
                      backgroundColor: appColors["white"]!,
                    ),
                  ),
                ),
                TextFormField(
                  controller: answerController,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  decoration: InputDecoration(
                    focusColor: Colors.grey,
                    prefixIcon: Icon(
                      Icons.arrow_right,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: appColors['primary']!, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: appColors['primary']!, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: "Answer",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: 'Integer Answer',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value >
                        0) {
                      // setState(() {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value -
                              1);
                      // });
                    }
                  },
                  child: const Icon(Icons.chevron_left, size: 25.0)),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.toggleReview();
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["purple"]!),
                    child: Text("Review Later",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    clearAnswer();
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["red"]!),
                    child: Text("Clear",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    if (setAnswer(answerController.text)) {
                      qs.saveAnswer();
                      if (Get.find<TestStateController>()
                              .currentQuestion
                              .value <
                          Get.find<TestStateController>().questions.length -
                              1) {
                        Get.find<TestStateController>().setCurrentQuestion(
                            Get.find<TestStateController>()
                                    .currentQuestion
                                    .value +
                                1);
                      }
                    }

                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["green"]!),
                    child: Text("Save & next",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    print(Get.find<TestStateController>()
                        .currentQuestion
                        .value
                        .toString());
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      // setState(() {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                      // });
                    }
                  },
                  child: const Icon(
                    Icons.chevron_right,
                    size: 25.0,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget getUnknownQuestion(BuildContext context, String image,
      TeXViewRenderingEngine renderingEngine) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(right: 0.0),
          decoration: BoxDecoration(
            color: appColors["black"]!,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(
                "Q${Get.find<TestStateController>().currentQuestion.value + 1}: Unknown Question Type",
                style: TextStyle(color: appColors["white"]!),
              ),
              const Spacer(),
              Image.asset(
                image,
                height: 40,
                width: 40,
              ),
              Icon(
                Icons.help_outline,
                color: appColors["white"]!,
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: appColors["white"]!),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(20),
                      child: clumsyTextLabel(
                          "Sorry, This is an Unkown Question type question")),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value >
                        0) {
                      // setState(() {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value -
                              1);
                      // });
                    }
                  },
                  child: const Icon(Icons.chevron_left, size: 25.0)),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.toggleReview();
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["purple"]!),
                    child: Text("Review Later",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    clearAnswer();
                    // qs.clearAnswer();
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["red"]!),
                    child: Text("Clear",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // setState(() {
                    qs.saveAnswer();
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                    }
                    // });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        color: appColors["green"]!),
                    child: Text("Save & next",
                        style: TextStyle(color: appColors["white"]!)),
                  )),
              GestureDetector(
                  onTap: () {
                    // qs.saveAnswer();
                    print(Get.find<TestStateController>()
                        .currentQuestion
                        .value
                        .toString());
                    if (Get.find<TestStateController>().currentQuestion.value <
                        Get.find<TestStateController>().questions.length - 1) {
                      // setState(() {
                      Get.find<TestStateController>().setCurrentQuestion(
                          Get.find<TestStateController>()
                                  .currentQuestion
                                  .value +
                              1);
                      // });
                    }
                  },
                  child: const Icon(
                    Icons.chevron_right,
                    size: 25.0,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
