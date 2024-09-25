
import 'package:getx/app/data/model/gravity/question.dart';

import 'gravity_file.dart';
import 'topic.dart';


class Exam {
  late String id,name,examDate;
  late List<Question> questions;

  Exam.fromJSON(Map<String,dynamic> json,{bool hasQuestions=false})
  {
    id=json["_id"];
    name = json['name'];
    examDate = json['exam_date'];
    print("a");
    if(hasQuestions){
      print("z");
      questions=List.generate(json['questions'].length, (index) {
        print("b");
        return Question.fullFromJSON(json['questions'][index]);
      });
    }

  }

  @override
  String toString()
  {
    return "Exam: $name\n";
  }
}

