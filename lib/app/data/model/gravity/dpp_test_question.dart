
import 'package:getx/app/data/model/gravity/dpp_test_section.dart';
import 'instructions.dart';
import 'dpp_question.dart';
import 'subject.dart';
import 'marking_scheme.dart';

class DppTestQuestion {
  late int testQuestionIndex;
  late DppQuestion question;
  late Instructions instructions;
  late MarkingScheme scheme;
  late Subject subject;

  DppTestSection? testSection;
  DppTestQuestion({required this.question,required this.subject,required this.scheme,required this.instructions,this.testQuestionIndex=0});
  DppTestQuestion.fromJson(Map<String,dynamic> json,{this.testQuestionIndex=0,this.testSection})
  {
    print("testQuestion");
    print(json['question']);
    question = DppQuestion.minimalFromJSON(json['question']);
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
