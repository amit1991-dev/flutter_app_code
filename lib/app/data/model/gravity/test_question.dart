import 'package:flutter/foundation.dart';
import 'package:getx/app/data/model/gravity/test_section.dart';
import 'instructions.dart';
import 'question.dart';
import 'subject.dart';
import 'marking_scheme.dart';

class TestQuestion {
  late int testQuestionIndex;
  late Question question;
  late Instructions instructions;
  late MarkingScheme scheme;
  late Subject subject;

  TestSection? testSection;
  TestQuestion({required this.question,required this.subject,required this.scheme,required this.instructions,this.testQuestionIndex=0});
  TestQuestion.fromJson(Map<String,dynamic> json,{this.testQuestionIndex=0,this.testSection})
  {
    print("testQuestion");
    print(json['question']);
    question = Question.minimalFromJSON(json['question']);
    print(json['subject']);
    subject = Subject.fromJSON(json['subject']);
    print("testQuestion");
    scheme = MarkingScheme.fromJSON(json['scheme']);
    print(json['instructions']);
    instructions = Instructions.fromJSON(json['instructions']);
  }

  Map<String,dynamic> toJson()
  {
    return {'question':question.id,'subject':subject.id,'scheme':scheme.id,'instructions':instructions.id};
  }
}
