import 'package:flutter/foundation.dart';
import 'package:getx/app/data/model/gravity/academic_file.dart';


import 'comprehension.dart';
import 'question_options.dart';

class Question {
  String id,question,questionType;
  String? solution;
  var correctAns;
  String? chapter,subtopic,topic;
  String? media,questionSubtype;
  Comprehension? comprehension;
  AcademicFile? file;

  List<Option> options;

  Question._full(this.id,this.question,this.questionType,this.correctAns,this.solution,
      this.options,{this.chapter="-",this.subtopic="-",this.topic="-",this.media,this.file,this.comprehension,this.questionSubtype});

  Question._minimal(this.id,this.question,this.questionType,this.options,{this.comprehension,this.questionSubtype});

  factory Question.minimalFromJSON(Map<String,dynamic> json)
  {
    print(json['_id']);
    print(json['image']);
    print(json['question']);
    print(json['question_type']);
    print("${json['class_number']},${json['positive_marks']},${json['negative_marks']}");
    // print(json['subject']);
    // print(json['instructions']);


    if(json['question_type']!="comprehension"){
      return Question._minimal(json['_id'],json['question'],json['question_type'],getListOptions(json['options']),questionSubtype:json['question_subtype'] ?? 'scq');
    }
    else{
      print('comprehensiondsaasd');
      print(json['comprehension']);
      return Question._minimal(json['_id'],json['question'],json['question_type'],getListOptions(json['options']),comprehension:Comprehension.fromJSON(json['comprehension']),questionSubtype:json['question_subtype'] ?? 'scq');
    }
  }

  factory Question.fullFromJSON(Map<String,dynamic> json)
  {
    AcademicFile? file;
    if(json.containsKey('document')){
       file = AcademicFile.fromJSON(json['document']);
    }
    if(json['question_type']!="comprehension"){
      return Question._full(json['_id'],json['question'],json['question_type'],json['correct_answer'],json['solution'],
        getListOptions(json['options']),chapter:json['chapter'],subtopic:json['subtopic'],topic:json['topic'],media: json['media'],file:file,questionSubtype:json['question_subtype'] ?? 'scq');
    }
    else{
      print('comprehensiondsaasd');
      print(json['comprehension']);
      return Question._full(json['_id'],json['question'],json['question_type'],json['correct_answer'],json['solution'],
        getListOptions(json['options']),chapter:json['chapter'],subtopic:json['subtopic'],topic:json['topic'],media: json['media'],file:file,comprehension:Comprehension.fromJSON(json['comprehension']),questionSubtype:json['question_subtype'] ?? 'scq');
    }
  }

  @override
  String toString()
  {
    StringBuffer sb = StringBuffer();
    for (var element in options) {
      sb.write(element.toString());
    }
    return "$question:${options.length} , $sb\n";
  }

  static List<Option> getListOptions(List<dynamic> objects){
    List<Option> options =[];
    print(objects);
    for (var element in objects) {
      options.add(Option.fromJSON(element));
    }
    return options;

  }
}




// class SingleChoiceQuestion extends Question{
//   List<Option> options;
//   SingleChoiceQuestion(String id, String name,this.options) : super(id, name){
//
//   }
//
//   factory SingleChoiceQuestion.fromJSON(Map<String,String> json)
//   {
//     // return SingleChoiceQuestion(json['_id'],json['username']);
//   }
//
// }
