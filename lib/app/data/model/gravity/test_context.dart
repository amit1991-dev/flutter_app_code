import 'package:getx/app/data/model/gravity/test_question.dart';
import 'package:getx/app/data/model/gravity/test_section.dart';

import 'question_status.dart';
import 'test_with_sections.dart';

class TestContext{
  late String id;
  late int timeLeft;
  late int attemptNumber;
  late String testContextStatus;// [uninitialized paused finished running]
  TestWithSections? testWithSections;
  // 'question':question.id,'attempted':astate==AnsweredState.ANSWERED_SAVED,'answer_value':astate==AnsweredState.ANSWERED_SAVED?answer:"",'subject':question.subject,'visited':vstate==VisitState.VISITED ,'time_allotted':timeSpent};
  late List<QuestionStatus> lqs;


  TestContext({required this.id,required this.timeLeft,required this.attemptNumber,required this.testWithSections,required this.lqs});
  TestContext.fromJson(Map<String, dynamic> json,{bool questions=false})
  {
    id = json['_id']??"-";
    timeLeft = json['time_left']??2;
    attemptNumber = json['attempt_number']??0;
    // print("questions");
    // print(questions);
    if(json['test'].runtimeType != String){
      print("inside type checked if");
      // print(questions);
      print(questions);
      testWithSections = TestWithSections.fromJSON(json['test'], questions);
    }

    // print("testContext");
    lqs=[];
    testContextStatus = json['test_state_status'];
    // print(testContextStatus);
    if(questions)
    {
      if (testContextStatus == "uninitialized") {
        print("initializing data");
        List<TestSection> testSections = testWithSections!.testSections!; //testSections not null because questions==true
        int index = 0;
        for (var section in testSections) {
          print("looping section:${section.name}");
          List<TestQuestion> questions = section.sectionQuestions;
          for (TestQuestion question in questions) {
            if(question.testSection==null){
              print("null section");
            }
            lqs.add(QuestionStatus(index: index, question: question));
            index++;
          }
        }
      } else {
          print("filling up with old statuses in textContext constructor");
          // List data = json['data'] as List;
          // for (int i = 0; i < data.length; i++) {
          //   var singleTestStatusJson = data[i];
          //   print(singleTestStatusJson);
          //   QuestionStatus qs=QuestionStatus.fromJson(singleTestStatusJson, index: i);
          //   if(qs.astate == AnsweredState.ANSWERED_SAVED){
          //     print("yes");
          //     print(qs.question.testSection);
          //     qs.question.testSection!.markedQuestions.add(i);
          //   }
          //   lqs.add(qs);
          // }

          List<TestSection> testSections = testWithSections!.testSections!; //testSections not null because questions==true
          int index = 0;
          List data = json['data'] as List;

          for (var section in testSections) {
            var singleTestStatusJson = data[index];
            print("looping section:${section.name}");
            List<TestQuestion> questions = section.sectionQuestions;
            for (TestQuestion question in questions) {
              QuestionStatus qs=QuestionStatus.fromJson(singleTestStatusJson,question, index: index,ts: section);
              if(qs.astate == AnsweredState.ANSWERED_SAVED){
                print("yes");
                print(qs.question.testSection);
                qs.question.testSection!.markedQuestions.add(index);
              }
              lqs.add(qs);
              index++;
            }
          }

          int i=0;
          for(var qs in lqs){
            print("${i}:${qs.answer}");
            i++;
          }

      }
    }
  }
}