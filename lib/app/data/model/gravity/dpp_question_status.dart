
import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx/app/data/model/gravity/dpp_test_section.dart';



import 'dpp_test_question.dart';
class DppQuestionStatus {
  late String subject;
  dynamic tempAnswer,answer;
  late DppTestQuestion question;
  int index;
  late bool optional=false,contribution=false,correctlyMarked=false;
  late int timeSpent;

  Rx<SelectedState> state=SelectedState.UN_VISITED.obs;
  Rx<AnsweredState> astate = AnsweredState.UNANSWERED.obs;
  Rx<ReviewState> rstate = ReviewState.UN_MARKED.obs;
  Rx<VisitState> vstate = VisitState.UN_VISITED.obs;

  // dynamic notifyListener;
  DppQuestionStatus({required this.index,required this.question,this.answer="",this.tempAnswer="",this.optional=false,this.timeSpent=0});

  DppQuestionStatus.fromJson(Map<String,dynamic> json,this.question,{this.index=0,DppTestSection? ts,}){

    print(json);
    subject =json['subject']??"unknown";
    optional =json['is_optional']??false;
    contribution =json['contribution']??false;
    // question = TestQuestion.fromJson(json['question'],testSection: ts);

    if(question.question.questionType=="mcq" || (question.question.questionType=="comprehension" && question.question.questionType=="mcq")){
      answer = json['answer_value']??[];
    }
    else{
      answer = json['answer_value']??"";
    }
    tempAnswer = answer;

    if(json["attempted"]!=null){
      astate.value = json['attempted']?AnsweredState.ANSWERED_SAVED:astate.value;
      print("Astate");
      print(astate.value);

    }
    if(json["visited"]!=null){
      vstate.value = json['visited']?VisitState.VISITED:vstate.value;
    }
    if(json["correctly_marked"]!=null){
      correctlyMarked = json['correctly_marked'];
    }
      timeSpent = json['time_allotted'];
    }

  @override
  String toString(){
    return "${question.question.id},$answer\n";
  }


  void setAnswer(String answer)
  {
    print("setting ans");
    if(answer != "") {
      tempAnswer = answer;
      state.value = SelectedState.ANSWERED;

      if (astate.value != AnsweredState.ANSWERED_SAVED) {
        astate.value = AnsweredState.ANSWERED;
      }
    }
    else
    {
      clearAnswer();
    }

  }

  void setToggleAnswer(List<String> answer)
  {
    print("setting ans");
    if(answer.isNotEmpty) {
      tempAnswer = answer;
      state.value = SelectedState.ANSWERED;

      if (astate.value != AnsweredState.ANSWERED_SAVED) {
        astate.value = AnsweredState.ANSWERED;
      }
    }
    else
    {
      clearToggleAnswer();
    }
  }

  void saveAnswer(){
    print("Saving answer");
    if(tempAnswer!="")
    {
      answer = tempAnswer;
      astate.value = AnsweredState.ANSWERED_SAVED;
    }
  }

  void toggleReview(){
    print("toggling marked state");
    if(rstate.value == ReviewState.UN_MARKED)
    {
      rstate.value = ReviewState.MARKED;
    }
    else{
      rstate.value = ReviewState.UN_MARKED;
    }
      print("notifying listeners");
  }

  void visit()
  {
    print("visiting node");
    vstate.value = VisitState.VISITED;
  }

  void clearAnswer()
  {
    print("clearing answer");
    tempAnswer = "";
    answer = "";
    state.value = SelectedState.VISITED_UNANSWERED;
    rstate.value = ReviewState.UN_MARKED;
    astate.value = AnsweredState.UNANSWERED;
  }

  void clearToggleAnswer()
  {
    print("clearing answer");
    tempAnswer = [];
    answer = [];
    state.value = SelectedState.VISITED_UNANSWERED;
    rstate.value = ReviewState.UN_MARKED;
    astate.value = AnsweredState.UNANSWERED;
  }

  void setState(SelectedState s)
  {
    state.value = s;
  }

  void incrementTimeSpent()
  {
    timeSpent++;
  }

  @override
  bool operator ==(other) => other is DppQuestionStatus && (other.state == state);

  Map<String,dynamic> toJson()
  {
    Map<String,dynamic> body ={
      'question':{'question':question.question.id,"subject":question.subject.id,"scheme":question.scheme.id,"instructions":question.instructions.id},
      'attempted':astate.value==AnsweredState.ANSWERED_SAVED,
      'answer_value':astate.value==AnsweredState.ANSWERED_SAVED?answer:"",
      'subject':question.subject.name,
      'visited':vstate.value==VisitState.VISITED ,
      'time_allotted':timeSpent,
      "is_optional":optional,
      "contribution":contribution
    };
    print("sending attempted:${jsonEncode(body)}");
    return body;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => state.hashCode;

}


enum SelectedState{
  MARK_FOR_REVIEW, MARK_FOR_REVIEW_AND_UNANSWERED,MARK_FOR_REVIEW_AND_ANSWERED, ANSWERED,VISITED_UNANSWERED, UN_VISITED
}

enum AnsweredState{
  UNANSWERED, ANSWERED, ANSWERED_SAVED
}

enum ReviewState{
  MARKED, UN_MARKED
}

enum VisitState{
  VISITED, UN_VISITED
}

enum TimeState{
  ALOT,HALFWAY,DANGER,UP
}

enum TestState{
  STARTED,FINISHED,SUBMITTED,SUBMISSION_STARTED,ERROR_SUBMITTING
}