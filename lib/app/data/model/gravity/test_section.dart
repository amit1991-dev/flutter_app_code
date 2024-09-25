import 'package:flutter/foundation.dart';
import 'instructions.dart';
import 'question.dart';
import 'subject.dart';
import 'marking_scheme.dart';
import 'test_question.dart';

class TestSection {
  late String name,sectionType;
  late List<TestQuestion> sectionQuestions;
  late int requiredOptionalQuestionsCount;
  // int numberMarked = 0;
  List<int> markedQuestions = [];
  TestSection({required this.name,required this.sectionType,required this.sectionQuestions});

  TestSection.fromJSON(Map<String,dynamic> json)
  {
    print("testSection");
    var questions = json['questions'];
    sectionQuestions = [];
    for(var question in questions){
      sectionQuestions.add(TestQuestion.fromJson(question,testSection: this));
    }
    print("testSection");
    name=json['name'];
    print("asdad");
    sectionType=json['section_type'];
    print("asdad");
    requiredOptionalQuestionsCount = json['numberCompulsoryQuestions'];
  }

  canMarkQuestion(int index){
    print("inside can mark question!");
    print("Section type: $sectionType");
    if(markedQuestions.contains(index)){
      return true;
    }
    if(sectionType == "optional-jee"){
      print(markedQuestions.length < requiredOptionalQuestionsCount);
      return markedQuestions.length < requiredOptionalQuestionsCount;
    }
    else if(sectionType == "optional-neet"){
      return true;
    }
    else
      {
        print(3);
        return true;
      }
    }

  markQuestion(int index){
    print("markedQuestions");

    if(markedQuestions.contains(index)){
      return true;
    }

    if(canMarkQuestion(index)){

      markedQuestions.add(index);
      print("${markedQuestions.length}/$requiredOptionalQuestionsCount questions answers marked");
      print(markedQuestions);
      return true;
    }
    else
    {
      print("cannot mark question");
      print("${markedQuestions.length}/$requiredOptionalQuestionsCount");
      print(markedQuestions);
      return false;
    }
    print(markedQuestions);
  }


  unMarkQuestion(int index){
    print("markedQuestions");
    if(markedQuestions.isNotEmpty)
      {
        // numberMarked--;
        if(markedQuestions.contains(index)){
          markedQuestions.remove(index);
        }
        print(markedQuestions);
        return true;
      }
    else{
      print(markedQuestions);
      return false;
    }

    // print(sectionType);
    // if(canMarkQuestion()){
    //   numberMarked++;
    //   print("$numberMarked/$requiredOptionalQuestionsCount questions answers marked");
    //   return true;
    // }
    // else
    // {
    //   print("cannot mark question");
    //   print("$numberMarked/$requiredOptionalQuestionsCount");
    //   return false;
    // }
  }
}


// class JeeOptionalTestSection extends TestSection {
//   int numberCompulsoryQuestions,attemptedQuestions = 0;
//   JeeOptionalTestSection.fromJSON(super.json) :numberCompulsoryQuestions= json['numberCompulsoryQuestions'], super.fromJSON();
// }
//
// class NeetOptionalTestSection extends TestSection {
//   int numberCompulsoryQuestions,attemptedQuestions = 0;
//   NeetOptionalTestSection.fromJSON(super.json) :numberCompulsoryQuestions= json['numberCompulsoryQuestions'], super.fromJSON();
// }
